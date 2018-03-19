-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: startupStatusManager.lua
--  Creator 	: zg
--  Date		: 2016-11-10
--  Comment		: 启动场景, 启动过程为， 载入lua的bind类， 访问远程服务器，获得CDN地址， 检查下载，读取配置， 读取协议， 进入登录
-- ***************************************************************


module("startupStatusManager", package.seeall) 


local constStartupStatus = {"esStart", "esPreHttp", "esHttping", "esHttped", "esDownload", "esDownloaded", "esPreDataReader", "esDataReadered", "esPreProtocalReader", "esProtocalReadered", "esPreGlobalLuaReader", "esGlobalLuaReadered"}
local enumStartupStatus = nil
local httpCount = 0
local currentStatus = nil
local storagePath = nil
local streamAssetsCount = 0
local streamAssetsCopied = 0
local unZipProgress = 0
local timerTask = nil   


function initialize()
	enumStartupStatus = syntaxUtility.createEnum(constStartupStatus)
	setStartupStatus(enumStartupStatus.esStart)
end


function setStartupStatus(newStatus)
	currentStatus = newStatus
	logInfo(string.format(stringUtility.rejuctSymbol("StartupStatusManager Status : {0}"), constStartupStatus[currentStatus]))

	if newStatus == enumStartupStatus.esStart then
        applicationGlobal.prepareAlert()    
        storagePath = PathUtility.StoragePath
		-- checkNetwork()
		setStartupStatus(enumStartupStatus.esPreHttp)
	elseif newStatus == enumStartupStatus.esPreHttp then
		preHttp()
	elseif newStatus == enumStartupStatus.esHttping then
		httpRequest()
	elseif newStatus == enumStartupStatus.esDownload then
		startDownload()
		setVersion()
	elseif newStatus == enumStartupStatus.esDownloaded then
		endDownload()
	elseif newStatus == enumStartupStatus.esPreDataReader then
		preDataReader()
	elseif newStatus == enumStartupStatus.esDataReadered then
		dataReaderCompleted()
	elseif newStatus == enumStartupStatus.esPreProtocalReader then
		preProtocalReader()
	elseif newStatus == enumStartupStatus.esProtocalReadered then
		protocalReaderCompleted()
	elseif newStatus == enumStartupStatus.esPreGlobalLuaReader then
		preGlobalLuaReader()
	elseif newStatus == enumStartupStatus.esGlobalLuaReadered then
		globalLuaReaderCompleted()
	end
end


function setVersion()
	GameProgress.Instance:SetVersion("v" .. AssetStatusManager.instance.localConfProject.version)
end


-------------------------------访问配置------------------------------------------
function preHttp()
	if httpCount <= assetBB.AssetConstants.Max_Repeat_Count_Http then
		httpCount = httpCount + 1
		setStartupStatus(enumStartupStatus.esHttping)
        GameProgress.Instance:SetProgressTxt(string.format(stringUtility.rejuctSymbol(startupLocalization.getLocal("sys_startup_msg_2")), httpCount), "", 0)

		platformRequest.playerEvent(
		    platformBridge.enumEventType.eetUserDefined      	--事件类型
		    ,1001                                              	--事件ID
		    ,"getCdnUrl"                                     	--事件名字
		    ,platformBridge.enumEventState.eesStart         	--事件状态
		    ,string.format(stringUtility.rejuctSymbol(startupLocalization.getLocal("sys_startup_msg_2")), httpCount)              	--事件说明
		)
	else
		--超出下载次数
		GameProgress.Instance:SetProgressTxt(startupLocalization.getLocal("sys_startup_cdn_error"), "", 0)
		applicationGlobal.alert:alertSingle(startupLocalization.getLocal("sys_tip_title_1"), 
            	startupLocalization.getLocal("login_WangLuoMangWeiZhaoDaoPeizhi"), function () end, startupLocalization.getLocal("button_confirm"))
	end
end


function httpRequest()
	platformRequest.getInfo()
end


function httpResponse()
    local versionStr = FileUtility.GetString(PathUtility.PersistentDataPath.."/init.log")
    applicationConfig.gameConfig.appVersion = stringUtility.split(versionStr, '-')[1]
    logInfo("applicationConfig.gameConfig.appVersion:" .. applicationConfig.gameConfig.appVersion)
    
    if applicationConfig.macro.UNITY_EDITOR then
        applicationConfig.gameConfig.appVersion = "1.0.0"
    end

    local httpUrl = string.format(stringUtility.rejuctSymbol("{0}?mt=gameinfo&gid={1}&sdkid={2}&cdn={3}&channel={4}&appversion={5}"), applicationConfig.gameConfig.serverCdnUrl,
    	applicationConfig.gameConfig.gameId, applicationConfig.gameConfig.sdkid, applicationConfig.gameConfig.cdnUrl, applicationConfig.gameConfig.channelId, applicationConfig.gameConfig.appVersion)
    logInfo("httpResponse: Url = "..httpUrl)

	local c = coroutine.create(
		function() 
			local www = UnityEngine.WWW(httpUrl)
			UnityEngine.Yield(www)
			if www.error == nil then
				platformRequest.playerEvent(
				    platformBridge.enumEventType.eetUserDefined      	          --事件类型
				    ,1001                                              	          --事件ID
				    ,"getCdnUrl"                                     	          --事件名字
				    ,platformBridge.enumEventState.eesFinish         	          --事件状态
				    ,startupLocalization.getLocal("sys_startup_cdn_getAddress")   --事件说明
				)
				local content = StringUtility.EncodeUnicodeWWW(www)
				logInfo("返回content："..content)
				applicationGlobal.serverConfig = json.decode(content)

				if not applicationConfig.macro.UNITY_EDITOR and not applicationConfig.gameConfig.isDebug then
					applicationConfig.gameConfig.cdnUrl = applicationGlobal.serverConfig.cdnUrl
					-- applicationConfig.gameConfig.cdnUrl = "http://172.16.4.100:8800/"
					logInfo("applicationConfig.gameConfig.cdnUrl = "..applicationConfig.gameConfig.cdnUrl)
				end
				setStartupStatus(enumStartupStatus.esDownload)
			else
			    logInfo("httpResponse error:  "..www.error)
				setStartupStatus(enumStartupStatus.esPreHttp)

				platformRequest.playerEvent(
				    platformBridge.enumEventType.eetUserDefined      	                 --事件类型
				    ,1001                                              	                 --事件ID
				    ,"getCdnUrl"                                     	                 --事件名字
				    ,platformBridge.enumEventState.eesFailed         	                 --事件状态
				    ,startupLocalization.getLocal("sys_startup_cdn_getAddress")        	 --事件说明
				)
			end
		end)
	coroutine.resume(c)
end


-------------------------------下载资源------------------------------------------
function startDownload()
	GameProgress.Instance:SetProgressTxt(startupLocalization.getLocal("sys_startup_get_cdnRes"), "", 0)
    logInfo(string.format(stringUtility.rejuctSymbol("applicationConfig.gameConfig.cdnUrl: {0}"), applicationConfig.gameConfig.cdnUrl))
	AssetResultHandler.instance:addCallback(callbackAssetsManager)
    AssetStatusManager.instance:initialize(applicationConfig.gameConfig.cdnUrl, PathUtility.PersistentDataPath.."/project.manifest", storagePath)
    AssetStatusManager.instance:prepareLocalManifest()

	platformRequest.playerEvent(
	    platformBridge.enumEventType.eetUserDefined      	--事件类型
	    ,1002                                           	--事件ID
	    ,"loadCdnFiles"                                     --事件名字
	    ,platformBridge.enumEventState.eesStart         	--事件状态
	    ,startupLocalization.getLocal("sys_startup_get_cdnRes")                                    	--事件说明
	)
end


--通过AssetResultHandler dispatchUpdateEvent调用
function callbackAssetsManager(resultHander, assetErrorCode, progressItem, message)
	local errMsg = nil
	if assetErrorCode == assetBB.enumAssetEventCode.aecVersionNotice then  --下载version失败
		GameProgress.Instance:SetProgressTxt(string.format(stringUtility.rejuctSymbol(startupLocalization.getLocal("sys_startup_msg_1")), message), "", 0)
		if tonumber(message) == assetBB.AssetConstants.Max_Repeat_Count_Version then 
            applicationGlobal.alert:alertSingle(startupLocalization.getLocal("sys_tip_title_1"), 
            	startupLocalization.getLocal("login_WangLuoMangWeiZhaoDaoPeizhi"), function () end, startupLocalization.getLocal("button_confirm"))
		end
	elseif assetErrorCode == assetBB.enumAssetEventCode.aecManifestNotice then  --下载manifest失败
		GameProgress.Instance:SetProgressTxt(string.format(stringUtility.rejuctSymbol(startupLocalization.getLocal("sys_startup_download_Manifest")), message), "", 0)
	    if tonumber(message) == assetBB.AssetConstants.Max_Repeat_Count_Manifest then 
            applicationGlobal.alert:alertSingle(startupLocalization.getLocal("sys_tip_title_1"), 
            	startupLocalization.getLocal("login_WangLuoMangWeiZhaoDaoPeizhi"), function () end, startupLocalization.getLocal("button_confirm"))
            FileUtility.DeleteFile(AssetStatusManager.instance.cacheVersionPath)   --下载3次失败 删除存储路径的version文件
	    end
	elseif assetErrorCode == assetBB.enumAssetEventCode.aceErrorPackage then
		msg = startupLocalization.getLocal("error_no_local_mainfest")
		platformRequest.errorLog(2080,"aceErrorPackage",msg)
	elseif assetErrorCode == assetBB.enumAssetEventCode.aceErrorNoLocalManifest then
		msg = "aceErrorNoLocalManifest"
	elseif assetErrorCode == assetBB.enumAssetEventCode.aecUpdateProgression then
		
		--正常热更资源+延迟资源
		--如果totalDownloaded=totalSize 显示"进入游戏"按钮
        local totalDownloaded = progressItem.totalDownloaded + AssetDelayDownloadManager.instance.downloaded    
        local totalSize = progressItem.totalSize + AssetDelayDownloadManager.instance.totalSize
        local finishWarmDownload 
        if progressItem.totalDownloaded >= progressItem.totalSize then
            finishWarmDownload = true
        else
            finishWarmDownload = false
        end
        assetBB.totalWarmAssetsSize = progressItem.totalSize    --记录热更资源大小，方便后面下载延迟资源时用到
        GameProgress.Instance:SetEnableRunPos(progressItem.totalSize, totalSize)

        GameProgress.Instance:SetDownLoadProgressTxt(startupLocalization.getLocal("login_check_update"), 
        	AssetUtility.instance:convertFileSize(totalDownloaded).."/"..AssetUtility.instance:convertFileSize(totalSize), 
        	tonumber(totalDownloaded), totalDownloaded/totalSize, finishWarmDownload)

	elseif assetErrorCode == assetBB.enumAssetEventCode.aecAssetUpdated then
		--
	elseif assetErrorCode == assetBB.enumAssetEventCode.aecVersionDownloadError then
		msg = startupLocalization.getLocal("error_download_mainfest")
		platformRequest.errorLog(2081,"aecVersionDownloadError",msg)
	elseif assetErrorCode == assetBB.enumAssetEventCode.aecErrorDownloadManifest then
		msg = startupLocalization.getLocal("error_download_mainfest")
		platformRequest.errorLog(2082,"aecErrorDownloadManifest",msg)
	elseif assetErrorCode == assetBB.enumAssetEventCode.aecErrorParseManifest then
		msg = startupLocalization.getLocal("error_parst_mainfest")
		platformRequest.errorLog(2083,"aecErrorParseManifest",msg)
	elseif assetErrorCode == assetBB.enumAssetEventCode.aecCheckAllowUpdate then
        totalFileSize = AssetUtility.instance:convertFileSize(progressItem.totalSize)
      --  checkNetworkReachability(progressItem.totalSize)
        AssetStatusManager.instance:setUpdateState(assetBB.enumAssetState.asAllowUpdate)
	elseif assetErrorCode == assetBB.enumAssetEventCode.aecAlreadyUpToDate then
		setStartupStatus(enumStartupStatus.esDownloaded)
	elseif assetErrorCode == assetBB.enumAssetEventCode.aecUpdateFailure then
		msg = startupLocalization.getLocal("failed_update")
		platformRequest.errorLog(2084,"aecUpdateFailure",msg)
	elseif assetErrorCode == assetBB.enumAssetEventCode.aecErrorUpdating then				
		logInfo(string.format(stringUtility.rejuctSymbol("aecErrorUpdating : progressItem.assetId = {0}, message = {1}"), progressItem.assetId, message))     --正在下载，发现有下载失败的
		platformRequest.errorLog(2085,"aecErrorUpdating","正在下载，发现有下载失败的")
	elseif assetErrorCode == assetBB.enumAssetEventCode.aecErrorDecompress then
		msg = startupLocalization.getLocal("error_decompress")	--正在解压
		platformRequest.errorLog(2086,"aecErrorDecompress",msg)
	elseif assetErrorCode == assetBB.enumAssetEventCode.aecUpdateFinished then
		logInfo("aecUpdateFinished!")		--下载完成并解压
	elseif assetErrorCode == assetBB.enumAssetEventCode.aecNewVersionFound then
		logInfo("aecNewVersionFound!")	--发现新版本		
	end

	if msg ~= nil then
		logInfo(string.format(stringUtility.rejuctSymbol("错误日志:{0}"), msg))
		--弹出错误对话框
		-- applicationGlobal.tooltip:errorMessage(msg)
	end
end


-- --检测网络状态
-- function checkNetwork()
-- 	if UnityEngine.Application.internetReachability == assetBB.enumNetworkState.wifi then    --wifi   
--         setStartupStatus(enumStartupStatus.esPreHttp)
--     else  
--         applicationGlobal.alert:alertSingle(startupLocalization.getLocal("sys_tip_title_1"), startupLocalization.getLocal("sys_net_notWifi_tip"), function()	
--            setStartupStatus(enumStartupStatus.esPreHttp)
--         end, startupLocalization.getLocal("file_cs_TipWinControl_0"))
--     end
-- end


function endDownload()
	platformRequest.playerEvent(
	    platformBridge.enumEventType.eetUserDefined      	--事件类型
	    ,1002                                           	--事件ID
	    ,"loadCdnFiles"                                     --事件名字
	    ,platformBridge.enumEventState.eesFinish         	--事件状态
	    ,"下载cdn资源完成"                                  --事件说明
	)

    if assetBB.updateStartUpScript == true then
        --重新开始启动流程
        logInfo("======lua启动流程重启======")
    	ScriptManager.GetInstance():ReStart()
        return
    end

    if assetBB.updateScript == true then    --重初始化lua字节码缓存必须提前到这里
        assetBB.updateScript = false
        logInfo("======重新加载lua======")
        ScriptManager.GetInstance():ReInitLuaBytecode()
    end
    setStartupStatus(enumStartupStatus.esPreDataReader) 
end


-------------------------------读取配置------------------------------------------
function preDataReader()
	dataReader.loadConf()      --读取配置，预装载lua代码
	platformRequest.playerEvent(
	    platformBridge.enumEventType.eetUserDefined      	--事件类型
	    ,1003                                           	--事件ID
	    ,"readData"		                                    --事件名字
	    ,platformBridge.enumEventState.eesStart         	--事件状态
	    ,"读取配置"                                     	--事件说明
	)
end


function dataReaderComplete()
	setStartupStatus(enumStartupStatus.esDataReadered)
end


function dataReaderCompleted()
	platformRequest.playerEvent(
	    platformBridge.enumEventType.eetUserDefined      	--事件类型
	    ,1003                                           	--事件ID
	    ,"readData"		                                    --事件名字
	    ,platformBridge.enumEventState.eesFinish         	--事件状态
	    ,"读取配置完成"                                     	--事件说明
	)

	setStartupStatus(enumStartupStatus.esPreProtocalReader)
end


-------------------------------读取协议------------------------------------------
function preProtocalReader()
	dataReader.loadProtocal()

	platformRequest.playerEvent(
	    platformBridge.enumEventType.eetUserDefined      	--事件类型
	    ,1004                                           	--事件ID
	    ,"readProtocal"		                                    --事件名字
	    ,platformBridge.enumEventState.eesStart         	--事件状态
	    ,"读取协议"                                     	--事件说明
	)
end


function protocalReaderComplete()
	setStartupStatus(enumStartupStatus.esProtocalReadered)
end


function protocalReaderCompleted()
	platformRequest.playerEvent(
	    platformBridge.enumEventType.eetUserDefined      	--事件类型
	    ,1004                                           	--事件ID
	    ,"readProtocal"		                                    --事件名字
	    ,platformBridge.enumEventState.eesFinish         	--事件状态
	    ,"读取协议完成"                                     	--事件说明
	)
	setStartupStatus(enumStartupStatus.esPreGlobalLuaReader)
end

------------------------------------------读取GlobalLua(applicationLoad 和applicationAfterLoad)-----------------------

function preGlobalLuaReader()
	reload("applicationLoad")
	reload("applicationLoadAfter")
	dataReader.loadGlobalLua()

	-- platformRequest.playerEvent(
	--     platformBridge.enumEventType.eetUserDefined      	--事件类型
	--     ,1004                                           	--事件ID
	--     ,"readGlobalLua"		                                    --事件名字
	--     ,platformBridge.enumEventState.eesStart         	--事件状态
	--     ,"读取全局lua对象(applicationLoad 和applicationAfterLoad)"                                     	--事件说明
	-- )
end


function globalLuaReaderComplete()
	setStartupStatus(enumStartupStatus.esGlobalLuaReadered)
end


function globalLuaReaderCompleted()
	-- platformRequest.playerEvent(
	--     platformBridge.enumEventType.eetUserDefined      	--事件类型
	--     ,1004                                           	--事件ID
	--     ,"readGlobalLua"		                                    --事件名字
	--     ,platformBridge.enumEventState.eesFinish         	--事件状态
	--     ,"读取全局lua对象(applicationLoad 和applicationAfterLoad)"                                     	--事件说明
	-- )
	doActionBeforeEnterScene()
end


--登录场景前的准备
function doActionBeforeEnterScene()
	logInfo("doActionBeforeEnterScene---------------")

    GameProgress.Instance:SetTextWithoutProgress(startupLocalization.getLocal("sys_startup_msg_3"))
	--资源下载完成 首先加载shader，加载完成回调再进入Login场景
    shaderUtility.loadShader(function ()
    	logInfo("加载shader完成")
        applicationGlobal.enterLoginBefore()
	    applicationGlobal.sceneSwitchManager:enterScene(sceneSwitchRes.loginScene)
    end)
end