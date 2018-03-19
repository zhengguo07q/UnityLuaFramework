-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: syntaxUtility.lua
--  Creator 	: zg
--  Date		: 2016-11-13
--  Comment		: 
-- ***************************************************************


module("syntaxUtility", package.seeall)


function createEnum(tb, index)
	if type(tb) ~= "table" then
		error("Sorry, it's not table, it is " .. type(tb) .. ".")
	end
    local enumtbl = {} 
    local enumindex = index or 0 
    for i, v in ipairs(tb) do 
        enumtbl[v] = enumindex + i 
    end 
    return enumtbl
end


function string2Table(str)
	return loadstring("return "..str)
end


function reverseKeyValue(tb)
	local tb2 = {}
	table.foreach(tb, function(k, v)
		tb2[v] = k
	end)
end


function mergeTable(tb1, tb2)
	table.foreach(tb2, function(k, v)
		tb1[k] = v
	end)
end


--深拷贝
function deepCopy(object)
	local lookupTable = {}
	local function copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookupTable[object] then
			return lookupTable[object]
		end
		local newTable = {}
		lookupTable[object] = newTable
		for index, value in pairs(object) do
			newTable[copy(index)] = copy(value)
		end
		return setmetatable(newTable, getmetatable(object))
	end
	return copy(object)
end


function checkTableKey(table)
	
end


function sortById(a, b)
	if a.id < b.id then
		return true
	end
	return false
end


function getTrueOrFalse(num)
	if num == 1 then
		return true
	else
		return false
	end
end


function addDelegate(reftb, delegate, delegateName, callback)
	reftb[delegate.name .. delegateName] = callback
	delegate[delegateName] = {'+=', callback}
end


function removeDelegate(reftb, delegate, delegateName)
	callback = reftb[delegate.name .. delegateName] 
	delegate[delegateName] = {'-=', callback}
end


--移除对象（适用list）
function removeItem(list, item, isAll)
	local rmCount = 0
	for i = 1, #list do
		if list[i - rmCount] == item then
			table.remove(list, i - rmCount)
			if isAll then
				rmCount = rmCount + 1
			else
				break
			end
		end
	end
end


--获取table长度（适用key非顺序的table）
function getTableCount(listTable)
    local count = 0
    if listTable ~= nil then
        for k,v in pairs(listTable) do
            count = count + 1
        end
    end

    return count
end


function createItem(parentTransform, goPrefab, scriptName)
	local go = Object.Instantiate(goPrefab)
	go:SetActive(true)
	local luaTabel = ScriptManager.GetInstance():WrapperWindowControl(go, scriptName)
    go.transform.parent = parentTransform
    GameObjectUtility.LocalPosition(go, 0, 0, 0)
    go.transform.localRotation = Quaternion.identity
    GameObjectUtility.LocalScale(go, 1, 1, 1)
    return go, luaTabel	
end


instances = {}
function getInstance(scriptRes)
	if type(scriptRes) ~= "string" then
		return
	end

	if instances[scriptRes] == nil then
		local go = GameObject(scriptRes) 
		go.transform.parent = SingletonObject.Instance.ParentGameObject.transform
	--	print(go, scriptRes)
		require(scriptRes)
		
		local scriptControl = ScriptManager.GetInstance():WrapperWindowControl(go, scriptRes)
		scriptControl.scriptRes = scriptRes
		scriptControl:initialize()
		instances[scriptRes] = scriptControl
	end

	return instances[scriptRes]
end


function destroyInstance(instance)
	local saveInstance = instances[instance.scriptRes]

	if saveInstance == nil then
		error("destroy instance failure , not instance error : " .. instance.scriptRes)
	end

	instance:dispose()
	GameObject.Destroy(instance.gameObject)

	instances[instance.scriptRes] = nil
end