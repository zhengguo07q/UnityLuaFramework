-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : loggerWriter.lua
--  Creator     : zg
--  Date        : 2017-5-9
--  Comment     : 写入到日志文件
--  必须写的日志有：    
--                  1启动登录到进入游戏的所有流程性的日志
--                  2所有关键点日志，比如说打开窗口日志， 切换场景日志
--                  3重要节点日志，比如说切换出去
-- ***************************************************************


LoggerWriter = BaseClass()


function LoggerWriter:initialize()

end


function LoggerWriter.info(str)
	LogUtility.Log(str)
	-- 编辑器模式下输出
	if applicationConfig.macro.UNITY_EDITOR then
        print("<color=yellow>" .. str .. "</color>")
    end
end 

function LoggerWriter.error(str)
	applicationGlobal.logger:errorToServer("[Error:] " .. str)
	LogUtility.Log("[Error:] " .. str)
	-- 编辑器模式下输出
	if applicationConfig.macro.UNITY_EDITOR then
        print("<color=red>" .. str .. "</color>")
    end

    if videoBB ~= nil and videoBB.videoState == videoBB.enumVideoState.play then
    	applicationGlobal.tooltip:errorMessage(str)
    	videoBB.quitVideo()
    end

    if videoBB ~= nil and applicationGlobal.loading.isUploadVideo then
        applicationGlobal.loading:showUploadVideo(false)
    end

    if videoBB ~= nil and applicationGlobal.loading.isDownloadVideo then
        applicationGlobal.loading:showDownLoadVideo(false)
    end
end 


LoggerWriter.instance = LoggerWriter.new()


_G['logInfo'] = LoggerWriter.instance.info
_G['logError'] = LoggerWriter.instance.error
-- _G['error'] = LoggerWriter.instance.info()
