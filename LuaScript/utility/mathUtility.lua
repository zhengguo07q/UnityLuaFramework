-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: mathUtility.lua
--  Creator 	: panyuhuan
--  Date		: 2017-1-9
--  Comment		: 
-- ***************************************************************


module("mathUtility", package.seeall)


-- 取整数部分
function getIntNum(x)
	if x == 0 then
		return 0
	end

	if math.ceil(x) == x then
		x = math.ceil(x)
	else
		x = math.ceil(x) - 1
	end
	return x
end


-- 四舍五入
function round(x)
	if x - math.floor(x) > 0.4 then
		return math.ceil(x)
	else
		return math.floor(x)
	end
end


-- 限制大小
function clamp(value, min, max)
	if value <= min then
		value = min
	elseif value >= max then
		value = max
	end

	return value
end


--取小数部分
function getDecimalNum(x)
	if x == 0 then
		return 0
	end

	if math.floor(x) == x then
		return 0
	else
		return x - math.floor(x)
	end
end