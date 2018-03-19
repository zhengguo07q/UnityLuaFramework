-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : Asset.lua
--  Creator     : sf
--  Date        : 2017-5-8
--  Comment     :
-- ***************************************************************

AssetList = BaseClass()

function AssetList:ctor()
	self.assetList = {}
end


function AssetList:get(name)
	if name == nil or name == "" then
		return nil
	end
	for i, v in pairs(self.assetList) do
		if v.name == name then
			return v
		end
	end
	return nil
end


function AssetList:exsits(name)
	local asset = self:get(name)
	if asset == nil then
		return false
	else
		return true
	end
end


function AssetList:put(asset)
	local asset2 = self:get(asset.name)
	if asset2 == nil then
		table.insert(self.assetList, asset)
		return asset
	else
		Debug.LogError("asset already exists, name:" .. asset.name)
		return asset2
	end
end


function AssetList:putWithoutCheck(asset)
	table.insert(self.assetList, asset)
end


-- function AssetList:printDebug()
-- 	local desc = ""
-- 	for i, v in pairs(self.assetList) do
-- 		desc = desc .. v:toString()
-- 	end
-- 	Debug.LogError("AssetList Count : " .. #self.assetList .. "    List :  " .. desc)
-- end


function AssetList:printNeverUseRef()
	local desc = ""
	local count = 0
	for i, v in pairs(self.assetList) do
		if v.gcType == AssetGCType.actRefCounted then
			if not v:IsRefUsed() then
				count = count + 1
				desc = desc .. v:toString()
			end
		end
	end
	Debug.LogError("never user refcount : " .. count .. "    List :  " .. desc)
end


function AssetList:printRefNotZero()
	local desc = ""
	local count = 0
	for i, v in pairs(self.assetList) do
		if v.gcType == AssetGCType.actRefCounted then
			if not v:IsUnused() then
				count = count + 1
				desc = desc .. v:toString()
			end
		end
	end
	Debug.LogError("used assets count : " .. count .. "    List :  " .. desc)
end
