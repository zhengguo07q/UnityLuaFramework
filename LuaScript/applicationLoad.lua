-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: applicationLoad.lua
--  Creator 	: zg
--  Date		: 2016-11-10
--  Comment		: 装载非AA、BB的lua脚本
-- ***************************************************************


module("applicationLoad", package.seeall)


--功能开放
delayLoadGlobalLua("module/system/functionOpend")

delayLoadGlobalLua("utility/colorUtility")
delayLoadGlobalLua("utility/gameUtils")
delayLoadGlobalLua("utility/vipBuyTipsUtility")
delayLoadGlobalLua("utility/timeUtility")
delayLoadGlobalLua("utility/attributeUtility")
delayLoadGlobalLua("utility/stoneMatrixPropsUtility")
delayLoadGlobalLua("utility/errorInfo")
delayLoadGlobalLua("utility/jumpUtility")
delayLoadGlobalLua("utility/collectionUtility")
delayLoadGlobalLua("utility/timeManagerUtility")
delayLoadGlobalLua("utility/textResolve")
delayLoadGlobalLua("utility/shaderUtility")
delayLoadGlobalLua("utility/uiAssetCache")
delayLoadGlobalLua("utility/mathBit")
delayLoadGlobalLua("utility/windowContentEffectUtility")

delayLoadGlobalLua("framework/actionPriority")

delayLoadGlobalLua("framework/uiComponent/uiListLayoutBase")
delayLoadGlobalLua("framework/uiComponent/uiListLayoutList")
delayLoadGlobalLua("framework/uiComponent/uiListLayoutTiled")
delayLoadGlobalLua("framework/uiComponent/uiScriptBehaviour")
delayLoadGlobalLua("framework/uiComponent/uiListLayoutChatList")

delayLoadGlobalLua("utility/spriteProxy")
delayLoadGlobalLua("framework/loader/asyncObject")

--窗口相关
delayLoadGlobalLua("framework/window/effect/windowEffectManager")
delayLoadGlobalLua("framework/window/effect/windowEffect")
delayLoadGlobalLua("framework/window/control/windowControl")
delayLoadGlobalLua("framework/window/control/windowPanel")
delayLoadGlobalLua("framework/window/windowBase")

delayLoadGlobalLua("framework/window/windowMask")
delayLoadGlobalLua("framework/window/windowCamera")
delayLoadGlobalLua("framework/window/windowStack")
delayLoadGlobalLua("framework/window/windowQueue")
delayLoadGlobalLua("framework/window/windowQueueRegister")
delayLoadGlobalLua("framework/window/windowResId")
delayLoadGlobalLua("framework/window/windowModelManager")
delayLoadGlobalLua("framework/window/windowRapidBlurEffect")


delayLoadGlobalLua("module/component/commonUITop") --add lxy 6.8

--战斗相关
delayLoadGlobalLua("battle/map/mapManager")

-- 通用道具类
delayLoadGlobalLua("module/component/civilCommonItem")
delayLoadGlobalLua("module/component/componentCardPrefabInfo")
delayLoadGlobalLua("module/component/componentGangFlag")
delayLoadGlobalLua("module/component/commonRedTip")
delayLoadGlobalLua("module/commonAward/commonAwardPopupWindow")
delayLoadGlobalLua("module/loader/commonLoader")

--
delayLoadGlobalLua("battle/effect/bezier")
-- delayLoadGlobalLua("framework/manager/effect/effectManager")

delayLoadGlobalLua("battle/base/scene")
delayLoadGlobalLua("battle/base/objectData")
delayLoadGlobalLua("battle/base/player")
delayLoadGlobalLua("battle/battleUI/mainUI/dragAndDrop/dragAndDropManager")
delayLoadGlobalLua("battle/battleUI/mainUI/dragAndDrop/dropTargetArea")
delayLoadGlobalLua("battle/battleUI/mainUI/dragAndDrop/dragRegion")

delayLoadGlobalLua("battle/battleUI/mainUI/skill/mainUISkillPanelBB")

delayLoadGlobalLua("battle/camera/cameraShadowProjector")
delayLoadGlobalLua("battle/camera/cameraCBOutline")
delayLoadGlobalLua("battle/camera/cameraMove")
delayLoadGlobalLua("battle/camera/cameraShock")

--场景对象
delayLoadGlobalLua("battle/sceneObject/sceneObject")
delayLoadGlobalLua("battle/sceneObject/modelObject")
delayLoadGlobalLua("battle/sceneObject/moveableObject")
delayLoadGlobalLua("battle/sceneObject/sceneObjectNotify")

--动画系统
delayLoadGlobalLua("battle/sceneObject/anim/animModel")
delayLoadGlobalLua("battle/sceneObject/anim/animRenderer")
delayLoadGlobalLua("battle/sceneObject/anim/animEvent")


--技能系统
delayLoadGlobalLua("battle/skill/skill")
delayLoadGlobalLua("battle/skill/skillImpact")
delayLoadGlobalLua("battle/skill/skillEffectFactory")
delayLoadGlobalLua("battle/skill/skillEffect/skillEffect")
delayLoadGlobalLua("battle/skill/skillEffect/skillEffectPath")
delayLoadGlobalLua("battle/skill/skillEffect/skillEffectTarget")
delayLoadGlobalLua("battle/skill/skillEffect/skillEffectScaleLaser")
delayLoadGlobalLua("battle/skill/skillEffect/skillEffectLR")
delayLoadGlobalLua("battle/skill/skillEffect/skillEffectLRLaser")
delayLoadGlobalLua("battle/skill/skillEffect/skillEffectBulletLaster")

--身上的小组件
delayLoadGlobalLua("battle/sceneObject/unilt/haloManager")
delayLoadGlobalLua("battle/sceneObject/unilt/shieldManager")

--效果
delayLoadGlobalLua("battle/effect/effectCache")
delayLoadGlobalLua("battle/effect/effectObject")

--输入系统
delayLoadGlobalLua("battle/input/inputLockControll")
delayLoadGlobalLua("battle/input/inputManager")
delayLoadGlobalLua("battle/input/inputObject")

delayLoadGlobalLua("battle/utility/materialUtility")

-- 战斗掉落
delayLoadGlobalLua("battle/sceneDrop/sceneDropBB")
delayLoadGlobalLua("battle/sceneDrop/sceneDropManager")

delayLoadGlobalLua("battle/base/chief")
delayLoadGlobalLua("module/mainUi/mainUIWindowListener")

-- 行为树
delayLoadGlobalLua("battle/btree/behaviorTreeBase")
delayLoadGlobalLua("battle/btree/behaviorTreeAction")
delayLoadGlobalLua("battle/btree/behaviorTreeCondition")
delayLoadGlobalLua("battle/btree/behaviorTreeAIUtil")
delayLoadGlobalLua("battle/btree/behaviorTreeAI")
delayLoadGlobalLua("battle/btree/behaviorTreeAIFactory")
delayLoadGlobalLua("battle/btree/behaviorTreeState")

delayLoadGlobalLua("module/login/loginRandomName")

-- 公会战相关
-- delayLoadGlobalLua("module/gang/gangWar/dijstraFind")
-- delayLoadGlobalLua("module/gang/gangWar/characterIdlePathData")

--战斗引导
delayLoadGlobalLua("battle/battleUI/guideUI/guideActionBase")
delayLoadGlobalLua("battle/battleUI/guideUI/guideActionDialogue")
delayLoadGlobalLua("battle/battleUI/guideUI/guideActionCard")
delayLoadGlobalLua("battle/battleUI/guideUI/guideActionSelectTroop")
delayLoadGlobalLua("battle/battleUI/guideUI/guideActionMoveTroop")
delayLoadGlobalLua("battle/battleUI/guideUI/guideActionSkill")
delayLoadGlobalLua("battle/battleUI/guideUI/guideActionCardHint")
delayLoadGlobalLua("battle/battleUI/guideUI/guideActionShowGenralSkill")
delayLoadGlobalLua("battle/battleUI/guideUI/guideActionChangeCard")

-- 战斗中断线重连
delayLoadGlobalLua("battle/battleUI/receover/guideReceover")
delayLoadGlobalLua("battle/battleUI/receover/troopReceover")
delayLoadGlobalLua("battle/battleUI/receover/uiCardReceover")
delayLoadGlobalLua("battle/battleUI/receover/battleReceoverManager")

--战斗结算相关
-- delayLoadGlobalLua("battle/battleUI/battleResult/battleResultManager")

-- 星际远征相关
delayLoadGlobalLua("module/universe/universeMaterialUtil")
delayLoadGlobalLua("module/universe/universeUtil")
delayLoadGlobalLua("module/universe/universeInstance")
delayLoadGlobalLua("module/universe/dungeon/universeDungeonPanel")
delayLoadGlobalLua("module/universe/planet/planetSplitScreen")

--我的星球
delayLoadGlobalLua("module/ownPlanet/module/input/ownPlanetinputCamera")
delayLoadGlobalLua("module/ownPlanet/module/utility/gridUtility")

-- 引导监听器
-- delayLoadGlobalLua("module/guide/guideListenerViewActivity")

