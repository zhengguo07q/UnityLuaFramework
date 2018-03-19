-- -- ***************************************************************
-- --  Copyright(c) Yeto
-- --  FileName	: gameObjectUtility.lua
-- --  Creator 	: zg
-- --  Date		: 2016-12-30
-- --  Comment		: 
-- -- ***************************************************************


-- module("gameObjectUtility", package.seeall)


-- function findInParents(go, clazz)
-- 	if go == nil then
-- 		return
-- 	end

-- 	local comp = go:GetComponent(clazz)
-- 	if comp == nil then
-- 		local t = go.transform.parent
-- 		while t ~= nil and comp == nil do
-- 			comp = t.gameObject:GetComponent(clazz)
-- 			t = t.parent
-- 		end
-- 	end

-- 	return comp
-- end


-- function findAndGet(path,  parentGo, clazz)
--     local bindGo = find(path, parentGo, false)
--     if bindGo == nil then
--         error("gameobject utility find error , path : " + path)
--     end
--     return bindGo:GetComponent(clazz)
-- end


-- function findAndAdd(path, parentGo, clazz)
--     local bindGo = find(path, parentGo, false)
--     if bindGo == nil then
--         error("gameobject utility find error , path : " + path)
--     end
--     return bindGo:AddComponent(clazz)
-- end


-- function getIfNotAdd(bindGo, clazz)
--     local component = bindGo:GetComponent(clazz)
--     if component == nil then
--         component = bindGo:AddComponent(clazz)
--     end
--     return component
-- end


-- function find(path, parentGo, isThrow)
--     if parentGo == nil then
--         local go = GameObject.Find(path)
--     else
--         local trans = parentGo.transform:Find(path)
--         if trans ~= nil then
--             return trans.gameObject
--         end
--     end
--     if isThrow == true and go == nil then
--         error("gameobject utility find error , path : " + path)
--     end
--     return go
-- end


-- function findAndAddChild(path, parentGo, childName, clazz)
--     local bindGo = find(path, parentGo)
--     if bindGo == nil then
--         error("gameobject utility find error , path : " + path)
--     end
--     local childGo = GameObject()
--     if childName ~= nil then
--         childGo.name = childName
--     end
--     childGo.transform.parent = bindGo.transform
--     childGo.transform.localPosition = Vector3.zero
--     childGo.transform.localScale = Vector3.one
--     childGo.transform.localRotation = Quaternion.identity
--     return childGo:AddComponent(clazz)
-- end


-- function addGameObject(parentGo, childGo)
--     childGo.transform.parent = parentGo.transform
-- 	if string.find(childGo.gameObject.name, "ChatPanel") ~= nil then 
--         childGo.transform.localPosition = Vector3(-700, 0, 0)
--     else
-- 		childGo.transform.localPosition = Vector3.zero
-- 	end
--     childGo.transform.localScale = Vector3(1, 1, 1)
--     childGo.transform.localRotation = Quaternion.identity
--     return childGo
-- end


-- function addGameObjectPrefab(parent, prefab)
--     local go = nil
--     if prefab.activeSelf == true then
--         go = GameObject.Instantiate(prefab)  
--     else
--         prefab:SetActive(true)
--         go = GameObject.Instantiate(prefab)
--         prefab:SetActive(false)
--     end
    
--     if go ~= nil and parent ~= nil then
--         local t = go.transform
--         t.parent = parent.transform
--         t.localPosition = Vector3.zero
--         t.localRotation = Quaternion.identity
--         t.localScale = Vector3.one
--         go.layer = parent.layer
--     end
--     return go
-- end


-- function addGameObjectFix(parentGo, childGo)
--     childGo.transform.parent = parentGo.transform
--     return childGo
-- end


-- function createGameObject(name, clazz)
--     local go = GameObject()
--     if name ~= nil and clazz(name) == "string" then
--         go.name = name
--     end 
--     return go:AddComponent(clazz)
-- end


-- function createNilGameObject(parentGo, name)
--     local go = GameObject()
--     if name ~= nil then
--         go.name = name
--     end
--     if parentGo ~= nil then
--         go.transform.parent = parentGo.transform
--     end
    
--     go.transform.localScale    = Vector3.one
--     go.transform.localPosition = Vector3.zero
--     return go
-- end


-- function removeGameObject(childGo)
--     childGo.transform.parent = nil
-- end


-- function destoryGameObject(go, isImmediate)
--     if isImmediate == false then
--         UnityEngine.Object.DestroyObject(go)
--     else
--         UnityEngine.Object.DestroyImmediate(go)
--     end
-- end


-- function clearChildGameObject(parentGo, isImmediate)
--     local parentTrans = parentGo.transform
--     for i = parentTrans.childCount-1, 0, -1 do
--         local childTrans = parentTrans:GetChild(i)
--         destoryGameObject(childTrans.gameObject, isImmediate)
--     end
-- end


-- function isExistsChildGameObject(parentGo)
--     if parentGo.transform.childCount ~= 0 then
--         return true
--     end
--     return false
-- end


-- function getChildGameObject(parentGo)
--     local childList = {}
--     for i=0, parentGo.transform.childCount - 1 do
--         local trans = parentGo.transform:GetChild(i)
--         table.insert(childList, trans.gameObject)
--     end
--     return childList
-- end

