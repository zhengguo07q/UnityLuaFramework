-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : attributeUtility.lua
--  Creator     : ly
--  Date        : 2017-3-3
--  Comment     : 属性计算工具
-- ***************************************************************


module("attributeUtility", package.seeall)     

eunmAttrKey = { 
	 HP = "hp", -- 生命值
     ATK = "at", -- 攻击力
     AS = "as", -- 攻击速度
     MS = "ms", -- 移动速度
     SD = "sd", -- 攻击距离
     CRIT = "cit", -- 暴击率
     DG = "dg", -- 闪避率
     BK = "bk", -- 格挡率
     CTHM = "cthm", -- 暴击伤害加成
     BKHM = "bkhm", -- 格挡伤害加成
     DRPT = "drpt", -- 免伤率
     LEGATK = "legAtk", -- 军团攻击
     LEGDEF = "legDef", -- 军团防御
     HOMEHP = "homeHp"   
}


eunmAttrValueKey = {
	BASE = "base", -- 基础值 
	BASEPT = "basePt", -- 基础百分比
	ADD = "add", -- 附加值
	ADDPT = "addPt", -- 附加百分比
	PT = "pt" -- 总百分比

}

-- 设置属性键值
function setAttribute(attributeDic, attrStr)
	if attributeDic == nil then attributeDic = {} end 

	-- local strArr = stringUtility.split(attrStr, ",")
	-- for i,v in ipairs(strArr) do
		local subArr = stringUtility.split(attrStr, "_")
		if #subArr > 2 then 
			local attributeValueVO = attributeDic[subArr[1]]
			if attributeValueVO ~= nil then
				attributeValueVO[subArr[2]] = attributeValueVO[subArr[2]] + tonumber(subArr[3])
			else
				attributeValueVO = {}
				attributeValueVO[subArr[2]] = tonumber(subArr[3])
			end 
			attributeDic[subArr[1]] = attributeValueVO
		end 
	-- end
	return attributeDic
end


function addAttributeValue(oriAttrValueVO, attributeValueVO)
	if attributeValueVO == nil or oriAttrValueVO == nil then return end

	oriAttrValueVO.base = attributeValueVO.base or 0
	oriAttrValueVO.basePt = attributeValueVO.basePt or 0
	oriAttrValueVO.add = attributeValueVO.add or 0
	oriAttrValueVO.addPt = attributeValueVO.addPt or 0
	oriAttrValueVO.pt = attributeValueVO.pt or 0

	return oriAttrValueVO
end


function getTotalValue(oriAttrValueVO)
	if oriAttrValueVO == nil then 
		return 0 
	end

	local base = oriAttrValueVO.base or 0
	local basePt = oriAttrValueVO.basePt or 0
	local add = oriAttrValueVO.add or 0
	local addPt = oriAttrValueVO.addPt or 0
	local pt = oriAttrValueVO.pt or 0

	-- return (base * (1 + basePt) + add * (1 + addPt)) * (1 + pt)
	local value = 0
	if base ~= 0 or add ~= 0 then
		value = (base * (1 + basePt) + add * (1 + addPt)) * (1 + pt)
	else
		value = pt
	end 
	return value
end


function setTotalValue(oriAttrValueVO, value)
	if oriAttrValueVO == nil then
	    return
    end
    oriAttrValueVO.base = oriAttrValueVO.base or 0
	oriAttrValueVO.basePt = oriAttrValueVO.base or 0
	oriAttrValueVO.add = oriAttrValueVO.base or 0
	oriAttrValueVO.addPt = oriAttrValueVO.base or 0
	oriAttrValueVO.pt = oriAttrValueVO.base or 0

    oriAttrValueVO.serverAttrValue = value

end