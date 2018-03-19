-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : stoneMatrixPropsUtility.lua
--  Creator     : lxy
--  Date        : 2017-3-14 21:20
--  Comment     : 
-- ***************************************************************

module("stoneMatrixPropsUtility", package.seeall)        


-- 获取符文道具形状
function getRuneShapeByType(type)
	local ret = ""
	if type == 0 then
		ret = "sanjiaoxing"
	elseif type == 1 then
		ret = "lingxing"
	elseif type == 2 then
		ret = "xingxing"
	end
	return ret
end


--获取符文道具颜色
function getRuneColorByLevel(level)
 	local ret = ""
 	if level == 1 then
 		ret = "baise"
 	elseif level == 2 then
 		ret = "lvse"
 	elseif level == 3 then
 		ret = "lanse"
 	elseif level == 4 then
 		ret = "zise"
 	elseif level == 5 then
 		ret = "chengse"
 	elseif level == 6 then
 		ret = "hongse"
 	elseif level == 7 then
 		ret = "jinse"
 	elseif level == 8 then
 		ret = "heise"
 	elseif level == 9 then
 		ret = "fense"
 	elseif level == 10 then
 		ret = "shenghongse"
 	end
 	return ret
 end


 -- 根据类型等级得到符文的icon
function getBgSpriteName(level, type)
	local color = getRuneColorByLevel(level)
	local shape = getRuneShapeByType(type)
	return "icon_" .. shape .. "-" ..color
end


-- 符文符号
function remarkSprite(fuhaokaitou, attr)
	local ret = ""
 	if attr == "hp" then
 		ret = fuhaokaitou .. "shengming"
 	elseif attr == "atk" then
 		ret = fuhaokaitou .. "gongji"
 	elseif attr == "as" then
 		ret = fuhaokaitou .. "gongjisudu"
 	elseif attr == "ms" then
 		ret = fuhaokaitou .. "yidong"
 	elseif attr == "crit" then
 		ret = fuhaokaitou .. "baojilv"
 	elseif attr == "cthm" then
 		ret = fuhaokaitou .. "baoji"
 	elseif attr == "drpt" then
 		ret = fuhaokaitou .. "baoji"
 	end
 	return ret
end


function isPercent(percent, attribute)
    if attribute and attribute ~= "" then
        if (attribute == "crit" or attribute == "drpt") then -- 暴击率  ---免伤率            
            return true
        end
    end

    local percentstr = string.lower(percent)
    if (percentstr == "base" or percentstr == "add") then return false end

    if percentstr == "addpt" or percentstr == "pt" or percentstr == "basept" then
        return true
    end
    return false
end
