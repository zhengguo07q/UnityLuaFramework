-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: platformRequest.lua
--  Creator 	: zg
--  Date		: 2016-11-30
--  Comment		: 发送请求
-- ***************************************************************


module("platformRequest", package.seeall)


function getInfo()
	platformBridge.requestMessage(platformBridge.enumMessageType.emtGetInfo, {})
end


--执行打开登录界面等
function login()
	platformBridge.requestMessage(platformBridge.enumMessageType.emtLogin, {})
end


function logout()
    platformBridge.requestMessage(platformBridge.enumMessageType.emtLogout, {})
end


function pay(shopItem)
    local dataItem = {}
    
    local extensionTab = {}
    extensionTab.userid = playerInfoBB.playerInfo.playerId
    extensionTab.username = playerInfoBB.playerInfo.playerName
    extensionTab.serverid = playerInfoBB.playerInfo.server
    extensionTab.productid = shopItem.id
    extensionTab.channelid = applicationConfig.gameConfig.channelId

    dataItem.serverid = playerInfoBB.playerInfo.server
    dataItem.userid = applicationConfig.loginConfig.uid
    dataItem.roleid = playerInfoBB.playerInfo.playerId
    dataItem.rolename = playerInfoBB.playerInfo.playerName
    dataItem.extension = json.encode(extensionTab)
    dataItem.rechargeType = shopItem.rechargeType
    dataItem.unitprice = shopItem.currency
    dataItem.currencyType = shopItem.currencyType
    dataItem.productcode = shopItem.product
    dataItem.productname = L(shopItem.name)

    platformBridge.requestMessage(platformBridge.enumMessageType.emtPay, dataItem)
end


function report(playerId, serverId,level)
    local dataItem = {}
    dataItem.serverId = serverId
    dataItem.userId = playerId
    dataItem.level = level
    platformBridge.requestMessage(platformBridge.enumMessageType.emtReport, dataItem)
end


function gm()
	
end


function share()
    local dataItem = {}
    dataItem.serverid = playerInfoBB.playerInfo.server
    dataItem.roleid = playerInfoBB.playerInfo.playerId
    platformBridge.requestMessage(platformBridge.enumMessageType.emtShare, dataItem)
end


function userCenter()

end


function bbs()
	
end


function exit()

end


-- 错误日志，用法如下
-- platformRequest.errorLog(400,"adecError","Request fail!")
function errorLog(errorType,errorCode,errorContent)
    local msg = {}
    msg.errorType = errorType
    msg.errorCode = errorCode
    msg.errorContent = errorContent

    -- print_t(msg)
    logInfo("platformRequest.errorLog:" .. errorContent)
    platformBridge.requestMessage(platformBridge.enumMessageType.emtErrorLog, msg)
end


-- 玩家事件，用法如下
-- platformRequest.playerEvent(
--     platformBridge.enumEventType.eetCopyzone        --事件类型
--     ,1                                              --事件ID
--     ,"事件名字"                                     --事件名字
--     ,platformBridge.enumEventState.eesStart         --事件状态
--     ,"事件说明"                                     --事件说明
-- )
function playerEvent(eventType,eventId,eventName,eventState,eventComment)
    local msg = {}
    msg.eventType = eventType
    msg.eventId = eventId
    msg.eventName = eventName
    msg.eventState = eventState
    msg.eventComment = eventComment

    -- print_t(msg)
    logInfo("platformRequest.playerEvent:" .. eventComment)
    platformBridge.requestMessage(platformBridge.enumMessageType.emtPlayerEvent, msg)
end


-- 玩家物品，用法如下
-- platformRequest.playerItem(
--     platformBridge.enumItemType.eitOther          --物品类型
--     ,1                                            --物品ID
--     ,"物品名字"                                   --物品名字
--     ,1                                            --物品获得或消耗数量(消耗用负值)
--     ,"物品说明"                                   --物品说明(如:物品来源或用途)
-- )
function playerItem(itemType,itemId,itemName,itemNum,itemComment)
    local msg = {}
    msg.itemType = itemType
    msg.itemId = itemId
    msg.itemName = itemName
    msg.itemNum = itemNum
    msg.itemComment = itemComment

    -- print_t(msg)
    logInfo("platformRequest.playerItem:" .. itemComment)
    platformBridge.requestMessage(platformBridge.enumMessageType.emtPlayerItem, msg)
end


-- 玩家信息，用法如下
-- platformRequest.playerInfo(platformBridge.enumInfoType.eitVipUpdate)--信息类型

-- 玩家信息，用法2如下
-- platformRequest.playerInfo(
--     platformBridge.enumInfoType.vipUpdate     --信息类型
--     ,1                                        --服务器ID
--     ,"服务器名字"                             --服务器名字
--     ,1                                        --用户ID
--     ,1                                        --用户等级
--     ,1                                        --用户VIP等级
--     ,"用户名字"                               --用户名字
-- )
function playerInfo(infoType,serverId,serverName,userId,userLevel,userVipLevel,userName)
    local msg = {}
    msg.infoType = infoType
    msg.serverId = serverId
    msg.serverName = serverName
    msg.userId = userId
    msg.userLevel = userLevel
    msg.userVipLevel = userVipLevel
    msg.userName = userName

    --允许不传服务器信息和玩家信息，将从固定位置读取
    if applicationConfig.loginConfig then
        if not msg.serverId then
            msg.serverId = applicationConfig.loginConfig.zoneid
        end
        if not msg.serverName then
            msg.serverName = applicationConfig.loginConfig.zonename
        end
    end
    if not msg.userId then
        msg.userId = playerInfoBB.playerInfo.playerId
    end
    if not msg.userLevel then
        msg.userLevel = playerInfoBB.playerInfo.level
    end
    if not msg.userVipLevel then
        msg.userVipLevel = playerInfoBB.playerInfo.vipLevel
    end
    if not msg.userName then
        msg.userName = playerInfoBB.playerInfo.playerName
    end

    -- print_t(msg)
    logInfo("platformRequest.playerInfo:" .. infoType)
    platformBridge.requestMessage(platformBridge.enumMessageType.emtPlayerInfo, msg)
end


-- 讯飞登录 TODO:最后讯飞相关函数可合并
function iflyLogin(userId)
    local msg = { userId = userId }    
    platformBridge.requestMessage(platformBridge.enumIflyEventType.eietLogin, msg)
end


function iflyLoginOut()
    local msg = { userId = "1" }
    platformBridge.requestMessage(platformBridge.enumIflyEventType.eietLogOut, msg)
    loginBB.isGVoiceInitOK = false
end


-- 开始录音
function startRecord()
    -- local msg = { start = "1" }
    -- platformBridge.requestMessage(platformBridge.enumIflyEventType.eietStartRecord, msg)
    GVoiceUtility.GetInstance():StartRecord()
end


function stopRecord()
    -- local msg = { endRecord = "1" }
    -- platformBridge.requestMessage(platformBridge.enumIflyEventType.eietStopRecord, msg)
    GVoiceUtility.GetInstance():StopRecord() --自动上传
end


function cancleRecord()
    -- local msg = { cancleRecord = "1" }
    -- platformBridge.requestMessage(platformBridge.enumIflyEventType.eietCancleRecord, msg)
    GVoiceUtility.GetInstance():CancleRecord()
end


-- 请求播放语音
function startPlay(fileId)
    if chatBB.lastOptions ~= nil then
        -- GVoiceUtility.GetInstance():StopPlayReocrdFile()
        -- if chatBB.lastOptions.fileid ~= fileId then
        --     chatBB.stopVoiceAnim(chatBB.lastOptions)
        -- end
        chatBB.stopAllVoiceAnim()
    end
    GVoiceUtility.GetInstance():PlayReocrdFile(fileId)
end


function loginComplete()
    platformBridge.requestMessage(platformBridge.enumMessageType.emtLoginComplete, {uid = applicationConfig.loginConfig.uid})
end


function intoMainScene()
    platformBridge.requestMessage(platformBridge.enumMessageType.emtIntoMainScene, {})
end


--设置排行榜
function setRank(score, board)
    if playerInfoBB.isGameCenterLogin then        
        Social.ReportScore(score, board, platformRequest.onSetRank)
    end
end


function onSetRank( success )
    if success then
        logInfo("设置Game Center排行榜成功")
    else
        logInfo("设置Game Center排行榜失败")
    end
end


--设置成就
function setProgress(achievementID, progress)
    if playerInfoBB.isGameCenterLogin then   
        Social.ReportProgress(achievementID, progress, platformRequest.onSetProgress)  
    end
end


function onSetProgress( success )
    if success then
        logInfo("设置Game Center成就成功")
    else
        logInfo("设置Game Center成就失败")
    end
end