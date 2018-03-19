-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : windowMask.lua
--  Creator     : lxy
--  Date        : 2017-2-27 10:45
--  Comment     : 
-- ***************************************************************


WindowMask = BaseClass()

WindowMask.MASK_RESOURCE_NAME = "UI/Background/WindowMaskPanel"
WindowMask.maskGameObject = nil
WindowMask.panelNameDicClickClose = {}  -- panel允许点击关闭记录表(只记录允许关闭的panelName)


--设置遮罩可以点击关闭    add lxy 2017-3-11
function WindowMask:setMaskClickClosed(goPanel)
    if goPanel then
        local panelName = goPanel.name   --  goPanel: NoticePanel(Clone)
        if nil == self.panelNameDicClickClose[panelName] then           
            self.panelNameDicClickClose[panelName] = true
        end
    end
end


-- 关闭时移除
function WindowMask:removeClickablePanel(goPanel)
    if goPanel then
        local panelName = goPanel.name
        if self.panelNameDicClickClose[panelName] then 
            self.panelNameDicClickClose[panelName] = nil 

        end
    end
end


-- 添加Masks，并setDepth
function WindowMask:dealwithUiMask(go)
    if go == nil then return end   
    self:addMask(go)
    if #WindowStack.instance.windowBaseList > 0 then
        self:adjustDepth(WindowStack.instance.windowBaseList[#WindowStack.instance.windowBaseList])
    end
end


-- 生成遮罩Mask
function WindowMask:addMask(go)
    if go == nil or Slua.IsNull(go) then return end
    self:destoryMaskGameObject()

    if string.find(go.name, "UniverseDungeonPanel") ~= nil then return end --此panel 遮挡星球导致星球变暗
    self:getMaskGameObject()
    GameObjectUtility.AddGameObject(go, self.maskGameObject)
end


function WindowMask:adjustDepth(window)
    if window == nil or Slua.IsNull(window.transform) or window.transform.childCount < 1 then return end

    local nowPanelTrans = window.transform:GetChild(0)
    local nowPanel
    if nowPanelTrans then
        nowPanel = nowPanelTrans.gameObject:GetComponentInChildren(UIPanel, true)
        local windowMaskPanel = window.transform:Find("WindowMaskPanel(Clone)")
        if windowMaskPanel then
            self:setWindowMask(windowMaskPanel.gameObject, nowPanel.depth - 2)
        end
    end
end


-- destroy window的遮罩Mask
function WindowMask:destroyMaskOfWindow(window)
    if window then
        local windowMaskPanel = window.transform:Find("WindowMaskPanel(Clone)")
        if windowMaskPanel then
            GameObjectUtility.DestroyGameObject(windowMaskPanel.gameObject,true)
        end
    end
end


function WindowMask:setWindowMask(goWindowMask,depth)
    local  maskPanel = goWindowMask:GetComponentInChildren(UIPanel, true)
    if maskPanel then
        maskPanel.depth = depth
    end
end


function WindowMask:getMaskGameObject()
     if self.maskGameObject == nil then        
        self.maskGameObject = ResourceLoader.Instantiate(self.MASK_RESOURCE_NAME) --尚未设置父节点
        assert(self.maskGameObject ~= nil)        
        UIEventListener.Get(self.maskGameObject.transform:Find("WindowMask").gameObject).onClick = function() self:onClickMask(self.maskGameObject)  end
        local maskSprite = self.maskGameObject.transform:Find("WindowMask").gameObject:GetComponent("UISprite")
        if PlayerPrefs.GetInt("rapidBlur", 1) == 0 then 
            maskSprite.color = Color(1, 1, 1, 0.8) 
        else
            maskSprite.color = Color(1, 1, 1, 0.5) 
        end
     end      
end


function WindowMask:destoryMaskGameObject()
    if self.maskGameObject ~= nil then
        GameObjectUtility.DestroyGameObject(self.maskGameObject, true) -- destoryGameObject(go, isImmediate)
        self.maskGameObject = nil
    end
end


function WindowMask:onClickMask(goParent)
    local topwindow = WindowStack.instance.windowBaseList[#WindowStack.instance.windowBaseList]

    -- 判断最顶层的windowPanel 的 Dic value是否存在
    if nil == topwindow then return end
    if topwindow.panelObject == nil then print("----- error: topwindow.panelObject is nil -----"); return end
    local panelName = topwindow.panelObject.name
    if self.panelNameDicClickClose[panelName] then
        -- 关闭父窗体
        for i = 1, goParent.transform.parent.childCount do
            local window = goParent.transform.parent:GetChild(i - 1)
            if window.gameObject.name ~= "WindowMaskPanel(Clone)" then
                local luaScriptOnGo = ScriptManager.GetInstance():WrapperWindowControl(window.gameObject, nil)
                luaScriptOnGo:close()

                -- 关闭时播放音效
                applicationGlobal.audioPlay:playAudio(audioConfig.Audio_CloseInterface_Tips)
                return
            end
        end
    end
end


WindowMask.instance = WindowMask.new()