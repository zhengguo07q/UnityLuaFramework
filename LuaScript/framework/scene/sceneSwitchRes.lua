-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: sceneSwitchRes.lua
--  Creator 	: zg
--  Date		: 2016-12-16
--  Comment		: 
-- ***************************************************************


module("sceneSwitchRes", package.seeall)

loginSwitchScene 	= SceneSwitchUtility.instance:sceneRes(SceneSwitchType.sstLoginSwitch, "module/login/loginInstance")
loginScene 			= SceneSwitchUtility.instance:sceneRes(SceneSwitchType.sstLogin, "module/login/loginInstance")
battleScene         = SceneSwitchUtility.instance:sceneRes(SceneSwitchType.sstBattle, "battle/battleInstance", SceneLoaderRes.commonLoader)
battlePvpScene      = SceneSwitchUtility.instance:sceneRes(SceneSwitchType.sstBattle, "battle/battleInstance", SceneLoaderRes.pvpLoader)
mainUiScene 		= SceneSwitchUtility.instance:sceneRes(SceneSwitchType.sstMainUI, "module/mainUi/mainUiInstance", SceneLoaderRes.commonLoader)
universeScene 		= SceneSwitchUtility.instance:sceneRes(SceneSwitchType.sstUniverse, "module/universe/universeInstance", SceneLoaderRes.commonLoader)
ownPlanetScene 		= SceneSwitchUtility.instance:sceneRes(SceneSwitchType.sstOwnPlanet, "module/ownPlanet/ownPlanetInstance", SceneLoaderRes.commonLoader)
towerScene    		= SceneSwitchUtility.instance:sceneRes(SceneSwitchType.sstTower, "module/tower/towerInstance", SceneLoaderRes.commonLoader)

