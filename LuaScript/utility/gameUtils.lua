-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : gameUtils.lua
--  Creator     : lxy
--  Date        : 2017-2-21
--  Comment     : 
-- ***************************************************************


module("gameUtils", package.seeall)        


--取简体一到十
function getBigSimpleChineseNumber(num)
    if num == 1 then
        return L("file_cs_GameUtils_11")
    elseif num == 2 then
        return L("file_cs_GameUtils_12")
    elseif num == 3 then
        return L("file_cs_GameUtils_13")
    elseif num == 4 then
        return L("file_cs_GameUtils_14")
    elseif num == 5 then
        return L("file_cs_GameUtils_15")
    elseif num == 6 then
        return L("file_cs_GameUtils_16")
    elseif num == 7 then
        return L("file_cs_GameUtils_17")
    elseif num == 8 then
        return L("file_cs_GameUtils_18")
    elseif num == 9 then
        return L("file_cs_GameUtils_19")
    elseif num == 10 then
        return L("file_cs_GameUtils_20")
    else
        return nil
    end
end


-- 00:00 
function getStringHourTime(second, length)
    local hour = math.floor(second / 3600)
    local min = math.floor((second % 3600) / 60)
    local sec = second % 60
    return gameUtils. getIntNumber(hour, length) .. ":" .. gameUtils.getIntNumber(min, length) .. ":" .. gameUtils.getIntNumber(sec, length)
end
    
    
function getIntNumber(num, median)
    local tstr = tostring(num)
    local dis = median - #tstr
    
    for i = 1, dis do 
        tstr = "0" .. tstr
    end
    return tstr
end


-- 根据errorCode获取错误信息
function getErrorInfoByCode(errorCode)
    local str = ""
    for k,v in pairs(conf.errorCode) do
        if v.code == errorCode then 
            str = string.gsub(v.tip,"#","")
            break
        end
    end
    return str
end


-- 时间常量
Minute2Second = 60  
Hour2Minute = 60
Minute2MillionSecond = 60000
Second2MillionSecond = 1000
Hour2MillionSecond  = 3600000 

Hour2Second         = 3600 
Day2Minute          = 1440
Day2Second          = 86400
Day2MillionSecond   = 86400000


-- 00天00时00分 [startsecond 结束时间 毫秒数 , length 
function getStringDateTime(endsecond, length)
    local msecond = endsecond - timeManagerUtility.getServerTimeMs()
    if msecond <= 0 then
        return "--" .. L("activity_tian") .. "--"..L("activity_shi") .. "--" .. L("activity_fen")
    end

    local second = math.floor(msecond / 1000)
    local day = math.floor(second / Day2Second)
    local hour = math.floor((second % Day2Second) / Hour2Second)
    local min = math.floor((second % Hour2Second) / Minute2Second)
    return getIntNumber(day, length)..L("activity_tian") .. getIntNumber(hour, length) .. L("activity_shi")..getIntNumber(min, length) .. L("activity_fen")
end


function getIntNumber(num, median)
   local str = tostring(num)
   local dis = median - #str
   for i = 1, dis do   
       str = "0"..str
   end
   return str
end


--static DateTime UTC_BEIJING = new DateTime(1970, 1, 1, 8, 0, 0)
-- 暂未添加 时区
function getShortDateByTimeStamp(t)
    return os.date("%Y.%m.%d",t/1000)
end


-- msecond 毫秒数   length
function getStringHourTime2(msecond, length)
    if msecond <= 0 then        
        return "--" .. L("activity_tian") .. "--" .. L("activity_shi") .. "--" .. L("activity_fen")
    end
    local second = math.floor(msecond / 1000)
--    print("--------second-------",second)
    local hour = math.floor(second  / Hour2Second)
    local min = (second % Hour2Second) / Minute2Second
    min = math.floor(min)
    local second2 = second % 60

    local x = string.format(stringUtility.rejuctSymbol(L("nvshensongbao_05")), getIntNumber(hour, length), getIntNumber(min, length), getIntNumber(second2, length))
    return x
end

-- n:n秒, 返回ms
function getRemindTime(endTime,n)    
    local time = endTime - n*1000
    if time < 0 then return -1 end
    return time
end


--删除table里key为value的项，数组需要为1开始的连续数组
function removeTabKey(tab, key, value)
    for i=1, #tab do
        if tab[i][key] == value then
            table.remove(tab, i)
        end
    end
end


function setIPXAdaptive(cameraComponent)
    if Screen.width == 2436 and Screen.height == 1125 then
        cameraComponent.rect     = Rect(0.03, 0, 0.97, 1)
    end
end