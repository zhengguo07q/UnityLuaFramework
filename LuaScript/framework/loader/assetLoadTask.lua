-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : assetLoader.lua
--  Creator     : sf
--  Date        : 2017-5-8
--  Comment     : 
-- ***************************************************************
AssetLoadTask = BaseClass()


function AssetLoadTask:ctor()
	self.callbackList2 = {}
	self.callbackList = {}
	self.progress = 0
	self.state = assetBB.enumLoadState.notStartLoad
	self.failReason = ""
end


--通过AssetLoader的loadingCheck调用
function AssetLoadTask:update()
	if self.state == assetBB.enumLoadState.notStartLoad then 
		local readPath = AssetUtil.instance:getAssetWWWPath(self.path)
		self.state = assetBB.enumLoadState.wwwStart
		self.www = UnityEngine.WWW(readPath)
	elseif self.state == assetBB.enumLoadState.wwwStart then 
		if self.www.isDone then
			if self.www.error ~= nil then 
				self.state = assetBB.enumLoadState.failed 
				self.failReason = self.www.error
				Debug.LogError("progress:" .. self.progress .. " path:" .. self.path .. " failed:" .. self.failReason)
			else 
				self:WWWLoadDoneDeal()
			end
		else 
			self.progress = self.www.progress	
		end
	end
end


function AssetLoadTask:WWWLoadDoneDeal()
	self.state = assetBB.enumLoadState.success
	self.assetBundle = self.www.assetBundle
	self.progress = 1
	
	if AssetLoader.instance:containAsset(self.path) then 
		self.state = assetBB.enumLoadState.failed
		self.failReason = "asset already exsits"
		return
	end
	if self.assetBundle == nil then 
		self.state = assetBB.enumLoadState.failed
		self.failReason = "error cannot not create assetbundle"
	end
end


function AssetLoadTask:isDone()
	if self.state == assetBB.enumLoadState.success or self.state == assetBB.enumLoadState.failed then 
		return true
	end
	return false
end


function AssetLoadTask:getLoadState()
   return self.state
end


function AssetLoadTask:addcallbackAsset(funCallBack) 
	table.insert(self.callbackList, funCallBack)
end


function AssetLoadTask:addcallbackObject(funCallBack) 
	table.insert(self.callbackList2, funCallBack)
end


function AssetLoadTask:find(loadList, path)
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



--资源判断
AssetJudge = BaseClass()


function AssetJudge:getneverDestroyList()
	if self.neverDestroyList == nil then 
		self.neverDestroyList = {}
		table.insert(self.neverDestroyList, "UI/Reconnect/ReConnectPanel")
		table.insert(self.neverDestroyList, "UI/Tooltip/TooltipPanel")
		table.insert(self.neverDestroyList, "Prefabs/Common/WindowMask")
	end
	return self.neverDestroyList
end


function AssetJudge:getSceneTypes()
	if self.sceneTypes == nil then 
		self.sceneTypes = {}
		table.insert(self.sceneTypes, "Scene")
	end
	return self.sceneTypes
end


function AssetJudge:isScene(path)
	local parts = stringUtility.split(path, "/")
	for i ,v in pairs(parts) do 
		if v == "Scene" then 
			return true 
		end 
	end 
	return false
end


function AssetJudge:getonceList()
	if self.onceList == nil then 
		self.onceList= {}
		table.insert(self.onceList, "Texture/bigmap2")
	end
	return self.onceList
end


function AssetJudge:isOnceList(path)
	
	local tstr = path
	local idx = path:match(".+()%.%w+$")
    if idx then
        tstr = tstr:sub(1, idx - 1)
    end
	
    for i, v in pairs(self:getonceList()) do 
		if string.find(path, v) ~= nil then 
			return true
		end
	end
	
	return false
end	


function AssetJudge:neverDestroyListPath(path)
	for i, v in pairs(self:getneverDestroyList()) do 
		if string.find(v, path) then 
			return true 
		end
	end
	return false
end
	

function AssetJudge:getGCType(path)
	if self:neverDestroyListPath(path) then   --常驻内存 的
		return AssetGCType.actForever--0
	end
	if self:isOnceList(path) then 
		return AssetGCType.actOnce--3
	end
	if self:isScene(path) then 
		return AssetGCType.actCustom--4
	end
	return AssetGCType.actRefCounted--1

end	

AssetJudge.instance = AssetJudge.new()
