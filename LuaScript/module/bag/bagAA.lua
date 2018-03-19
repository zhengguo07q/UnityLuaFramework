-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: bagAA.lua
--  Creator 	: panyuhuan
--  Date		: 2017-1-14
--  Comment		: 后端背包数据回调
-- ***************************************************************


module("bagAA", package.seeall)


-- 返回背包信息
NetClient.Add(20231002, function(data)
	if data.status == 0 then
		bagBB.getBagData()

		-- 添加红点
        mainUIBB.setFunctionRed(mainUIBB.enumSpriteHint.Bag, bagBB.getRedByType(-1))
	else
		applicationGlobal.tooltip:errorMessage(errorInfo.getInfo(data.status))
	end
end)


-- 更新道具数量推送
NetClient.Add(20231003, function(data)
	-- print("-----------------------------------更新道具数量推送-----------------------------------------")
	-- print_t(data)
	if data.status == 0 then
		-- local currScene = applicationGlobal.sceneSwitchManager.currentSceneInstance
	 --    if currScene ~= nil and isSuper(currScene, MainUiInstance) and currScene.guideNewLayer ~= nil then
	 --        currScene.guideNewLayer:updateItemNum(data.itemId)   -- 引导
	 --    end

	 	bagBB.updateBagItem(data)
		-- local itemData = bagBB.updateBagItem(data) -- 更新数据
		-- if itemData ~= nil then
		-- 	local newItemData = {}
		-- 	newItemData.id = itemData.itemModelId
		-- 	newItemData.count = data.delta
		-- 	CommonAwardPopupWindow.instance:showNewItem(newItemData)
		-- end
		local bagPanel = WindowStack.instance:getWindow(windowResId.bagPanel)
        if bagPanel ~= nil and bagPanel.window.isShow then
           bagPanel:updateItemNum(data)
        end
	else
		applicationGlobal.tooltip:errorMessage(errorInfo.getInfo(data.status))
	end
end)


-- 新增道具推送
NetClient.Add(20231004, function(data)
	-- print("-------------------------------新增道具推送----------------------------")
	-- print_t(data)
	if data.status == 0 then
		bagBB.addNewItem(data)

		-- local newItemData = {}
		-- newItemData.id 	  = data.itemModelId
		-- newItemData.count = data.numb
		-- CommonAwardPopupWindow.instance:showNewItem(newItemData)

		local bagPanel = WindowStack.instance:getWindow(windowResId.bagPanel)
        if bagPanel ~= nil and bagPanel.window.isShow then
           bagPanel:addNewItem(data)
        end

     --    local currScene = applicationGlobal.sceneSwitchManager.currentSceneInstance
	    -- if currScene ~= nil and isSuper(currScene, MainUiInstance) and currScene.guideNewLayer ~= nil then
	    --     currScene.guideNewLayer:addItem(nil)   -- 引导
	    -- end

        -- 添加红点
        mainUIBB.setFunctionRed(mainUIBB.enumSpriteHint.Bag, bagBB.getRedByType(-1))

        --create by liyang 2017-4-14，新增道具检测将军府红点
        -- mainUIBB.setFunctionRed(mainUIBB.enumSpriteHint.General, strategosBB.checkAllRedTip())
        local sceneInstance = applicationGlobal.sceneSwitchManager.currentSceneInstance
		if sceneInstance ~= nil and isSuper(sceneInstance, MainUiInstance) and sceneInstance.mainUILayer ~= nil then	
			if sceneInstance.mainUILayer.mainUIButton ~= nil then 
				sceneInstance.mainUILayer.mainUIButton:setRedHint("captain", strategosBB.checkAllRedTip())
			end
		end 
        
        -- 添加阵法红点 by lxy 2017-5-16	
		mainUIBB.setFunctionRed(mainUIBB.enumSpriteHint.StoneMatrix, stoneMatrixBB.checkRedTips())
	else
		applicationGlobal.tooltip:errorMessage(errorInfo.getInfo(data.status))
	end
end)


-- 删除道具推送
NetClient.Add(20231005, function(data)
	if data.status == 0 then
		bagBB.removeItemData(data)
		local bagPanel = WindowStack.instance:getWindow(windowResId.bagPanel)
        if bagPanel ~= nil and bagPanel.window.isShow then
           bagPanel:removeItem(data)
        end

        -- 添加红点
        mainUIBB.setFunctionRed(mainUIBB.enumSpriteHint.Bag, bagBB.getRedByType(-1))

         -- 添加阵法红点 by lxy 2017-5-16	
		mainUIBB.setFunctionRed(mainUIBB.enumSpriteHint.StoneMatrix, stoneMatrixBB.checkRedTips())
	else
		applicationGlobal.tooltip:errorMessage(errorInfo.getInfo(data.status))
	end
end)


-- 出售道具返回
NetClient.Add(20231009, function(data)
	if data.status == 0 then
		local bagPanel = WindowStack.instance:getWindow(windowResId.bagPanel)
        if bagPanel ~= nil and bagPanel.window.isShow then
           bagPanel:sellOrUseCallBack(data.itemId, 1)
        end

        local bagHandlerPanel = WindowStack.instance:getWindow(windowResId.bagHandlerPanel)
        if bagHandlerPanel ~= nil and bagHandlerPanel.window.isShow then
           bagHandlerPanel:sellCallBack()
        end
	else
		applicationGlobal.tooltip:errorMessage(errorInfo.getInfo(data.status))
	end
end)


-- 道具使用返回
NetClient.Add(20231011, function(data)
	if data.status == 0 then
		local bagPanel = WindowStack.instance:getWindow(windowResId.bagPanel)
        if bagPanel ~= nil and bagPanel.window.isShow then
           bagPanel:sellOrUseCallBack(data.itemId, 2)
        end

        local noPowerTipPanel = WindowStack.instance:getWindow(windowResId.noPowerTipPanel)
        if noPowerTipPanel ~= nil and noPowerTipPanel.window.isShow then
           noPowerTipPanel:useItemCallBack()
        end

        local bagHandlerPanel = WindowStack.instance:getWindow(windowResId.bagHandlerPanel)
        if bagHandlerPanel ~= nil and bagHandlerPanel.window.isShow then
           bagHandlerPanel:useCallBack()
        end
	else
		applicationGlobal.tooltip:errorMessage(errorInfo.getInfo(data.status))
	end
end)