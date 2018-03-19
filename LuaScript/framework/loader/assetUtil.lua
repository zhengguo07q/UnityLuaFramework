-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : assetUtil.lua
--  Creator     : sf
--  Date        : 2017-5-8
--  Comment     : 
-- ***************************************************************

AssetUtil = BaseClass()


function AssetUtil:getAssetWWWPath(path)
	local readPath = self:getAssetAbsolutePath(path)
	
	if string.find(readPath, "jar:file:///") ~= nil then  --判断是否为android下的streamingAssets
		return readPath
	end
	
	if applicationConfig.macro.UNITY_EDITOR then 
		readPath = "file:///" .. readPath
	else
		readPath = "file://" .. readPath
	end
	return readPath
end


--获取Asset完整路径
function AssetUtil:getAssetAbsolutePath(path)
	local bundleName = self:addfirstChard(path)   --实际用到的bundleName
	if bundleName == nil then 
		return ""
	end
    -- if assetBB.localizationAssetList[bundleName] ~= nil then   --如果是国际化资源需要重新按当前语言获取
    --     bundleName = bundleName .. "_" .. languageUtility.getResourceLocalizationName() .. "_"
    -- end
    bundleName = assetBB.getLocalizationAssetName(bundleName)
  
	local abpath = nil
	if applicationConfig.macro.UNITY_EDITOR and applicationConfig.macro.UNITY_IOS then          
		abpath = "AssetBundle/IOS/"
		abpath = UnityEngine.Application.dataPath .. "/../" .. abpath .. bundleName .. ".ab"
	elseif applicationConfig.macro.UNITY_EDITOR and applicationConfig.macro.UNITY_ANDROID then  

	    abpath = "AssetBundle/Android/"
		abpath = UnityEngine.Application.dataPath .. "/../" .. abpath .. bundleName .. ".ab"


		--方便测试
		-- abpath = AssetUtility.instance:getResourcePath(bundleName)..".ab"                          	
	else
		abpath = AssetUtility.instance:getResourcePath(bundleName)..".ab"                             --移动平台
	end

    LogUtility.ForLogAB(bundleName)
   -- print("加载ab===========  "..abpath)
	return abpath
end


function AssetUtil:addfirstChard(path)
	local dest_filename = ""
	if string.find(path, "/") == nil then
		logInfo("path中不存在'/'  :"..path)
	end
	local fn_flag2 = string.find(path, "/")
	
	if fn_flag1 then 
		local dir = string.match(path, "(.+)\\[^\\]*")
		if dir == nil or dir == "" then 
			return path
		end
		dest_filename = string.match(path, ".+\\([^\\]*)$")
		return dir .. "/" ..string.sub(self:getFirstFilChar(dir),1,1) .. dest_filename
	end 
	
	if fn_flag2 then
		local dir2 = string.match(path, "(.+)/[^/]*")
		if dir2 == nil or dir2 == "" then 
			return path
		end
		dest_filename = string.match(path, ".+/([^/]*)")
		return dir2 .. "/" ..string.sub(self:getFirstFilChar(dir2),1,1) .. dest_filename
	end 
end


--传路径  
function AssetUtil:getFirstFilChar(path)
	local index = string.find(path, "/")
	if  index ~= nil then 
		return self:getFirstFilChar(string.sub(path,index + 1))
	end
	return path
end


-- function AssetUtil:encryptData(data)
-- 	return 
-- end


-- function AssetUtil:decryptData(data)
-- 	return 
-- end

AssetUtil.instance = AssetUtil.new()