-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : windowContentEffectUtility.lua
--  Creator     : linyongqing
--  Date        : 2017-9-5
--  Comment     : 窗口内容特效工具
-- ***************************************************************


module("windowContentEffectUtility", package.seeall)      


-- 左标签动画
function addLeftTabsAnimation(tabs, offset)
	for _, tab in pairs(tabs) do
		local position  = tab.transform.localPosition
		GameObjectUtility.LocalPosition(tab, position.x - offset, position.y, position.z)
	end
	
	local co = coroutine.create(function ()
		for i, tab in pairs(tabs) do
			Yield(WaitForSeconds(0.05))
			if Slua.IsNull(tab) then
				break
			end
			local position  = tab.transform.localPosition
			LeanTween.moveLocal(tab, Vector3(position.x + offset, position.y, position.z), 0.15)
		end
	end)

	coroutine.resume(co)
end


-- 右侧依次进入画面动画
function addRightTabsAnimation(tabs, offset)
	for _, tab in pairs(tabs) do
		local position  = tab.transform.localPosition
		GameObjectUtility.LocalPosition(tab, position.x + offset, position.y, position.z)
	end

	local co = coroutine.create(function ()
		for i, tab in pairs(tabs) do
			Yield(WaitForSeconds(0.05))
			local position  = tab.transform.localPosition
			LeanTween.moveLocal(tab, Vector3(position.x - offset, position.y, position.z), 0.15)
		end
	end)

	coroutine.resume(co)
end


-- 从下到上
function addDownToUpAnim(go, offset)
	local position = go.transform.localPosition
	GameObjectUtility.LocalPosition(go, position.x, position.y - offset, position.z)
	local co = coroutine.create(function ()
		Yield(WaitForSeconds(0.1))
		LeanTween.moveLocal(go, Vector3(position.x, position.y, position.z), 0.1)
	end)
	coroutine.resume(co)
end


-- 从上到下
function addTopToDownAnim(go, offset)
	local position = go.transform.localPosition
	GameObjectUtility.LocalPosition(go, position.x, position.y + offset, position.z)
	local co = coroutine.create(function ()
		Yield(WaitForSeconds(0.1))
		LeanTween.moveLocal(go, Vector3(position.x, position.y, position.z), 0.1)
	end)
	coroutine.resume(co)
end


-- 从右到左的动画
function addRightToLeftAnim(go, offset, time)
	if time == nil then time = 0.1 end
	local position = go.transform.localPosition
	GameObjectUtility.LocalPosition(go, position.x + offset, position.y, position.z)
	local co = coroutine.create(function ()
		Yield(WaitForSeconds(0.1))
		LeanTween.moveLocal(go, Vector3(position.x, position.y, position.z), time)
	end)
	coroutine.resume(co)
end


-- 从左到右的动画
function addLeftToRightAnim(go, offset, time)
	if time == nil then time = 0.1 end
	local position = go.transform.localPosition
	GameObjectUtility.LocalPosition(go, position.x - offset, position.y, position.z)
	local co = coroutine.create(function ()
		Yield(WaitForSeconds(0.1))
		LeanTween.moveLocal(go, Vector3(position.x, position.y, position.z), time)
	end)
	coroutine.resume(co)
end


function addLeftToButtonAnim(go, offset)
	local position = go.transform.localPosition
	GameObjectUtility.LocalPosition(go, position.x - offset, position.y, position.z)
	local co = coroutine.create(function ()
		Yield(WaitForSeconds(0.1))
		LeanTween.moveLocal(go, Vector3(position.x, position.y, position.z), 0.10)
	end)
	coroutine.resume(co)
end


--移除Item特效
function addRemoveItemAnim(goRoot, goItem, goEffectRoot, callFun)
	--保存数据的节点
	--localPosition.x 是否锁住，大于0锁住
	--localPosition.y 是否在播放动画，大于0在播放
	--localPosition.z 上一次移除的时间
	local goDataRoot = GameObjectUtility.Find("_addRemoveItemAnim_DATA_" .. goRoot:GetInstanceID(), goRoot.transform.parent.gameObject)
	if goDataRoot == nil then
		goDataRoot = GameObject("_addRemoveItemAnim_DATA_" .. goRoot:GetInstanceID())
		GameObjectUtility.SetParent(goDataRoot, goRoot.transform.parent.gameObject, false)
		goDataRoot.transform.localPosition = goRoot.transform.localPosition

		local data1 = GameObject("Data1")
		GameObjectUtility.SetParent(data1, goDataRoot, false)
	end
	local goData1 = GameObjectUtility.Find("Data1", goDataRoot)

	local goEffect = nil

	local continueRemoveTime = 0.4 								--可持续移除时间
	local isLock = goData1.transform.localPosition.x > 0		--是否锁住，当播放上移，锁住
	local isAnim = goData1.transform.localPosition.y > 0		--是否在播放动画
	local itemDis = 0 											--每个Item的距离

	local completeCall = function() 
		if callFun ~= nil then
			callFun()
		end

		GameObject.Destroy(goDataRoot)
	end

	if isLock then
		return false
	end

	--计算Item距离
	local allItemY = {}
	for i = 0, goRoot.transform.childCount - 1 do
		table.insert(allItemY, goRoot.transform:GetChild(i).localPosition.y)
    end
    table.sort(allItemY)
    if #allItemY >= 2 then
    	itemDis = math.abs(allItemY[1] - allItemY[2])
    end

	--播放特效
	local cor = coroutine.create(function()
		--设置数据
		GameObjectUtility.LocalPosition(goData1, goData1.transform.localPosition.x, 1, goData1.transform.localPosition.z)
		GameObjectUtility.LocalPosition(goData1, goData1.transform.localPosition.x, goData1.transform.localPosition.y, Time.time)

		goEffect = GameObjectUtility.Find("Effect/UI/ui_tongyong_kuang", goEffectRoot)
		if goEffect == nil then
			goEffect = AsyncObject.makePrefab("Effect/UI/ui_tongyong_kuang").gameObject
			GameObjectUtility.AddGameObject(goEffectRoot, goEffect)	
		end
		goEffect.gameObject:SetActive(true)
        Yield(WaitForSeconds(0.3))   

		--播放移除item的动画
		local position1 = goItem.transform.localPosition
		LeanTween.moveLocal(goItem, Vector3(position1.x + 2000, position1.y, position1.z), 0.3)
		local moveDis = 500 		--0.1秒移动的阈值

        Yield(WaitForSeconds(0.1))
		goEffect.gameObject:SetActive(false) 

		--播放其他节点移上来
		local lastRemoveTime = goData1.transform.localPosition.z  --上一次移除的时间
		if Time.time - lastRemoveTime > continueRemoveTime then
			--锁住
			GameObjectUtility.LocalPosition(goData1, 1, goData1.transform.localPosition.y, goData1.transform.localPosition.z)

			--播放其他item位移上来
			for i = 0, goRoot.transform.childCount - 1 do
		        local go = goRoot.transform:GetChild(i).gameObject
				local position2 = go.transform.localPosition

				local removeItemCount = 0
				--计算这个Item上有多少个Item移除了
				for j = 0, goRoot.transform.childCount - 1 do
			        local go2 = goRoot.transform:GetChild(j).gameObject
			        if go2.transform.localPosition.x > moveDis and go2.transform.localPosition.y > position2.y then
			        	removeItemCount = removeItemCount + 1
			        end
			    end

				if removeItemCount ~= 0 and position2.x < moveDis then
					LeanTween.moveLocal(go, Vector3(position2.x, position2.y + removeItemCount * itemDis, position2.z), 0.2)
				end
		    end 	

        	Yield(WaitForSeconds(0.25)) 

			completeCall()
		end
    end)
    coroutine.resume(cor)

	return true
end


--道具获得动画
function addItemEffectAnim(abPath, parentGo, startPosi, endPosi, effectCount)
	effectCount = effectCount == nil and 10 or effectCount

	local goName = "ItemEffect" .. string.gsub(abPath, "/", "-")

	--总节点
	local effectRoot = GameObjectUtility.Find(goName, parentGo)
	--每个特效节点
	local effectChildGo = {}

	--生成总节点
	if effectRoot == nil then
		effectRoot = GameObject(goName)
		GameObjectUtility.SetParent(effectRoot, parentGo, false)
	end

	--显示缓存节点
	local effectIndex = 0
	effectRoot:SetActive(true)
	for i = 0, effectRoot.transform.childCount-1 do 
		local go = effectRoot.transform:GetChild(i).gameObject

		if go.activeSelf == false and effectIndex < effectCount then
			effectIndex = effectIndex + 1
			go:SetActive(true)
			table.insert(effectChildGo, go)
		end
	end

	--缓存不够，生成新节点
	for i=effectIndex+1, effectCount do
		local go = AsyncObject.makePrefab(abPath).gameObject
		GameObjectUtility.SetParent(go, effectRoot, false)
		table.insert(effectChildGo, go)
	end

	--显示特效
	layerUtility.setLayer(effectRoot, parentGo.layer)
	for i=1, #effectChildGo do
		local go = effectChildGo[i]

		local vecPosi = Vector3(math.random(-20, 20), math.random(-10, 10), 0)
		vecPosi = startPosi + (vecPosi * 0.01)
		GameObjectUtility.Position(go, vecPosi.x, vecPosi.y, vecPosi.z)

		local co = coroutine.create(function ()
			Yield(WaitForSeconds(Mathf.Clamp(math.random(2, i+2), 2, 10) * 0.1))
			local moveTime = math.random(2, 5) * 0.1
			LeanTween.move(go, endPosi, moveTime)

			Yield(WaitForSeconds(moveTime + 0.1))
			if not Slua.IsNull(go) then
				go:SetActive(false)
			end
		end)
		coroutine.resume(co)
	end
end


--添加Item动画渐变
function addItemAnimRamp(goRoot, goItem, goEffectRoot, callFun)
	local svPanel = GameObjectUtility.FindInParent(goItem, "UIScrollView")

	if svPanel ~= nil then
		svPanel.enabled = false
	end

	local co = coroutine.create(function ()
		--Item特效
		local goEffect = GameObjectUtility.Find("Effect/UI/ui_tongyong_kuang", goEffectRoot)
		if goEffect == nil then
			goEffect = AsyncObject.makePrefab("Effect/UI/ui_tongyong_kuang").gameObject
			GameObjectUtility.AddGameObject(goEffectRoot, goEffect)
		end
		goEffect.gameObject:SetActive(true)
	--	Yield(WaitForSeconds(0.1))
	--	goEffect.transform.parent = goRoot.transform.parent
		Yield(WaitForSeconds(1))
		GameObjectUtility.DestroyGameObject(goEffect, false)
	end)
	coroutine.resume(co)

	local co = coroutine.create(function ()
		Yield(WaitForSeconds(0.3))
		if callFun ~= nil then
			callFun()
		end

		local allChild = GameObjectUtility.GetChildGameObject(goRoot)
		table.sort( allChild, function(a1, a2) return a1.transform.localPosition.y > a2.transform.localPosition.y end )

		local isAnim = false
		for i=1, #allChild do
			local wid = GameObjectUtility.GetIfNotAdd(allChild[i], "UIWidget")
			if wid.alpha ~= 1 then
				isAnim = true
			end
		end

		if isAnim == false then
			for i=1, #allChild do
				local go = allChild[i]

				local wid = GameObjectUtility.GetIfNotAdd(go, "UIWidget")
				local tw1Anim = GameObjectUtility.GetIfNotAdd(go, "TweenAlpha")
				tw1Anim.duration = 0.5
				tw1Anim.delay = (i-1) * 0.1
				tw1Anim.from = allChild[i]:GetInstanceID() == goItem:GetInstanceID() and 0.8 or 0
				tw1Anim.to = 1
				tw1Anim:ResetToBeginning()
				tw1Anim:PlayForward()

				local tw2Anim = GameObjectUtility.GetIfNotAdd(go, "TweenScale")
				tw2Anim.duration = 0.2
				tw2Anim.delay = (i-1) * 0.1 + 0.05
				tw2Anim.from = allChild[i]:GetInstanceID() == goItem:GetInstanceID() and Vector3(1, 1, 1) or Vector3(1.015, 1.015, 1)
				tw2Anim.to = Vector3(1, 1, 1)
				tw2Anim:ResetToBeginning()
				tw2Anim:PlayForward()
			end
		end

		Yield(WaitForSeconds(0.5))
		if svPanel ~= nil then
			svPanel.enabled = true
		end
	end)
	coroutine.resume(co)
end