-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: bagHandlerPanel.lua
--  Creator 	: panyuhuan
--  Date		: 2017-1-14
--  Comment		: 使用或购买物品弹框
-- ***************************************************************


BagHandlerPanel = BaseClass(WindowPanel)


function BagHandlerPanel:initialize()
	self.varCache.lbl_max.text = L("bag_button_3")
	self.varCache.lbl_getTip.text = L("bag_tishi_2")

	self.num = 1
	--self.moneyType2SprName = { "icon-jinbi", "icon-", "icon-physical strength", "icon-kapaitujian" }

	self.itemPrefab = civilCommonItem.addCommonItem(self.gameObject, Vector3(-2, 174, 0))
	GameObjectUtility.LocalScale(self.itemPrefab, 1.2, 1.2, 1)
	self.itemScript = ScriptManager.GetInstance():WrapperWindowControl(self.itemPrefab, nil)
	self.itemScript:updateDepth(10)
	applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Interface_Tips)
end


function BagHandlerPanel:resetUI()
	applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Interface_Tips)
end


function BagHandlerPanel:clickButton(go, btnName)
	if btnName == "btn_mask" then
		self:close()
		applicationGlobal.audioPlay:playAudio(audioConfig.Audio_CloseInterface_Tips)
	elseif btnName == "btn_sell" then
		self:sellItem()
		-- applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Click_Tips)
	elseif btnName == "btn_add" then
		applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Click_Tips)
		self:clickAddHandler()
	elseif btnName == "btn_sub" then
		applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Click_Tips)
		self:clickSubHandler()
	elseif btnName == "btn_min" then
		self:clickMinHandler()
		applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Click_Tips)
	end
end


function BagHandlerPanel:setPanelData()
	self.itemValue = bagBB.curSelectItemData
	if self.itemValue == nil then
		return
	end

	self.num = self.itemValue.numb
	self.operationType = bagBB.curOperationType --1是出售，2是使用
	
	if self.operationType == bagBB.bagHandleType.sell then
		self.varCache.lbl_getMoney.text = tostring(self.itemValue.sell_price * self.num)
		self.varCache.lbl_sell.text = L("bag_handle_1")
		self.varCache.go_canGetGo:SetActive(true)
	elseif self.operationType == bagBB.bagHandleType.use then
		self.varCache.lbl_getMoney.text = tostring(self.itemValue.use_effect_num * self.num)
		self.varCache.lbl_sell.text = L("bag_handle_3")
		self.varCache.go_canGetGo:SetActive(false)
	end

	if (self.itemValue.use_effect_num > 0 and self.operationType == bagBB.bagHandleType.use) or self.operationType == bagBB.bagHandleType.sell then
		if self.operationType == bagBB.bagHandleType.sell then
			self.varCache.sp_getMoney.spriteName = bagBB.bagSellIconType[tostring(self.itemValue.money_type)]
		elseif self.operationType == bagBB.bagHandleType.use then
			self.varCache.sp_getMoney.spriteName = bagBB.bagSellIconType[tostring(self.itemValue.use_effect_type)]
		end
	else
		self.varCache.sp_getMoney.spriteName = ""
		self.varCache.lbl_getMoney.text = L("bag_handle_5")
	end

	self.varCache.lbl_sellNum.text = string.format(stringUtility.rejuctSymbol("{0}/{1}"), self.num, self.itemValue.numb)
    self.itemScript:setItemData(self.itemValue.itemModelId, nil, nil, nil, nil, nil, false)
    self.varCache.lbl_name.text = string.format(stringUtility.rejuctSymbol("[{0}]{1}[-]"), colorUtility.getColorByQuality(self.itemValue.quality), self.itemValue.name)
end


function BagHandlerPanel:clickMinHandler()
	self.num = 1

	self:updateItemPrice()
end


function BagHandlerPanel:clickAddHandler()
	if self.num >= self.itemValue.numb then
		return
	end

	self.num = self.num + 1
	self:updateItemPrice()
end


function BagHandlerPanel:clickSubHandler()
	if self.num <= 1 then
		return
	end 

	self.num = self.num - 1
	self:updateItemPrice()
end


function BagHandlerPanel:sellItem()
	if self.operationType == bagBB.bagHandleType.sell then 
		local condition = stringUtility.split(conf.functionOpen["112"].condition, ",")
		-- 还没达到出售物品的开放等级
		if playerInfoBB.playerInfo.level < tonumber(condition[2]) then
			applicationGlobal.tooltip:errorMessage(L("system_needLevel") .. condition[2])
			applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Warn_Tips)
		else
			NetClient.Send(20231008, {itemId = self.itemValue.itemId, num = self.num})
			applicationGlobal.audioPlay:playAudio(audioConfig.Audio_CloseInterface_Tips)
		end
	elseif self.operationType == bagBB.bagHandleType.use then 
		NetClient.Send(20231010, {itemId = self.itemValue.itemId, number = self.num})
		applicationGlobal.audioPlay:playAudio(audioConfig.Audio_CloseInterface_Tips)
	end
end


function BagHandlerPanel:updateItemPrice()
	if self.operationType == bagBB.bagHandleType.sell then
		self.varCache.lbl_getMoney.text = tostring(self.itemValue.sell_price * self.num)
	elseif self.operationType == bagBB.bagHandleType.use then
		self.varCache.lbl_getMoney.text = tostring(self.itemValue.use_effect_num * self.num)
	end

	self.varCache.lbl_sellNum.text = string.format(stringUtility.rejuctSymbol("{0}/{1}"), self.num, self.itemValue.numb)
end


function BagHandlerPanel:sellCallBack()
	self:sellOrUseSucceedEffect(self.itemValue.money_type)
	self:close()
end


function BagHandlerPanel:useCallBack()
	self:sellOrUseSucceedEffect(self.itemValue.use_effect_type)
	self:close()
end


function BagHandlerPanel:sellOrUseSucceedEffect(typeIndex)
	local currScene = applicationGlobal.sceneSwitchManager.currentSceneInstance
    if currScene ~= nil and isSuper(currScene, MainUiInstance) and currScene.sceneEffectPanel ~= nil then 
    	currScene.sceneEffectPanel.sceneEffectResObtain.obtainResPoint = self.varCache.sp_getMoney.transform.position
    	if typeIndex == 0 then
        	currScene.sceneEffectPanel.sceneEffectResObtain:addEffectMove(sceneEffectBB.enumObtainType.otGold)
		elseif typeIndex == 1 then
        	currScene.sceneEffectPanel.sceneEffectResObtain:addEffectMove(sceneEffectBB.enumObtainType.otDiamond)
		end
    end
end