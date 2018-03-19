-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: spriteProxy.lua
--  Creator 	: pyh
--  Date		: 2016-12-29
--  Comment		: 
-- ***************************************************************


module("spriteProxy", package.seeall)

local consumeAtlasPath = "Atlas/ItemIcon/ConsumeAtlas"            --消耗类0
local materialAtlasPath = "Atlas/ItemIcon/MaterialAtlas"          --材料类
local captainEquipAtlasPath = "Atlas/ItemIcon/CaptainEquipAtlas"  --舰长装备
local cardSoulAtlasPath = "Atlas/ItemIcon/CardSoulAtlas"          --卡魂
local cardItemAtlasPath = "Atlas/ItemIcon/CardItemAtlas"          --卡魂
local consumeAtlas1Path = "Atlas/ItemIcon/ConsumeAtlas1"          --消耗类1


function getAtalsPath(altas)
	if altas == 0 then
		return consumeAtlasPath
	elseif altas == 1 then
		return materialAtlasPath
	elseif altas == 2 then
		return captainEquipAtlasPath
	elseif altas == 3 then
		return cardSoulAtlasPath
	elseif altas == 4 then
		return cardItemAtlasPath
	elseif altas == 5 then
		return consumeAtlas1Path
	else
		return ""
	end
end


function getTroopAtalsPath(isTroop)
	if isTroop == false then
		return "Atlas/CardMagic/CardMagic"
	else
		return "Atlas/CardTroopEquip/CardTroopEquip"
	end
end


function getItemFrameSpriteNameByQualityV6(itemQuality)
	local spriteName = ""
	if itemQuality == 1 then
		spriteName = "BG-wupin-bai"
	elseif itemQuality == 2 then
		spriteName = "BG-wupin-lv"
	elseif itemQuality == 3 then
		spriteName = "BG-wupin-lan"
	elseif itemQuality == 4 then
		spriteName = "BG-wupin-zi"
	elseif itemQuality == 5 then
		spriteName = "BG-wupin-cheng"
	elseif itemQuality == 0 then 
		spriteName = "BG-wupin-wu"
	end

	return spriteName
end


function isArmFrameLackByType(itemType)
	if itemType == bagBB.itemType.token or itemType == bagBB.itemType.generalEquip or itemType == bagBB.itemType.cardSoul or 
		itemType == bagBB.itemType.ordnancePiece or itemType == bagBB.itemType.ordnanceDrawings then
        return true
    end
    return false
end


-- 获取物品缺角品质框和非缺角品质框
function getArmFrameSpriteNameByQualityType(itemQuality,itemType)
	local spriteName = ""
	if isArmFrameLackByType(itemType) == true then
		if itemQuality == 1 then
			spriteName = "BG-wupin-bai"
			--"card-bai"
		elseif itemQuality == 2 then
			spriteName = "BG-wupin-lv"
			--"card-lv"
		elseif itemQuality == 3 then
			spriteName = "BG-wupin-lan"
			--"card-lan"
		elseif itemQuality == 4 then
			spriteName = "BG-wupin-zi"
			--"card-zi"
		elseif itemQuality == 5 then
			spriteName = "BG-wupin-cheng"
			--"card-cheng"
		end
		return spriteName
	else
		spriteName = getItemFrameSpriteNameByQualityV6(itemQuality)
		return spriteName
	end
end


function getSubQualitySprite(itemQuality)
    if itemQuality == 2 then
        return "BG-wupin-lv+"
    elseif itemQuality == 3 then
        return "BG-wupin-lan+"
    elseif itemQuality == 4 then
	    return "BG-wupin-zi+"
	elseif itemQuality == 5 then
		return "BG-wupin-cheng+"
	else
		return ""
 	end
end


function getCardTroopSkill(iconAtlas)
    if iconAtlas == "CardTroopSkill1" then
    	return "Atlas/CardTroopSkill1/CardTroopSkill1"
    elseif iconAtlas == "CardTroopSkill2" then
    	return "Atlas/CardTroopSkill2/CardTroopSkill2"
    else
    	return ""
    end
end