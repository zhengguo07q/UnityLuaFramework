-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: windowEffect.lua
--  Creator 	: zg
--  Date		: 2017-1-6
--  Comment		: 
-- ***************************************************************


--效果基类
WindowEffect = BaseClass()


function WindowEffect:ctor()
	self.window = nil
end


function WindowEffect:initialize()
	
end


function WindowEffect:execute()
	
end


function WindowEffect:complete()
	
end


--关闭的时候没有任何效果
WindowCloseNullEffect = BaseClass(WindowEffect)


function WindowCloseNullEffect:execute()
	self:complete()
end


function WindowCloseNullEffect:complete()
	WindowStack.instance:onCloseWindow(self.window)
end


--打开的时候没有任何效果
WindowOpenNullEffect = BaseClass(WindowEffect)


function WindowOpenNullEffect:execute()
	self:complete()
end


function WindowOpenNullEffect:complete()
	WindowStack.instance:afterOpenWindow(self.window)
end


--打开的时候进行透明度
WindowOpenAlphaEffect = BaseClass(WindowEffect)


function WindowOpenAlphaEffect:initialize()
	self.duration = 0.3
end


function WindowOpenAlphaEffect:execute()
    local tweenAlpha = GameObjectUtility.GetIfNotAdd(self.window.panelObject.gameObject, "TweenAlpha")
    tweenAlpha.from = 0.5
    tweenAlpha.to = 1
    tweenAlpha.method = UITweener.Method.Linear
    tweenAlpha.style = UITweener.Style.Once
    tweenAlpha.duration = self.duration
    tweenAlpha:ResetToBeginning()
    tweenAlpha:PlayForward()
    tweenAlpha:SetOnFinished(function()
    	self:complete()
    end)
end


function WindowOpenAlphaEffect:complete()
	WindowStack.instance:afterOpenWindow(self.window)
end


--关闭的时候进行缩放
WindowOpenSecondScaleEffect = BaseClass(WindowEffect)


function WindowOpenSecondScaleEffect:execute()
	self:complete()
end


function WindowOpenSecondScaleEffect:complete()
	WindowStack.instance:afterOpenWindow(self.window)
end


--打开的时候进行背景模糊
WindowBgGuassianBlurEffect = BaseClass(WindowEffect)


function WindowBgGuassianBlurEffect:execute()
	if PlayerPrefs.GetInt("rapidBlur", 1) == 0 then 
		return 
	end 
	layerUtility.setLayer(self.window.gameObject, 16)

    local camera = WindowCamera.instance:getUICamera().gameObject
    local rapidBlurEffect = ScriptManager.GetInstance():WrapperWindowControl(camera, 'framework/window/windowRapidBlurEffect')
    if rapidBlurEffect ~= nil then 
  		rapidBlurEffect:enableRapidBlurEffect()
  	end 
end


function WindowBgGuassianBlurEffect:complete()
	WindowStack.instance:afterOpenWindow(self.window)
end


--打开的时候闪一个特效并且缩放打开
WindowOpenEffectScaleEffect = BaseClass(WindowEffect)


function WindowOpenEffectScaleEffect:execute()
    GameObjectUtility.LocalScale(self.window.panelObject.gameObject, 0, 0, 0)
	
	--显示特效
	self:playEffect(self.window.panelObject.gameObject, function() self:complete() end)
end


function WindowOpenEffectScaleEffect:complete()
	WindowStack.instance:afterOpenWindow(self.window)
end


function WindowOpenEffectScaleEffect:playEffect(go, completeCall)
	--显示特效
    AssetLoader.instance:asyncLoad("Effect/UI/ui_dakai_02", function(asset)
        local effectGo = GameObject.Instantiate(asset.mainObject)
        effectGo.name = "uiOpenEffect"
		GameObjectUtility.AddGameObject(go, effectGo)
        GameObjectUtility.LocalScale(effectGo, 1, 1, 1)

		local co1 = coroutine.create(function ()
			Yield(WaitForSeconds(0.2))
			GameObject.Destroy(effectGo)
		end)
		coroutine.resume(co1)

		--显示动画
   		local anim = GameObjectUtility.GetIfNotAdd(go, "UnityEngine.Animator")
	    if anim.runtimeAnimatorController ~= nil then
	    	anim:Play("open_effect")
	    else
	  		AssetLoader.instance:asyncLoad("Effect/UI/ui_dakai_01", function(asset)
	    		anim.runtimeAnimatorController = asset.mainObject:GetComponent(Animator).runtimeAnimatorController
	   		end)
	    end

		local co2 = coroutine.create(function ()
			Yield(WaitForSeconds(0.4))
			if completeCall ~= nil then
				completeCall()
			end
		end)
		coroutine.resume(co2)
    end)
end