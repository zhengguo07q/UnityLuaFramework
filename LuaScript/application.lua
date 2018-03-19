-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: application.lua
--  Creator 	: zg
--  Date		: 2016-11-10
--  Comment		: 启动类
-- ***************************************************************


import "UnityEngine"


function printInfo()
	--print("lua engine version : " .. _VERSION)
end


function initVsObject()
	local uiRoot = GameObject.Find("UI Root")
    -- GameObject.DontDestroyOnLoad(uiRoot)

    WindowLayerManager.instance:buildHolder(uiRoot)
end


function reload(moduleName)
	package.loaded[moduleName] = nil
	require(moduleName)
end


-- 使用协程，加载全局lua文件
function delayLoadGlobalLua(moduleName)
	table.insert(dataReader.globalLuaScripts, moduleName)
end


function loadScript()
	reload("applicationLoadStartup")   
	languageUtility.setLanguage()
	GameProgress.Instance:SetWarningLbl(startupLocalization.getLocal("jiankangzhonggao"))
	MacroUtility.SetLuaMacro()
end


--初始化网络
function initNetwrok()
	NetClient.GetInstance():BindScript("module/network/network")
	_G["protoData"] = {}
end


function startGame()
	qualitySettingUtility.setBaseQuality()
	UnityEngine.Screen.sleepTimeout = -1  --设置不休眠
    ScreenDebugUtility.GetInstance()
	startupStatusManager.initialize()
end


function main()
	printInfo()
	loadScript()
	initVsObject()
	initNetwrok()
	startGame()
end
