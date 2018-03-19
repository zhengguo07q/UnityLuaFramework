-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: windowBase.lua
--  Creator 	: zg
--  Date		: 2017-1-4
--  Comment		: 预备把子窗口这个概念干掉
-- ***************************************************************


WindowBase = BaseClass()


WindowBase.uiRoot = nil
WindowBase.windowRoot = nil
WindowBase.windowBackRoot = nil


function WindowBase:ctor()
	self.openEffect = nil
	self.closeEffect = nil
    self.guassianBlurEffect = nil
	self.sortId = -1
	self.baseDepth = -1

	self.asset = nil

	self.isShow = false
	self.isDestory = false
	self.isAfterComplete = false
	self.backButton = nil

	self.panel = nil
	self.panelObject = nil
	self.isAsyncComplete = false
end


--初始化窗口的时候设置创公开信息
function WindowBase:setWindowRes(windowResId)
    self.windowRes = windowResId

    self.openEffect = WindowEffectManager.Instance:getWindowEffect(self, self.windowRes.openEffectType)
    self.closeEffect = WindowEffectManager.Instance:getWindowEffect(self, self.windowRes.closeEffectType)
    self.guassianBlurEffect = WindowEffectManager.Instance:getWindowEffect(self, self.windowRes.guassianBlurType) -- change by liyang 2017.6.29
end


--异步载入资源开始
function WindowBase:async()
	AssetLoader.instance:asyncLoad(self.windowRes.resourcePath, function(asset)   
        -- 延迟处理
        local c = coroutine.create(function()
            self.asset = asset
            if self.asset == nil then
                return
            end
            Yield(WaitForEndOfFrame)
            
            self.isAsyncComplete = true
            self.asset:AddRef() 
            self.panelObject = GameObject.Instantiate(asset.mainObject)
            GameObjectUtility.AddGameObject(self.gameObject, self.panelObject)
            layerUtility.setLayer(self.gameObject, 5)
            WindowUtility.instance:applyAdjustment()   --调整层次
            self.panelObject:GetComponent("UIPanel").alpha = 0

            -- FastLuaUtility.Traceback()

            Yield(WaitForSeconds(0.04))

            self:asyncComplete(asset)
        end)
        coroutine.resume(c)
		 
	end)
end


--异步载入完成, 在这里显示
function WindowBase:asyncComplete(asset) 
	self.panel = ScriptManager.GetInstance():WrapperWindowControl(self.panelObject, nil)
	self.panel.window = self
	self.panel:initialize()

    self.panelObject:GetComponent("UIPanel").alpha = 1

    if self.isShow == true then 
		self.openEffect:execute()
        self.guassianBlurEffect:execute() -- change by liyang 2017.6.29
    end

    Yield(WaitForEndOfFrame)
    
    self.panel:afterInitialize()

    if self.options ~= nil then
        if self.options.callback ~= nil then
            self.options.callback(self.panel)
        end
    end
end


--再次可用的时候调用打开效果
function WindowBase:onEnable()
	if self.isAsyncComplete == false then
		return
	end
    self.openEffect:execute()
    self.guassianBlurEffect:execute()
end


--禁用窗口
function WindowBase:onDisable()
    self.isShow = false
    if self.isDestory == true then    --销毁的时候
        WindowStack.instance:destroyWindow(self)       
    end
end


--打开窗口, 这个时候窗口已经被创建了的， 这里只是做一些其他操作， 对原来有影响的操作
function WindowBase:open(isHideParent, needReset)
    WindowMask.instance:dealwithUiMask(self.gameObject)  --add lxy 2017.2.27
    WindowStack.instance.currentTopWindow = self  -- change by liyang 2017.12.11

    if self.isShow == true then
        self.guassianBlurEffect:execute() -- change by liyang 2017.6.29
        return
    end

    if isHideParent == true then
        self:disableParent()                             --其他窗口不是顶层处理方式
    end
    self.openEffect:initialize()
    self.gameObject:SetActive(true)
    self.isShow = true

    if needReset == true and self.panel ~= nil then      --重新打开重置一下UI
        self.panel:resetUI()
    end 
    if self.options ~= nil and self.panel ~= nil then
        if self.options.callback ~= nil then
            self.options.callback(self.panel)
        end
    end
end


--真正关闭
function WindowBase:close()
    --FastLuaUtility.PlayAudio("10001")
    WindowMask.instance:removeClickablePanel(goPanel)

    self:setBackGroundGuassianBlur(false) --关闭高斯模糊 -- change by liyang 2017.6.29

    if self.gameObject.activeSelf == false then          --之前处于隐藏状态
      --  WindowStack.instance:destroyWindow(self)
    else
        --self.isDestory = true
        self.closeEffect:initialize()
        self.closeEffect:execute()
    end

    self:openLastWindow()
end


--打开窗口之后
function WindowBase:afterOpen()
    self.panel:afterOpen()
end


--关闭窗口之后
function WindowBase:afterClose()
    self.panel:afterClose()
end


--打开父窗口
function WindowBase:openLastWindow()
	local lastWindow = WindowStack.instance.windowBaseList[#WindowStack.instance.windowBaseList]
	if lastWindow ~= nil then
    	lastWindow:open(nil, true)
	end
end


--隐藏父窗口
function WindowBase:disableParent()
	local lastWindow = WindowStack.instance.windowBaseList[#WindowStack.instance.windowBaseList]

	if lastWindow ~= nil then
    	lastWindow:setDisable()
	end
end


--纯粹只是设置隐藏禁用
function WindowBase:setDisable()
    if self.isShow == false then
        return
    end
    self.closeEffect:initialize()
    self.closeEffect:execute()
end


--销毁窗口
function WindowBase:destory(clearAssets)
    --[[
    if self.gameObject.activeSelf == false then          --之前处于隐藏状态
        WindowStack.instance:destroyWindow(self)
    else
        self.isDestory = true
        self.closeEffect:initialize()
        self.closeEffect:execute()
    end

    --]]
     self:setBackGroundGuassianBlur(false) 
     self.isDestory = true
     WindowStack.instance:destroyWindow(self, clearAssets)
end


function WindowBase:onDestroy()
    self.openEffect:delete()
    self.closeEffect:delete()
    self.guassianBlurEffect:delete()
	WindowStack.instance.afterCloseWindow(self)
end


--设置窗口背景高斯模糊
function WindowBase:setBackGroundGuassianBlur(flag)

    if PlayerPrefs.GetInt("rapidBlur", 1) == 0 then 
        return 
    end 
    
    if flag then 
        if not Slua.IsNull(self.gameObject) then 
            if self.gameObject.layer == 16 then
                return
            end 
            --将打开的窗口改变layer, 使用新相机显示这个layer，原相机使用模糊
            layerUtility.setLayer(self.gameObject, 16)
        end

        local camera = WindowCamera.instance:getUICamera().gameObject
        local rapidBlurEffect = ScriptManager.GetInstance():WrapperWindowControl(camera, nil)
        if rapidBlurEffect ~= nil then 
            rapidBlurEffect:enableRapidBlurEffect()
        end
    else 
        if not Slua.IsNull(self.gameObject) then 
            if self.gameObject.layer == 5 then
                return
            end
            layerUtility.setLayer(self.gameObject, 5)
        end
        
        local camera = WindowCamera.instance:getUICamera().gameObject
        local rapidBlurEffect = ScriptManager.GetInstance():WrapperWindowControl(camera, nil)
        if rapidBlurEffect ~= nil then 
            rapidBlurEffect:disableRapidBlurEffect()
        end
    end
end