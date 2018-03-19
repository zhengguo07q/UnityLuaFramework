-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: autoLoad.lua
--  Creator 	: zg
--  Date		: 2016-11-10
--  Comment		: 全局的载入
-- ***************************************************************


module("windowResId", package.seeall)


noticePanel	 				= WindowUtility.instance:windowRes("UI/Notice/NoticePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
selectServerPanel 			= WindowUtility.instance:windowRes("UI/Login/SelectServerPanel", 0, UIEffectType.uetOpen, UIEffectType.uetCloseNull)
playerInfoPanel				= WindowUtility.instance:windowRes("UI/PlayerInfo/PlayerInfoPanel", 0, UIEffectType.uetOpen, UIEffectType.uetCloseNull)
playerHeadPanel				= WindowUtility.instance:windowRes("UI/PlayerInfo/PlayerHeadPanel", 0, UIEffectType.uetOpen, UIEffectType.uetCloseNull)
playerEditorNamePanel		= WindowUtility.instance:windowRes("UI/PlayerInfo/PlayerEditorNamePanel", 0, UIEffectType.uetOpen, UIEffectType.uetCloseNull)
playerCdkeyPanel			= WindowUtility.instance:windowRes("UI/PlayerInfo/PlayerCdkeyPanel", 0, UIEffectType.uetOpen, UIEffectType.uetCloseNull)

vipPanel					= WindowUtility.instance:windowRes("UI/Vip/VipPanel",19,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
dailyMissionPanel           = WindowUtility.instance:windowRes("UI/DailyMission/DailyMissionPanel",35,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
emailPanel                  = WindowUtility.instance:windowRes("UI/Email/EmailPanel",16,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
emailContentPanel           = WindowUtility.instance:windowRes("UI/Email/EmailContentPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
monthCardPanel              = WindowUtility.instance:windowRes("UI/MonthCard/MonthCardPanel",0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
monthInfo					= WindowUtility.instance:windowRes("UI/MonthCard/MonthInfo",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

gangGangListPanel           = WindowUtility.instance:windowRes("UI/Gang/GangGangListPanel",42,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
gangCreatGangPanel			= WindowUtility.instance:windowRes("UI/Gang/GangCreatGangPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
gangSearchGangPanel			= WindowUtility.instance:windowRes("UI/Gang/GangSearchGangPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
gangCreatFlagPanel			= WindowUtility.instance:windowRes("UI/Gang/GangCreatFlagPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
gangsciencePanel            = WindowUtility.instance:windowRes("UI/Gang/GangSciencePanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
gangScienceInfoPanel        = WindowUtility.instance:windowRes("UI/Gang/GangScienceInfoPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur) 
gangScienceLevelUpPanel     = WindowUtility.instance:windowRes("UI/Gang/GangScienceLevelUpPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur) 
gangBossPanel     			= WindowUtility.instance:windowRes("UI/Gang/GangBossPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull) 
gangBossRankPanel     		= WindowUtility.instance:windowRes("UI/Gang/GangBossRankPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur) 
gangHelpPanel   		    = WindowUtility.instance:windowRes("UI/Gang/GangHelpPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur) 

gangPanel 					= WindowUtility.instance:windowRes("UI/Gang/GangPanel", 43, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
gangModifyNamePanel			= WindowUtility.instance:windowRes("UI/Gang/GangModifyNamePanel", 43, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
gangAddConditionPanel		= WindowUtility.instance:windowRes("UI/Gang/GangAddConditionPanel", 43, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
gangModifyNoticePanel		= WindowUtility.instance:windowRes("UI/Gang/GangModifyNoticePanel", 43, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
gangApplicationListPanel	= WindowUtility.instance:windowRes("UI/Gang/GangApplicationListPanel", 43, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
gangRedLogPanel				= WindowUtility.instance:windowRes("UI/Gang/GangRedLogPanel", 43, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
gangGiveRedPanel			= WindowUtility.instance:windowRes("UI/Gang/GangGiveRedPanel", 43, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
gangTransExchange			= WindowUtility.instance:windowRes("UI/Gang/GangTransExchangePanel", 43, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
gangDayAwardPanel			= WindowUtility.instance:windowRes("UI/Gang/GangDayAwardPanel", 43, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
gangDetailsPanel			= WindowUtility.instance:windowRes("UI/Gang/GangDetailsPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

boxTreasureLookPanel		= WindowUtility.instance:windowRes("UI/BoxTreasureLook/BoxTreasureLookPanel", 43, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

achievementPanel            = WindowUtility.instance:windowRes("UI/Achievement/AchievementPanel",30,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

storePanel                  = WindowUtility.instance:windowRes("UI/Store/StorePanel",50,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
storeBuyItemPanel           = WindowUtility.instance:windowRes("UI/Store/StoreBuyItemPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

chatSelectPanel             = WindowUtility.instance:windowRes("UI/Chat/ChatSelectPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

rankPanel                   = WindowUtility.instance:windowRes("UI/Rank/RankPanel",9,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
rankSelectPanel             = WindowUtility.instance:windowRes("UI/Rank/RankSelectPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
rankHelpPanel               = WindowUtility.instance:windowRes("UI/Rank/RankHelpPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

scenePlotPanel              = WindowUtility.instance:windowRes("UI/Dialogue/ScenePlotPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

bagPanel                    = WindowUtility.instance:windowRes("UI/Bag/BagPanel",12,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
bagHandlerPanel             = WindowUtility.instance:windowRes("UI/Bag/BagHandlerPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

fogOfWarPanel               = WindowUtility.instance:windowRes("UI/BigMap/FogOfWarPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
relicTipPanel               = WindowUtility.instance:windowRes("UI/BigMap/Relic/RelicTipPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

patrolPanel           		= WindowUtility.instance:windowRes("UI/Patrol/PatrolPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

colosseumPanel				= WindowUtility.instance:windowRes("UI/Colosseum/ColosseumPanel",57,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

escortPanel					= WindowUtility.instance:windowRes("UI/Escort/EscortPanel",58,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

cardPanel                   = WindowUtility.instance:windowRes("UI/Card/CardPanel",32,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cardGetWayPanel             = WindowUtility.instance:windowRes("UI/Card/CardGetWayPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
cardGroupTipsPanel          = WindowUtility.instance:windowRes("UI/Card/CardGroupTipsPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
cardPropertyPanel           = WindowUtility.instance:windowRes("UI/Card/CardPropertyPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cardSuccessAdvancePanel     = WindowUtility.instance:windowRes("UI/Card/CardSuccessAdvancePanel",0,UIEffectType.uetOpenEffectScale,UIEffectType.uetCloseNull ,UIEffectType.uetGuassianBlur)
cardMagicPanel              = WindowUtility.instance:windowRes("UI/Card/CardMagicPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
cardConvertPanel            = WindowUtility.instance:windowRes("UI/Card/CardConvertPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cardInfoPanel               = WindowUtility.instance:windowRes("UI/Card/CardInfoPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)            
cardSophisticationPanel     = WindowUtility.instance:windowRes("UI/Card/CardSophisticationPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cardSophisticationSuccessPanel = WindowUtility.instance:windowRes("UI/Card/CardSophisticationSuccessPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull,UIEffectType.uetGuassianBlur)
cardEquipAndGetEquipNewPanel= WindowUtility.instance:windowRes("UI/Card/CardEquipAndGetEquipNewPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull ,UIEffectType.uetGuassianBlur)

houseStorePanel             = WindowUtility.instance:windowRes("UI/House/HouseStorePanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
housePlantDetail            = WindowUtility.instance:windowRes("UI/House/HousePlantDetail",62,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

bigSailPanel                = WindowUtility.instance:windowRes("UI/BigSail/BigSailPanel",51,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
commonSweepPanel            = WindowUtility.instance:windowRes("UI/CitySweep/CommonSweepPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
bigSailCityPanel            = WindowUtility.instance:windowRes("UI/BigSail/BigSailCityPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

strategosPanel              = WindowUtility.instance:windowRes("UI/Strategos/StrategosPanel", 15,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
strategosExpUpPanel         = WindowUtility.instance:windowRes("UI/Strategos/StrategosExpUpPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
strategosEquipListPanel     = WindowUtility.instance:windowRes("UI/Strategos/StrategosEquipListPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
strategosStrengthenPanel    = WindowUtility.instance:windowRes("UI/Strategos/StrategosStrengthenPanel",0,UIEffectType.uetOpenEffectScale,UIEffectType.uetCloseNull,UIEffectType.uetGuassianBlur)
strategosEquipSuitPanel     = WindowUtility.instance:windowRes("UI/Strategos/StrategosEquipSuitPanel",0,UIEffectType.uetOpenEffectScale,UIEffectType.uetCloseNull,UIEffectType.uetGuassianBlur)
strategosUpStarPanel        = WindowUtility.instance:windowRes("UI/Strategos/StrategosUpStarPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull,UIEffectType.uetGuassianBlur)
strategosEquipOutputPanel   = WindowUtility.instance:windowRes("UI/Strategos/StrategosEquipOutPutPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

cruciataPanel               = WindowUtility.instance:windowRes("UI/Cruciata/CruciataPanel", 2,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

cruciataShadowPanel         = WindowUtility.instance:windowRes("UI/CruciataShadow/CruciataShadowPanel",65,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cruciataShadowAddPanel      = WindowUtility.instance:windowRes("UI/CruciataShadow/CruciataShadowAddPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cruciataShadowBoxPanel      = WindowUtility.instance:windowRes("UI/CruciataShadow/CruciataShadowBoxPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cruciataShadowTipsPanel     = WindowUtility.instance:windowRes("UI/CruciataShadow/CruciataShadowTipsPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cruciataShadowOpenBoxPanel  = WindowUtility.instance:windowRes("UI/CruciataShadow/CruciataShadowOpenBoxPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

battleLineupPanel           = WindowUtility.instance:windowRes("UI/BattleLineup/BattleLineupPanel",8,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
battleLineupstrategosPanel  = WindowUtility.instance:windowRes("UI/BattleLineup/BattleLineupstrategosPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
battleLineupSelectGeneralPanel= WindowUtility.instance:windowRes("UI/BattleLineup/BattleLineupSelectGeneralPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
battleLineupEditPanel       = WindowUtility.instance:windowRes("UI/BattleLineup/BattleLineupEditPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

fairBattleLineupPlayingPanel= WindowUtility.instance:windowRes("UI/BattleLineup/BattleLineupPanel", 8, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cardBagPanel                = WindowUtility.instance:windowRes("UI/CardBag/CardBagPanel", 34, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
depotExchangePanel          = WindowUtility.instance:windowRes("UI/Depot/DepotExchangePanel", 0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
cardBagPreviewPanel         = WindowUtility.instance:windowRes("UI/CardBag/CardBagPreviewPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
depotHandbookPanel          = WindowUtility.instance:windowRes("UI/Depot/DepotHandbookPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
commonCardBoxPanel          = WindowUtility.instance:windowRes("UI/Common/CommonCardBoxPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
depotShowPanel              = WindowUtility.instance:windowRes("UI/Depot/DepotShowPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

friendPanel                 = WindowUtility.instance:windowRes("UI/Friend/FriendPanel", 6, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
friendsGivePowerPanel       = WindowUtility.instance:windowRes("UI/Friend/FriendsGivePowerPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

firstRechargePanel          = WindowUtility.instance:windowRes("UI/FirstRecharge/FirstRechargePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)


outputGotoPanel             = WindowUtility.instance:windowRes("UI/OutputGoto/OutputGotoPanel", 0, UIEffectType.uetOpen, UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

pyramidMapPanel             = WindowUtility.instance:windowRes("UI/Pyramid/PyramidMapPanel", 56, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
pyramidRewardPanel          = WindowUtility.instance:windowRes("UI/Pyramid/PyramidRewardPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

cityFightPanel              = WindowUtility.instance:windowRes("UI/CitySystem/CityFightPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityDiscoveryPanel          = WindowUtility.instance:windowRes("UI/CityDiscovery/CityDiscoveryPanel", 46, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
cityDiscoveryEffectPanel    = WindowUtility.instance:windowRes("UI/CityDiscovery/CityDiscoveryEffectPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityDiscoveryAwardPanel     = WindowUtility.instance:windowRes("UI/CityDiscovery/CityDiscoveryAwardPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityDiscoveryResultPanel    = WindowUtility.instance:windowRes("UI/CityDiscovery/CityDiscoveryResultPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityDiscoveryTotalAwardPanel= WindowUtility.instance:windowRes("UI/CityDiscovery/CityDiscoveryTotalAwardPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityWarSiegePanel           = WindowUtility.instance:windowRes("UI/CityWar/CityWarSiegePanel", 48, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityWarSalaryRemindPanel    = WindowUtility.instance:windowRes("UI/CityWar/CityWarSalaryRemindPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityWarCastellanPanel       = WindowUtility.instance:windowRes("UI/CityWar/CityWarCastellanPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityWarCastellanListPanel   = WindowUtility.instance:windowRes("UI/CityWar/CityWarCastellanListPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityWarRedPacketPanel       = WindowUtility.instance:windowRes("UI/CityWar/CityWarRedPacketPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityWarBannerColorPanel     = WindowUtility.instance:windowRes("UI/CityWar/CityWarBannerColorPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityWarDiamondPanel         = WindowUtility.instance:windowRes("UI/CityWar/CityWarDiamondPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityWarSalaryPanel          = WindowUtility.instance:windowRes("UI/CityWar/CityWarSalaryPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityWarResultPanel          = WindowUtility.instance:windowRes("UI/CityWar/CityWarResultPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
cityInnerPanel              = WindowUtility.instance:windowRes("UI/CityInner/CityInnerPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

vipShopPanel 				= WindowUtility.instance:windowRes("UI/VipShop/VipShopPanel", 61, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

goldenTouchPanel 			= WindowUtility.instance:windowRes("UI/GoldenTouch/GoldenTouchPanel", 36, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

missionDialogueGeneralPanel = WindowUtility.instance:windowRes("UI/Dialogue/GeneralDialoguePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
missionDialogueNamePanel    = WindowUtility.instance:windowRes("UI/Dialogue/NameDialoguePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

shopPanel                   = WindowUtility.instance:windowRes("UI/Shop/ShopPanel", 11, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

mallPanel                   = WindowUtility.instance:windowRes("UI/Shop/MallPanel", 11, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
--银河联赛
qualifyingPanel 			= WindowUtility.instance:windowRes("UI/Conquest/ConquestPanel", 3, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
qualifyingTipPanel 			= WindowUtility.instance:windowRes("UI/Conquest/ConquestTipPanel", 0, UIEffectType.uetOpenEffectScale,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
qualifyingCardsPanel		= WindowUtility.instance:windowRes("UI/Conquest/ConquestCardsPanel", 0, UIEffectType.uetOpenEffectScale,UIEffectType.uetCloseNull,UIEffectType.uetGuassianBlur)
qualifyingTreasureTipPanel  = WindowUtility.instance:windowRes("UI/Conquest/ConquestTreasureTipsPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
-- qualifyingOpenTreasurePanel = WindowUtility.instance:windowRes("UI/Conquest/ConquestOpenTreasurePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
qualifyingSeasonPanel 		= WindowUtility.instance:windowRes("UI/Conquest/ConquestSeasonPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
qualifyingSeasonAwardPanel 	= WindowUtility.instance:windowRes("UI/Conquest/ConquestSeasonAwardPanel", 0, UIEffectType.uetOpenEffectScale,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
qualifyingSeasonHistoryPanel= WindowUtility.instance:windowRes("UI/Conquest/ConquestSeasonHistoryPanel", 0, UIEffectType.uetOpenEffectScale,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
-- qualifyingSeasonAwardTipPanel  = WindowUtility.instance:windowRes("UI/Conquest/ConquestSeasonAwardTipsPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
qualifyingSeasonStatisticsPanel = WindowUtility.instance:windowRes("UI/Conquest/ConquestSeasonStatisticsPanel", 0, UIEffectType.uetOpenEffectScale,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
qualifyingVideoPanel        = WindowUtility.instance:windowRes("UI/Conquest/ConquestVideoPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
qualifyingSeasonRankPanel   = WindowUtility.instance:windowRes("UI/Conquest/ConquestSeasonRankPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

areaTreasurePanel           = WindowUtility.instance:windowRes("UI/AreaTreasure/AreaTreasurePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

noLevelTipPanel             = WindowUtility.instance:windowRes("UI/BigMap/NoLevelTipPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
noPowerTipPanel             = WindowUtility.instance:windowRes("UI/BigMap/NoPowerTipPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
stoneMatrixPanel            = WindowUtility.instance:windowRes("UI/StoneMatrix/StoneMatrixPanel", 63, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
stoneMatrixTujingPanel      = WindowUtility.instance:windowRes("UI/StoneMatrix/StoneMatrixTujingPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
scoopDiamondPanel 			= WindowUtility.instance:windowRes("UI/ScoopDiamond/ScoopDiamondPanel", 55, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
roleDetailsPanel            = WindowUtility.instance:windowRes("UI/RoleDetails/RoleDetailsPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

sceneEnterBigSailPanel      = WindowUtility.instance:windowRes("UI/BigMap/SceneEnterBigSailPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

-- gangWarSignUpPanel          = WindowUtility.instance:windowRes("UI/Gang/GangWar/GangWarSignUpPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
-- gangWarScorePanel           = WindowUtility.instance:windowRes("UI/Gang/GangWar/GangWarScorePanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
-- gangWarInfoPanel            = WindowUtility.instance:windowRes("UI/Gang/GangWar/GangWarInfoPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
-- gangWarPointPanel           = WindowUtility.instance:windowRes("UI/Gang/GangWar/GangWarPointPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
-- gangWarPanel                = WindowUtility.instance:windowRes("UI/Gang/GangWar/GangWarPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
activityPanel               = WindowUtility.instance:windowRes("UI/Activity/ActivityPanel",14,UIEffectType.uetOpen,UIEffectType.uetCloseNull)

arenaPanel                  = WindowUtility.instance:windowRes("UI/Arena/ArenaPanel",14,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
arenaManifestoPanel         = WindowUtility.instance:windowRes("UI/Arena/ArenaManifestoPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
arenaWarPanel               = WindowUtility.instance:windowRes("UI/Arena/ArenaWarPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
arenaAwardPanel             = WindowUtility.instance:windowRes("UI/Arena/ArenaAwardPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
arenaThronePanel            = WindowUtility.instance:windowRes("UI/Arena/ArenaThronePanel",15,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
arenaRankPanel              = WindowUtility.instance:windowRes("UI/Arena/ArenaRankPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

robotDetailsPanel           = WindowUtility.instance:windowRes("UI/Robot/RobotDetailsPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

rechargeGiftPanel           = WindowUtility.instance:windowRes("UI/RechargeGift/RechargeGiftPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

guideDialoguePanel          = WindowUtility.instance:windowRes("UI/Battle/GuideDialoguePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
chatPanel                   = WindowUtility.instance:windowRes("UI/Chat/ChatPanel", 5, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

createRolePanel 			= WindowUtility.instance:windowRes("UI/CreateRole/CreateRolePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

patrolPanel					= WindowUtility.instance:windowRes("UI/Patrol/PatrolPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

universeUIPanel			    = WindowUtility.instance:windowRes("UI/Universe/UniverseUIPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

awardBattlePanel			= WindowUtility.instance:windowRes("UI/AwardBattle/AwardBattlePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
missionPanel				= WindowUtility.instance:windowRes("UI/Mission/MissionPanel", 1, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

civilBuyPanel				= WindowUtility.instance:windowRes("UI/CivilBuy/CivilBuyPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)


lookVideoPanel				= WindowUtility.instance:windowRes("UI/LookVideo/LookVideoPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
commonTreasurePanel         = WindowUtility.instance:windowRes("UI/Common/CommonTreasurePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
commonSweepPanel            = WindowUtility.instance:windowRes("UI/CommonSweep/commonSweepPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
sweepResultPanel            = WindowUtility.instance:windowRes("UI/CommonSweep/SweepResultPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
sweepAwardPanel             = WindowUtility.instance:windowRes("UI/CommonSweep/SweepAwardPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

fightEnterInfoPanel		    = WindowUtility.instance:windowRes("UI/FightEnterInfo/FightEnterInfoPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
fairPlayingPanel			= WindowUtility.instance:windowRes("UI/FairPlaying/FairPlayingPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
commonMatchPanel 			= WindowUtility.instance:windowRes("UI/Common/CommonMatchPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)


commonRulePanel             = WindowUtility.instance:windowRes("UI/Common/CommonRulePanel", 0, UIEffectType.uetOpenEffectScale,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)  

ownPlanetGiftPanel          = WindowUtility.instance:windowRes("UI/OwnPlanet/OwnPlanetGiftPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)  
ownPlanetNoticePanel        = WindowUtility.instance:windowRes("UI/OwnPlanet/OwnPlanetNoticePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
ownPlanetSharePanel         = WindowUtility.instance:windowRes("UI/OwnPlanet/OwnPlanetSharePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
ownPlanetBoxPanel           = WindowUtility.instance:windowRes("UI/OwnPlanet/OwnPlanetBoxPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
ownPlanetMookPanel          = WindowUtility.instance:windowRes("UI/OwnPlanet/OwnPlanetMookPanel", 0, UIEffectType.uetOpenEffectScale,UIEffectType.uetCloseNull)
ownPlanetGiftGivingPanel    = WindowUtility.instance:windowRes("UI/OwnPlanet/OwnPlanetGiftGivingPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
ownPlanetMookHandlePanel    = WindowUtility.instance:windowRes("UI/OwnPlanet/OwnPlanetMookHandlePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
ownPlanetSpecialtyLookPanel = WindowUtility.instance:windowRes("UI/OwnPlanet/OwnPlanetSpecialtyLookPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
ownPlanetSettingPanel		= WindowUtility.instance:windowRes("UI/OwnPlanet/OwnPlanetSettingPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
		
planetTreasurePanel         = WindowUtility.instance:windowRes("UI/Universe/PlanetTreasurePanel", 0, UIEffectType.uetOpenEffectScale,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

godWarPanel                 = WindowUtility.instance:windowRes("UI/GodWar/GodWarPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
universeDungeonPanel        = WindowUtility.instance:windowRes("UI/Universe/UniverseDungeonPanel", 0, UIEffectType.uetOpenEffectScale,UIEffectType.uetCloseNull)
godWarEnemyPanel            = WindowUtility.instance:windowRes("UI/GodWar/GodWarEnemyPanel", 0, UIEffectType.uetOpen, UIEffectType.uetCloseNull)

recordSharePanel			= WindowUtility.instance:windowRes("UI/Record/RecordSharePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
playerInfoRedeemPanel		= WindowUtility.instance:windowRes("UI/PlayerInfo/PlayerInfoRedeemPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

galaxyExplorePanel			= WindowUtility.instance:windowRes("UI/GalaxyExplore/GalaxyExplorePanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
galaxyExploreLevelPanel		= WindowUtility.instance:windowRes("UI/GalaxyExplore/GalaxyExploreLevelPanel", 0, UIEffectType.uetOpen, UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)

noobWeekPanel               = WindowUtility.instance:windowRes("UI/Noobweek/NoobweekPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull, UIEffectType.uetGuassianBlur)
dramaPanel               	= WindowUtility.instance:windowRes("UI/Drama/DramaPanel", 0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)

--towerPanel                  = WindowUtility.instance:windowRes("UI/Tower/TowerPanel",0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
towerShopPanel              = WindowUtility.instance:windowRes("UI/Tower/TowerShopPanel",0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
towerDungeonPanel           = WindowUtility.instance:windowRes("UI/Tower/TowerDungeonPanel",0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
towerBoxPanel               = WindowUtility.instance:windowRes("UI/Tower/TowerBoxPanel",0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
towerBuffPanel              = WindowUtility.instance:windowRes("UI/Tower/TowerBuffPanel",0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
towerHelpPanel              = WindowUtility.instance:windowRes("UI/Tower/TowerHelpPanel",0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
towerLotteryPanel           = WindowUtility.instance:windowRes("UI/Tower/TowerLotteryPanel",0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
towerRepayPanel             = WindowUtility.instance:windowRes("UI/Tower/TowerRepayPanel",0,UIEffectType.uetOpen,UIEffectType.uetCloseNull)
towerBonusBattlePanel       = WindowUtility.instance:windowRes("UI/Tower/TowerBonusBattlePanel",0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
towerRankPanel              = WindowUtility.instance:windowRes("UI/Tower/TowerRankPanel",0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)
towerUsePowerPanel          = WindowUtility.instance:windowRes("UI/Tower/TowerUsePowerPanel",0, UIEffectType.uetOpen,UIEffectType.uetCloseNull)