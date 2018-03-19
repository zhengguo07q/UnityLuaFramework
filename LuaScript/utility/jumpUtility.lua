-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : jumpUtility.lua
--  Creator     : liyang
--  Date        : 2017-4-8
--  Comment     : 成就任务或者升级任务跳转到窗口
-- ***************************************************************


module("jumpUtility", package.seeall)


--所有的跳转
Jump = 
{
    jMain                    = 1,            --主界面
    jCaptainAttribute        = 1100,         --舰长属性
    jCaptainEquip            = 1101,         --舰长装备
    jCaptainStory            = 1102,         --舰长故事
    jGuardArmy               = 1200,         --列表-部队
    jGuardWeapon             = 1201,         --列表-战术武器
    jGuardAssemble           = 1202,         --列表-组合推荐
    jGuardAttribute          = 1203,         --护卫队属性
    jGuardEquip              = 1204,         --护卫队装备
    jGuardStory              = 1205,         --护卫队故事
    jGangList                = 1300,         --军团列表
    jGangInformation         = 1301,         --军团基本信息
    jGangMember              = 1302,         --成员列表
    jGangDaily               = 1303,         --军团日志
    jGangApply               = 1304,         --申请列表
    jGangBusiness            = 1305,         --成员交易
    jGangMission             = 1306,         --军团任务
    jGangRedPacket           = 1307,         --每日红包
    jGangProvidePacket       = 1308,         --发红包
    jGangGetPacket           = 1309,         --抢红包
    jGangTechnology          = 1310,         --军团科技
    jGangBoss                = 1311,         --军团BOSS
    jBag                     = 1400,         --背包
    jTeamArmy                = 1500,         --战队-部队
    jTeamWeapon              = 1501,         --战队-战术武器
    jMissionDay              = 1600,         --日常任务
    jMissionAchievement      = 1601,         --成就
    jRankMilitary            = 1700,         --军衔榜
    jRankGang                = 1701,         --军团榜
    jRankArena               = 1702,         --竞技榜
    jActivitySeriesSigned    = 1800,         --连续签到
    jActivityDaySigned       = 1801,         --天天签到
    jActivityLevelUp         = 1802,         --升级奖励
    jActivityMilitary        = 1803,         --军衔奖励
    jActivityVip             = 1804,         --VIP福利
    jActivityGrowUp          = 1805,         --成长基金
    jActivityFirstRecharge   = 1806,         --首充
    jMallRecharge            = 1900,         --充值
    jMallSupply              = 1901,         --补给站
    jMallGold                = 1902,         --金币商店
    jMallMilkyWay            = 1903,         --银河商会
    jMallGang                = 1904,         --军团商店
    jMallExploit             = 1905,         --功勋商店
    jMallArena               = 1906,         --竞技商店
    jFriendList              = 2000,         --我的好友
    jFriendApply             = 2001,         --好友申请
    jFriendPresent           = 2002,         --好友赠送
    jFriendRecommend         = 2003,         --好友推荐
    jPostBox                 = 2100,         --邮箱
    jMatchMain               = 2200,         --赛事主界面
    jMatchArena              = 2201,         --星航竞技
    jMatchFairPlay           = 2202,         --公平竞技
    jPatrolMain              = 2300,         --巡逻主界面
    jPatrolCaptain           = 2301,         --舰长试炼
    jPatrolMilkyWay          = 2302,         --银河传记
    jPatrolStar              = 2303,         --星空探秘
    jPatrolDiamondOre        = 2304,         --矿星剿匪
    jPatrolGoldOre           = 2305,         --狙击异兽
    jPatrolExpOre            = 2306,         --经验本
    jWarGalaxy               = 2400,         --星系界面
    jWarStar                 = 2401,         --星球列表界面
    jWarInformation          = 2402,         --星球详情
    jEventMain               = 2500,         --联赛主界面
    jEventBook               = 2501,         --联赛图鉴
    jEventSeason             = 2502,         --赛季
    jEventData               = 2503,         --数据统计
    jEventHistory            = 2504,         --历史战绩
    jEventReward             = 2505,         --奖励
    jSetIndividual           = 2600,         --个人设置
    jSetLanguage             = 2601,         --语言设置
    jSetAnnouncement         = 2602,         --游戏公告
    jVipMain                 = 2700,         --VIP主界面
    jMyStarMain              = 2800,         --我的星球主界面
}


--所有的跳转对应的功能开放，nil的默认开放
JumpFunctionMap = 
{
    jMain                    = nil,                                                --主界面
    jCaptainAttribute        = functionOpend.Functions.fCaptainProperty,           --舰长属性
    jCaptainEquip            = functionOpend.Functions.fCaptainEquip,              --舰长装备
    jCaptainStory            = functionOpend.Functions.fCaptainStory,              --舰长故事
    jGuardArmy               = functionOpend.Functions.fGuardList,                 --列表-部队
    jGuardWeapon             = nil,                                                --列表-战术武器
    jGuardAssemble           = nil,                                                --列表-组合推荐
    jGuardAttribute          = functionOpend.Functions.fGuardProperty,             --护卫队属性
    jGuardEquip              = functionOpend.Functions.fGuardEquip,                --护卫队装备
    jGuardStory              = functionOpend.Functions.fGuardStory,                --护卫队故事
    jGangList                = functionOpend.Functions.fGangList,                  --军团列表
    jGangInformation         = functionOpend.Functions.fGangCore,                  --军团基本信息
    jGangMember              = nil,                                                --成员列表
    jGangDaily               = nil,                                                --军团日志
    jGangApply               = nil,                                                --申请列表
    jGangBusiness            = functionOpend.Functions.fGangTrans,                 --成员交易
    jGangMission             = functionOpend.Functions.fGangMission,               --军团任务
    jGangRedPacket           = functionOpend.Functions.fGangRed,                   --每日红包
    jGangProvidePacket       = nil,                                                --发红包
    jGangGetPacket           = nil,                                                --抢红包
    jGangTechnology          = functionOpend.Functions.fGangTechnology,            --军团科技
    jGangBoss                = functionOpend.Functions.fGangBoss,                  --军团BOSS
    jBag                     = functionOpend.Functions.fBag,                       --背包
    jTeamArmy                = functionOpend.Functions.fBunch,                     --战队-部队
    jTeamWeapon              = nil,                                                --战队-战术武器
    jMissionDay              = functionOpend.Functions.fMissionDay,                --日常任务
    jMissionAchievement      = functionOpend.Functions.fMissionAchievement,        --成就
    jRankMilitary            = functionOpend.Functions.fRankMilitary,              --军衔榜
    jRankGang                = functionOpend.Functions.fRankGang,                  --军团榜
    jRankArena               = functionOpend.Functions.fRankArena,                 --竞技榜
    jActivitySeriesSigned    = functionOpend.Functions.fActivitySeries,            --连续签到
    jActivityDaySigned       = functionOpend.Functions.fActivityDay,               --天天签到
    jActivityLevelUp         = functionOpend.Functions.fActivityUpLev,             --升级奖励
    jActivityMilitary        = functionOpend.Functions.fActivityMilitary,          --军衔奖励
    jActivityVip             = functionOpend.Functions.fActivityVip,               --VIP福利
    jActivityGrowUp          = functionOpend.Functions.fActivityUpGrow,            --成长基金
    jActivityFirstRecharge   = functionOpend.Functions.fActivityFirstFlush,        --首充
    jMallRecharge            = functionOpend.Functions.fShopRecharge,              --充值
    jMallSupply              = functionOpend.Functions.fShopDepot,                 --补给站
    jMallGold                = functionOpend.Functions.fShopGold,                  --金币商店
    jMallMilkyWay            = functionOpend.Functions.fShopMilkyWay,              --银河商会
    jMallGang                = functionOpend.Functions.fShopGang,                  --军团商店
    jMallExploit             = functionOpend.Functions.fShopFairPlaying,           --功勋商店
    jMallArena               = functionOpend.Functions.fShopAthletics,             --竞技商店
    jFriendList              = functionOpend.Functions.fFriendMy,                  --我的好友
    jFriendApply             = functionOpend.Functions.fFriendApply,               --好友申请
    jFriendPresent           = functionOpend.Functions.fFriendGive,                --好友赠送
    jFriendRecommend         = functionOpend.Functions.fFriendReferral,            --好友推荐
    jPostBox                 = functionOpend.Functions.fEmail,                     --邮箱
    jMatchMain               = functionOpend.Functions.fMatch,                     --赛事主界面
    jMatchArena              = functionOpend.Functions.fMatchArena,                --星航竞技
    jMatchFairPlay           = functionOpend.Functions.fMatchFairCompetition,      --公平竞技
    jPatrolMain              = functionOpend.Functions.fPatrol,                    --巡逻主界面
    jPatrolCaptain           = functionOpend.Functions.fPatrolCaptainTried,        --舰长试炼
    jPatrolMilkyWay          = functionOpend.Functions.fPatrolMilkyWay,            --银河传记
    jPatrolStar              = functionOpend.Functions.fPatrolStarrySky,           --星空探秘
    jPatrolDiamondOre        = functionOpend.Functions.fPatrolDiamond,             --矿星剿匪
    jPatrolGoldOre           = functionOpend.Functions.fPatrolGold,                --狙击异兽
    jPatrolExpOre            = functionOpend.Functions.fPatrolExp,                 --经验本
    jWarGalaxy               = functionOpend.Functions.fGalaxyQuest,               --星系界面
    jWarStar                 = nil,                                                --星球列表界面
    jWarInformation          = nil,                                                --星球详情
    jEventMain               = functionOpend.Functions.fLeague,                    --联赛主界面
    jEventBook               = nil,                                                --联赛图鉴
    jEventSeason             = nil,                                                --赛季
    jEventData               = nil,                                                --数据统计
    jEventHistory            = nil,                                                --历史战绩
    jEventReward             = nil,                                                --奖励
    jSetIndividual           = functionOpend.Functions.fSystemPerson,              --个人设置
    jSetLanguage             = functionOpend.Functions.fSystemLanguage,            --语言设置
    jSetAnnouncement         = functionOpend.Functions.fSystemNotice,              --游戏公告
    jVipMain                 = functionOpend.Functions.fVip,                       --VIP主界面
    jMyStarMain              = nil,                                                --我的星球主界面
}


-- 跳转到模块
function jumpToModule(jumpEventId, pars, basePanel)
    print("跳转到模块------", jumpEventId)
    local isOpen = false
    local isNeedCheck = false
    local isNotCallBack = false

    --任务成就
    if jumpEventId == windowResId.missionPanel.id then 
        print("<color=red> ################################### </color>")
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fMissionAchievement, false)
        if isOpen then
            WindowStack.instance:openWindow(windowResId.missionPanel, basePanel, false, {callback = function(panel) 
                panel:selectList(2)
            end})
        end
    --星际远征
    elseif jumpEventId == 2 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fGalaxyQuest, false)
        if isOpen then
            applicationGlobal.sceneSwitchManager:enterScene(sceneSwitchRes.universeScene)
        end
    --银河联赛
    elseif jumpEventId == windowResId.qualifyingPanel.id then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fLeague, false)
        if isOpen then
            WindowStack.instance:openWindow(windowResId.qualifyingPanel, nil, false)
        end
    --聊天
    elseif jumpEventId == windowResId.chatPanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.chatPanel, nil, false)
        end
    --好友
    elseif jumpEventId == windowResId.friendPanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.friendPanel, nil, false)
        end
    --战队
    elseif jumpEventId == windowResId.battleLineupPanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.battleLineupPanel, nil, false)
        end
    --排行榜
    elseif jumpEventId == windowResId.rankPanel.id then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fRank, false)
        if isOpen then
            WindowStack.instance:openWindow(windowResId.rankPanel, nil, false)
        end
    --公告
    elseif jumpEventId == windowResId.noticePanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.noticePanel, nil, false)
        end
    --商店
    elseif jumpEventId == windowResId.shopPanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.shopPanel, nil, false)
        end
    --背包
    elseif jumpEventId == windowResId.bagPanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.bagPanel, nil, false)
        end
    --活动
    elseif jumpEventId == windowResId.activityPanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.activityPanel, nil, false)
        end
    --舰长
    elseif jumpEventId == windowResId.strategosPanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.strategosPanel, nil, false)
        end
    --邮件
    elseif jumpEventId == windowResId.emailPanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.emailPanel, nil, false)
        end
    --VIP
    elseif jumpEventId == windowResId.vipPanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.vipPanel, nil, false)
        end
    --设置界面
    elseif jumpEventId == windowResId.playerInfoPanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.playerInfoPanel, nil, false)
        end
    --护卫队
    elseif jumpEventId == windowResId.cardPanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.cardPanel, nil, false)
        end
    --加入公会
    elseif jumpEventId == windowResId.gangGangListPanel.id then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.gangGangListPanel, nil, false)
        end
    --日常任务
    elseif jumpEventId == windowResId.missionPanel.id then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fMissionAchievement, false)
        if isOpen then
            WindowStack.instance:openWindow(windowResId.missionPanel, nil, false)
        end
    --砖石
    elseif jumpEventId == 55 then 
        isNeedCheck = true 
        isOpen = true -- functionOpend.getState(functionOpend.EFunctions.ScoopDiamond, false)
        if isOpen then
            awardBattleBB.openUI(awardBattleBB.awardBattleType.abtDiamond)
        end
    --金币
    elseif jumpEventId == 56 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fPatrolGold, false)
        if isOpen then
            awardBattleBB.openUI(awardBattleBB.awardBattleType.abtGold)
        end
    --经验
    elseif jumpEventId == 57 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fPatrolExp, false)
        if isOpen then
            awardBattleBB.openUI(awardBattleBB.awardBattleType.abtExp)
        end
    --星空探秘 
    elseif jumpEventId == 71 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fPatrolStarrySky, false) and patrolBB.isOpenTime(patrolBB.patrolType.ptEscort)
        if isOpen then
            WindowStack.instance:openWindow(windowResId.escortPanel, nil, false)
        end
    --银河传记
    elseif jumpEventId == 72 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fPatrolMilkyWay, false)
        if isOpen then
            WindowStack.instance:openWindow(windowResId.godWarPanel, nil, false)
        end
    --星航竞技
    elseif jumpEventId == 73 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fMatchArena, false)
        if isOpen then
            WindowStack.instance:openWindow(windowResId.arenaPanel, nil, false)
        end
    --补给站
    elseif jumpEventId == 74 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fShopDepot, false)
        if isOpen then
            mallBB.currSelectPanel = mallBB.uiMallType.ustDepot
            WindowStack.instance:openWindow(windowResId.mallPanel, nil, false)
        end
    --舰长试炼
    elseif jumpEventId == 75 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fPatrolCaptainTried, false)
        if isOpen then
            WindowStack.instance:openWindow(windowResId.cruciataPanel, nil, false)
        end
    --体力
    elseif jumpEventId == 76 then 
        isNeedCheck = true
        isOpen = true
        CommonUITop.instance.prefabInstance:onBuyPower()
    --购买金币
    elseif jumpEventId == 77 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fShopGold, false)
        if isOpen then
            mallBB.currSelectPanel = mallBB.uiMallType.ustGold
            WindowStack.instance:openWindow(windowResId.mallPanel, nil, false)
        end
    -- 巡逻界面
    elseif jumpEventId == 78 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fPatrol, false)
        if isOpen then
            WindowStack.instance:openWindow(windowResId.patrolPanel, nil, false)
        end
    -- 军团科技
    elseif jumpEventId == 79 then 
        isNeedCheck = true 
        isOpen = playerInfoBB.playerInfo.gangId ~= 0
        if isOpen then
            gangBB.openGangUI(gangBB.uiGangType.ugtScience)
        end
    -- 军团任务
    elseif jumpEventId == 80 then 
        isNeedCheck = true 
        isOpen = playerInfoBB.playerInfo.gangId ~= 0
        if isOpen then
            gangBB.openGangUI(gangBB.uiGangType.ugtActivity, gangBB.uiActivityType.uatMission)
        end
    -- 军团列表
    elseif jumpEventId == 81 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fGang, false)
        if isOpen then
            WindowStack.instance:openWindow(windowResId.gangGangListPanel, nil, false)
        end
    -- 军团主界面
    elseif jumpEventId == 82 then 
        isNeedCheck = true 
        isOpen = playerInfoBB.playerInfo.gangId ~= 0
        if isOpen then
            gangBB.openGangUI(gangBB.uiGangType.ugtCore)
        end
    -- 舰长装备
    elseif jumpEventId == 83 then 
        strategosBB.currToggle = strategosBB.enumCaptainToggle.ectEquip
        WindowStack.instance:openWindow(windowResId.strategosPanel, nil, false)
    -- 公平竞技
    elseif jumpEventId == 84 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fMatchStarsailor, false)
        if isOpen then
            WindowStack.instance:openWindow(windowResId.fairPlayingPanel, nil, false)
        end
    -- 战队
    elseif jumpEventId == 85 then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            WindowStack.instance:openWindow(windowResId.battleLineupPanel, nil, false)
        end
    -- 星际探索
    elseif jumpEventId == 87 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fGalaxyExplore, false)
        if isOpen then
            WindowStack.instance:openWindow(windowResId.galaxyExplorePanel, nil, false)
        end  
    -- 潜能精炼
    elseif jumpEventId == 88 then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            NetClient.Send(20891001, {cardModelId = pars.where})  
        end  
    -- 钻石本
    elseif jumpEventId == 89 then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            awardBattleBB.openUI(awardBattleBB.awardBattleType.abtDiamond)
        end    
    -- 金币本
    elseif jumpEventId == 90 then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            awardBattleBB.openUI(awardBattleBB.awardBattleType.abtGold)
        end        
    --打开星际远征的关卡UI
    elseif jumpEventId == 1004 and pars.where ~= 0 then
        universeBB.curJumpInPlanetId = pars.where
        universeBB.curEnterUniverseRoute = universeBB.enumEnterUniverseRoute.eeurOnlyJumpDungeon
        applicationGlobal.sceneSwitchManager:enterScene(sceneSwitchRes.universeScene)
    --先祖遗迹
    elseif jumpEventId == 86 then
        applicationGlobal.sceneSwitchManager:enterScene(sceneSwitchRes.towerScene)
    --先祖遗迹商店
    elseif jumpEventId == 91 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fShopTower, false)
        if isOpen then
            shopBB.openShopUI(shopBB.uiShopType.ustTower)
        end    
    --购买会员
    elseif jumpEventId == 92 then 
        isNeedCheck = true 
        isOpen = true
        if isOpen then
            mallBB.currSelectPanel = mallBB.uiMallType.ustMember
            WindowStack.instance:openWindow(windowResId.mallPanel, nil, false)
        end
    --竞技商店
    elseif jumpEventId == 93 then 
        isNeedCheck = true 
        isOpen = functionOpend.getState(functionOpend.Functions.fShopArena, false)
        if isOpen then
            shopBB.openShopUI(shopBB.uiShopType.ustArena)
        end    
    end


    if isNotCallBack then
        basePanel:close()
    end

    if isOpen == false and isNeedCheck then
        applicationGlobal.tooltip:errorMessage(L("ex_sc_errorCode_tip_28"))
    end
end


--主界面
function jumpMain(pars)        
end


--主界面
function jumpCaptainAttribute(pars)        
end


--舰长装备
function jumpCaptainEquip(pars)        
end


--舰长故事
function jumpCaptainStory(pars)        
end


--列表-部队
function jumpGuardArmy(pars)        
end


--列表-战术武器
function jumpGuardWeapon(pars)        
end


--列表-组合推荐
function jumpGuardAssemble(pars)        
end


--护卫队属性
function jumpGuardAttribute(pars)        
end


--护卫队装备
function jumpGuardEquip(pars)        
end


--护卫队故事
function jumpGuardStory(pars)        
end


--军团列表
function jumpGangList(pars)        
end


--军团基本信息
function jumpGangInformation(pars)        
end


--成员列表
function jumpGangMember(pars)        
end


--军团日志
function jumpGangDaily(pars)        
end


--申请列表
function jumpGangApply(pars)        
end


--成员交易
function jumpGangBusiness(pars)        
end


--军团任务
function jumpGangMission(pars)        
end


--每日红包
function jumpGangRedPacket(pars)        
end


--发红包
function jumpGangProvidePacket(pars)        
end


--抢红包
function jumpGangGetPacket(pars)        
end


--军团科技
function jumpGangTechnology(pars)        
end


--军团BOSS
function jumpGangBoss(pars)        
end


--背包
function jumpBag(pars)        
end


--战队-部队
function jumpTeamArmy(pars)        
end


--战队-战术武器
function jumpTeamWeapon(pars)        
end


--日常任务
function jumpMissionDay(pars)        
end


--成就
function jumpMissionAchievement(pars)        
end


--军衔榜
function jumpRankMilitary(pars)        
end


--军团榜
function jumpRankGang(pars)        
end


--竞技榜
function jumpRankArena(pars)        
end


--连续签到
function jumpActivitySeriesSigned(pars)        
end


--天天签到
function jumpActivityDaySigned(pars)        
end


--升级奖励
function jumpActivityLevelUp(pars)        
end


--军衔奖励
function jumpActivityMilitary(pars)        
end


--VIP福利
function jumpActivityVip(pars)        
end


--成长基金
function jumpActivityGrowUp(pars)        
end


--首充
function jumpActivityFirstRecharge(pars)        
end


--充值
function jumpMallRecharge(pars)        
end


--补给站
function jumpMallSupply(pars)        
end


--金币商店
function jumpMallGold(pars)        
end


--银河商会
function jumpMallMilkyWay(pars)        
end


--军团商店
function jumpMallGang(pars)        
end


--功勋商店
function jumpMallExploit(pars)        
end


--竞技商店
function jumpMallArena(pars)        
end


--我的好友
function jumpFriendList(pars)        
end


--好友申请
function jumpFriendApply(pars)        
end


--好友赠送
function jumpFriendPresent(pars)        
end


--好友推荐
function jumpFriendRecommend(pars)        
end


--邮箱
function jumpPostBox(pars)        
end


--赛事主界面
function jumpMatchMain(pars)        
end


--星航竞技
function jumpMatchArena(pars)        
end


--公平竞技
function jumpMatchFairPlay(pars)        
end


--巡逻主界面
function jumpPatrolMain(pars)        
end


--舰长试炼
function jumpPatrolCaptain(pars)        
end


--银河传记
function jumpPatrolMilkyWay(pars)        
end


--星空探秘
function jumpPatrolStar(pars)        
end


--矿星剿匪
function jumpPatrolDiamondOre(pars)        
end


--狙击异兽
function jumpPatrolGoldOre(pars)        
end


--经验本
function jumpPatrolExpOre(pars)        
end


--星系界面
function jumpWarGalaxy(pars)        
end


--星球列表界面
function jumpWarStar(pars)        
end


--星球详情
function jumpWarInformation(pars)        
end


--联赛主界面
function jumpEventMain(pars)        
end


--联赛图鉴
function jumpEventBook(pars)        
end


--赛季
function jumpEventSeason(pars)        
end


--数据统计
function jumpEventData(pars)        
end


--历史战绩
function jumpEventHistory(pars)        
end


--奖励
function jumpEventReward(pars)        
end


--个人设置
function jumpSetIndividual(pars)        
end


--语言设置
function jumpSetLanguage(pars)        
end


--游戏公告
function jumpSetAnnouncement(pars)        
end


--VIP主界面
function jumpVipMain(pars)        
end


--我的星球主界面
function jumpMyStarMain(pars)        
end