-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: timeManagerUtility.lua
--  Creator 	: linyongqing
--  Date		: 2017-4-18
--  Comment		: 
-- ***************************************************************


module("timeManagerUtility", package.seeall)


serverTimeNow = 0
centenTime    = 0
heartCount    = 0


-- 获取服务器时间（毫秒）
function getServerTimeNow()
	local time = serverTimeNow + (Time.time - centenTime) * 1000
	return time
end


-- 获取服务器时间（毫秒）
function getServerTimeBySes()
	return getServerTimeNow()
end


-- 获取服务器时间（秒）
function getServerTimeMs()
	return getServerTimeNow() * 0.001
end


function enterGameSuccUpdateTime(data)
	serverTimeNow = data.currTime
	centenTime    = Time.time
end


function updateServerTime(data)
	heartCount = heartCount + 1
	local clientTime = Time.time * 1000
	if heartCount <= 1 or clientTime - data.clientTime < 200 then
		serverTimeNow = data.serverTime + (clientTime - data.clientTime) / 2
		centenTime	  = Time.time
	end
end


function sendHeart()
	NetClient.Send(20010131, { delayTime = Time.time * 1000 })
	LuaTimer.Add(0, 3000, function ()
		NetClient.Send(20010131, { delayTime = Time.time * 1000 })
		return true
	end)
end