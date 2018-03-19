-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: windowModelManager.lua
--  Creator 	: zg
--  Date		: 2017-1-4
--  Comment		: UI上的模型的管理
-- ***************************************************************


WindowModel = BaseClass(WindowControl)


function WindowModel:initialize()
    self.modeHolder = self.transform:Find("ModelRoot").gameObject
    self.transform.localPosition = Vector3(self.transform.localPosition.x, self.transform.localPosition.y, self.transform.localPosition.z + 1000)
    --self.transform.localPosition = Vector3(self.transform.localPosition.x, self.transform.localPosition.y - 1, self.transform.localPosition.z)      --现在我们的模型需要定位到-1

    self.modelCamera = self.gameObject:GetComponentInChildren(Camera)
    self:applyLayer(self.layerDefinition)

    self:createRenderTexture()
end


function WindowModel:applyLayer(layerDefine)
    layerUtility.setLayer(self.gameObject, layerDefine)
    shaderUtility.resetShader(self.gameObject)

    if self.modelCamera ~= nil then
        if self.layerDefinition == 3 then
            self.modelCamera.cullingMask = math.pow(2, -1)
        else
            self.modelCamera.cullingMask = math.pow(2, self.layerDefinition)
        end
    end
end


--停止渲染
function WindowModel:stopRenderer()
    self.isRenderer = false
    self:applyLayer(3)
end


--开始渲染
function WindowModel:startRenderer()
    self.isRenderer = true
    self:applyLayer(self.layerDefinition)
end


function WindowModel:dispose()

end


--创建渲染贴图
function WindowModel:createRenderTexture()
    if self.modelCamera == nil then
        return
    end
 --   self:destroyRenderTexture()
    local renderTexture = RenderTexture(self.options.width, self.options.height, 24, RenderTextureFormat.ARGB32)
    renderTexture.name = "modelRenderTexture"
    renderTexture.antiAliasing = self.options.antiAliasing
    self.modelCamera.targetTexture = renderTexture

    self.targetTextrue = self.modelCamera.targetTexture
    self.modelTexture.mainTexture = self.targetTextrue
end


--销毁渲染贴图
function WindowModel:destroyRenderTexture()
    if self.targetTextrue == nil then
        return
    end
    self.modelCamera.targetTexture = null
    self.targetTextrue:Release()
    Object.Destroy(self.targetTextrue)
end


--隐藏对象
function WindowModel:onDisable()
    self:destroyRenderTexture()
end


--激活对象
function WindowModel:onEnable()
    self:createRenderTexture()
end


ReplaceWindowModel = BaseClass(WindowModel)


function ReplaceWindowModel:setReplaceModelPath(path)
    self.resourcePath = path
    self.gameObject.name = self.resourcePath
    
    if self.asset ~= nil then
        self.asset:ReleaseRef()
        self.asset = nil
    end
    AssetLoader.instance:asyncLoad(self.resourcePath, function (asset)
    	self:callbackModelResourceCompleteImpl(asset)
    end)
end


function ReplaceWindowModel:callbackModelResourceCompleteImpl(asset)
    if asset == nil then
        return
    end

    self.asset = asset
    self.asset:AddRef()

    self:callbackModelResourceComplete(self.asset.mainObject)
end


function ReplaceWindowModel:callbackModelResourceComplete(gameobject)
    if Slua.IsNull(self.modeHolder) then 
        return 
    end 

    GameObjectUtility.ClearChildGameObject(self.modeHolder, true)
    self.modelObject = GameObject.Instantiate(gameobject)
    -- print('####################################')
    -- print(self.modeHolder.transform.childCount)
    
    -- print(self.modeHolder.transform.childCount)
    GameObjectUtility.AddGameObject(self.modeHolder, self.modelObject)
    -- print(self.modeHolder.transform.childCount)

--[[
    local parentTrans = self.modeHolder.transform
    for i=0, parentTrans.childCount-1 do
        local childTrans = parentTrans:GetChild(i)
        print(childTrans.gameObject.name)
        local anim = childTrans.gameObject:GetComponentInChildren(Animator)
        print('anim', anim)
    end

    local anim2 = self.modeHolder:GetComponentInChildren(Animator)
    print('anim2', anim2)
]]--

    self:applyLayer(self.layerDefinition)
end


function ReplaceWindowModel:setTextureSize(width, height)
    self.modelTexture.width = width
    self.modelTexture.height = height or width
end


function ReplaceWindowModel:dispose()
    ReplaceWindowModel.super.dispose(self)
    if self.asset == nil then
        return
    end    

    self.asset:ReleaseRef()
    self.asset = nil
end


WindowModelManager = BaseClass()


function WindowModelManager:ctor()
    self.layerDefintions = {25 ,26, 27, 28, 29, 30, 31}

	self.windowModelList = {}
	self.rendererModelList = {}
end


--添加模型
function WindowModelManager:addModel(modelTexture, script, options)
    options = options or {}
    if type(options.width) ~= "number" then
        options.width = 512
    end
    if type(options.height) ~= "number" then
        options.height = 512
    end
    if type(options.antiAliasing) ~= "number" then
        options.antiAliasing = 2
    end

    if #self.windowModelList > 10 then
        error("too much window model!")
    end

    local layerId = self:getUnusedLayerId()
    if layerId == -1 then
        error("too much render window model :" .. self:getModelString())
    end

    local modelGameobject = self:createModel()
    GameObjectUtility.AddGameObjectFix(modelTexture.gameObject, modelGameobject)
    modelGameobject.transform.localScale = Vector3(360, 360, 360)

    local windowModel = ScriptManager.GetInstance():WrapperWindowControl(modelGameobject, script)

    windowModel.options = options
    windowModel.modelTexture = modelTexture
    -- windowModel.layerDefinition = 3
    windowModel.layerDefinition = layerId
    windowModel:initialize()

    table.insert(self.windowModelList, windowModel)
    return windowModel
end


--删除模型
function WindowModelManager:removeModel(model)
    if model == null then
        return 
    end

    local k = 0
    for i,v in ipairs(self.windowModelList) do
        if v == model then
            k = i
        end
    end
    table.remove(self.windowModelList, k)
    self:stopRenderer(model)
    model:dispose()
    GameObjectUtility.DestroyGameObject(model.gameObject, false)
end


--开始渲染
function WindowModelManager:startRenderer(model)
    if model.isRenderer == true then
        return
    end

    local layerId = self:getUnusedLayerId()
    if layerId == -1 then
        error("too much render window model :" .. self:getModelString())
    end

    model.layerDefinition = layerId
    table.insert(self.rendererModelList, model.layerDefinition, model)

    model:startRenderer()
end


--停止渲染
function WindowModelManager:stopRenderer(model)
    if model.isRenderer == false then
        return
    end
    self.rendererModelList[model.layerDefinition] = nil
    model:stopRenderer()
end


--得到当前未使用过的图层
function WindowModelManager:getUnusedLayerId()
    for i=1, #self.layerDefintions do
        local layer = self.layerDefintions[i]
        if self.rendererModelList[layer] == nil then
            return layer
        end
    end
    return -1
end


--得到模型描述字符串
function WindowModelManager:getModelString()
    local message = "modelPath :"
    for k, v in pairs(self.rendererModelList) do
        message = message .. v.resourcePath
        message = message .. k
        message = message .. "     "
    end
    return message
end


--创建一个渲染贴图
function WindowModelManager:createModel()
    local replaceModel = GameObject("ReplaceModel")
    local cameraModel = GameObject("Camera")
    local modelRoot = GameObject("ModelRoot")
    GameObjectUtility.AddGameObject(replaceModel, cameraModel)
    GameObjectUtility.AddGameObject(replaceModel, modelRoot)

    local modelCamera = cameraModel:AddComponent(Camera)
    modelCamera.clearFlags = CameraClearFlags.SolidColor
    modelCamera.backgroundColor = Color.black
    modelCamera.orthographic = true
    modelCamera.orthographicSize = 1
    modelCamera.farClipPlane = 100
    modelCamera.nearClipPlane = -100
    modelCamera.backgroundColor = Color(0, 0, 0, 0)
    modelCamera.orthographicSize = WindowUtility.instance:getAutoAdpateSize()
    modelCamera.renderingPath = 1

--[[
    local renderTexture = RenderTexture(width, height, 24, RenderTextureFormat.ARGB32)
    renderTexture.name = "modelRenderTexture"
    renderTexture.antiAliasing = antiAliasing
    modelCamera.targetTexture = renderTexture
]]--
    return replaceModel
end


WindowModelManager.instance = WindowModelManager.new()