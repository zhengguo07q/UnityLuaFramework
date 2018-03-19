-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : languageUtility.lua
--  Creator     : 
--  Date        : 
--  Comment     : 
-- ***************************************************************


module("languageUtility", package.seeall)


function getLanguageLocalizationName()
	--临时处理，修复zh版本获取不到资源的临时解决方案
	-- if applicationConfig.gameConfig.country == "zh" then
 --        return "xm" .. applicationConfig.gameConfig.language    
	-- end
    return applicationConfig.gameConfig.country .. applicationConfig.gameConfig.language    --xmCN
end



function getResourceLocalizationName()
    return getLanguageLocalizationName() .. applicationConfig.gameConfig.packageVersion  --xmCN1 , xmCN2
end


--设置语言
function setLanguage()
    local currentCountry = nil
    if PlayerPrefs.HasKey("CurrentCountry") then
    	currentCountry = PlayerPrefs.GetString("CurrentCountry")
    else
    	currentCountry = StartupManager.GetInstance().country
    end

	local currentLanguage = nil
    if PlayerPrefs.HasKey("CurrentLanguage") then
    	currentLanguage = PlayerPrefs.GetString("CurrentLanguage")
    else
		logInfo("----------- StartupManager.Instance.language :-------------"..StartupManager.GetInstance().language)
        logInfo("----------- StartupManager.Instance.languagePhone :-------------"..StartupManager.GetInstance().languagePhone)
        if checkLanguageIsContain(StartupManager.GetInstance().language) then
            currentLanguage = StartupManager.GetInstance().language
        else
            currentLanguage = getDefautLanguage(StartupManager.GetInstance().languagePhone)
        end
    end

    local currentPackageVersion = StartupManager.GetInstance().packageVersion
    logInfo("=============当前选择语言：============ "..currentCountry..currentLanguage)

    PlayerPrefs.SetString("CurrentCountry", currentCountry)
    PlayerPrefs.SetString("CurrentLanguage", currentLanguage)

    local options = {language = currentLanguage, country = currentCountry, packageVersion = currentPackageVersion}
    syntaxUtility.mergeTable(applicationConfig.gameConfig, options)
end


-- 检查sdk中设置的语言类型是否在包体中
function checkLanguageIsContain(language)
    local result = false
    for k, v in pairs(applicationConfig.languageContryConfig) do
        if language == v then
            result = true
            break
        end
    end
    return result
end


-- 根据手机设置，返回语言类型
function getDefautLanguage(languagePhone)
    local result = nil
    for k, v in pairs(applicationConfig.languageContryConfig) do
        if k == languagePhone then
            result = v
            break
        end
    end
    return result
end