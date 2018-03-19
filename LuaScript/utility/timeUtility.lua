-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : timeUtility.lua
--  Creator     : zg
--  Date        : 2017-2-17
--  Comment     : 
-- ***************************************************************


module("timeUtility", package.seeall) 


--得到特定格式的时间 00:00
function formatTimeToMinSec(time)
	local min = math.floor(time / 60)
	local sec = time % 60
    if sec < 10 then
        return min .. ':0' .. sec
    end
	return min .. ':' .. sec
end


function formatSecTime(Tr, typeId)  --Tr单位毫秒
	local formatTime = ""
    local day = math.floor(Tr / (24 * 1000 * 60 * 60))
    local hour = math.floor(((Tr - day * (24 * 1000 * 60 * 60)) / (1000 * 60 * 60)))
    local min = math.floor(((Tr - day * (24 * 1000 * 60 * 60) - hour * (1000 * 60 * 60)) / (1000 * 60)))
    local sec = math.floor(((Tr - day * (24 * 1000 * 60 * 60) - hour * (1000 * 60 * 60) - min * (1000 * 60))) / 1000)
    if typeId == 1 then
        formatTime = sec .. ''
    elseif typeId == 2 then
        formatTime = ((min > 9 and min .. '') or "0" .. min) .. ":" .. ((sec > 9 and sec .. '') or "0" .. sec)
    elseif typeId == 3 then
        formatTime = ((hour > 9 and hour.. '') or "0" .. hour) .. ":" .. ((min > 9 and min .. '') or "0" .. min) .. ":" .. ((sec > 9 and sec .. '') or "0" .. sec)
    elseif typeId == 4 then --赛季倒计时
        formatTime = ((day > 9 and day .. '') or "0" .. day) .. L("common_titel_8") .. ((hour > 9 and hour.. '') or "0" .. hour) .. L("common_titel_9") .. ((min > 9 and min .. '') or "0" .. min) .. L("common_titel_10") --.. ((sec > 9 and sec .. '') or "0" .. sec)
    elseif typeId == 5 then --礼包倒计时
        local count = 0  --显示的个数
        if day > 0 then 
            formatTime = formatTime .. day .. L("common_titel_8")
            count = count + 1
        end 

        if hour > 0 and count < 2  then 
            formatTime = formatTime .. hour .. L("common_titel_9")
             count = count + 1
        end 

        if min > 0 and count < 2  then 
            formatTime = formatTime .. min .. L("common_titel_10")
            count = count + 1
        end 

        if sec > 0 and count < 2 then 
            formatTime = formatTime .. sec .. L("common_titel_11")
        end       
    end
    return formatTime
end





function getTimeStamp(t)
    local tableTime = os.date("*t", t/1000)
    return tableTime.month .. "/" .. tableTime.day .. " " .. tableTime.hour .. ":" .. tableTime.min
end

function nowTimeSpan(Tr, tp)
	local dt_1970 = TimeZone.CurrentTimeZone.ToLocalTime(DateTime(1970, 1, 1))
	local tricks_1970 = dt_1970.Ticks--1970年1月1日刻度
	local time_tricks = tricks_1970 + Tr * 10000--日志日期刻度
	local now_tricks = tricks_1970 + TimeManager.Instance.ServerTimeNow * 10000--当前日期刻度
	local timeSpan = TimeSpan(time_tricks)
	local timeSpanNow = TimeSpan(now_tricks)
	return timeSpanNow - timeSpan
end


function getTime(t)
    local hour = mathUtility.getIntNum(t / (1000 * 60 * 60))
    local min = mathUtility.getIntNum(((t - hour * (1000 * 60 * 60)) / (1000 * 60)))
    local sec = mathUtility.getIntNum((t - hour * (1000 * 60 * 60) - min * (1000 * 60)) / 1000)
    local timeString = ((hour > 9 and hour.. '') or "0" .. hour) .. ":" .. ((min > 9 and min .. '') or "0" .. min) .. ":" .. ((sec > 9 and sec .. '') or "0" .. sec)

    return timeString
end


-- 延迟多少s后点击
buttonTime = 0
function checkBtnIsClick(delayTime)
    if Time.time - buttonTime < delayTime then
        return false
    end

    buttonTime = Time.time

    return true
end


-- 00:00 
function getStringHourTime(second, length)
    local hour = math.floor(second / 3600)
    local min = math.floor((second % 3600) / 60)
    local sec = math.floor(second % 60)
    return getIntNumber(hour, length) .. ":" .. getIntNumber(min, length) .. ":" .. getIntNumber(sec, length)
end
    
    
function getIntNumber(num, median)
    local tstr = tostring(num)
    local dis = median - #tstr
    
    for i = 1, dis do 
        tstr = "0" .. tstr
    end
    return tstr
end


--秒转换成00:00:00格式
function secToStr(secCount)
    local hour = math.floor(secCount/3600)
    local minute = math.fmod(math.floor(secCount/60), 60)
    local second = math.fmod(secCount, 60)

    local str = "[b]" .. string.format("%02d", hour) .. ":" .. string.format("%02d", minute) .. ":" .. string.format("%02d", second) .. "[/b]"

    return str
end


--月日转换成xx月xx日格式
function mdToStr(month, day)
    return string.format(stringUtility.rejuctSymbol(L("gang_info_75")), string.format("%02d", month), string.format("%02d", day))
end


--判断现在时间是否在当天时间段内，weeks单位为星期（1-7）
function isScheduledTime(stratTime, endTime, weeks)
    local serverTime = timeManagerUtility.getServerTimeNow() 
    serverTime = serverTime * 0.001
    local timeNow_t = os.date("*t", serverTime)

    local startTime_t = stringUtility.split(stratTime, ":")
    local endTime_t = stringUtility.split(endTime, ":")

    local timeNow = serverTime
    --转化得到时间戳（秒）
    local startTime = os.time({year = timeNow_t.year, month = timeNow_t.month, day = timeNow_t.day, hour = startTime_t[1], min = startTime_t[2], sec = startTime_t[3]})
    local endTime = os.time({year = timeNow_t.year, month = timeNow_t.month, day = timeNow_t.day, hour = endTime_t[1], min = endTime_t[2], sec = endTime_t[3]})

    local week = timeNow_t.wday - 1
    local isWeek = false
    for i=1, #weeks do
        if weeks[i].week == 7 then
            weeks[i].week = 0
        end
        if weeks[i].week == week then
            isWeek = true
            break
        end
    end
    
    if isWeek then
        if endTime == "24:00:00" and timeNow >= startTime then
            return true
        end

        if timeNow >= startTime and timeNow < endTime then
            return true
        end
    end

    return false
end


--判断当天是否在安排的日期内，weeks单位为星期（1-7）
--参数（字符串“1,3,5”  或者  表{1, 3, 5}）
function isScheduledWday(weeks)
    if type(weeks) == "string" then
        weeks = stringUtility.split(weeks, ",")
    end
    local serverTime = timeManagerUtility.getServerTimeBySes() -- 暂时用本地时间，到时候统一换成服务器时间
    serverTime = serverTime / 1000
    local serverTime_t = os.date("*t", serverTime)

    local wday = serverTime_t.wday - 1
    if wday == 0 then
        wday = 7
    end

    for i=1, #weeks do
        if tonumber(weeks[i]) == tonumber(wday) then
            return true
        end
    end

    return false
end


--获取距离当天24:00的秒杀
function getZeroSec()
    local serverTime = timeManagerUtility.getServerTimeBySes() -- 暂时用本地时间，到时候统一换成服务器时间
    serverTime = serverTime / 1000
    local timeNow_t = os.date("*t", serverTime)

    local endTime = os.time({year = timeNow_t.year, month = timeNow_t.month, day = timeNow_t.day, hour = 0, min = 0, sec = 0})
    endTime = endTime + 24*60*60

    return endTime - serverTime
end