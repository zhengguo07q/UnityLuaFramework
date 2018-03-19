-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: windowEffectManager.lua
--  Creator 	: zg
--  Date		: 2017-1-6
--  Comment		: 
-- ***************************************************************


WindowEffectManager = BaseClass()


UIEffectType = 
{
	uetCloseNull 	     = 1,
	uetOpen 		     = 2,
	uetOpenNull		     = 3,
	uetOpenSecond	     = 4,
    uetGuassianBlur      = 5,    -- 启动高斯模糊
    uetOpenEffectScale   = 6,    -- 打开特效缩放效果
}


function WindowEffectManager:getWindowEffect(windowBase, effectType)
    local effect = nil
    
    if effectType == UIEffectType.uetOpen then
    	effect = WindowOpenAlphaEffect.new()
    elseif effectType == UIEffectType.uetOpenNull then
    	effect = WindowOpenNullEffect.new()
    elseif effectType == UIEffectType.uetOpenSecond then
    	effect = WindowOpenSecondScaleEffect.new()
    elseif effectType == UIEffectType.uetCloseNull then
    	effect = WindowCloseNullEffect.new()
    elseif effectType == UIEffectType.uetGuassianBlur then
        effect = WindowBgGuassianBlurEffect.new()
    elseif effectType == UIEffectType.uetOpenEffectScale then
        effect = WindowOpenEffectScaleEffect.new()
    else
    	effect = WindowEffect.new()
    end

    effect.window = windowBase
    effect:initialize()
    return effect
end


WindowEffectManager.Instance = WindowEffectManager.new()