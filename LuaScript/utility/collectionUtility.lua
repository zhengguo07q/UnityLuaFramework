-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : collectionUtility.lua
--  Creator     : xiewenjian
--  Date        : 2017-4-11
--  Comment     : 表数据转移
-- ***************************************************************


module("collectionUtility", package.seeall)   

--转移字典
function CloneDictionary(dictionary)
	local destDict = {}
	for k, v in pairs(dictionary) do 
		destDict[k] = v
	end
	return destDict
end


--转移列表
function CloneListNQueue(list)
	local destList = {}
	for i = 1, #list do 
		table.insert(destList, list[i])
	end
	return destList
end


-- function CloneQueue(queue)
-- 	local destQueue = {}
-- 	for 
-- end