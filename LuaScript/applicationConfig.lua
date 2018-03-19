-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : applicationConfig.lua
--  Creator     : zg
--  Date        : 2016-11-10
--  Comment     : 配置信息
-- ***************************************************************


module("applicationConfig", package.seeall)


-- 包体中包含了的语言-国家配置,
languageContryConfig = 
{
    -- k是组合键:语言地区码
    -- v是程序定义的   
    zh_CN              = "CN",    -- 中文简体
    zh_TW              = "TW",    -- 中文繁体(新马地区)
    --en              = "en",    -- 英语
}


macro = 
{
    UNITY_IOS           = false,
    UNITY_ANDROID       = false,
    UNITY_EDITOR        = false,
}


gameConfig =
{
    persistentDataPath      = "",
    sdcardPath              = "",
    packageName             = "",
    gameId                  = 102,
    sdkid                   = 1000,
    channelId               = 0, -- 0 内网渠道   1 外网渠道
    macAddress              = "",
    serverCdnUrl            = "http://api.sdk.yetogame.com/gamenew.php",        --获取网络上配置的CDN地址
    -- serverCdnUrl            = "http://api.yetogame.com:81/gamenew.php",        --获取网络上配置的CDN地址
     cdnUrl                  = "http://172.16.4.17:8800/",
   -- cdnUrl                  = "http://cdn.yetogame.com/t2_dev_release/",
 --   serverListUrl           = "http://api.sdk.yetogame.com/gamenew.php",       --选服列表
    serverListUrl           = "http://sdkt2.yetogame.com/gamenew.php",       --选服列表
    serverErrorUrl          = "http://monitor.yetogame.com/?action=api.Exceptlog!record",
    videoUploadUrl          = "http://video.yetogame.com/?action=api.replay!uploadReplay", -- 录像上传url
    videoDownloadUrl        = "http://video.yetogame.com/?action=api.replay!downloadReplay&id=", -- 录像下载url
    videoGetListUrl         = "http://video.yetogame.com/?action=api.replay!replayList&playerId=", -- 录像列表url
    appVersion              = "1.0",
    zoneTime                = 8,         -- 时区
    isDebug                 = true,         
    language                = "CN",
    country                 = "xm",
    languagePhone           = "zh-CN",
    packageVersion          = "1",
    voiceAppId              = "1404126435",
    voiceAppKey             = "5f9fcb57fc8f51e43a62b3bedeb7bfd8",
    voiceServerUrl          = "udp://cn.voice.gcloudcs.com:10001",
    rechargePlatform        = 0
}


loginConfig =
{
    uid                     = "",
    access_token            = "",
    zoneid                  = ""
}

