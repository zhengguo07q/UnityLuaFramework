-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: sceneInstanceBase.lua
--  Creator 	: zg
--  Date		: 2016-12-16
--  Comment		: 所有的场景类的基础类, 在这里负责装载相关的流程
--                一般需要实现的接口：loadLoaderResource  loadSceneResource  enterScene
-- ***************************************************************


SceneInstanceBase = BaseClass()


function SceneInstanceBase:ctor()
    -- self.lastSceneDefine = nil
    -- self.currentSceneDefine = nil
    
    self.sceneRes = nil
    self.loader = nil                           --场景装载器
    self.loadListLoader = ListLoader.new()      --场景装载器的载入队列
    self.sceneListLoader = ListLoader.new()
    self.delayDestroyLoader = false
end


function SceneInstanceBase:initialize()

end


function SceneInstanceBase:startScene()
    self.maskLoader = WindowLayerManager.instance:builder("UI/Loader/MaskLoader", WindowLayerDefinition.wldLoadingLayer)
    GameObjectUtility.AddGameObject(WindowLayerManager.instance:getLayerRootObject(WindowLayerDefinition.wldLoadingLayer), self.maskLoader.gameObject)
    self.maskLoader:initialize()

    logInfo("SceneInstanceBase:startScene:" .. self.sceneRes.sceneType)
    GL.Clear(false, true, Color.black)
    self:loadLoaderResource()
    self.loadListLoader:setCallback(function()
        -- local co = coroutine.create(function ()
        --     -- Yield(WaitForSeconds(0.5))
        --     self:callbackLoadLoaderComplete()
        --     Yield()
            
        -- end)
        -- coroutine.resume(co)
        self:callbackLoadLoaderComplete()   --目前不需要协程 10.18.xjl
    end)
    self.loadListLoader:load()
end


--这里放入装载器需要的资源
function SceneInstanceBase:loadLoaderResource()
    --获取加载界面所需的资源
    local needAssets = SceneSwitchUtility.instance:getLoaderRes(self.sceneRes.sceneLoadResouece)

    for i=1, #needAssets do
        self.loadListLoader:putWaitLoad(needAssets[i])
    end
end


--场景主循环
function SceneInstanceBase:update()
    GL.Clear(false, true, Color.black)   


    if self.loadListLoader ~= nil then
        self.loadListLoader:update()
	else
		self.loadListLoader = ListLoader.new()
    end
    if self.sceneListLoader ~= nil then
        self.sceneListLoader:update() 
        if self.loader ~= nil and self.sceneListLoader and self.sceneListLoader.combProgress ~= nil then
            --self.loader:setMaxValue(0.8)
            self.loader:setLoadProgress(self.sceneListLoader.combProgress * 0.9)   
        end
	else 
		self.sceneListLoader = ListLoader.new()
    end
    
    WindowCamera.instance:update()
end


--启动载入器流程， 这里载入器本身已经装载完成了
function SceneInstanceBase:callbackLoadLoaderComplete(resourceName)
    if resourceName ~= nil then
        logInfo("场景名称 =" .. resourceName .. "................")
    end

    if self.sceneRes.sceneLoadResouece ~= nil then  --没有特殊的场景装载需求, 就是完全没有载入过程
        self.loader = WindowLayerManager.instance:builder(self.sceneRes.sceneLoadResouece, WindowLayerDefinition.wldLoadingLayer)
        GameObjectUtility.AddGameObject(WindowLayerManager.instance:getLayerRootObject(WindowLayerDefinition.wldLoadingLayer), self.loader.gameObject)
        self.loader:initialize()
        --self.loader:setLoadProgress(0.9)
    end

    if SceneSwitchManager.instance.delayDestroy then
        --切回到主场景时如果有lastWindow需要延迟销毁loader（保证打开窗口）
        if SceneSwitchManager.instance.currentSceneInstance.sceneRes.sceneType == SceneSwitchType.sstMainUI 
            and applicationGlobal.sceneSwitchManager.lastSceneWindow ~= nil then
            self.delayDestroyLoader = true
        else
            self.delayDestroyLoader = false
        end
        SceneSwitchManager.instance:delayDestoryScene()     
    end

    self:loadSceneResource()                        --下一个场景需要的东西
    self.sceneListLoader:setCallback(function()
        self:callbackSceneLoaderComplete()
    end)
    self.sceneListLoader:load()
end


function SceneInstanceBase:callbackSceneLoaderComplete(resourceName)
    self:enterScene()
end


function SceneInstanceBase:loadPerfabUI(callback)
    self.prepareUIList = self:getShouldPrepareUI()
    if self.prepareUIList ~= nil then 
        --self.loader:setMaxValue(0.95)
        self.prepareUICount = #self.prepareUIList
        self:loadUI(self.prepareUIList[1], function() callback()
            end)
    else 
        callback()
    end  
end


function SceneInstanceBase:loadUI(panelData, callback)
    if #self.prepareUIList == 0 or panelData == nil then 
            callback()
        return 
    end 

    WindowStack.instance:openWindow(panelData, nil, false, {callback = function(panel)   
       panel:close()
       table.remove(self.prepareUIList, 1)
       --self.loader:setMaxValue(0.1 + (1 - #self.prepareUIList/self.prepareUICount) * 0.85)
       self:loadUI(self.prepareUIList[1], function() callback() end)
    end}, true)
end 


function SceneInstanceBase:getShouldPrepareUI()
    local allPrepareUIList = self:prepareUI()
    if allPrepareUIList == nil then 
        return nil
    end 

    -- for i, v in pairs(allPrepareUIList) do 
    --     if WindowStack.instance:getWindow(v) ~= nil then 
    --         table.remove(allPrepareUIList, i)
    --     end
    -- end 
    return allPrepareUIList

end

function SceneInstanceBase:prepareUI()
    return nil
end


--这里放入下一个场景需要的资源
function SceneInstanceBase:loadSceneResource()
    
end


--进入场景实现
function SceneInstanceBase:enterScene()

end


function SceneInstanceBase:afterEnterScene() 

    if self.loadListLoader ~= nil then
        self.loadListLoader:dispose()
        self.loadListLoader = nil    
    end

    if self.sceneListLoader ~= nil then
        self.sceneListLoader:dispose()    
        self.sceneListLoader = nil
    end 

    SceneSwitchManager.instance:notify(SceneSwitchEvent.seInto, self)             --通告场景切换的流程
    if self.loader ~= nil then
        self.loader:setLoadProgress(1)
        -- GameObjectUtility.DestroyGameObject(self.loader.gameObject, false)         --销毁掉场景

        if self.delayDestroyLoader then     --延迟1秒销毁loader
            self.waitTime = LuaTimer.Add(1000, 2000, function ()
                self.loader:destroySelf()
                self.maskLoader:destroySelf()
                LuaTimer.Delete(self.waitTime)
                self.waitTime = nil
            end)
        else
            self.loader:destroySelf()
            self.maskLoader:destroySelf()
        end
    end

    actionPriority.runing = true
    actionPriority.startWork()

    AssetLoader.instance:clearAssets()
    Resources.UnloadUnusedAssets()


end


function SceneInstanceBase:exitScene()
    logInfo("SceneInstanceBase:exitScene:" .. self.sceneRes.sceneType)
    actionPriority.stopWork() 
end


function SceneInstanceBase:destroySceneNow()
    
end


function SceneInstanceBase:destoryScene()

end


function SceneInstanceBase:dispose()
    
end