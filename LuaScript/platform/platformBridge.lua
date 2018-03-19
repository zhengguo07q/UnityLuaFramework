-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: platformBridge.lua
--  Creator 	: zg
--  Date		: 2016-11-10
--  Comment		: 在这里进行wrapper包装
-- ***************************************************************


module("platformBridge", package.seeall)


--定义枚举类型
enumMessageType = 
{
    emtGetLanguage          = 'emtGetLanguage',
    emtGetInfo              = 'emtGetInfo',
    emtLogin                = 'emtLogin',
    emtLogout               = 'emtLogout',
    emtPay                  = 'emtPay',
    emtGm                   = 'emtGm',
    emtShare                = 'emtShare',
    emtUserCenter           = 'emtUserCenter',
    emtBbs                  = 'emtBbs',
    emtExit                 = 'emtExit',
    emtLog                  = 'emtLog',
    emtErrorLog             = 'emtErrorLog',
    emtSdkLog               = 'emtSdkLog',
    emtSdkErrorLog          = 'emtSdkErrorLog',
    emtPlayerInfo           = 'emtPlayerInfo',
    emtPlayerItem           = 'emtPlayerItem',
    emtPlayerEvent          = 'emtPlayerEvent',
    emtReport               = 'emtReport',
    emtLoginGameCenter      = 'emtLoginGameCenter',
    emtIntoMainScene        = 'emtIntoMainScene',
    emtLoginComplete        = 'emtLoginComplete',
    emtLoginValidate        = 'emtLoginValidate',   
}


--语音相关枚举类型
enumIflyEventType = 
{
    eietLogin               = "eietLogin",          --登录事件
    eietLoginOk             = "eietLoginOk",        --登录是否OK
    eietLogOut              = "eietLogOut",         --登出
    eietStartRecord         = "eietStartRecord",    -- 开始录音
    eietCancleRecord        = "eietCancleRecord",   -- 取消录音
    eietStopRecord          = "eietStopRecord",     -- 停止录音: 录音结束+上传+发送消息成功
    eietSendRecIsOk         = "eietSendRecIsOk",    -- 发送录音是否成功, UI界面可以显示该语音了
    eietStopRecord          = "eietStopRecord",     -- 停止录音
    eietStopPlay            = "eietStopPlay",       -- 停止播放
    eietStartPlay           = "eietStartPlay",      -- 开始播放
    eietRecordIsOk          = "eietRecordIsOk",     -- 录音是否成功
    eietOneVoiceIn          = "eietOneVoiceIn",     -- 来了一条语音(自己 or other)
    eietGetTxtOk            = "eietGetTxtOk",       -- 获取语音文本完毕
    eietUploadFail          = "eietUploadFail",     -- 上传失败
    eietDownloadFail        = "eietDownloadFail",   -- 下载失败
    eietPlayRecFail         = "eietPlayRecFail" ,   -- 播放失败
    eietSpeechToTextFail    = "eietSpeechToTextFail", -- 获取语音文本失败
}


--玩家事件枚举类型
enumEventType = 
{
    eetMission              = "eetMission",         --任务事件
    eetCopyzone             = "eetCopyzone",        --副本事件
    eetUserDefined          = "eetUserDefined",     --自定义事件
}


--玩家事件枚举状态
enumEventState = 
{
    eesStart                = "eesStart",           --开始
    eesFinish               = "eesFinish",          --完成
    eesFailed               = "eesFailed",          --失败
    eesCancel               = "eesCancel",          --取消
}


--玩家物品枚举类型
enumItemType = 
{
    eitDiamond              = "eitDiamond",         --钻石
    eitOther                = "eitOther",           --其他未定义的物品
}


--玩家信息枚举类型
enumInfoType = 
{
    eitInitiative           = "eitInitiative",      --初始化信息
    eitPlayerCreate         = "eitPlayerCreate",    --创建玩家
    eitPlayerUpdate         = "eitPlayerUpdate",    --玩家升级
    eitVipUpdate            = "eitVipUpdate",       --Vip等级升级
    eitPlayerBename         = "eitPlayerBename",    --取名
    eitPlayerRename         = "eitPlayerRename",    --改名
}


--发送消息到SDK
function requestMessage(messageType, options)
    print("requestMessage---------------", messageType)
    print_t(options)
    if applicationConfig.macro.UNITY_EDITOR == true then
        options.messageType = messageType
        -- options.uid = PlayerPrefs.GetString("auth_key")
        -- options.access_token = "c2lnbj1iZTRmM2ZmYTgyZTAzYWM2YzViYzYzMzJmMWZiMzU5ZiZkYXRhPXsidWlkIjoibGl5YW5nMDMiLCJzZGtpZCI6MTAwMCwiY2hhbm5lbCI6IjEiLCJwdXNoX2tleSI6IiIsInNlcnZpY2VDb2RlIjoiIiwidCI6MTUxODMzNzE1M30="
        -- 956457044 = c2lnbj1hNjFkZjc4ZWI3MTA2ZTU4N2MyYjhiZDA5Y2I3NWZjMSZkYXRhPXsidWlkIjoiOTU2NDU3MDQ0Iiwic2RraWQiOjEwMDAsImNoYW5uZWwiOiIxIiwicHVzaF9rZXkiOiIiLCJzZXJ2aWNlQ29kZSI6IiIsInQiOjE1MTc0MDA3MzF9
        -- ly01 = c2lnbj0xNjI0NGQxOTY2MzRkNmNiMDUwMDM0M2RjYzhmMzA2NiZkYXRhPXsidWlkIjoibHkwMSIsInNka2lkIjoxMDAwLCJjaGFubmVsIjoiMSIsInB1c2hfa2V5IjoiIiwic2VydmljZUNvZGUiOiIiLCJ0IjoxNTE3Mzk0MzIxfQ==
        -- ly02 = c2lnbj1mZWE1Yzc5YjlmNTVhNDVmNTkyNDk5YjUyMDA1MjdjNSZkYXRhPXsidWlkIjoibHkwMiIsInNka2lkIjoxMDAwLCJjaGFubmVsIjoiMSIsInB1c2hfa2V5IjoiIiwic2VydmljZUNvZGUiOiIiLCJ0IjoxNTE3NDA1MzU4fQ==
        -- ly10 = c2lnbj05NzAwZWNhZjA5MDc1YzMyMWYzNzE2M2ZlMzQ1OTljMyZkYXRhPXsidWlkIjoibHkxMCIsInNka2lkIjoxMDAwLCJjaGFubmVsIjoiMSIsInB1c2hfa2V5IjoiIiwic2VydmljZUNvZGUiOiIiLCJ0IjoxNTE3NDEwNjIzfQ==
        -- ly14 = c2lnbj03OTY5ODEyNzYyZjY4NjhkNmQ0NzY0MzRlY2RjZDNlYiZkYXRhPXsidWlkIjoibHkxNCIsInNka2lkIjoxMDAwLCJjaGFubmVsIjoiMSIsInB1c2hfa2V5IjoiIiwic2VydmljZUNvZGUiOiIiLCJ0IjoxNTE3NDU1MDkwfQ==
        -- ly15 = c2lnbj0zZTRkNDU4ZWYxNWJjZGMzMjlhNzQyMDM4NWI4MjViNyZkYXRhPXsidWlkIjoibHkxNSIsInNka2lkIjoxMDAwLCJjaGFubmVsIjoiMSIsInB1c2hfa2V5IjoiIiwic2VydmljZUNvZGUiOiIiLCJ0IjoxNTE3NDU2MDczfQ==
        -- 游客 = c2lnbj02MmMzNGE0NWI0MWM0ZWMwMGYwNmY4ODExZDNlZTI3ZiZkYXRhPXsidWlkIjoiNzA3MDIwMTg1MDMiLCJzZGtpZCI6MTAwMCwiY2hhbm5lbCI6IjEiLCJwdXNoX2tleSI6IiIsInNlcnZpY2VDb2RlIjoiIiwidCI6MTUxNzk5NDk0Mn0=
        responseMessage(options)
    elseif applicationConfig.macro.UNITY_ANDROID == true or applicationConfig.macro.UNITY_IOS == true then
        SDKSupportUtility.RequestMessage(messageType, options)
    end
end


--从SDK响应消息
function responseMessage(options)
    if options.messageType == enumMessageType.emtGetInfo then
        platformResponse.getInfo(options)
    elseif options.messageType == enumMessageType.emtLogin then
        print(" sdk响应 emtLogin ")
        print_t(options)
        platformResponse.login(options)
    elseif options.messageType == enumMessageType.emtLogout then
        logInfo(" sdk响应: emtLogout")
        platformResponse.logout(options)
    elseif options.messageType == enumIflyEventType.eietLoginOk then
        loginBB.isGVoiceInitOK = true
        print(" IM loginOK ")
        print_t(options)
    elseif options.messageType == enumIflyEventType.eietSendRecIsOk then -- unused change to eietGetTxtOk
        print(" eietSendRecIsOk ")
        print_t(options)
        platformResponse.isSendRecordOK(options)
    elseif options.messageType == enumIflyEventType.eietStopPlay then
        print(" eietStopPlay ")
        platformResponse.stopVoiceAnim(options) 
    elseif options.messageType == enumIflyEventType.eietCancleRecord then
        print(" eietCancleRecord ")
        -- platformResponse.stopVoiceAnim(options) 
    elseif options.messageType == enumIflyEventType.eietRecordIsOk then
        -- print("IM RecordOK: ",options)
        -- print_t(options)
    elseif options.messageType == enumIflyEventType.eietGetTxtOk then
        print(" eietGetTxtOk ")
        platformResponse.isSendRecordOK(options)
    elseif options.messageType == enumMessageType.emtSdkLog then
        logInfo("sdk log:  "..options.content)
    elseif options.messageType == enumMessageType.emtSdkErrorLog then
        logInfo("sdk errorLog:  "..options.content)
    elseif options.messageType == enumMessageType.emtLoginGameCenter then
        platformResponse.loginGameCenter(options)
    elseif options.messageType == enumMessageType.emtShare then
        logInfo(" sdk响应: emtShare")
        print("<color=red>share responseMessage-----------</color>")
        platformResponse.share(options)
    end
end

