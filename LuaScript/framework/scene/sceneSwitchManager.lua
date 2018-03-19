-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: sceneSwitchManager.lua
--  Creator 	: zg
--  Date		: 2016-12-16
--  Comment		: 
-- ***************************************************************


--场景切换事件
SceneSwitchEvent = 
{
	seNull		= 1,
	seCreate	= 2,
	seExit		= 3,
	seDestory	= 4,
	seInto		= 5,
}


--场景切换的类型
SceneSwitchType = 
{
	sstLogin		= 1,    -- 登录
	sstBigmap		= 2,
	sstBattle		= 3,
	sstHouse		= 4,
	sstLoginSwitch 	= 5,
	sstMainUI 		= 6,    
	sstUniverse 	= 7,	-- 宇宙图
	sstOwnPlanet 	= 8,	-- 我的星球
	sstTower        = 9,    -- 先祖遗迹
}


--场景loader需要先加载的资源
SceneLoaderRes = 
{
	commonLoader = "UI/Loader/CommonLoader",
	pvpLoader = "UI/Loader/PvpLoadingPanel",
}


SceneSwitchManager = BaseClass()
SceneSwitchManager.instance = nil


function SceneSwitchManager:initialize()
end


function SceneSwitchManager:ctor()
	self.listeners = {}							-- 监听器
	self.lastSceneRes = nil 					-- 上一次场景资源
	self.lastSceneInstance = nil 				-- 上一次载入的场景实例
	self.currentSceneInstance = nil 			-- 当前载入的场景实例
    self.lastSceneWindow = nil                  -- 进入战斗需要记录打开上一次的模块id
	SceneSwitchManager.instance = self
	self.delayDestroy = false                   -- 延迟销毁
end


--添加场景监听器
function SceneSwitchManager:addListener(listener)
	table.insert(self.listeners, listener)
end


--删除场景监听器
function SceneSwitchManager:removeListener(listener)
	print("SceneSwitchManager----removeListener--------")
	-- table.remove(self.listeners, listener)
	for i=1, #self.listeners do
        if self.listeners[i] == listener then
            table.remove(self.listeners, i)
            break
        end
    end
end


--通告场景监听器事件
function SceneSwitchManager:notify(evtType, sceneInstance)
	for _, listener in ipairs(self.listeners) do
		listener(evtType, sceneInstance)
	end
end


--进入场景
function SceneSwitchManager:enterScene(sceneRes)
	logInfo("SceneSwitchManager:enterScene:" .. sceneRes.sceneType)

	AssetDelayDownloadManager.instance:doWhenSwitchScene(sceneRes)

	if self.currentSceneInstance ~= nil then
		if self.currentSceneInstance.sceneRes.sceneType == sceneRes.sceneType then
    	    self.delayDestroy = false
    	else
    		self.delayDestroy = true             --需要延迟销毁
    	end
		self:notify(SceneSwitchEvent.seExit, self.currentSceneInstance)
		self.currentSceneInstance:exitScene()
		self.lastSceneInstance = self.currentSceneInstance
        
        if not self.delayDestroy then
            self:delayDestoryScene()	   --不需要延迟销毁的场景立即执行销毁
	    end
	    self:destroySceneNow()
	end

	self:createScene(sceneRes)
end


--创建一个场景
function SceneSwitchManager:createScene(sceneRes)
	logInfo("SceneSwitchManager:createScene:" .. sceneRes.sceneType)
    GameObjectUtility.ClearChildGameObject(self.gameObject, true)
    local sceneGo = GameObjectUtility.CreateNullGameObject(self.gameObject, sceneRes.sceneType)
    self.currentSceneInstance = ScriptManager.GetInstance():WrapperWindowControl(sceneGo, sceneRes.sceneScript)
    self:notify(SceneSwitchEvent.seCreate, self.currentSceneInstance)
    self.currentSceneInstance:initialize()
    self.currentSceneInstance.sceneRes = sceneRes

    self.currentSceneInstance:startScene()

    self.currentSceneInstance.currentSceneDefine = sceneRes
    if self.lastSceneInstance ~= nil then									--保存上一次场景资源
        self.lastSceneRes = self.lastSceneInstance.sceneRes
        self.currentSceneInstance.lastSceneDefine = self.lastSceneInstance.currentSceneDefine
    end
end


-- 立刻销毁场景（有些需要立即销毁的东西放下这里）
function SceneSwitchManager:destroySceneNow()
	if self.lastSceneInstance ~= nil then
		self.lastSceneInstance:destroySceneNow()
	end
end


--延迟销毁场景
function SceneSwitchManager:delayDestoryScene()
    if self.lastSceneInstance ~= nil then
    	logInfo("SceneSwitchManager:delayDestoryScene:" .. self.lastSceneInstance.sceneRes.sceneType)
        self:notify(SceneSwitchEvent.seDestory, self.lastSceneInstance)
        self.lastSceneInstance:destoryScene()
        self.lastSceneInstance:dispose()
        GameObjectUtility.DestroyGameObject(self.lastSceneInstance.gameObject, false)
    end
    AssetLoader.instance:clearAssets()
    Resources.UnloadUnusedAssets()
   
    System.GC.Collect()
    collectgarbage("collect")
end

