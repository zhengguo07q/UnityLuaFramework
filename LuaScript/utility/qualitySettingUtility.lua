-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : qualitySettingUtility.lua
--  Creator     : 
--  Date        : 
--  Comment     : 
-- ***************************************************************


module("qualitySettingUtility", package.seeall)


function setBaseQuality()
    QualitySettings.antiAliasing            = 4
    QualitySettings.vSyncCount              = 0
    QualitySettings.anisotropicFiltering    = AnisotropicFiltering.Disable
    Application.targetFrameRate             = 30
end


function setAntiAliasing(val)
    QualitySettings.antiAliasing            = val
end