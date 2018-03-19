-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: sceneSwitchUtility.lua
--  Creator 	: zg
--  Date		: 2017-1-12
--  Comment		: 
-- ***************************************************************


SceneSwitchUtility = BaseClass()

function SceneSwitchUtility:sceneRes(sceneType, sceneScript, sceneLoadResouece)
	local sceneResId = {}
	sceneResId.sceneType = sceneType	
	sceneResId.sceneScript = sceneScript 						--场景脚本
	sceneResId.sceneLoadResouece = sceneLoadResouece			--场景装载的资源
	return sceneResId
end


--获取场景loader需要先加载的资源
function SceneSwitchUtility:getLoaderRes(sceneName)
	local tab = {}
	if sceneName == SceneLoaderRes.pvpLoader then
		tab = {"UI/Loader/PvpLoadingPanel"}
	elseif sceneName == SceneLoaderRes.commonLoader  then
		loadConf = conf.loading["2"]

		--登录界面用图片1
		if applicationGlobal.sceneSwitchManager.lastSceneInstance ~= nil then   -- 登录成功loaing主界面
			local sceneType = applicationGlobal.sceneSwitchManager.lastSceneInstance.currentSceneDefine.sceneType
			if sceneType == SceneSwitchType.sstLogin or sceneType == SceneSwitchType.sstLoginSwitch then
				loadConf = conf.loading["1"]
			end	
		end

	    commonLoaderBB.bg = loadConf.bg
		tab = {"UI/Loader/CommonLoader", "Texture/BigTexV1/" .. commonLoaderBB.bg}	
	end
	return tab
end

SceneSwitchUtility.instance = SceneSwitchUtility.new()

