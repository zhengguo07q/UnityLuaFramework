-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: startupLocalization.lua
--  Creator 	: zg
--  Date		: 2016-11-10
--  Comment		: 
-- ***************************************************************


module("startupLocalization", package.seeall)


local config = 
{
    language = "CN",
    contents =
	{
        login_init = 
        {
            CN = "初始化",
			TW = "初始化中",
            EN = "Initializing"
        },
        login_filedecompress = 
        {
            CN = "文件解压中",
			TW = "文件解壓中",
            EN = "Decompressing files"
        },
        login_check_update = 
        {
            CN = "正在替换最新科技",
			TW = "正在替換最新科技",
            EN = "Check and update files"
        },
        login_WangLuoMangWeiZhaoDaoPeizhi =
        {
            CN = "网络繁忙,请检查网络设置并重新启动",
			TW = "網路繁忙，請檢查網路設置并重新啟動",
            EN = "Network is busy, please check the setting of network and restart the application"
        },
        login_decompressdion_finish =
        {
            CN = "数据文件解压完成",
			TW = "數據文件解壓完成",
            EN = "Files of data are decompressed"
        },
        login_decompressdion_unusual =
        {
            CN = "【解压】 解压缩异常:",
			TW = "文件解壓異常",
            EN = "Decompress failed"
        },
        login_decompressdioning = 
        {
            CN = "数据文件解压中",
			TW = "數據文件解壓中",
            EN = "Decompressing the files of data"
        },
        login_load_multi_file =
        {
            CN = "加载配置文件({0}/{1})",
			TW = "正在加載配置文件({0}/{1})",
            EN = "Load config{0}/{1}"
        },
        login_loading_script = 
        {
            CN = "正在加载脚本",
			TW = "正在加載腳本",
            EN = "Loading"
        },
        login_load_script_finish = 
        {
            CN = "加载脚本完成",
			TW = "加載腳本完成",
            EN = "Load scripts successfully"
        },
        login_networkbusy = 
        {
            CN = "网络异常",
			TW = "網路異常",
            EN = "Network doesn't work"
        },
        login_networkbusy_retry = 
        {
            CN = "无法连接服务器,是否重新尝试？",
			TW = "無法連接服務器，是否重新嘗試？",
            EN = "Connect to server failed, please try again"
        },
        jiankangzhonggao = 
        {
            CN = "抵制不良游戏  拒绝盗版游戏  注意自我保护  谨防受骗上当  适度游戏益脑  沉迷游戏伤身  合理安排时间  享受健康生活",
			TW = " ",
            EN = " "
        },
        login_local_net = 
        {
            CN = "系统检测到更新文件{0},请完成更新后进入游戏!(建议在wifi环境下进行更新)",
			TW = "系統檢測到更新文件{0}，請完成更新后進入遊戲！（建議在wifi環境下進行更新）",
            EN = "Please finish update to enter the game! ( better update in wi-fi condition)"
        },
        button_confirm = 
        {
			CN = "确定",
			TW = "確定",
			EN = "OK"
        },
        button_cancer = 
		{
			CN = "取消",
			TW = "取消",
			EN = "Cancel"
		},
		error_no_local_mainfest = 
		{
			CN = "没有发现本地的project.manifest文件,请尝试重新登陆！",
			TW = "沒有發現本地的project.manifest文件，請重試重新登錄！",
			EN = "Can not find local project.manifest file, please try to login again!"
		},
		error_parst_mainfest = 
		{
			CN = "配置文件格式错误,请尝试重新登陆！",
			TW = "配置文件格式錯誤，請嘗試重新登錄！",
			EN = "Configuration file format error, please login again!"
		},
		error_download_mainfest = 
		{
			CN = "下载配置文件失败,请尝试重新登陆！",
			TW = "下載配置文件失敗，請嘗試重新登錄！",
			EN = "Fail to download configuration file, please login again!"
		},
		failed_update = 
		{
			CN = "更新文件失败,请尝试重新登陆！",
			TW = "更新文件失敗，請嘗試重新登錄！",
			EN = "Fail to update files, please login again!",
		},
		error_update = 
		{
			CN = "连接更新服务器失败,请尝试重新登陆！",
			TW = "連接更新服務器失敗，請嘗試重新登錄！",
			EN = "Fail to connect update server, please login again!"
		},
		error_decompress =
		{
			CN = "解压文件失败,请尝试重新登陆！",
			TW = "解壓文件失敗，請嘗試重新登錄！",
			EN = "Fail to unzip files, please login again!"
		},
		login_connect_server_failed = 
		{
			CN = "登陆失败,请再次尝试,或选择其他服务器！",
			TW = "登錄失敗，請再次嘗試或選擇其他服務器！",
			EN = "Login failed, please try again, or try other server"
		},
		file_cs_TipWinControl_0 = 
		{
			CN ="确定",
			TW = "確定",
			EN = "未翻译"
		},
		file_cs_TipWinControl_1 =
		{
			CN = "取消",
			TW = "取消",
			EN = "未翻译"
		},
		file_cs_TipWinControl_2 =
		{
			CN = "充值",
			TW = "充值",
			EN = "未翻译"
		},
		login_load_file = 
	   	{
	        CN = "加载配置文件",
			TW = "加載配置文件",
	        EN = "Loading files"
      	},
      	login_script_file =
		{
			CN = "加载脚本文件",
			TW = "加載腳本文件",
			EN = "Loading script"
		},
		package_update_desc = 
		{
			CN = "游戏包需要下载更新",
			TW = "遊戲包需要下載更新",
			EN = "Loading script"
		},
		sys_tip_title_1 = 
		{
		    CN = "系统",
			TW = "系統",
		    EN = ""
	    },
	    sys_tip_msg_1 =
	    {
            CN = "资源下载失败，请重试!",
			TW = "資源下載失敗，請重新嘗試！",
            EN = ""
	    },
	    sys_tip_msg_2 = 
	    {
            CN = "您的网络不稳定，请稍后再试~",
			TW = "您的網路不穩定，請稍後再試~",
            EN = ""
	    },
	    sys_tip_msg_3 = 
	    {
            CN = "检测到启动逻辑已发生更改（重启后生效），请重启游戏！~",
			TW = "檢測到啟動邏輯已發生更改，請重啟遊戲！",
            EN = ""
	    },  
        sys_startup_msg_1 = 
	    {
            CN = "下载version文件，第{0}次",
			TW = "下載version文件，第{0}次",
            EN = ""
	    },
	    sys_startup_msg_2 = 
	    {
            CN = "访问CDN服务器，第{0}次",
			TW = "訪問CDN服務器，第{0}次",
            EN = ""
	    },
	    sys_startup_msg_3 = 
	    {
            CN = "请稍后，飞船即将踏入星空",
			TW = "請稍後，飛船即將踏入星空",
            EN = ""
	    },
	    sys_startup_cdn_error = 
	    {
            CN = "访问CDN服务器出错",
			TW = "訪問CDN服務器出錯",
            EN = ""
	    },
	    sys_startup_cdn_getAddress = 
	    {
            CN = "获得CDN地址",
			TW = "獲得CDN地址",
            EN = ""
	    },
	    sys_startup_get_cdnRes = 
	    {
            CN = "下载CDN资源",
			TW = "下載CDN資源",
            EN = ""
	    },
	    sys_startup_download_Manifest = 
	    {
            CN = "下载manifest文件, 第{0}次",
			TW = "下載manifest文件，第{0}次",
            EN = ""
	    },
	    sys_startup_download_NewestApp = 
	    {
            CN = "请前往下载最新安装包",
			TW = "請前往下載最新安裝包",
            EN = ""
	    },
        button_gotoDownLoad = 
        {
			CN = "前往下载",
			TW = "前往下載",
			EN = ""
        },
        sys_net_notWifi_tip = 
        {
			CN = "检测到您当前使用的不是wifi网络，游戏过程中可能会产生流量，建议在wifi环境下体验更好！",
			TW = "檢測到您當前使用的不是wifi網路，遊戲過程中可能會產生流量，建議在wifi環境下體驗更好！",
			EN = ""
        }
	}
}


function getLocal(key)
	if config.contents[key] == nil then
		error("error localizetion key : " .. key)
	end
	local content = config.contents[key][applicationConfig.gameConfig.language] 
	if content ~= nil then
		return content
	else
		logInfo("<color=red>语言 </color>"..applicationConfig.gameConfig.language)
		logInfo("<color=red>找不到的key==========================</color>"..key)
	end
	return key
end
