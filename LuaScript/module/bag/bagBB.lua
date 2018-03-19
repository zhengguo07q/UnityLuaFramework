-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: bagBB.lua
--  Creator 	: panyuhuan
--  Date		: 2017-1-14
--  Comment		: 物品数据类
-- ***************************************************************


module("bagBB", package.seeall)


curSelectItemData = {}   -- 当前选中的item数据，点击使用或者出售才存数据
curOperationType = 1     --1是出售，2是使用

bagItemList = {}         --所有物品信息

--物品类型
itemType = 
{
    consume = 0,                 --消耗
    material = 1,                --材料
    task = 2,                    --任务
    gift = 3,                    --礼包
    others = 4,                  --其他
    token = 5,                   --将令
    cardEquip = 6,               --卡牌装备
    generalEquip = 7,            --将军装备
    seed = 8,                    --种子
    fruit = 9,                   --果实
    generalEquipUpgrade = 10,    --将军装备进阶材料
    cardSoul = 11,               --卡魂
    ordnancePiece = 12,          --军械碎片
    zhenshi = 13,                --阵石
    ordnanceDrawings = 14,       --军械图纸
    specialty = 15    			 --特产
}


bagHandleType = 
{
	sell = 1,   --出售 
	use = 2     --使用
}


--出售货币类型0:金币  1:钻石  2:体力 3:卡魂
bagSellIconType = 
{
    ["0"] = "icon-jinbi",
    ["1"] = "icon-zuanshi",
    ["2"] = "icon-tili"
}


--服务器货币类型
moneyType =
{ 
	item 			= 1,		--道具
	gold 			= 2,		--金币
	diamond 		= 3,		--钻石
	playerExp 		= 4,		--玩家经验
	card 			= 5,		--卡牌
	gangCoin 		= 6,		--公会币
	fairPlayScore 	= 7,		--功勋币(公平竞技积分)
	generalExp 		= 8,		--将军经验(8)
	ration 			= 9,		--体力(9)
	showBox 		= 10,		--展示宝箱
	gangExp 		= 11,		--公会经验
	gangMemberExp 	= 12,		--公会成员经验
	arenaGem 		= 13,		--竞技场宝石
	tower 			= 14,		--遗迹货币
}


--服务器货币类型转换成Icon
moneyIconType =
{ 
	[moneyType.item] 				= "",						--道具
	[moneyType.gold] 				= "icon-jinbi",				--金币
	[moneyType.diamond] 			= "icon-zuanshi",			--钻石
	[moneyType.playerExp] 			= "",						--玩家经验
	[moneyType.card] 				= "",						--卡牌
	[moneyType.gangCoin] 			= "icon-juntuanbi",			--公会币
	[moneyType.fairPlayScore] 		= "icon-gongpingjingji",	--功勋币(公平竞技积分)
	[moneyType.generalExp] 			= "",						--将军经验(8)
	[moneyType.ration] 				= "icon-tili",				--体力(9)
	[moneyType.showBox] 			= "",						--展示宝箱
	[moneyType.gangExp] 			= "",						--公会经验
	[moneyType.gangMemberExp] 		= "",						--公会成员经验
	[moneyType.arenaGem] 			= "Arena-icon-01",			--竞技场宝石
	[moneyType.tower] 				= "icon-10",				--遗迹货币
}


--服务器货币类型转换成ItemID
moneyItemType =
{ 
	[moneyType.item] 				= 0,				--道具
	[moneyType.gold] 				= 900102,			--金币
	[moneyType.diamond] 			= 900101,			--钻石
	[moneyType.playerExp] 			= 900106,			--玩家经验
	[moneyType.card] 				= 0,				--卡牌
	[moneyType.gangCoin] 			= 900107,			--公会币
	[moneyType.fairPlayScore] 		= 900103,			--功勋币(公平竞技积分)
	[moneyType.generalExp] 			= 900108,			--将军经验(8)
	[moneyType.ration] 				= 900105,			--体力(9)
	[moneyType.showBox] 			= 0,				--展示宝箱
	[moneyType.gangExp] 			= 0,				--公会经验
	[moneyType.gangMemberExp] 		= 900103,			--公会成员经验
	[moneyType.arenaGem] 			= 900113,			--竞技场宝石
	[moneyType.tower] 				= 900114,			--遗迹货币
}


gold = 900102       --金币
diamond = 900101    --钻石


-- 得到背包的所有数据，相当于C#ItemVo的集合，往后要添加什么属性，都在这边加
function getBagData()
	bagItemList = {}
	local allData = protoData[20231002].backpackList
	for i=1, #allData do
		local curItemData = oneItemData(allData[i])
		table.insert(bagItemList, curItemData)

		--create by liyang 2007-4-11
		strategosBB.checkBagItemForEquipState(curItemData)
	end
end


-- 单个item的数据
function oneItemData(data)
	local curItemData = data
	local itemXml = conf.item[curItemData.itemModelId .. '']
	if itemXml == nil then
		return
	end

	curItemData.icon = itemXml.icon --道具icon
	curItemData.name = L(string.gsub(itemXml.name, "#", ""))
	--道具类型 0：消耗 1：材料
    -- 2：任务  3：礼包 4：其他 
    -- 5、将令  6、卡牌装备 
    -- 7、将军装备 8、 种子 
    -- 9、果实 10、将军装备、进阶材料 
    -- 11、卡魂 12、军械碎片 13.阵石
	curItemData.type = itemXml.type --道具类型

	curItemData.stack_number = itemXml.stackNumber --最大叠加数量
	curItemData.isUse = itemXml.use --道具能否使用
	curItemData.use_limit_level = itemXml.useLimitLevel --使用等级限制
	curItemData.use_limit_country = itemXml.useLimitCountry --使用国家限制
	if itemXml == nil or itemXml.consume == nil or itemXml.consume == "-1" then 
		curItemData.use_effect_type = 0
		curItemData.use_effect_num = 0
	else
	    local consumeData = stringUtility.split(itemXml.consume, ":")
		curItemData.use_effect_type = ((consumeData[1] ~= "-1" and tonumber(consumeData[1])) or 0) --使用类型：金币、砖石
		curItemData.use_effect_num = ((consumeData[2] ~= "-1" and tonumber(consumeData[2])) or 0) --使用获得数量
	end

	curItemData.isSell = itemXml.sell --能否出售
	curItemData.sell_price = itemXml.sellPrice --出售价格
	curItemData.money_type = itemXml.moneyType --出售货币类型0:金币  1:钻石  2:体力 3:卡魂
	curItemData.isShowTip = itemXml.sellPrompt --是否出售提示
	curItemData.info = L(string.gsub(itemXml.info, "#", "")) --物品描述
	
	if itemXml.nature ~= nil then 
		curItemData.equipDesc = L(string.gsub(itemXml.nature, "#", "")) --装备属性描述
	end
	-- 缺少EquipType、EquipStrategosId，要在将军府上才能获得数据
	curItemData.altasType = itemXml.altasType --根据altasType判断icon在那个图集里

	local equipData = conf.itemEquip[curItemData.itemModelId .. '']
	curItemData.isSuit = (((equipData ~= nil and equipData.suit > 0) and true) or false) --是否是套装装备装备
	curItemData.isRed = itemXml.useTips --是否显示红点,0是否
	if itemXml == nil or itemXml.convertStr == nil or itemXml.convertStr == "" then
		curItemData.equipExp = 0
	else
	    curItemData.equipExp = ((itemXml.convertStr == "" and 0) or (tonumber(stringUtility.split(itemXml.convertStr, ":")[2]))) --装备经验
	end

	curItemData.equipLevel  = ((equipData ~= nil and equipData.level) or 0) --装备等级

	return curItemData
end


-- 通过id获取某个物品的数据
function getItemById(itemModelId)
	for k, v in pairs(bagItemList) do
		if v.itemModelId == itemModelId then
			return v
		end
	end
end


-- 通过id获取物品的数量
function getItemNumById(itemModelId)
	local num = 0
	for k, v in pairs(bagItemList) do
		if v.itemModelId == itemModelId then
			num = num + v.numb
		end
	end

	return num
end


-- 根据物品类型得到item集合
function getItemsByType(itemType)
	local items = {}
	for k, v in pairs(bagItemList) do
		if itemType >= 0 and v.type == itemType then
			table.insert(items, v)
		elseif itemType < 0 then
			table.insert(items, v)
		elseif itemType == 6 and v.type == 7 then
			table.insert(items, v)
		end
	end
	return items
end


-- 根据类型判断是否显示红点
function getRedByType(itemType)
	for k, v in pairs(bagItemList) do
		if itemType == -1 then
			if v.isRed == 1 then
				return true
			end
		else
			if (v.isRed == 1 and v.type == itemType) then
				return true
			end
		end
	end

	return false
end


-- 更新背包的数据
function updateBagItem(itemValue)
	local itemData = nil
	for k, v in pairs(bagItemList) do
		if v.itemId == itemValue.itemId then
			v.numb = itemValue.numb
			itemData = v
		end
	end
	cardBB.reSetAllCardRed()
	return itemData
end


-- 新增一个道具
function addNewItem(data)
	local curItemData = oneItemData(data)
	table.insert(bagItemList, curItemData)

	--create by liyang 2007-4-11
	strategosBB.checkBagItemForEquipState(data)
	cardBB.reSetAllCardRed()
end


-- 删除道具
function removeItemData(data)
	for k, v in pairs(bagItemList) do
		if v.itemId == data.itemId then
			table.remove(bagItemList, k)

			--create by liyang 2007-4-11
			strategosBB.checkDeleteItemForEquipState(data.itemId)
			strategosBB.checkBagItemForEquipState(data)
			strategosBB.setMainPanelRedTip()
			cardBB.reSetAllCardRed()
			break
		end
	end
end


-- 可以强化的装备
function hasStrengthenEquip()
	for k,v in pairs(bagItemList) do
		if v.equipLevel > 0 then
			return true
		end
	end

	return false
end