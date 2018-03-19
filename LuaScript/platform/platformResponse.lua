-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : platformResponse.lua
--  Creator     : zg
--  Date        : 2016-11-30
--  Comment     : 接受响应net
-- ***************************************************************


module("platformResponse", package.seeall)


function getInfo(options)
    syntaxUtility.mergeTable(applicationConfig.gameConfig, options)

    if options.isDebug == "true" then
        applicationConfig.gameConfig.isDebug = true
    elseif  options.isDebug == "false" then
        applicationConfig.gameConfig.isDebug = false
    end

    if applicationConfig.gameConfig.rechargePlatform == 0 then
        applicationConfig.gameConfig.rechargePlatform = 1
        if applicationConfig.macro.UNITY_ANDROID then
            applicationConfig.gameConfig.rechargePlatform = 1
        elseif applicationConfig.macro.UNITY_IOS then
            applicationConfig.gameConfig.rechargePlatform = 2
        end
    end

    startupStatusManager.httpResponse()
end


function login(options)
    print("platformResponse login success -----------------")
    syntaxUtility.mergeTable(applicationConfig.loginConfig, options)
     if applicationConfig.macro.UNITY_EDITOR then
        applicationConfig.loginConfig.uid =  PlayerPrefs.GetString("auth_key")
     else
        if applicationConfig.loginConfig.uid and applicationConfig.loginConfig.uid ~= "" then
            PlayerPrefs.SetString("auth_key", applicationConfig.loginConfig.uid)
        end
        -- print("<color=red> ===========> SetString auth_key========== </color>",applicationConfig.loginConfig.uid, print_t(applicationConfig.loginConfig))
     end

    LoginLayer.loginSuccess()
    platformRequest.loginComplete()
end


function logout()
    logInfo("____________ logout() ____________")
    applicationGlobal.reconnect:logout()
end


function pay()
end


function gm()
    
end


function share()

end


function userCenter()

end


function bbs()
    
end


function exit()

end


--讯飞登出
function imLogout()

end


-- 协议20106307 推送过来的语音
function oneVoiceIn(options)
    print("-----------oneVoiceIn--------")
    -- 找到最后一条自己的语音信息-->找到对应的语音Item : 结束上传中 状态, 填写duration ,语音文本
    chatBB.sendChatMsg4Android(options)
end


-- TODO:点击播放的时候 声音文本

-- stop录音上传Anim  发协议数据
function isSendRecordOK(options)
    --chatPanel  jsonObject.put(IFlyConstant.SEND_RECORD_IS_OK, isOk);}  "send_record_is_ok" true false
    print("-----------isSendRecordOK------------",options)
    print_t(options)
    
    chatBB.stopVoiceAnim(options)
    oneVoiceIn(options)
end


function stopVoiceAnim(options)
    chatBB.stopVoiceAnim(options)
end


--IOS GameCenter登录
function loginGameCenter(options)
    print("-----------loginGameCenter------------")
    logInfo("-----------loginGameCenter------------")

    Social.localUser:Authenticate(platformResponse.loginGameCenterComplete)
end


function loginGameCenterComplete( success )
    print("loginGameCenterComplete" ..  Social.localUser.id)
    print(success)

    if success then
        playerInfoBB.isGameCenterLogin = true
        platformBridge.requestMessage(platformBridge.enumMessageType.emtLoginValidate, {uid = Social.localUser.id})
	else
		applicationGlobal.tooltip:errorMessage(L("ex_sc_game_center_login_failed"))
    end
end
