-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : colorUtility.lua
--  Creator     : zg
--  Date        : 2016-12-6
--  Comment     : 
-- ***************************************************************


module("colorUtility", package.seeall)        


color = 
{
    white              = Color.white,
    black              = Color.black,
    naturals           = Color(219 / 255, 205 / 255, 160 / 255),
    gray               = Color(190 / 255, 190 / 255, 190 / 255),
    brown              = Color(81 / 255, 48 / 255, 33 / 255),
    red                = Color(242 / 255, 16 / 255, 10 / 255),
    orange             = Color(255 / 255, 64 / 255, 0),
    purple             = Color(251 / 255, 123 / 255, 198 / 255),
    blue               = Color(0, 210 / 255, 255 / 255),
    green              = Color(71 / 255, 212 / 255, 74 / 255),
    tab                = Color(127 / 255, 100 / 255, 73 / 255),
    titleGray          = Color(163 / 255, 163 / 255, 163 / 255),
    titleChoose        = Color(248 / 255, 191 / 255, 96 / 255),
    auntRed            = Color(170 / 255, 55 / 255, 55 / 255),
    chat               = Color(30 / 255, 30 / 255, 30 / 255),
    yellow             = Color(255 / 255, 255 / 255, 0 / 255)
}


colorType =
{
    ["White"] = 0,
    ["Black"] = 1,
    ["LightBlue"] = 2,
    ["Red"] = 3,
    ["Green"] = 4,
    ["Yellow"] = 5,
    ["Orange"] = 6,
    ["Brown"] = 7,
    ["Khaki"] = 8,
    ["Normal"] = 9,
    ["Unique"]= 10,
    ["Scarce"] = 11, 
    ["History"] = 12,
    ["Tale"] = 13, 
    ["ThinYellow"] = 14,
    ["OrangeYellow"] = 15,
    ["Gray"] = 16,
    ["LightGreen"] = 17,
    ["Purple"] = 18
}


--字符串转换颜色
function str2color(colorStr)
    local colorStrs = stringUtility.split(colorStr, ",")
    local color = Color(colorStrs[1]/255,colorStrs[2]/255,colorStrs[3]/255, 1)
    if colorStrs[4] ~= nil then
        color.a =  colorStrs[4] / 255
    end
    
    return color
end


-- 获取颜色
function getStringColor(strValue, type)
    local strColor = tostring(strValue)
    if type == colorType.White then
        strColor = string.format("[dee0e6]%s[-]", strValue)
    elseif type == colorType.Black then
        strColor = string.format("[000000]%s[-]", strValue)
    elseif type == colorType.LightBlue then
        strColor = string.format("[80f1ff]%s[-]", strValue)
    elseif type == colorType.Red then
        strColor = string.format("[fc2319]%s[-]", strValue)
    elseif type == colorType.Green then
        strColor = string.format("[49d718]%s[-]", strValue)
    elseif type == colorType.LightGreen then
        strColor = string.format("[4fe31c]%s[-]", strValue)
    elseif type == colorType.Blue then
        strColor = string.format("[0000ff]%s[-]", strValue)
    elseif type == colorType.Yellow then
        strColor = string.format("[ffff00]%s[-]", strValue)
    elseif type == colorType.Orange then
        strColor = string.format("[e9967a]%s[-]", strValue)
    elseif type ==colorType.Brown then
        strColor = string.format("[513021]%s[-]", strValue)
    elseif type == colorType.Khaki then
        strColor = string.format("[dbcda0]%s[-]", strValue)
    elseif type == colorType.Normal then
        strColor = string.format("[ffffff]%s[-]", strValue)
    elseif type == colorType.Unique then
        strColor = string.format("[00ff22]%s[-]", strValue)
    elseif type == colorType.Scarce then
        strColor = string.format("[096fff]%s[-]", strValue)
    elseif type == colorType.History then
        strColor = string.format("[d42de3]%s[-]", strValue)
    elseif type == colorType.Tale then
        strColor = string.format("[ff6600]%s[-]", strValue)
    elseif type == colorType.ThinYellow then
        strColor = string.format("[f6eabb]%s[-]", strValue)
    elseif type == colorType.Gray then
        strColor = string.format("[aea4a4]%s[-]", strValue)
    elseif type == colorType.Purple then 
        strColor = string.format("[F42ED3FF]%s[-]", strValue)
    end
    return strColor
end


--获取物品缺角品质框和非缺角品质框
function getArmFrameSpriteNameByQualityType(itemQuality)
    local spriteName = ""
    if itemQuality == 1 then
        spriteName = "Frame-suipianbox-bai" 
    elseif itemQuality == 2 then
        spriteName = "Frame-suipianbox-lv"
    elseif itemQuality == 3 then
        spriteName = "Frame-suipianbox-lan"
    elseif itemQuality == 4 then
        spriteName = "Frame-suipianbox-zi"
    elseif itemQuality == 5 then
        spriteName = "Frame-suipianbox-chengse"
    end
    return spriteName
end


--获取物品完整品质框
function getBoxFrameSpriteNameByQualityType(itemQuality)
    local spriteName = ""
    if itemQuality == 1 then
        spriteName = "Frame-box-bai" 
    elseif itemQuality == 2 then
        spriteName = "Frame-box-lv"
    elseif itemQuality == 3 then
        spriteName = "Frame-box-lan"
    elseif itemQuality == 4 then
        spriteName = "Frame-box-zi"
    elseif itemQuality == 5 then
        spriteName = "Frame-box-chengse"
    end
    return spriteName
end


-- 根据品质得到色码
function getColorByQuality(quality)
    if quality == 1 then
        return "ffffff"
    elseif quality == 2 then
        return "00ff22"
    elseif quality == 3 then
        return "096fff"
    elseif quality == 4 then
        return "d42de3"
    elseif quality == 5 then
        return "ff6600"
    end
    return "ffffff"
end


--根据品质获取颜色
function getColorByQuality2(content, quality)
	if quality == 1 then 
		return string.format("[eaeaea]%s[-]", content)
	elseif quality == 2 then 
		return string.format("[4fe31c]%s[-]", content)
	elseif quality == 3 then 
		return string.format("[1bc1ff]%s[-]", content)
	elseif quality == 4 then 
		return string.format("[fd59ff]%s[-]", content)
	elseif quality == 5 then 
		return string.format("[ffcd21]%s[-]", content)
	else
		return string.format("[ffffff]%s[-]", content)
	end
end


fightIconQualitySprNameV5 = 
{
    "BG-wupin-bai", 
    "BG-wupin-lv", 
    "BG-wupin-lan", 
    "BG-wupin-zi", 
    "BG-wupin-cheng"
}


-- 卡牌品质
function getV5FightIconSpriteNameByQuality(quality)
    return fightIconQualitySprNameV5[quality]
end