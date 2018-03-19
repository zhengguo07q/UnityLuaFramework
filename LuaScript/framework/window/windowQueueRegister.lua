-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: windowQueueRegister.lua
--  Creator 	: xiewenjian
--  Date        : 2017-4-11
--  Comment	    : 回退队列
-- ***************************************************************


WindowQueueRegister = BaseClass()

enumWindowSourceType = 
{
	wstGangShop             = 1,		--工会商店
    wstFairPlayingPanel     = 2,		--公平竞技
    wstCruciataPanel        = 5,		--舰长试炼
    wstConquestPanel        = 7,		--银河联赛
    wstCardBagPanel         = 8,	
    wstEscortPanel          = 9,		--星空护送
    wstScoopDiamondPanel    = 10,
    wstPyramidMapPanel      = 11,
    wstColosseumPanel       = 12,
    wstVipShopPanel         = 13,
    wstCruciataShadowPanel  = 14,
    wstVipPanel             = 15,
    wstActivityPanel        = 16,		--活动界面
    wstGangPanel            = 17,
    wstStorePanel           = 18,
    wstDungeonSweepPanel    = 19,		--星球扫荡
    wstCitySweepPanel       = 20,
	wstFairPlayingShop       	= 21,
	wstGangShop       			= 22,
	wstGoldShop       			= 23,
	wstDepotgShop       		= 24,	-- 补给站
	wstMilkyWayShop       		= 25,
	wstUniverseDungeonPanel		= 26,
	wstTowerShop				= 27,	-- 先祖遗迹商店

}


function WindowQueueRegister:initialize()
	self:registerGoto(enumWindowSourceType.wstCruciataPanel, windowResId.cruciataPanel)
    self:registerGoto(enumWindowSourceType.wstConquestPanel, windowResId.qualifyingPanel)
    self:registerGoto(enumWindowSourceType.wstCardBagPanel, windowResId.cardBagPanel)
    self:registerGoto(enumWindowSourceType.wstGangPanel, windowResId.gangPanel)
    self:registerGoto(enumWindowSourceType.wstVipPanel, windowResId.vipPanel)
	self:registerGoto(enumWindowSourceType.wstFairPlayingPanel, windowResId.fairPlayingPanel)
	self:registerGoto(enumWindowSourceType.wstActivityPanel, windowResId.activityPanel)
    
    self:registerGoto(enumWindowSourceType.wstScoopDiamondPanel, windowResId.scoopDiamondPanel)
    self:registerGoto(enumWindowSourceType.wstPyramidMapPanel, windowResId.pyramidMapPanel)
    self:registerGoto(enumWindowSourceType.wstColosseumPanel, windowResId.colosseumPanel)
    self:registerGoto(enumWindowSourceType.wstVipShopPanel, windowResId.vipShopPanel)
    self:registerGoto(enumWindowSourceType.wstEscortPanel, windowResId.escortPanel)
    self:registerGoto(enumWindowSourceType.wstCruciataShadowPanel, windowResId.cruciataShadowPanel)
    self:registerGoto(enumWindowSourceType.wstCitySweepPanel, windowResId.commonSweepPanel)
    self:registerGoto(enumWindowSourceType.wstStorePanel, windowResId.storePanel)
	
	self:registerGoto(enumWindowSourceType.wstUniverseDungeonPanel, windowResId.universeDungeonPanel)
	-- shopPanel
	-- ustRecharge 	   = 1,       	 --充值商品
	-- ustGold 		   = 2,	      	 --金币商品
	-- ustMilkyWay 	   = 3,       	 --银河商会
	-- ustGang 		   = 4,       	 --军团商店
	-- ustFairPlay     = 5,        	 --公平竞技商店
	-- ustDepotg       = 6,        	 --补给站商店
	self:registerGoto(enumWindowSourceType.wstFairPlayingShop, 	windowResId.shopPanel, shopBB.uiShopType.ustFairPlay)
    self:registerGoto(enumWindowSourceType.wstGangShop, 		windowResId.shopPanel, shopBB.uiShopType.ustGang)
    -- self:registerGoto(enumWindowSourceType.wstGoldShop, 		windowResId.shopPanel, shopBB.uiShopType.ustGold)
	self:registerGoto(enumWindowSourceType.wstMilkyWayShop, 	windowResId.shopPanel, shopBB.uiShopType.ustMilkyWay)
	self:registerGoto(enumWindowSourceType.wstTowerShop, 		windowResId.shopPanel, shopBB.uiShopType.ustTower)

	self:registerDungenSweep()
	self:registerExceptiond()
end


function WindowQueueRegister:registerGoto(windowSourceType, windowResId, uiShopType)
	local conquestQueue = WindowQueue.new()
	local targetPanelPath = 
	{
		eventType = enumWindowEventType.wetWindow,
		window = windowResId,
		lastWindow = false,
		uiShopType = uiShopType, --add lxy 9.19
	}
	conquestQueue:addQueuePath(targetPanelPath)

	local targetConditionPath = 
	{
		eventType = enumWindowEventType.wetWindow,
		window  = windowResId,
	}
	conquestQueue:addConditionPath(targetConditionPath)

	WindowQueueManager.instance:register(windowSourceType, conquestQueue)
end

--add sweep
function WindowQueueRegister:registerDungenSweep()
	local dungenSweepQueue = WindowQueue.new()

	local universeScenePath = 
	{
		eventType = enumWindowEventType.wetScene,
		nextSceneDefine = sceneSwitchRes.universeScene,
	}
	dungenSweepQueue:addQueuePath(universeScenePath)

	local commonSweepPanelPath = 
	{
		eventType = enumWindowEventType.wetWindow,
		window = windowResId.commonSweepPanel,
	}
	dungenSweepQueue:addQueuePath(commonSweepPanelPath)

	local universeSceneConditionPath = 
	{
		eventType = enumWindowEventType.wetScene,
		lastSceneDefine = sceneSwitchRes.universeScene,
		nextSceneDefine = sceneSwitchRes.mainUiScene,
	}
	dungenSweepQueue:addConditionPath(universeSceneConditionPath)
	
	WindowQueueManager.instance:register(enumWindowSourceType.wstDungeonSweepPanel, dungenSweepQueue)
end


function WindowQueueRegister:registerExceptiond()
	local res = {}
	table.insert(res, windowResId.goldenTouchPanel)
	table.insert(res, windowResId.shopPanel)

	for i = 1, #res do 
		WindowQueueManager.instance:registerException(res[i])
	end
end