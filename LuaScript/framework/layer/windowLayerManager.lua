-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: windowLayerManager.lua
--  Creator 	: zg
--  Date		: 2017-1-11
--  Comment		: 
-- ***************************************************************


WindowLayerManager = BaseClass()


WindowLayerManager.layerDict = {}


function WindowLayerManager:builder(scriptResourcePath, layerDefinition)
    local scriptBehaviour = ScriptManager.GetInstance():LoadScriptBehaviourFromResource(scriptResourcePath)
    if scriptBehaviour == nil then 
       print("scriptBehaviour is nil")
    end 
    self:apply(scriptBehaviour.gameObject, layerDefinition)
    return scriptBehaviour
end


function WindowLayerManager:apply(go, layerDefintion)
    WindowUtility.instance:adjustmentPanelDepth(go, layerDefintion.layerIndex)
    layerUtility.setLayer(go, layerDefintion.renderLayerIndex)
end


--得到层的根节点
function WindowLayerManager:getLayerRootObject(layerDefinition)
    local holder = WindowLayerManager.layerDict[layerDefinition]
    if holder ~= nil then
    	return holder.gameObject
    end
end


--清除层里面的所有子对象
function WindowLayerManager:clearLayerObject(layerDefinition)
    local holder = WindowLayerManager.layerDict[layerDefinition]
    if holder ~= nil then
        local layerObject = holder.gameObject
        GameObjectUtility.ClearChildGameObject(layerObject, false)
    end
end


--构建所有的层, 特殊的loading图层已经开始的时候就加入进来了
function WindowLayerManager:buildHolder(rootGo)
	local scene2d = GameObject.Find("UI Root/Scene2d")				--检查scene2d是否有创建

	if scene2d == nil then			
	    local scene2d = GameObject("Scene2d")
	    GameObjectUtility.AddGameObject(rootGo, scene2d)
	end

    for layerName, layerDefinition in pairs(WindowLayerDefinition) do
        local tr = scene2d.transform:Find(layerName)
		local layerGameObject = nil
    	if tr == nil then
	        layerGameObject = GameObject()
	        layerGameObject.name = layerName
	        GameObjectUtility.AddGameObject(scene2d, layerGameObject)
        else
            layerGameObject = tr.gameObject
	    end

        layerHolder = {}
        layerHolder.gameObject = layerGameObject
        layerHolder.layerName = layerName
        layerHolder.layerDefinition = layerDefinition

        WindowLayerManager.layerDict[layerDefinition] = layerHolder
    end
end


--交换两个图层
function WindowLayerManager:swapLayer(srcLayerDef, destLayerDef)
    local destGo = self:getLayerRootObject(destLayerDef)
    if GameObjectUtility.IsExistsChildGameObject(destGo) == true then
        for i = 0, destGo.transform.childCount - 1 do 
            trans = destGo.transform:GetChild(i)
            error(trans.gameObject.name .. "MMP 占聊天的层了")
        end 
        error("Layer definition child object is not nil : " )
        print_t(destLayerDef)
    end

    local srcGo = self:getLayerRootObject(srcLayerDef)	
    local srcChildList = GameObjectUtility.GetChildGameObject(srcGo)
    local srcChildGo
    for i = 1, #srcChildList do
        srcChildGo = srcChildList[i]
        if srcChildGo ~= nil then
	        self:apply(srcChildGo, destLayerDef)
	        GameObjectUtility.AddGameObject(self:getLayerRootObject(destLayerDef), srcChildGo)
	    end
    end
end


WindowLayerManager.instance = WindowLayerManager.new()