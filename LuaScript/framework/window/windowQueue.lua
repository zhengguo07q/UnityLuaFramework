-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: windowQueue.lua
--  Creator 	: xiewenjian
--  Date        : 2017-4-11
--  Comment	    : 回退队列
-- ***************************************************************


enumWindowEventType = 
{
    wetWindow   = 1,
    wetScene    = 2,
}


windowQueuePath = 
{
	eventType,		--执行的事件类型
	pathName,     	--执行的事件参数
	window,
	lastWindow,
	isGotoData,     --是否需要设置跳转数据
   	nextSceneDefine,
    lastSceneDefine,
    isAuto
}


WindowQueue = BaseClass()


function WindowQueue:ctor()
	self.cacheQueuePathList = {}		
	self.queuePathList = {}				--必须要执行的事件
	self.conditionList = {}				--关闭时候的条件
end


function WindowQueue:addQueuePath(queuePath)
	table.insert(self.cacheQueuePathList, queuePath)
end


function WindowQueue:addConditionPath(queuePath)
-- 重复加入
	table.insert(self.conditionList, queuePath)
end


function WindowQueue:isExecute()
	return self.isStartExecute
end


function WindowQueue:reset()
	self.isStartExecute = true
	self.isExecuted =false
	self.queuePathList = {}
    self.queuePathList = collectionUtility.CloneListNQueue(self.cacheQueuePathList)
end


function WindowQueue:getNextPath()
    return self.queuePathList[1]
end


--检查上一个执行路径是否完成
function WindowQueue:checkLastPath(eventType, windowEvt, windowRes, sceneEvt, sceneBase)

    if #self.queuePathList < 1 then
        return false
    end

    local lastQueuePath = self.queuePathList[1]

    --上一个窗口载入完成
    if lastQueuePath.eventType == enumWindowEventType.wetWindow and windowEvt == WindowStack.WindowEvent.weBeforeClose and lastQueuePath.window == windowRes then 
        return true
    elseif lastQueuePath.eventType == enumWindowEventType.wetScene and sceneEvt == SceneSwitchEvent.seInto and lastQueuePath.nextSceneDefine == sceneBase.currentSceneDefine then --上一个场景载入完成
        return true
    end

    return false 
end


--执行下一个路径
function WindowQueue:executeNextPath()
    if self.isExecuted then
        table.remove(self.queuePathList, 1)
    end

    local nextQueuePath = nil 
    if #self.queuePathList >= 1 then
        nextQueuePath = self.queuePathList[1]
    end

    if nextQueuePath ~= nil then 
        if nextQueuePath.eventType == enumWindowEventType.wetWindow then --上一个窗口载入完成        
            if nextQueuePath.uiShopType then shopBB.uiSelectType = nextQueuePath.uiShopType end
          
            local window = WindowStack.instance.windowCacheList[nextQueuePath.window]
            if self.nguiLayer == nil then self.nguiLayer = LayerMask.NameToLayer("UI") end
            if window and window.gameObject.layer ~= self.nguiLayer then
                layerUtility.setLayer(window.gameObject, self.nguiLayer)
            end  

            WindowStack.instance:openWindow(nextQueuePath.window, nil, false, {callback = function(panel)
                if self.callback ~= nil then self.callback(panel) end
            end})
        elseif nextQueuePath.eventType == enumWindowEventType.wetScene then --上一个场景载入完成
            WindowQueueManager.instance.sceneEventController:enterScene(nextQueuePath.nextSceneDefine)
        end 
    end

    self.isExecuted = true
end


--检查当前的条件
function WindowQueue:checkConditionList(eventType, windowEvt, windowRes, sceneEvt, sceneBase)
    -- print ("<color=yellow> ________________ checkConditionList  windowEvt self.conditionList_______________ </color>", windowEvt, #self.conditionList)
    if WindowQueueManager.instance.sceneEventController.lastSceneWindow ~= nil then             --在存在上一个场景的时候， 条件不起作用
        return
    end

    local queuePath = nil 
    for i = 1, #self.conditionList do 
        queuePath = self.conditionList[i]
        if queuePath.eventType == eventType and queuePath.eventType == enumWindowEventType.wetScene then 
            if sceneEvt == SceneSwitchEvent.seInto and queuePath.lastSceneDefine == sceneBase.lastSceneDefine and queuePath.nextSceneDefine == sceneBase.currentSceneDefine then 
               WindowQueueManager.instance:resetGoto()
            end 
        elseif queuePath.eventType == eventType and queuePath.eventType == enumWindowEventType.wetWindow then 
            if queuePath.window == windowRes and windowEvt == WindowStack.WindowEvent.weCloseBefore then 
                WindowQueueManager.instance:resetGoto()
            elseif queuePath.window == windowRes and windowEvt == WindowStack.WindowEvent.weOpenAfter then

            end 
        end 
    end
end


WindowQueueWindowListener = BaseClass()

function WindowQueueWindowListener:execute(evt, window)
    local windowQueue = WindowQueueManager.instance.currentWindowQueue

    if windowQueue == nil or window == nil or windowQueue:isExecute() == false then 
        return 
    end

    if WindowQueueManager.instance.exceptionWindowList[window.windowRes] ~= nil then
        WindowQueueManager.instance:clear()
        return
    end

    if windowQueue:checkLastPath(enumWindowEventType.wetWindow, evt, window.windowRes) then
        windowQueue:executeNextPath()
    end 

    windowQueue:checkConditionList(enumWindowEventType.wetWindow, evt, window.windowRes)
end


WindowQueueSceneListener = BaseClass()

function WindowQueueSceneListener:execute(evt, sceneBase)

    local windowQueue = WindowQueueManager.instance.currentWindowQueue
    if windowQueue == nil or windowQueue:isExecute() == false then 
        return 
    end

    if windowQueue:checkLastPath(enumWindowEventType.wetScene, nil, nil, evt, sceneBase) then 
        windowQueue:executeNextPath()
    end
    
    windowQueue:checkConditionList(enumWindowEventType.wetScene, nil, nil, evt, sceneBase)
end


WindowQueueCache = BaseClass()

function WindowQueueCache:ctor()
    self.cacheWindowBaseDict = {}
    self.cacheBaseChildList = {}
    self.cacheSortList = {}
    self.cacheDomamolDialoglist = {}

    self.invalidLayer = 25
    self.nguiLayer = LayerMask.NameToLayer("UI")
end


function WindowQueueCache:pushCurrentWindow()
    self:clearLastCache()

    self.cacheWindowBase = WindowStack.instance.currentTopWindow

    local srcCollect = WindowStack.instance.windowBaseDict
    self.cacheWindowBaseDict = collectionUtility.CloneDictionary(srcCollect)    
    WindowStack.instance.windowBaseDict = {}

    self.cacheBaseChildList = collectionUtility.CloneListNQueue(WindowStack.instance.windowBaseList)
    WindowStack.instance.windowBaseList = {}                                                                                                                       

    self.cacheWindowBase:setBackGroundGuassianBlur(false)

    for k, v in pairs(self.cacheBaseChildList) do 
        local windowGo = v.gameObject
        GameObjectUtility.AddGameObject(WindowBase.windowBackRoot, windowGo)
        layerUtility.setLayer(windowGo, self.invalidLayer)
    end
end


function WindowQueueCache:pullLastWindow()
    WindowStack.instance.currentTopWindow = self.cacheWindowBase
     WindowStack.instance.windowBaseDict = collectionUtility.CloneDictionary(self.cacheWindowBaseDict)

    WindowStack.instance.windowBaseList = collectionUtility.CloneListNQueue(self.cacheBaseChildList)
    WindowMask.instance:dealwithUiMask(self.cacheWindowBase.gameObject)

    for k, v in pairs(self.cacheBaseChildList) do 
        local window = v
        if window ~= nil then 
            GameObjectUtility.AddGameObject(WindowBase.windowRoot, window.gameObject)
            layerUtility.setLayer(window.gameObject, self.nguiLayer)
            if window.gameObject.activeInHierarchy then
                window.panel:refresh()
            end
        end
    end
end


function WindowQueueCache:applyWindowModelLayer()
    local modelEnumerator = windowModelManager.instance.rendererModelList
    for k, v in pairs(modelEnumerator) do
        v:applyLayer(v.layerDefinition)
    end
end


function WindowQueueCache:clearLastCache()
    self.cacheWindowBaseDict = {}
    self.cacheBaseChildList = {}
    self.cacheSortList = {}
    self.cacheDomamolDialoglist = {}
    self.cacheWindowBase = nil 
    self.cacheDomamolDialogList = {} 
    self.cacheLastDomamoDialog = nil 
end


function WindowQueueCache:clearCacheAndWindow()
    local backGoList = GameObjectUtility.GetChildGameObject(WindowBase.windowBackRoot)
    for i = 1, #backGoList do 
        local backGo = backGoList[i]
        if backGo ~= nil then 
            GameObjectUtility.DestroyGameObject(backGo, false)
        end
    end
end


WindowQueueManager = BaseClass()


function WindowQueueManager:initialize()
    self.showSweepProgressFlg = false -- 默认不显示扫荡进度 
    self.windowSoucreQueue = {}
    self.exceptionWindowList = {}
    self.sceneEventController = SceneSwitchManager.instance
    self.queueCache = WindowQueueCache.new()

    self.queueWindowListener = WindowQueueWindowListener.new()
    WindowStack.instance:addListener(function(evt, window)
        self.queueWindowListener:execute(evt, window)
    end)
    
    self.queueSceneListener = WindowQueueSceneListener.new()
    self.sceneEventController:addListener(function(evt, instanceBase)
        self.queueSceneListener:execute(evt, instanceBase)
    end)
end


function WindowQueueManager:goto(sourceType, gotoData, callback)
    logInfo("WindowQueueManager:goto:" .. sourceType)
    gotoData = gotoData or nil 

    if self.currentWindowQueue ~= nil then 
        logInfo("Current wondiw queue exists!" .. sourceType)
        return
    end

    local windowQueue = self.windowSoucreQueue[sourceType]

    if windowQueue == nil then 
        logInfo("Not register window source type!" .. sourceType)
        return
    end

    self.queueCache:pushCurrentWindow()

    self.currentWindowQueue = windowQueue
    self.currentWindowQueue:reset()
    self.currentWindowQueue.gotoData = gotoData
    self.currentWindowQueue:executeNextPath()
    self.currentWindowQueue.callback = callback
end


function WindowQueueManager:resetGoto()
    self.queueCache:pullLastWindow()
    self.currentWindowQueue = nil 
    self.showSweepProgressFlg = false
end


function WindowQueueManager:clear()
    self.queueCache:clearCacheAndWindow()
    self.currentWindowQueue = nil 
end


function WindowQueueManager:register(sourceType, windowQueue)
    if self.windowSoucreQueue[sourceType] ~= nil then 
        print("ready register window source type!")
    else 
        self.windowSoucreQueue[sourceType] = windowQueue
    end
end


function WindowQueueManager:registerException(windowRes)
    table.insert(self.exceptionWindowList, windowRes)
end

WindowQueueManager.instance = WindowQueueManager.new()