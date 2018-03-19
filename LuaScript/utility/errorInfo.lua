-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: errorInfo.lua
--  Creator 	: panyuhuan
--  Date		: 2017-4-1
--  Comment		: 后端协议回调，错误码提示
-- ***************************************************************


module("errorInfo", package.seeall)


function getInfo(errorCoderId)
	print("errorID", errorCoderId)
	for k,v in pairs(conf.errorCode) do
		if v.code == errorCoderId then
			if errorCoderId == 7 then -- 体力不足
				local currScene = applicationGlobal.sceneSwitchManager.currentSceneInstance
				if currScene ~= nil and (isSuper(currScene, MainUiInstance) or isSuper(currScene, UniverseInstance)) then
					CommonUITop.instance.prefabInstance:noPowerToBuy()
				end
				return ''
			elseif errorCoderId == 11 then
				applicationGlobal.alert:alertTwo(L("common_titel_2"), L("common_tishi_2"),
					function ()
						if not mainUIBB.mainUIData.openRecharge then    --充值是否开放的判断 默认开放
							applicationGlobal.tooltip:errorMessage(L("vip_recharge_function_not_open"))
						else
						mallBB.currSelectPanel = mallBB.uiMallType.ustRecharge 
						WindowStack.instance:openWindow(windowResId.mallPanel, nil, false)
						local mallPanel = WindowStack.instance:getWindow(windowResId.mallPanel)
						if mallPanel ~= nil and mallPanel.window.isShow then
							mallPanel:openCurrClickPanel(true)
						end
						end
					end,
					nil,
					L("common_button_1"), L("common_button_2")
			    )

			    return ''
			elseif errorCoderId == 12 then
				print("<color=red>============= errorCoderId == 12 ================== </color>") --金币不足
				applicationGlobal.alert:alertTwo(L("common_titel_3"), L("common_tishi_3"),
					function ()
						-- shopBB.openShopUI(shopBB.uiShopType.ustGold)
						mallBB.currSelectPanel = mallBB.uiMallType.ustGold
						WindowStack.instance:openWindow(windowResId.mallPanel, nil, false)
					end
			    )

			    return ''
			end

			return L(v.tip)
		end
	end

	return "unknown status "
end