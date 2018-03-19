-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : windowBase.lua
--  Creator     : zg
--  Date        : 2017-1-6
--  Comment     : 
-- ***************************************************************


WindowUtility = BaseClass()


--初始化界面的一些元素
function WindowUtility:initializeUIRoot()
    if WindowBase.uiRoot == nil then
        WindowBase.uiRoot = GameObject.Find("UI Root")
    end
    if WindowBase.windowRoot == nil then
        local windowRoot = GameObject("Window")
        GameObjectUtility.AddGameObject(WindowBase.uiRoot, windowRoot)
        GameObjectUtility.LocalScale(windowRoot, 1, 1, 1)
		WindowBase.windowRoot = windowRoot
	end
	if WindowBase.windowBackRoot == nil then
        local windowBackRoot = GameObject("WindowBack")
        GameObjectUtility.AddGameObject(WindowBase.uiRoot, windowBackRoot)
        GameObjectUtility.LocalScale(windowBackRoot, 1, 1, 1)
        WindowBase.windowBackRoot = windowBackRoot
    end
    if WindowBase.windowTempRoot == nil then
        local tempRoot = GameObject("WindowTemp")   --存储UI缓存
        GameObjectUtility.AddGameObject(WindowBase.uiRoot, tempRoot)
        GameObjectUtility.LocalScale(tempRoot, 1, 1, 1)
        WindowBase.windowTempRoot = tempRoot
    end
end


--对所有的窗口进行排序
function WindowUtility:sortWindow(windowList)
	self.sortList = windowList
    self.lastSortId = 0
    for i=1, #self.sortList do
        local window = self.sortList[i]
        window.sortId = self.lastSortId
        self.lastSortId = self.lastSortId + 1
    end
end


--调整层次
function WindowUtility:applyAdjustment()
    if self.sortList == nil then
        return
    end

    local baseDepth = WindowLayerDefinition.wldUILayer.layerIndex
    local panelDepth = 0

    for i = 1, #self.sortList do
        local window = self.sortList[i]
        if window ~= nil then
            panelDepth = baseDepth + window.sortId * 100
            WindowUtility.instance:adjustmentPanelDepth(window.gameObject, panelDepth)
        end
    end
end


--调整面板深度
function WindowUtility:adjustmentPanelDepth(panelGo, panelBaseDepth)
 
    local originalBaseDepth = panelBaseDepth
   	local panelArray = GameObjectUtility.GetComponentsInChildren(panelGo, "UIPanel", true)
   	local panels = panelArray
   	table.sort(panels,  function(a, b)
			if a.depth < b.depth then
				return true
			end
			return false
		end)

    local maskPanel = nil
    for i = 1, #panels do
        if panels[i].gameObject.name ~= "WindowMaskPanel(Clone)" then
            panels[i].depth = panelBaseDepth
            panelBaseDepth = panelBaseDepth + 1
        else 
            maskPanel = panels[i] 
        end
    end
    if maskPanel then
        maskPanel.depth = originalBaseDepth - 1
    end
end


--得到适配的大小
function WindowUtility:getAutoAdpateSize()
    local ret = 1
    if Screen.width / Screen.height < 1280 / 720 then
        local logicWidth = Screen.width * 720 / Screen.height
        local factor = logicWidth / 1280
        ret = factor
    end
    return ret
end


--创建窗口实例
function WindowUtility:windowRes(resourcePath, id, openEffectType, closeEffectType, guassianBlurType)
	local res = {}
	res.resourcePath = resourcePath
	res.id = id
	res.openEffectType = openEffectType
	res.closeEffectType = closeEffectType
    res.guassianBlurType = guassianBlurType
	return res
end


WindowUtility.instance = WindowUtility.new()