-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: bagPanel.lua
--  Creator 	: panyuhuan
--  Date		: 2017-1-14
--  Comment		: 背包界面
-- ***************************************************************


BagPanel = BaseClass(WindowPanel)


function BagPanel:initialize()
	self.varCache.lbl_title.text    = L("bag_beibao")
	self.varCache.lbl_tab1.text     = L("bag_yeqian_1")
	self.varCache.lbl_tab2.text     = L("bag_yeqian_2")
	self.varCache.lbl_tab3.text     = L("bag_yeqian_3")
	self.varCache.lbl_tab4.text     = L("bag_yeqian_4")
	self.varCache.lbl_use.text      = L("bag_button_1")
	self.varCache.lbl_sell.text     = L("bag_button_2")
	self.varCache.lbl_noTip.text    = L("bag_noData")
	self.varCache.lbl_priceTip.text = L("bag_tishi_1")

	self.varCache.go_tip2:SetActive(false)
	self.varCache.go_tip3:SetActive(false)
	self.varCache.go_tip4:SetActive(false)
	self.lastSelect = nil    --记录上次选择
	
    self.type = -1
	self:initBagGrid()

	CommonUITop.instance:showTopUIPanel(self.gameObject, 10)

    self.itemPrefab = civilCommonItem.addCommonItem(self.varCache.go_LeftContainer, Vector3(202, 180, 0))
	GameObjectUtility.LocalScale(self.itemPrefab, 1.2, 1.2, 1)
	--GameObjectUtility.SetParent(self.itemPrefab, self.varCache.go_LeftContainer, true)
	self.itemScript = ScriptManager.GetInstance():WrapperWindowControl(self.itemPrefab, nil)
	self.itemScript:updateDepth(10)
	self:setLeftDataVisible(false)

	
	self.moneyType2SprName = { "icon-jinbi", "icon-zuanshi" }

	self.buttonParent   = self.varCache.go_tabButtonContainer.transform
	self.leftButtonList = {}
	for i = 0, self.buttonParent.childCount - 1 do
        local button = self.buttonParent:GetChild(i)
        table.insert(self.leftButtonList, button.gameObject)
    end  

    CommonUITop.instance:showTopUIAnim()
	windowContentEffectUtility.addTopToDownAnim(self.varCache.go_commonWindow, 100)
    windowContentEffectUtility.addLeftTabsAnimation(self.leftButtonList, 176)
end


function BagPanel:clickButton(go, btnName)
	if btnName == "btn_close" then
		self.type = -1
		self:close()
		applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Return_Tips)
	elseif (btnName == "toggle1" or btnName == "toggle2" or btnName == "toggle3" or btnName == "toggle4") then
		applicationGlobal.audioPlay:playAudio(audioConfig.Audio_LeftLabel_Switching)
		self:tabBtnClick(btnName)
	elseif btnName == "btn_use" then
		self:clickToUse()
	elseif btnName == "btn_sell" then
		self:clickToSell()
	end
end


-- 初始化背包列表
function BagPanel:initBagGrid()
	self.layoutTiled = UIListLayoutTiled.new(self.varCache.go_grid)
	self.layoutTiled.childrenCount = 30    --最多30个
	self.layoutTiled.cellWidth = 150
	self.layoutTiled.cellHeight = 150
	self.layoutTiled.columnLimit = 5
	self.layoutTiled.saveIndex = true
	self.layoutTiled.offsetX = 10
	self.layoutTiled.offsetY = -40
	self.layoutTiled:setEventHandler(function (type, info)
        if type=="SelectBagItem" then
            bagBB.curSelectItemData = info[1]
            bagBB.curSelectItemData.selected = true
            self:refreshItemInfo(info[1])
            self:SelecItem(info[2])
        end
    end)

	AssetLoader.instance:asyncLoad("UI/Bag/BagItem", function (asset)
		self.itemAsset = asset
		self.itemAsset:AddRef()
		self.layoutTiled:setItemRenderer(asset.mainObject)

        self:updateItemList()
	end)
end


-- 点击tab
function BagPanel:tabBtnClick(btnName)
	if btnName == "toggle1" then
		self.type = -1
	elseif btnName == "toggle2" then
		self.type = 0
	elseif btnName == "toggle3" then
		self.type = 1
	elseif btnName == "toggle4" then
		self.type = 6
	end

	self.mSelectItemIndex = -1
	self:updateItemList()
end


function BagPanel:clickToUse()
	self:itemUseOrSell(bagBB.bagHandleType.use)
end


function BagPanel:clickToSell()
	local condition = stringUtility.split(conf.functionOpen["112"].condition, ",")
	-- 还没达到出售物品的开放等级
	if playerInfoBB.playerInfo.level < tonumber(condition[2]) then
		applicationGlobal.tooltip:errorMessage(L("ex_sc_errorCode_tip_28"))
	else
		self:itemUseOrSell(bagBB.bagHandleType.sell)
	end
end


function BagPanel:resetUI()
	CommonUITop.instance:showTopUIPanel(self.gameObject, 10)
	self.layoutTiled:resetPosition()
	self:tabBtnClick("toggle1")
    self.varCache.toggle1.value = true

    CommonUITop.instance:showTopUIAnim()
	windowContentEffectUtility.addTopToDownAnim(self.varCache.go_commonWindow, 100)
    windowContentEffectUtility.addLeftTabsAnimation(self.leftButtonList, 176)
    windowContentEffectUtility.addDownToUpAnim(self.varCache.go_grid.transform.parent.gameObject, 150)
end


-- 背包有300个格子
function BagPanel:updateItemList()
--	print("更新背包UI数据")
	local bagItemList = {}
	local bagItemCache = bagBB.getItemsByType(self.type)
	local bagItemCount = #bagItemCache

	for i=1, 300 do
		if i <= bagItemCount then
			table.insert(bagItemList, bagItemCache[i])
		else
			local itemVo = {}
			itemVo.itemModelId = 99999999
			table.insert(bagItemList, itemVo)
		end
	end

	self.bagCollection = ListCollection.new(bagItemList)
	self.bagCollection:sort(
		function (aData, bData)
            if tonumber(bData["itemModelId"] )> tonumber(aData["itemModelId"]) then
                return true
            end
            return false
        end
	)

	self.layoutTiled:setDataProvider(self.bagCollection)
    -- 进来数据默认选中第一个
    self.luaDataTime = LuaTimer.Add(100, 2000, function()
    	bagBB.curSelectItemData = self.bagCollection.list[1]
    	self:refreshItemInfo(self.bagCollection.list[1])
        --self.layoutTiled:resetPosition()

    	local firstItem = self.layoutTiled:getListChildern(1).gameObject    --获取第一个格子gameObject
    	local script = ScriptManager.GetInstance():WrapperWindowControl(firstItem, nil)
    	self:SelecItem(script)

    	return false
    end)

	self:setTypeState()
end


--选中格子
function BagPanel:SelecItem(itemScript)
	if self.lastSelect ~= nil then
        self.lastSelect:setSelected(false)
    end
    itemScript:setSelected(true)
    self.lastSelect = itemScript
end


function BagPanel:setTypeState()
	self.varCache.go_tip2:SetActive(bagBB.getRedByType(0))
	self.varCache.go_tip3:SetActive(bagBB.getRedByType(1))
	self.varCache.go_tip4:SetActive(bagBB.getRedByType(7))
end


--更新右侧物品信息
function BagPanel:refreshItemInfo(itemData)
	if itemData == nil then
		return
	end

	if itemData.itemModelId == 99999999 then
		self:setLeftDataVisible(false)
	else
		self:setLeftDataVisible(true)

        self.varCache.lbl_name.text = string.format(stringUtility.rejuctSymbol("[{0}]{1}[-]"), colorUtility.getColorByQuality(itemData.quality), itemData.name)
		self.varCache.lbl_price.text = tostring(itemData.sell_price)
		self.varCache.lbl_desc.text = itemData.info
		--self.varCache.lbl_itemNum.text = "×"..itemData.numb   --数量   

		self.varCache.btn_sell.gameObject:SetActive(itemData.isSell)
		self.varCache.btn_use.gameObject:SetActive(itemData.isUse)
		self.varCache.table_Buttoms:Reposition()
		self.varCache.sp_price.spriteName = self.moneyType2SprName[itemData.money_type + 1]
		self.varCache.sp_price:MakePixelPerfect()

        self.itemScript:setItemData(itemData.itemModelId, nil, nil, nil, nil, nil, false)   --设置格子数据
        --使用等级
		if (itemData.use_limit_level > 0 and itemData.use_limit_level > playerInfoBB.playerInfo.level) then
			self.varCache.btn_use:GetComponent("BoxCollider").enabled = false
			self.varCache.sp_use.color = colorUtility.color.black
		else
			self.varCache.btn_use:GetComponent("BoxCollider").enabled = true
			self.varCache.sp_use.color = colorUtility.color.white
		end
	end
end


-- 设置可不可见
function BagPanel:setLeftDataVisible(isTrue)
    self.varCache.lbl_name.gameObject:SetActive(isTrue)
    self.varCache.lbl_desc.gameObject:SetActive(isTrue)
    self.varCache.lbl_price.gameObject:SetActive(isTrue)
    self.varCache.lbl_equip.gameObject:SetActive(isTrue)
    self.varCache.lbl_noTip.gameObject:SetActive(not isTrue)
    self.varCache.lbl_priceTip.gameObject:SetActive(isTrue)
    self.varCache.btn_use.gameObject:SetActive(isTrue)
    self.varCache.btn_sell.gameObject:SetActive(isTrue)
  --  self.varCache.sp_iconBackBg.gameObject:SetActive(isTrue)
    self.varCache.sp_price.gameObject:SetActive(isTrue)
    self.varCache.go_equip:SetActive(isTrue)
    self.varCache.go_left1:SetActive(isTrue)
    self.varCache.go_line_1:SetActive(isTrue)
    self.itemPrefab:SetActive(isTrue)
end


function BagPanel:itemUseOrSell(operationType) --1是出售，2是使用
	bagBB.curOperationType = operationType
	--WindowStack.instance:openWindow(windowResId.bagHandlerPanel, self, false)

    WindowStack.instance:openWindow(windowResId.bagHandlerPanel, self, false,
    	{callback = function(panel)  panel:setPanelData()  end })
end


--出售和使用返回
function BagPanel:sellOrUseCallBack(itemId,operationType)
	applicationGlobal.tooltip:errorMessage(operationType == 1 and L("bag_tishi_4") or L("bag_tishi_3"))

	local hasSellOrUseItem = false --出售或使用后是否还存在该物品
	for i=1,#bagBB.bagItemList do
		if bagBB.bagItemList[i].itemId == itemId then
            hasSellOrUseItem = true
			break
		end
	end

	if hasSellOrUseItem then
		self:refreshItemInfo(bagBB.curSelectItemData)
	else
		bagBB.curSelectItemData = self.bagCollection.list[1]
		self:refreshItemInfo(self.bagCollection.list[1])

		local firstItem = self.layoutTiled:getListChildern(1).gameObject    --获取第一个格子gameObject
    	local script = ScriptManager.GetInstance():WrapperWindowControl(firstItem, nil)
    	self:SelecItem(script)
	end
end


-- 更新道具数量
function BagPanel:updateItemNum(itemValue)
	for i=1, #self.bagCollection.list do
		if self.bagCollection:getListByIndex(i).itemId == itemValue.itemId then
            self.bagCollection:getListByIndex(i).numb = itemValue.numb
            self.bagCollection:updateItem(self.bagCollection:getListByIndex(i))
		end
	end

	-- 添加红点			
	mainUIBB.setFunctionRed(mainUIBB.enumSpriteHint.StoneMatrix, stoneMatrixBB.checkRedTips())
end


-- 新增道具
function BagPanel:addNewItem(itemValue)
	if self.type == -1 then
		self:updateBagItemData(itemValue)
	else
		if itemValue.type ~= self.type then
		    self:updateBagItemData(itemValue)    
		end
	end
end


-- 更新背包数据
function BagPanel:updateBagItemData(itemValue)
	self.bagCollection:add(itemValue)

	self:setTypeState()

	self:updateItemList()   --刷新背包
end


-- 删除道具
function BagPanel:removeItem(itemValue)
	for i=1, #self.bagCollection.list do
		if self.bagCollection:getListByIndex(i).itemId == itemValue.itemId then
            self.bagCollection:remove(self.bagCollection:getListByIndex(i))
            break
		end
	end
	self:setTypeState()
end


function BagPanel:close()
	self.window:close()
	if self.lastSelect ~= nil then
        self.lastSelect:setSelected(false)
	    self.lastSelect = nil
	end 
end


function BagPanel:dispose()
	if self.itemAsset ~= nil then
        self.itemAsset:ReleaseRef()
        self.itemAsset = nil
    end

    if self.luaDataTime ~= nil then
    	LuaTimer.Delete(self.luaDataTime)
    	self.luaDataTime = nil
    end

    if self.luaListTime ~= nil then
    	LuaTimer.Delete(self.luaListTime)
    	self.luaListTime = nil
    end
end