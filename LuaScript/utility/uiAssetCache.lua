-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : uiAssetCache.lua
--  Creator     : liyibao
--  Date        : 2017-08-25
--  Comment     : 用于处理UI上的子UI预设创建和缓存
-- ***************************************************************


module("uiAssetCache", package.seeall)


--获取一个资源
function getAsset(uiScript, abPath, parentGo, panelGo, offsetDepth, call, scriptName)
	local script =  nil
	local go = nil
	
	--加载完成
	local loadComplete = function(script) 
		local depth = panelGo:GetComponent("UIPanel").depth + offsetDepth
    	GameObjectUtility.SetParent(script.gameObject, parentGo, false)
		WindowUtility.instance:adjustmentPanelDepth(script.gameObject, depth)   --调整层次
		
		script.gameObject:SetActive(true)
		call(script)
	end

	if uiScript._scriptList == nil then
		uiScript._scriptList = {}
	end
	if uiScript._assetList == nil then
		uiScript._assetList = {}
	end
	if uiScript._assetList[abPath] == nil then
		AssetLoader.instance:asyncLoad(abPath, function(asset)
			--父节点隐藏了
			if uiScript == nil or parentGo == nil or panelGo == nil or parentGo.activeInHierarchy == false then
				return
			end	
			--如果两个在同时加载，第二个直接返回
			if uiScript._scriptList[abPath] ~= nil then
				loadComplete(uiScript._scriptList[abPath])
				return
			end

			uiScript._assetList[abPath] = asset
			asset:AddRef()

	        go = GameObjectUtility.AddGameObjectPrefab(parentGo, asset.mainObject)
	        go.name = asset.mainObject.name
	        script = ScriptManager.GetInstance():WrapperWindowControl(go, scriptName)
	        script.rootScript = uiScript
	        uiScript._scriptList[abPath] = script

			if script.init ~= nil then
		        script:init()
		    end
			loadComplete(script)
		end)
	else
		loadComplete(uiScript._scriptList[abPath])
	end
end


--卸载资源
function destroyAssets(uiScript)
	if uiScript._assetList ~= nil then
		for k, v in pairs(uiScript._assetList) do
			if v ~= nil then
				v:ReleaseRef()
				v = nil
			end
		end
		uiScript._assetList = {}
	end
end


--GameObject缓存（缓存创建对象，子节点必须有一个对象，没有会创建空对象）
function createGameObjectsSub(goParent, goName, goNumber)
	local goItem = GameObjectUtility.Find(goName, goParent)

	--隐藏所有
	if goItem ~= nil then
		goItem:SetActive(false)
	end

	local index = 1
	local goTemp = GameObjectUtility.Find(goName .. index, goParent)
	while goTemp ~= nil do
		goTemp:SetActive(false)
		index = index + 1
		goTemp = GameObjectUtility.Find(goName .. index, goParent)
	end

	local gos = {}
	if goNumber > 0 then
		local go = createGameObject(goParent, goName, goItem)
		go:SetActive(true)
		table.insert(gos, go)
	end

	for i=1, goNumber-1 do
		local go = createGameObject(goParent, goName .. i, goItem)
		go:SetActive(true)
		table.insert(gos, go)
	end

	return gos
end


--GameObject缓存（使用预设对象创建缓存）
function createGameObjects(goParent, goName, goItem, goNumber)
	--隐藏所有
	local index = 1
	local goTemp = GameObjectUtility.Find(goName .. index, goParent)
	while goTemp ~= nil do
		goTemp:SetActive(false)
		index = index + 1
		goTemp = GameObjectUtility.Find(goName .. index, goParent)
	end

	local gos = {}
	for i=1, goNumber do
		local go = createGameObject(goParent, goName .. i, goItem)
		go:SetActive(true)
		table.insert(gos, go)
	end

	return gos
end


--创建缓存节点
function createGameObject(goParent, goName, goItem)
	local go = GameObjectUtility.Find(goName, goParent)

	if go == nil then
		if goItem ~= nil then			
			go = GameObjectUtility.AddGameObjectPrefab(goParent, goItem)
		else
	        go = GameObject(goName)
	        GameObjectUtility.SetParent(go, goParent, false)
		end
		layerUtility.setLayer(go, goParent.layer)
		go.name = goName
	end
	go:SetActive(true)

	return go
end