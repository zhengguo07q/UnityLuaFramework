-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: bagItem.lua
--  Creator 	: panyuhuan
--  Date		: 2017-1-14
--  Comment		: 背包item
-- ***************************************************************


BagItem = BaseClass(UIScriptBehaviour)


function BagItem:initialize()
	self.varCache.lbl_level.text = ""
	self.itemPrefab = civilCommonItem.addCommonItem(self.gameObject, Vector3(0, 0, 0))
	GameObjectUtility.LocalScale(self.itemPrefab, 1.3, 1.3, 1)
	self.itemScript = ScriptManager.GetInstance():WrapperWindowControl(self.itemPrefab, nil)
end


function BagItem:clickButton(go, btnName)
	if btnName == "btn_this" then
		-- 点击播放动画
		self.varCache.tweenScale.gameObject:SetActive(true)
        self.varCache.tweenScale.from = Vector3(1.2, 1.2, 1.2)
        self.varCache.tweenScale.to = Vector3(1, 1, 1)
        self.varCache.tweenScale.duration = 0.4
        self.varCache.tweenScale:ResetToBeginning()
        self.varCache.tweenScale:PlayForward()
		self:brocast("SelectBagItem", {self.bagData, self})
		applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Click_Tips)
	end
end


function BagItem:setSelected(selected)
	self.varCache.go_SelectedBg:SetActive(selected)
end


--更新格子数据
function BagItem:commitData()
	self.bagData = self.data

	if self.bagData.customDataIndex == bagBB.curSelectItemData.customDataIndex then
		self.varCache.go_SelectedBg:SetActive(true)
	else
		self.varCache.go_SelectedBg:SetActive(false)
	end

	if self.bagData.itemModelId == 99999999 then
		self.itemPrefab:SetActive(false)
		self.varCache.sp_bg.gameObject:SetActive(true)
		self.varCache.lbl_level.text = ""
		return
	end

    self.itemPrefab:SetActive(true)
    self.varCache.sp_bg.gameObject:SetActive(false)
    self.itemScript:setItemData(self.bagData.itemModelId, self.bagData.numb, nil, nil, nil, nil, false)
    -- 是武将装备且装备等级大于0
    if self.bagData.type == 7 and self.bagData.equipLevel > 0 then
    	self.varCache.lbl_level.text = "[f5f04a]+" .. self.bagData.equipLevel .. "[-]"
    else
    	self.varCache.lbl_level.text = ""
    end
end
