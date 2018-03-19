-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : vipBuyTipsUtility.lua
--  Creator     : lxy
--  Date        : 2017-2-11
--  Comment     :
-- ***************************************************************


module("vipBuyTipsUtility", package.seeall)        

function showVipBuyTips(type)
    local nowVipLv = playerInfoBB.playerInfo.vipLevel
    local buyTimesTbl = getBuyModuleType(type)
    local vip = buyTimesTbl[vipBB.vipData.vipName]
    local times = buyTimesTbl[vipBB.vipData.timesName]

    -- 最高级
    if nowVipLv == vipBB.vipData.VipLevelMax then
        local tip = string.format(stringUtility.rejuctSymbol(L("vip_buy_02")), vip, times)
        applicationGlobal.tooltip:errorMessage(tip)
        return
    end

    if vip == nowVipLv then
        local tip = string.format(stringUtility.rejuctSymbol(L("bigsail_cishubugou")), vip, times)
        applicationGlobal.tooltip:errorMessage(tip)
    end

    applicationGlobal.alert:alertTwo(
        string.format(stringUtility.rejuctSymbol(L("vip_buy_01")), vip, times),
        function()
            if not mainUIBB.mainUIData.openRecharge then
                applicationGlobal.tooltip:errorMessage(L("vip_recharge_function_not_open"))
            else
                mallBB.currSelectPanel = mallBB.uiMallType.ustRecharge 
                WindowStack.instance:openWindow(windowResId.mallPanel, nil, false)
            end
        end
    )
end


function getBuyModuleType(type)
    if type == vipBB.buyModuleType.gold then
        return vipBB.upperVipLimitGoldInfo
    elseif type == vipBB.buyModuleType.ration then
        return vipBB.upperVipLimitRationInfo
    elseif type == vipBB.buyModuleType.bigSail then
       return vipBB.upperVipLimitBigSailInfo
    elseif type == vipBB.buyModuleType.warGodDungeon then
        return vipBB.upperVipLimitWarGodDungeonInfo
    end
end