-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : assetLoader.lua
--  Creator     : sf
--  Date        : 2017-5-8
--  Comment     : 
-- ***************************************************************
--资源加载器  单例  
AssetLoader = BaseClass()


function AssetLoader:initialize()
	self.assetCacheList = AssetList.new()    --记录缓存过的资源
	self.loadTasklist = {}                   --加载队列

    self.downloader = AssetDelayDownloader.new()
    self.downloader:setConnectionTimeout()

	AssetLoader.instance = self
end


--mono
function AssetLoader:update()
    self:loadingCheck()
end
 

--加载检测
function AssetLoader:loadingCheck()
	for i, v in pairs(self.loadTasklist)  do 
		v:update()
		if v:isDone() then 
			local loadTask = v 
			table.remove(self.loadTasklist, i)
			
			if v:getLoadState() == assetBB.enumLoadState.success then 
				self:dealLoadTaskDone(v)
			else 
				local asset =  self.assetCacheList:get(loadTask.path)
				if asset ~= nil then 
					self:loadTaskCallback(loadTask, asset)
				end	
			end
		end
	end
end


function AssetLoader:containAsset(path)
	if self.assetCacheList:exsits(path) then 
       return true
	end 
    return false
end


function AssetLoader:getAsset(path)
    return self.assetCacheList:get(path)
end    


--资源加载完成 处理	
function AssetLoader:dealLoadTaskDone(loadTask)
	if loadTask:getLoadState() == assetBB.enumLoadState.failed then 
		logger.Error("file read failed, " .. loadTask.path .. " error:" .. loadTask.failReason)
		return
	end

	local assetName = loadTask.path
	local assetTemp = Asset(assetName, loadTask.assetBundle)
	assetTemp:Load()

	if not self.assetCacheList:exsits(assetName) then 
		self.assetCacheList:putWithoutCheck(assetTemp) 
	else 
		assetTemp:Destroy(true)
		assetTemp = self.assetCacheList:get(assetName)
	end

	self:loadTaskCallback(loadTask, assetTemp)	
end


function AssetLoader:loadTaskCallback(loadTask, asset)
   self:safeCallBack(loadTask.callbackList, asset)
   self:safeCallBack(loadTask.callbackList2, asset.mainObject)
end


function AssetLoader:safeCallBack(callbackList, asset)
    if callbackList == nil then 
       return
	end
		
	for i,v in pairs(callbackList) do 
		self:safeCallBackActionAsset(v, asset)
	end 
end


function AssetLoader:safeCallBackActionAsset(callbackList, asset)
    if callbackList == nil or asset.mainObject == nil then 
       return
	end
	if type(callbackList) == "number" then 
		FastLuaUtility.LoadDone(callbackList, asset)
	else 
		callbackList(asset)
	end
end


function AssetLoader:safeCallBackActionObject(callbackList, asset)
    if callbackList == nil then 
       return
	end
	
	if callbackList.Method.IsStatic == true then 
		callbackList(asset)
	else 
		if callbackList.Target ~= nil then 
			callbackList(asset)
		end
	end
end


--异步加载
function AssetLoader:asyncLoad(name, callbackAsset, callbackObject)
	if name == nil then
		error("async load resource name is nil")
	end
	local asset = self.assetCacheList:get(name)
	if asset == nil then  --缓存区无此资源
       return self:createLoadTask(name, callbackAsset, callbackObject)
	else
		self:safeCallBackActionAsset(callbackAsset, asset)
		self:safeCallBackActionAsset(callbackObject, asset.mainObject)
		return nil
	end
end


--创建一个加载任务
function AssetLoader:createLoadTask(name, callbackAsset, callbackObject)
	local loadTask = self:find(self.loadTasklist, name)		 
	if loadTask == nil then 
        loadTask = AssetLoadTask.new()
		--先检测是否延迟下载的资源
        if self:checkIsDelayDownloadAsset(name, callbackAsset, callbackObject) then
            loadTask.state = assetBB.enumLoadState.unDownloaded
        else
            loadTask.state = assetBB.enumLoadState.notStartLoad
        end
		loadTask.path = name
		loadTask:addcallbackAsset(callbackAsset)
		loadTask:addcallbackObject(callbackObject)
		table.insert(self.loadTasklist, loadTask)
	else
		loadTask:addcallbackAsset(callbackAsset)
	end		
	return loadTask
end


--这里判断一下是不是延迟下载的资源
--  如果是：判断是否已经下载过。
--    （1）未下载的要开始下载，下载完成回调：更新downloadstate=2并saveToFile(AssetDelayDownloader处理)，然后loadtask的state标记为0通知它可以开始加载资源了
--    （2）已下载的开始加载资源			  
--  如果否：开始加载资源
function AssetLoader:checkIsDelayDownloadAsset(name, callbackAsset, callbackObject)
	--注意资源名要获取国际化资源名!
	local abName = assetBB.getLocalizationAssetName(AssetUtil.instance:addfirstChard(name))
    if assetBB.delayDownloadAssetList[abName] ~= nil then
        -- logInfo("这是个延迟下载的资源："..abName)
        local projectAssets = AssetStatusManager.instance:getLocalConfProjectAsssets()
        local ast = projectAssets[abName]
        if ast == nil then
           	logInfo("projectManifest匹配不到指定的资源："..abName)
        end

        if ast.downloadState ~= assetBB.enumAssetDownloadState.adsSuccessed then         --判断是否已经下载过的
            if assetBB.waitDelayDownloadAssets[name] == nil then
                --开启下载
                assetBB.waitDelayDownloadAssets[name] = {}
                table.insert(assetBB.waitDelayDownloadAssets[name], {callbackAsset = callbackAsset, callbackObject = callbackObject})                 
                local downloadData = AssetDelayDownloadManager.instance:prepareDownloadData(name, abName, ast)
                self.downloader:downloadAsync(downloadData, function (data, response)
                    --下载完成回调，设置assetLoadTask的state为0: 可以开始
                    for i, v in pairs(self.loadTasklist)  do 
                        if v.path == data.nameId then
                        	logInfo("下载delay资源完成，可以开始加载: "..data.nameId)
                            v.state = assetBB.enumLoadState.notStartLoad
                        end
                    end

                    assetBB.waitDelayDownloadAssets[data.nameId] = nil
                end)
                logInfo("=======================开始下载delay资源：     "..abName)
            else
                table.insert(assetBB.waitDelayDownloadAssets[name], {callbackAsset = callbackAsset, callbackObject = callbackObject})
            end 
            return true  
        else
        	--logInfo("已经下载过的延迟资源: "..abName)
            return false
        end
    else
        return false
    end    	
end


function AssetLoader:find(loadList, path)
	if loadList == nil then 
		return nil 
	end 
	for i, v in pairs(loadList) do 	
		if v.path == path then 
			return v
		end
	end
	return nil
end


--同步加载 尽量不要用这个接口去加载，改用asyncLoad
function AssetLoader:syncLoad(name)
	local asset = self.assetCacheList:get(name)
	if asset ~= nil then 
		return asset
	end
	local  path = AssetUtil.instance:getAssetAbsolutePath(name)
	
	if not FileUtility.IsFileExist(path) then
		Debug.LogError("文件不存在，路径：" .. path)
		return nil
	end

	local data =  FileUtility.GetBytes(path)	
	if data ~= nil and #data > 0 then 
		-- AssetUtil.decryptData(data)
		local assetBundleTemp = UnityEngine.AssetBundle.LoadFromMemory(data)
		local newAsset = Asset(name, assetBundleTemp)
		newAsset:Load()
		self.assetCacheList:putWithoutCheck(newAsset)
		return newAsset
	else
		Debug.LogError("文件内容有错" .. name)
	end
end


--销毁指定资源
function AssetLoader:clearAsset(name, isClear)
	local list = self.assetCacheList.assetList 
	for i, v in pairs(list) do 
		if v.name == name  then 
			table.remove(list, i)
			if isClear ~= nil then 
				v:Destroy(isClear)
			else 
				v:Destroy(true)
			end
		end
	end
end


--销毁资源释放内存，会检查是否无用的资源再销毁，所以需要保证正常引用计数
function  AssetLoader:clearAssets()
	local list = self.assetCacheList.assetList
	for i = #list, 1, -1 do
		local asset = list[i]
		if asset.gcType == AssetGCType.actForever then 
		else 
			if 	asset:IsUnused() then 
				if asset.gcType == AssetGCType.actRefCounted or asset.gcType == AssetGCType.actCustom then 
					asset:Destroy(true)
				elseif asset.gcType == AssetGCType.actOnce then 
					asset:Destroy(false)
				end
				table.remove(list , i)
			end
		end 
	end
end
