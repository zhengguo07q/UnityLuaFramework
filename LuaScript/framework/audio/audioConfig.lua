-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : audioConfig.lua
--  Creator     : zg
--  Date        : 2016-12-16
--  Comment     : 
-- ***************************************************************


module("audioConfig", package.seeall)

-- 背景音乐
Audio_Normal_Background_music_1   = "20001"                     -- 背景音效（平时1）
-- Audio_Normal_Background_music_2   = "20002"                     --背景音效（平时2）
Audio_Battle_Background_music_1   = "20003"                     -- 背景音效（战斗1）
-- Audio_Battle_Background_music_2   = "20004"                     -- 背景音效（战斗2）
-- Audio_Battle_Background_music_3   = "20005"                     -- 背景音效（战斗3）
-- Audio_Battle_Background_music_4   = "20006"                     -- 背景音效（战斗4）
Audio_Normal_Background_music_5   = "20007"                     -- 星际远征1
Audio_Normal_Background_music_6   = "20008"                     -- 银河联赛
Audio_Normal_Background_music_7   = "20009"                     -- 星际远征2
Audio_Normal_Background_music_8   = "20010"                     -- 军团背景
Audio_Normal_Background_music_9   = "20011"                     -- 联赛匹配界面1
Audio_Normal_Background_music_10  = "20012"                     -- 联赛匹配界面2
-- end

-- 系统音效
Audio_Click_Tips                  = "10001"                     --通用点击音效：通用按钮点击触发/战斗时操作兵种单位触发
Audio_Return_Tips                 = "10002"                     --通用返回音效：通用返回按钮点击触发
Audio_Warn_Tips                   = "10003"                     --无效点击：点击按钮无效并反馈相应飘字触发
Audio_PopUp_Tips                  = "10004"                     --提示点击：点弹出确认弹窗触发  
Audio_Interface_Tips              = "10005"                     --打开2级界面：2级界面打开时触发/军械合成界面弹出触发 
Audio_CloseInterface_Tips         = "10006"                     --关闭2级界面：2级界面关闭时触发
Audio_LeftLabel_Switching         = "10007"                     -- 左侧标签切换:左侧标签按钮点击触发
Audio_TopLabel_Switching          = "10008"                     -- 顶部标签切换:顶部标签按钮点击触发
Audio_Roll_Switching              = "10009"                     -- 滚动入位:卡牌列表，任务列表，钻石副本列表滚动入位时触发
Audio_Reward_Switching            = "10010"                     -- 领取:任务&成就奖励领取按钮触发
Audio_CancelCard_Switching        = "10011"                     -- 撤回卡牌:编队界面中，点击撤回出战卡牌触发
Audio_IntoCard_Switching          = "10012"                     -- 上阵卡牌:编队界面中，点击添加出战卡牌触发
Audio_ComposeEquip_Switching      = "10013"                     -- 合成军械:点击军械合成按钮触发
Audio_ApparelEquip_Switching      = "10014"                     -- 装备军械:点击军械装备按钮触发
Audio_ClickCard_Switching         = "10015"                     -- 点击手牌:战斗中点击手牌触发
Audio_DevelopTalk_Switching       = "10016"                     -- 展开聊天栏:聊天栏展开时触发
Audio_CloseTalk_Switching         = "10017"                     -- 收起聊天栏:聊天栏收起时触发
Audio_IntoGalaxy_Switching        = "10018"                     -- 进入星系:点击有效星系图标（星系已解锁）并进入时触发
Audio_IntoCelestialBody_Switching = "10019"                     -- 进入星球:点击有效星球图标（星球已解锁）并进入时触发
Audio_Panel_CommonTreasure        = "10027"                     -- 通用开启宝箱动画 
-- end

-- 舰长音效
Audio_Captain_Skill_LevelUp       = "10021"                     -- 舰长技能升级时触发
Audio_Captain_Exp_Add             = "10022"                     -- 舰长吃经验书时触发
Audio_Captain_LevelUp             = "10023"                     -- 舰长升级时触发
Audio_Captain_StarUp              = "10024"                     -- 舰长升星时触发
--end

-- 战斗结算
Audio_BattleResult_Win            = "10025"                     -- 战斗胜利结算界面触发
Audio_BattleResult_Fail           = "10026"                     -- 战斗失败结算界面触发
--end

Audio_AwardCard_Get 			  = "10029"      				-- 卡牌获得背景音效 


-- 战斗相关音效
Audio_No_Energy                   = "810007"                    -- 能量不足
Audio_Converge                    = "810008"                    -- 集火


Audio_Qualifying_AddStar          = "10030"                     --联赛结算升星音效
Audio_Qualifying_ReduceStar       = "10031"                     --联赛结算降星音效
Audio_Qualifying_Promote          = "10023"                     --联赛结算军衔晋升音效
Audio_Qualifying_Result           = "10033"                     --联赛结算（弹出胜负）音效