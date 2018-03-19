-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: applicationGlobal.lua
--  Creator 	: zg
--  Date		: 2016-11-10
--  Comment		: 全局信息
-- ***************************************************************


module("applicationGlobal", package.seeall)
  

--服务器配置
serverConfig    = nil


--可能未拷贝资源时就用到了AlertPanel，所以如需用到需要先调用这里初始化一下，预先从Resource下加载一个
function prepareAlert()
    alert = ScriptManager.GetInstance():LoadScriptBehaviourFromStartup("UI/Alert/AlertPanel")
    WindowUtility.instance:adjustmentPanelDepth(alert.gameObject, WindowLayerDefinition.wldAlertLayer.layerIndex)
    layerUtility.setLayer(alert.gameObject, WindowLayerDefinition.wldAlertLayer.renderLayerIndex)
    GameObjectUtility.AddGameObject(WindowLayerManager.instance:getLayerRootObject(WindowLayerDefinition.wldAlertLayer), alert.gameObject)
    alert:initialize()   
end


--进入登录场景之后
function enterLoginBefore()
    tooltip = WindowLayerManager.instance:builder("UI/Tooltip/TooltipPanel", WindowLayerDefinition.wldTooltipLayer)
    
    if alert ~= nil then   --销毁登陆之前预先创建的
        GameObject.Destroy(alert.gameObject)
    end
    alert = WindowLayerManager.instance:builder("UI/AlertTip/AlertPanel", WindowLayerDefinition.wldAlertLayer)

    reconnect = WindowLayerManager.instance:builder("UI/Reconnect/ReConnectPanel", WindowLayerDefinition.wldReconnectLayer)
    loading = WindowLayerManager.instance:builder("UI/Common/CommonLoadingPanel", WindowLayerDefinition.wldReconnectLayer)

    GameObjectUtility.AddGameObject(WindowLayerManager.instance:getLayerRootObject(WindowLayerDefinition.wldTooltipLayer), tooltip.gameObject)
    GameObjectUtility.AddGameObject(WindowLayerManager.instance:getLayerRootObject(WindowLayerDefinition.wldAlertLayer), alert.gameObject)
    GameObjectUtility.AddGameObject(WindowLayerManager.instance:getLayerRootObject(WindowLayerDefinition.wldReconnectLayer), reconnect.gameObject)
    GameObjectUtility.AddGameObject(WindowLayerManager.instance:getLayerRootObject(WindowLayerDefinition.wldReconnectLayer), loading.gameObject)

    tooltip:initialize()
    alert:initialize()
    reconnect:initialize()
    loading:initialize()

 	WindowQueueManager.instance:initialize()
    WindowQueueRegister:initialize()

    -- 引导层
    guidePanel = WindowLayerManager.instance:builder("UI/Guide/GuidePanel", WindowLayerDefinition.wldGuideLayer)
    GameObjectUtility.AddGameObject(WindowLayerManager.instance:getLayerRootObject(WindowLayerDefinition.wldGuideLayer), guidePanel.gameObject)
    guidePanel:initialize()

    -- 升级界面
    playerUILevelUpPanel = WindowLayerManager.instance:builder("UI/MainPanel/MainUILevelUpPanel", WindowLayerDefinition.wldDiglogLayer)
    GameObjectUtility.AddGameObject(WindowLayerManager.instance:getLayerRootObject(WindowLayerDefinition.wldDiglogLayer), playerUILevelUpPanel.gameObject)
    playerUILevelUpPanel:initialize()

    WindowCamera.instance:initialize()
end


logger                   = syntaxUtility.getInstance("framework/logger/loggerManager")
audioPlay 				 = syntaxUtility.getInstance("framework/audio/audioPlay")
sceneSwitchManager 		 = syntaxUtility.getInstance("framework/scene/sceneSwitchManager")

effectCache              = syntaxUtility.getInstance("battle/effect/effectCache")
sceneObjectEffect        = syntaxUtility.getInstance("battle/sceneObject/sceneObjectEffect")
assetLoader              = syntaxUtility.getInstance("framework/loader/assetLoader")