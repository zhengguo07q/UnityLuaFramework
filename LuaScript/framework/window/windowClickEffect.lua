-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : windowClickEffect.lua
--  Creator     : linyongqing
--  Date        : 2017-9-14
--  Comment     : 窗口点击特效
-- ***************************************************************


WindowClickEffect = BaseClass()


function WindowClickEffect:initialize()
	local uiRoot = GameObject.Find("UI Root")
	self.uiCamera = uiRoot.transform:Find("CameraUITop"):GetComponent("Camera")
	self.effectRoot = GameObject("UIClickEffectRoot")
	GameObjectUtility.SetParent(self.effectRoot, uiRoot, true)
	GameObjectUtility.LocalPosition(self.effectRoot, 0, 0, 0)
	GameObjectUtility.LocalScale(self.effectRoot, 1, 1, 1)
	self.effectRoot.layer = 16

	AssetLoader.instance:asyncLoad("Effect/UI/ui_dianji_01", function(asset)
        self.clickEffectAsset = asset
        self.clickEffectAsset:AddRef()
    end)

	self.effectCache           = {}
    WindowClickEffect.instance = self
end


function WindowClickEffect:update()
	-- 战斗中没有点击效果
	if BattleInstance == nil or BattleInstance.instance == nil then
		if Input.GetMouseButtonDown(0) then-- or (Input.touchCount == 1 and Input.GetTouch(0).phase == TouchPhase.Began) then
			self:showClickEffect()
		end
	end
end


function WindowClickEffect:showClickEffect()
	local effect    = self:getEffect()
	local clickPosition = self.uiCamera:ScreenToWorldPoint(Input.mousePosition)
	GameObjectUtility.Position(effect, clickPosition.x, clickPosition.y, clickPosition.z)

	LuaTimer.Add(2000, 0, function ()
		effect:SetActive(false)
		table.insert(self.effectCache, effect)
		return false
	end)
end


function WindowClickEffect:getEffect()
	local effect = nil
	if #self.effectCache > 0 then
		effect = self.effectCache[1]
		table.remove(self.effectCache, 1)
		effect:SetActive(true)
		return effect
	end

	effect = GameObject("ClickEffect")
	if self.clickEffectAsset == nil then
		AssetLoader.instance:asyncLoad("Effect/UI/ui_dianji_01", function(asset)
        	local clickEffect = GameObject.Instantiate(asset.mainObject)
        	GameObjectUtility.SetParent(clickEffect, effect, true)
			GameObjectUtility.LocalPosition(clickEffect, 0, 0, 0)
			GameObjectUtility.LocalScale(clickEffect, 1, 1, 1)
    	end)
    else
    	local clickEffect = GameObject.Instantiate(self.clickEffectAsset.mainObject)
        GameObjectUtility.SetParent(clickEffect, effect, true)
		GameObjectUtility.LocalPosition(clickEffect, 0, 0, 0)
		GameObjectUtility.LocalScale(clickEffect, 1, 1, 1)
	end
	GameObjectUtility.SetParent(effect, self.effectRoot, true)
	return effect
end


function WindowClickEffect:dispose()
	
end