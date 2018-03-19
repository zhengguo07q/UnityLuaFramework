-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : AsyncObject.lua
--  Creator     : zg
--  Date        : 2017-1-13
--  Comment     : 异步的载入的一个组件
-- ***************************************************************


AsyncObject = BaseClass()


function AsyncObject:load(resourcePath)
    self.resourcePath = resourcePath
    AssetLoader.instance:asyncLoad(self.resourcePath, function (asset)
        self:loadCompleteCallback(asset)
    end)
end


function AsyncObject:loadCompleteCallback(asset)
    if Slua.IsNull(self.gameObject) or self.gameObject == nil then
        return
    end
    
    self.asset = asset
    self.asset:AddRef()

    GameObjectUtility.AddGameObjectPrefab(self.gameObject, self.asset.mainObject)
    if self.layer ~= nil then
        layerUtility.setLayer(self.gameObject, self.layer)
    end
    if self.delayTime ~= nil then
        local coroFunc = coroutine.create(function ()
            Yield(WaitForSeconds(self.delayTime))
            GameObjectUtility.DestroyGameObject(self.gameObject, false)
        end)
    coroutine.resume(coroFunc)
    end
end


function AsyncObject.makePrefab(resourcePath, delayTime, layer)
    local asyncObject = GameObject(resourcePath)
    local asyncObjectScript = ScriptManager.GetInstance():WrapperWindowControl(asyncObject, 'framework/loader/asyncObject')
    asyncObjectScript.delayTime = delayTime
    asyncObjectScript.layer = layer
    asyncObjectScript:load(resourcePath)
    return asyncObjectScript
end


function AsyncObject:destory()
    if self.asset == nil then
        return
    end
    self.asset:ReleaseRef()
    self.asset = nil
end


function AsyncObject:dispose()
    self:destory()
end
