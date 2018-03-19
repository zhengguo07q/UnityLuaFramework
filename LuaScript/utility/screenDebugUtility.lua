-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: screenDebugUtility.lua
--  Creator 	: zg
--  Date		: 2016-12-27
--  Comment		: 
-- ***************************************************************


module("screenDebugUtility", package.seeall)


isShow        = true
baseHeight    = 30
height        = 30
fps           = 0
lasUpdateTime = Time.realtimeSinceStartup
updateFPSTime = 0.1
frameUpdate   = 0

accountId       = PlayerPrefs.GetString("auth_key")
accountIdCache  = PlayerPrefs.GetString("auth_key")
enterSwitch     = PlayerPrefs.GetString("enterSwitch", "2") == "1" and true or false
flagSwitch      = PlayerPrefs.GetString("flagSwitch", "2") == "1"  and true or false

local switchStr       = enterSwitch == true and "开" or "关"
local flagSwitchStr   = flagSwitch  == true and "开" or "关"

local rec1 = Rect(Screen.width-120, 0, 120, 40)
local rec2 = Rect(Screen.width - 120, baseHeight + height * 0, 120, height)
local rec3 = Rect(Screen.width - 120, baseHeight + height * 1, 120, height)
local rec4 = Rect(Screen.width - 120 - 100, baseHeight + height * 1, 100, height)
local rec5 = Rect(Screen.width - 120, baseHeight + height * 2, 120, height)
local rec6 = Rect(Screen.width - 120, baseHeight + height * 3, 120, height)
local rec7 = Rect(Screen.width - 120, baseHeight + height * 4, 120, height)
local rec8 = Rect(Screen.width - 120, baseHeight + height * 5, 120, height)
local rec9 = Rect(Screen.width - 120, baseHeight + height * 6, 120, height)
local rec10 = Rect(Screen.width - 120, baseHeight + height * 7, 120, height)
local rec11 = Rect(Screen.width - 120, baseHeight + height * 8, 120, height)
local rec12 = Rect(Screen.width - 120, baseHeight + height * 9, 120, height)
local rec13 = Rect(Screen.width - 120, baseHeight + height * 10, 120, height)
local rec14 = Rect(Screen.width - 120, baseHeight + height * 11, 120, height)
local rec15 = Rect(Screen.width / 2, 0, 100, 100)
local rec16 = Rect(Screen.width - 120, baseHeight + height * 12, 120, height)
local rec17 = Rect(Screen.width - 120, baseHeight + height * 13, 120, height)
local rec18 = Rect(Screen.width - 120, baseHeight + height * 14, 120, height)
local rec19 = Rect(Screen.width - 120, baseHeight + height * 15, 120, height)
local rec20 = Rect(Screen.width - 120, baseHeight + height * 16, 120, height)
local rec21 = Rect(Screen.width - 120, baseHeight + height * 17, 120, height)
local rec22 = Rect(Screen.width - 120, baseHeight + height * 18, 120, height)

function onGui()
    
    if applicationConfig.macro.UNITY_EDITOR and applicationConfig.gameConfig.isDebug then
        isShow = GUI.Toggle(rec1, isShow, "DebugUtility")
        if isShow == true then
            showToolbar()
        end
    end
end


function showToolbar()
    if GUI.Button(rec2, "SwitchAccount") then
        switchAccount()
    end

    if GUI.Button(rec3, "ShutdownSocket") then
        shutdownSocket()
    end

    accountId = GUI.TextField(rec4, accountId, 64)
    if accountId ~= accountIdCache then
        PlayerPrefs.SetString("auth_key", accountId)
        accountIdCache = accountId
    end

    if GUI.Button(rec5, "EnterMission") then
        enterMission()
    end

    if GUI.Button(rec6, "SkipMission") then
    	skipMission()
    end

    if GUI.Button(rec7, "血条显示 : " .. flagSwitchStr) then
        flagSwitch    = not flagSwitch
        local switch  = flagSwitch == true and "1" or "2"
        PlayerPrefs.SetString("flagSwitch", switch)
        flagSwitchStr = flagSwitch == true and "开" or "关"
    end

    if GUI.Button(rec8, "SwitchLogger") then
        switchLogger()
    end

    if GUI.Button(rec9, "入场开关 : " .. switchStr) then
        enterSwitch = not enterSwitch
        local switch = enterSwitch == true and "1" or "2"
        PlayerPrefs.SetString("enterSwitch", switch)
        switchStr       = enterSwitch == true and "开" or "关"
    end


    if GUI.Button(rec10, "Skill") then
    end

    if GUI.Button(rec11, "oneStepPlay") then
        oneStepPlay()
    end

    if GUI.Button(rec12, "quiteVideo") then
        quiteVideo()
    end

    if GUI.Button(rec13, "fastSpeed") then
        fastSpeed()
    end

    if GUI.Button(rec14, "openLevelUpPanel") then
        openLevelUpPanel()
    end

    GUI.Label(rec15, "FPS: " .. math.ceil(fps)) 

    if GUI.Button(rec16, "testTreasure") then
        testTreasure()
    end

    if GUI.Button(rec17, "testCommonAward") then
        testCommonAward()
    end

    if GUI.Button(rec18, "testJson") then
        -- downloadVideo(86)
        -- guideBB.openMainPanel()
        testJson()
    end

    if GUI.Button(rec19, "我的星球入口") then
     --   applicationGlobal.sceneSwitchManager:enterScene(sceneSwitchRes.ownPlanetScene)
        WindowStack.instance:openWindow(windowResId.galaxyExplorePanel, nil, false)
    end

    if GUI.Button(rec20, "关闭引导") then
        guideBB.closeGuide()
    end
    
    if GUI.Button(rec21, "PrintBattleClassRef") then
       --测试
       --需要先打开联赛UI
       battleCC.printBattleClassRef()
        -- protoData[20041066] =
        -- {
        --     ["star"] = 0,
        --     ["battleId"] = 5,
        --     ["status"] = 0,
        --     ["datas"] = 
        --     {
        --         [1] = 
        --         {
        --             ["key"] = "DAMAGE_COUNT",
        --             ["value"] = "{300001:5092,300008:4776}",
        --         },
        --         [2] = 
        --         {
        --             ["key"] = "DURATION",
        --             ["value"] = "30169",
        --         },
        --     },
        --     ["winType"] = 0,
        --     ["winResult"] = 1,
        --     ["rewardList"] = {
        --     },
        --     ["source"] = 0,
        --     ["dunModelId"] = 0,
        --     ["battleType"] = 10001,
        --     ["score"] = 10,

        -- }

        -- protoData[20061024] = 
        -- {
        --     ["totalScore"] = 2300,
        --     ["winsScore"] = 3,
        --     ["isScoreLimit"] = 0,
        --     ["status"] = 0,
        --     ["addScore"] = 0,
        --     ["shutDownScore"] = 0,
        --     ["baseScore"] = 7,
        --     ["maxScore"] = 50,
        --     ["shutDownWins"] = 0,
        --     ["wins"] = 6,
        -- }
        -- battleBB.fightType = battleBB.enumBattleType.ebtConquest
        -- battleBB.initBattleResultByBattleType()
        -- local currScene = applicationGlobal.sceneSwitchManager.currentSceneInstance
        -- if currScene ~= nil and isSuper(currScene, BattleInstance) and currScene.resultPanel ~= nil then
        --     currScene.resultPanel:battleEnd(1)   --0平手  1胜利   2失败
        -- end
    end
end


function update()
    if isShow == true then
        frameUpdate = frameUpdate + 1
        if Time.realtimeSinceStartup - lasUpdateTime >= updateFPSTime then
            fps = frameUpdate / (Time.realtimeSinceStartup - lasUpdateTime)
            frameUpdate = 0
            lasUpdateTime = Time.realtimeSinceStartup
        end
    end
end


function getCard()
	battleLineupBB.getUseableCardGroup()
end


function switchAccount()
	if NetClient.GetInstance() ~= nil then
		NetClient.GetInstance():ShutDownSocketTest()
	end
	
	protoData = {}
	applicationGlobal.sceneSwitchManager:enterScene(sceneSwitchRes.loginSwitchScene)
    -- platformRequest.iflyLoginOut()
end


function login()
 	-- body
    
end


function shutdownSocket()
 	-- body
    if NetClient.GetInstance() ~= nil then
		NetClient.GetInstance():ShutDownSocketTest()
	end
end


function enterMission()
    print("1---------------------------------------------")

--    NetClient.Send(30361005, {cityDungeon = 1})
end


--跳过战斗
function skipMission()
    NetClient.Send(20041056, {})
end


function switchLogger()
 	-- body
end


function pause()
 	-- body
end


--开启/停止录像
function quiteVideo()
    videoBB.quitVideo()
end


--播放录像
function oneStepPlay()
    -- videoBB.playVideoByIndex(0)
    videoBB.oneStepPlay()
end


--播放录像
function fastSpeed()
    videoBB.fastSpeed()
end


-- 上传录像
function openLevelUpPanel()
    -- videoBB.uploadVideoByIndex(0)
    actionPriority.addPriority(actionPriority.enumPriorityType.eptRoleLevelup, function()
        applicationGlobal.playerUILevelUpPanel:updatePanel()
        -- actionPriority.busy = false
    end)
end


-- 测试宝箱开启
function testTreasure()
    local awardList = {   
            [1]={id=900102,count=500,type=2},
            [2]={id=900106,count=5,type=4},
            [3]={id=900108,count=20,type=8},
            [4]={id=300001,count=1,type=5},
            [5]={id=300001,count=1,type=5},
            [6]={id=300001,count=1,type=5},
            -- [5]={id=251001,count=2,type=1},
            -- [6]={id=301100,count=1,type=1},
            -- [7]={id=301100,count=1,type=1},
            -- [8]={id=301100,count=1,type=1},
            -- [9]={id=301100,count=1,type=1},
            -- [10]={id=301100,count=1,type=1},
            -- [11]={id=301100,count=1,type=1},
            -- [12]={id=301100,count=1,type=1},
            -- [13]={id=300102,count=1,type=5}
            }
    commonTreasureBB.setOpenData(awardList, 0, L("openbox_tishi3"))
    WindowStack.instance:openWindow(windowResId.commonTreasurePanel, nil, false)
end


-- 测试通用奖励
function testCommonAward()
    local awardList = {
        [1]={id=900102,count=500,type=2},
        [2]={id=900106,count=5,type=4},
        [3]={id=900108,count=20,type=8},
        [4]={id=300207,count=1,type=5,cardStar=2},
        -- [5]={id=300002,count=1,type=5},
        -- [6]={id=301100,count=1,type=1},
        -- [7]={id=300002,count=1,type=5},
    }

    -- local awardList = {
    --     [1]={id=900101,count=5,type=3}
    -- }
    local temp = {}
    temp.rewardList = awardList 
    outputBB.setOutputTotalData(temp)
    CommonAwardPopupWindow.instance:showAward()
end


--测试下载播放
function downloadVideo(id)
    videoBB.downloadVideoSuccessHandle = function(id)
       videoBB.playVideoById(id)
    end
    videoBB.downloadVideo(122)
end


function testJson()
    local str =  "{'conds':['1_13004_1','1_13005_1','1_11004_1','1_11005_1','1_12004_1','1_12005_1'],'count':4}"
    -- str = string.gsub(str, "\'", "\"")
    print("----",mstr)
    local tab, pos, err = json.decode(str)
    if err then
      print ("Error:", err)
    else
      print("tab", tab.count)
      for i = 1,#tab.conds do
        print (i, tab.conds[i])
      end
    end 
end