-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: applicationLoadStartup.lua
--  Creator 	: xujianlong
--  Date		: 2017-8-17
--  Comment		: 这里只装载启动流程所需要的
-- ***************************************************************


module("applicationLoadStartup", package.seeall)


reload("framework/profiler/profilerClass")
reload("framework/baseClass")
reload("framework/loader/assetUtil")
reload("framework/loader/assetLoadTask")
reload("framework/loader/asset")
reload("framework/loader/assetLoader")

reload("utility/syntaxUtility")
reload("utility/fileUtility")
reload("utility/screenDebugUtility")
reload("utility/stringUtility")
reload("utility/layerUtility")
reload("utility/debugUtility")
reload("utility/qualitySettingUtility")
reload("utility/languageUtility")
reload("utility/mathUtility")

reload("framework/uiComponent/data/listCollection")

-- 资源加载、解析
reload("framework/library/json")
reload("framework/assetsManager/assetBB")
reload("framework/assetsManager/assetConfProject")
reload("framework/assetsManager/assetDownloader")
reload("framework/assetsManager/assetDelayDownloader")
reload("framework/assetsManager/assetUtility")
reload("framework/assetsManager/assetStatusManager")
reload("framework/assetsManager/assetResultHandler")
reload("framework/assetsManager/assetDelayDownloadManager")
reload("reader/data")
reload("reader/dataReader")

reload("platform/platformBridge")
reload("platform/platformRequest")
reload("platform/platformResponse")

reload("startup/startupStatusManager")
reload("startup/startupLocalization")

--载入器相关
reload("framework/loader/listLoader")

--图层相关
reload("framework/layer/windowLayerBase")
reload("framework/layer/windowLayerDefinition")
reload("framework/layer/windowLayerManager")
reload("framework/window/windowUtility")

--场景相关
reload("framework/scene/sceneInstanceBase")
reload("framework/scene/sceneSwitchUtility")
reload("framework/scene/sceneSwitchManager")
reload("framework/scene/sceneSwitchRes")

--application
reload("applicationConfig")
reload("applicationGlobal")
-- 音频
reload("framework/audio/audioConfig")
--log
reload("framework/logger/loggerWriter")
--提示框
reload("module/alert/alertPanel")
reload("module/alert/alertMessagePanel")