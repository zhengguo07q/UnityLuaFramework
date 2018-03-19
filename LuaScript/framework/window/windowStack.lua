-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : windowBase.lua
--  Creator     : zg
--  Date        : 2017-1-4
--  Comment     : 
-- ***************************************************************


WindowStack = BaseClass()


--窗口事件
WindowStack.WindowEvent = 
{
    weOpenBefore      = 1,        --打开之前
    weOpenAfter       = 2,        --打开之后
    weCloseBefore     = 3,        --关闭之前
    weCloseAfter      = 4,        --关闭之后
    weDestory         = 5,        --销毁之后
}


--不做缓存的UI
WindowStack.NotCacheUI = 
{
    -- ["UI/PlayerInfo/PlayerInfoPanel"]               = 1,
    -- ["UI/Email/EmailPanel"]                         = 2, 
    -- ["UI/Bag/BagPanel"]                             = 3,
    ["UI/Rank/RankPanel"]                           = 1,
    ["UI/Conquest/ConquestSeasonPanel"]             = 2,
    ["UI/Conquest/ConquestSeasonRankPanel"]         = 3,
    ["UI/Conquest/ConquestSeasonStatisticsPanel"]   = 4,
    ["UI/Conquest/ConquestSeasonAwardPanel"]        = 5,
    ["UI/Conquest/ConquestSeasonHistoryPanel"]      = 6,
    ["UI/Conquest/ConquestCardsPanel"]              = 7,
    ["UI/Depot/DepotExchangePanel"]                 = 8,
    ["UI/Depot/DepotHandbookPanel"]                 = 9

}


--构造函数
function WindowStack:ctor()
    self.sorter = windowSorter
    self.listeners = {}
    self.currentTopWindow = nil             --当前置顶的窗口
    self.windowBaseDict = {}                --存储的已经创建的窗口，包括打开的和关闭的
    self.windowBaseList = {}                --记录当前打开着的窗口
                  
    self.windowCacheList = {}               --UI缓存，会放在WindowTemp层级（数组）
    self.maxUICahceNum = 15                 --最大缓存UI的数量，超过这个值会移除最早关闭的

    WindowUtility.instance.initializeUIRoot()
end


--添加窗口事件的监听器
function WindowStack:addListener(listener)
    table.insert(self.listeners, listener)
end


--删除窗口事件的监听器
function WindowStack:removeListener(listener)
    for i=1, #self.listeners do
        if self.listeners[i] == listener then
            table.remove(self.listeners, i)
            break
        end
    end
end


--清除所有监听器
function WindowStack:clearListener()
    self.listeners = {}
end


--通知所有的事件
function WindowStack:notifyListener(windowBase, windowEvt)
    for i = 1, #self.listeners do
        local listener = self.listeners[i]
        listener(windowEvt, windowBase)
    end
end


--重置整个窗口堆栈
function WindowStack:resetStackWindow()
    self.windowBaseDict = {}
end


--打开完成之后派发事件
function WindowStack:beforeOpenWindow(windowBase)
--    if windowBase.isAfterComplete == false then   --这是为了进行分帧优化，分帧调用完成后， UI才会主动发起打开完成事件
    self:notifyListener(windowBase, WindowStack.WindowEvent.weOpenBefore)
--    end
end


--开始执行关闭窗口
function WindowStack:onCloseWindow(windowBase)
    windowBase.gameObject:SetActive(false)
    self:notifyListener(windowBase, WindowStack.WindowEvent.weCloseBefore)

    syntaxUtility.removeItem(self.windowBaseList, windowBase, true)
    syntaxUtility.removeItem(WindowQueueManager.instance.queueCache.cacheBaseChildList, windowBase, true)    --这时候self.windowBaseList可能已经转移到WindowQueueCache，也要清一下

    --如果需要缓存则缓存，否则直接销毁
    if WindowStack.NotCacheUI[windowBase.windowRes.resourcePath] == nil then
        -- self.windowCacheList[windowBase.windowRes] = windowBase
        while(#self.windowCacheList >= self.maxUICahceNum) do
            local removeWindow = table.remove(self.windowCacheList, 1)
            self:destroyWindow(removeWindow)
        end
        syntaxUtility.removeItem(self.windowCacheList, windowBase, true)
        table.insert(self.windowCacheList, windowBase)
        
        GameObjectUtility.AddGameObject(WindowBase.windowTempRoot, windowBase.gameObject)
    else
        self:destroyWindow(windowBase)
    end

    --释放资源释放内存
    local c = coroutine.create(function ()
        AssetLoader.instance:clearAssets()
        Yield()

        self:afterCloseWindow(windowBase)            
        Yield()
        
        Resources.UnloadUnusedAssets()
        Yield()

        System.GC.Collect()
        Yield()

        collectgarbage("collect")

        print("当前打开窗口数量 = "..syntaxUtility.getTableCount(self.windowBaseList)..", UI缓存数量 = "..syntaxUtility.getTableCount(self.windowCacheList))
    end)

    if syntaxUtility.getTableCount(self.windowBaseList) == 0 then   --当前窗口全部关闭才对资源进行回收
        coroutine.resume(c)
    end
end


--开启窗口之后
function WindowStack:afterOpenWindow(windowBase)
    self:notifyListener(windowBase, WindowStack.WindowEvent.weOpenAfter)
    if windowBase ~= nil then
        windowBase:afterOpen()
    end
end


--关闭窗口之后
function WindowStack:afterCloseWindow(windowBase)
    WindowBehaviourProxy.instance:delayAfterCloseWindow()
    if windowBase ~= nil then
        windowBase:afterClose()
    end
end


--获得窗口
function WindowStack:getWindow(windowRes)
    local windowBase = self.windowBaseDict[windowRes]
    if windowBase ~= nil and windowBase.isShow then
        return windowBase.panel
    else
        return nil
    end 
end


function WindowStack:getWindowBase(windowRes)
    return self.windowBaseDict[windowRes]
end


function WindowStack:getCacheWindowByKey(key)
    for i = 1, #self.windowCacheList do
        if self.windowCacheList[i].windowRes == key then
            return self.windowCacheList[i]
        end
    end
    return nil
end



--打开窗口
function WindowStack:openWindow(windowRes, parentWindow , isHideParent, options)
    logInfo("WindowStack:openWindow: " .. windowRes.resourcePath)
    local lastWindow = self.windowBaseList[#self.windowBaseList] -- change by liyang 2017.6.29 上一个窗口关闭模糊效果
    if lastWindow ~= nil then
        lastWindow:setBackGroundGuassianBlur(false)
    end
    local window = self.windowBaseDict[windowRes]
    local create = false

    if window == nil then
        -- window = self.windowCacheList[windowRes]    -- add lxy 9.18
        window = self:getCacheWindowByKey(self.windowCacheList, windowRes)

        if window then
            logInfo("window.isShow : ", window.isShow)
            self.windowBaseDict[windowRes] = window
        elseif window == nil then
            window = self:createWindow(windowRes)
            self.windowBaseDict[windowRes] = window
            create = true
        end
    end

    window.options = nil 
    if options ~= nil then 
        window.options = options
    end  

    GameObjectUtility.AddGameObject(WindowBase.windowRoot, window.gameObject)    --重新加入windowRoot

    --将window重新加入到self.windowBaseList最后，并对所有窗口重新排序
    syntaxUtility.removeItem(self.windowBaseList, window, true)
    table.insert(self.windowBaseList, window)
    WindowUtility:sortWindow(self.windowBaseList)  
    WindowUtility.instance:applyAdjustment()
    self.currentTopWindow = window    

    if window.isShow == false then
        self:beforeOpenWindow(window)
        window:open(isHideParent, not create)
    end
    -- self.windowCacheList[windowRes] = nil
    syntaxUtility.removeItem(self.windowCacheList, window, true)
end


--创建窗口
function WindowStack:createWindow(windowRes)
    logInfo("WindowStack:createWindow: " .. windowRes.resourcePath)

    local resourceGo = GameObject(windowRes.resourcePath)
    local window = ScriptManager.GetInstance():WrapperWindowControl(resourceGo, "framework/window/windowBase")
    window:setWindowRes(windowRes)
    window:async()

    return window
end


--给定窗口是否存在
function WindowStack:isWindowExist(windowRes)
    if self.windowBaseDict[windowRes] ~= nil then
        return true
    end
    return false
end


--是否有窗口存在
function WindowStack:isWindowExist()
	local tnumber = 0 
	for i, v in pairs(self.windowBaseDict) do 
		tnumber = tnumber + 1
	end
    if tnumber >= 1 then
        return true
    end
    return false
end


--给定窗口是否可用
function WindowStack:isableWindow(windowRes)
    local windowBase = self.windowBaseDict[windowRes]
    if windowBase ~= nil then
        windowBase:setDisable()
    end
end


--关闭特定窗口
function WindowStack:closeWindow(windowRes)
    local windowBase = self.windowBaseDict[windowRes]
    if windowBase ~= nil then
        windowBase.panel:close()
    end
    
end


--销毁指定窗口
function WindowStack:destroyWindow(windowBase, clearAssets)
    windowBase.isDestory = false
    self:notifyListener(windowBase, WindowStack.WindowEvent.weDestory)
    syntaxUtility.removeItem(self.windowBaseList, windowBase, true)  --从队列中删除
    self.windowBaseDict[windowBase.windowRes] = nil
    WindowQueueManager.instance.queueCache.cacheWindowBaseDict[windowBase.windowRes] = nil   --这时候self.windowBaseDict可能已经转移到WindowQueueCache，所以也要清理一下
   
    -- self.windowCacheList[windowBase.windowRes] = nil
    syntaxUtility.removeItem(self.windowCacheList, windowBase, true)

    GameObjectUtility.DestroyGameObject(windowBase.gameObject, false)
    windowBase.asset:ReleaseRef() 

    if clearAssets == true then
        AssetLoader.instance:clearAssets()
    end
end


--销毁所有窗口
function WindowStack:destoryAll()
    for k, windowBase in pairs(self.windowBaseDict) do
        if windowBase ~= nil then
            windowBase:destory(true)
        end
    end
    self:resetStackWindow()
end


function WindowStack:closeAll()
    logInfo("执行WindowStack:closeAll")
    for k, windowBase in pairs(self.windowBaseDict) do
        -- if windowBase ~= nil and windowBase.panel ~= nil and windowBase.panel.gameObject.activeSelf then
        if windowBase ~= nil and windowBase.isShow then
            if windowBase.panel ~= nil then
                windowBase.panel:close()
            else
                logInfo("windowBase.panel居然为空？？"..windowBase.windowRes.resourcePath)
            end
        end
    end
end


function WindowStack:closeTempAll()
    -- for k, windowBase in pairs(self.windowCacheList) do
    --     if windowBase ~= nil and windowBase.panel ~= nil then
    --         self:destroyWindow(windowBase)
    --     end
    -- end
    print("<color=green>---------------------------------执行closeTempAll------------</color>")
    --改为list，遍历的时候需要从后往前删
    local count = #self.windowCacheList
    for i = count, 1, -1 do
        local windowBase = self.windowCacheList[i]
        if windowBase ~= nil and windowBase.panel ~= nil then
            self:destroyWindow(windowBase)
        end
    end
end


function WindowStack:getBaseDict()
    return self.windowBaseDict
end 


WindowStack.instance = WindowStack.new()


WindowBehaviourProxy = BaseClass()


function WindowBehaviourProxy:delayAfterCloseWindow()
	self.delayAfterCloseWindowImpl = coroutine.create(function()
        Yield()
		WindowStack.instance:notifyListener(nil, WindowStack.WindowEvent.weCloseAfter)
	end )
	coroutine.resume(self.delayAfterCloseWindowImpl)
end


-- function WindowBehaviourProxy:OnApplicationQuit()

-- end

WindowBehaviourProxy.instance = WindowBehaviourProxy.new()