-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : LoggerManager.lua
--  Creator     : zg
--  Date        : 2017-5-9
--  Comment     : 
-- ***************************************************************


LoggerManager = BaseClass()


function LoggerManager:initialize() 

end


--此函数输出的日志不能打印到控制台， 只能显示
function LoggerManager:interceptMessage(condition, stackTrace, errType)
    -- 错误和异常日志，写入日志文件，上传到性能监控
    if errType == 'Error' then
        local errorStr = "[Error:] " .. condition .. " " .. stackTrace 
        if not applicationConfig.macro.UNITY_EDITOR then
            self:errorToServer(json.encode(errorStr))
        end
        LogUtility.Log(errorStr)

    elseif errType == 'Exception' then 
        local errorStr = "[Exception:] " .. condition .. " " .. stackTrace
        if not applicationConfig.macro.UNITY_EDITOR then
            self:errorToServer(json.encode(errorStr))
        end
        LogUtility.Log(errorStr)

    elseif errType == 'Warning' then
        local errorStr = "[Warning:] " .. condition .. " " .. stackTrace
        LogUtility.Log(errorStr) 
    else
        -- 打印日志，不写入日志文件 

    end  
end


function LoggerManager:errorToServer(error)
    local httpUrl = applicationConfig.gameConfig.serverErrorUrl .. 
        "&uid="         .. applicationConfig.loginConfig.uid ..
        "&gameid="      .. applicationConfig.gameConfig.gameId ..
        "&sdkid="       .. applicationConfig.gameConfig.sdkid ..
        "&channelid="   .. applicationConfig.gameConfig.channelId .. 
        "&serverid="    .. applicationConfig.loginConfig.zoneid ..     
        "&mac="         .. applicationConfig.gameConfig.macAddress ..
        "&exception="   .. error ..
        "&time="        .. math.ceil(UnityEngine.Time.realtimeSinceStartup*1000) ..
        "&key="         .. Md5Utility.GetMd5Str(applicationConfig.loginConfig.uid..applicationConfig.gameConfig.gameId
                        .. applicationConfig.gameConfig.sdkid..applicationConfig.gameConfig.channelId..applicationConfig.loginConfig.zoneid
                        .. applicationConfig.gameConfig.macAddress..error) .. 
        "&version="      .. self:getVersion()

    local c = coroutine.create(
        function()
            local www = UnityEngine.WWW(httpUrl)
            UnityEngine.Yield(www)
            if www.error == nil then 
            --   local go = GameObject(Slua.ToString(www.bytes))
              -- print(Slua.ToString(www.bytes))
            else
               local go = GameObject(www.error)
            end
        end)
    coroutine.resume(c)
end


--在一帧内只发送一次
function LoggerManager:debug(bugId, logId, logMessage)
    self:bugLogToServer(bugId, logId, logMessage)
end


function LoggerManager:bugLogToServer(bugId, logId, logMessage)
    local httpUrl = applicationConfig.gameConfig.serverErrorUrl .. 
        "&gameid="      .. applicationConfig.gameConfig.gameId ..
        "&sdkid="       .. applicationConfig.gameConfig.sdkid ..
        "&channelId="   .. applicationConfig.gameConfig.channelId .. 
        "&mac="         .. applicationConfig.gameConfig.macAddress ..
        "&serverid="    .. applicationConfig.loginConfig.zoneid ..
        "&uid="         .. applicationConfig.loginConfig.uid ..
        "&bugId="       .. bugId ..
        "&logId="       .. logId ..
        "&logMessage="  .. logMessage
    local c = coroutine.create(
        function()
            local www = UnityEngine.WWW(httpUrl)
            UnityEngine.Yield(www)
            if www.error == nil then
             --  local go = GameObject(Slua.ToString(www.bytes))
              -- print(Slua.ToString(www.bytes))
            else
            --    local go = GameObject(www.error)
            end
        end)
    coroutine.resume(c)
end


--提交客户端本地日志文件
function LoggerManager:sendAllLogsToServer(valData)
    local time = valData.time
    local playerId = valData.playerId
    local sign = valData.sign
    local url = valData.url

    local logFiles = LogUtility.GetLogFilesName()
    if logFiles.Length == 0 then
        return
    end

    local c = coroutine.create(function()
        for i=1, logFiles.Length do
            local filePath = logFiles[i]
            local content = FileUtility.GetBytes(filePath)

            local wwwForm = UnityEngine.WWWForm()
            wwwForm:AddField("time", tostring(time))
            wwwForm:AddField("playerId", tostring(playerId))
            wwwForm:AddField("sign", tostring(sign))
            local fileName = System.IO.Path.GetFileName(filePath)
            fileName = string.sub(fileName, 5, fileName.length)
        
            wwwForm:AddBinaryData("file", content, fileName, "multipart / form - data")
            local www = UnityEngine.WWW(url, wwwForm)
            UnityEngine.Yield(www)
            if www.error == nil and www.text == "0" then
                logInfo("LoggerManager:sendAllLogsToServer: 上传日志成功")
            else
                local go = GameObject(www.error)
                logInfo("LoggerManager:sendAllLogsToServer: 上传日志失败")
            end 
        end     
    end)
    coroutine.resume(c)
end


function LoggerManager:getVersion()
    local version = AssetStatusManager.instance.localConfProject.version -- 版本信息 1.0.0-100
    return version
end