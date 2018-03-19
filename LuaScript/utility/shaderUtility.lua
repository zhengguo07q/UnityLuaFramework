-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : shaderUtility.lua
--  Creator     : zg
--  Date        : 2016-12-27
--  Comment     : 
-- ***************************************************************


module("shaderUtility", package.seeall)


shaderRef = nil
allShader = {}


function loadShader(callback)
    AssetLoader.instance:asyncLoad("Script/graphics", function (asset)
        loadShaderComplete(asset) 
        callback() 
   end)
end


function loadShaderComplete(asset)
    shaderRef = asset
    shaderRef:AddRef()
    local shaderVariantCollection = shaderRef.mainObject
    if shaderVariantCollection ~= nil then
        shaderVariantCollection:WarmUp()
    end

    local assets = shaderRef.assetBundle:LoadAllAssets()
    for i=1,#assets do
        allShader[assets[i].name] = assets[i]
    end

    -- print("打印allShader所有。。。。。。。。。。。。。。。。。。")
    -- print_t(allShader)
end


function getShader(shaderName)
    if applicationConfig.macro.UNITY_EDITOR then
        return Shader.Find(shaderName)
    else
        local shader = allShader[shaderName]
        if shader == nil then
            -- logInfo("allShader缓存中找不到指定的shader:    "..shaderName)
            shader = Shader.Find(shaderName)
        end
        if shader == nil then
            -- logInfo("Shader.Find也找不到指定的shader:    "..shaderName)
            shader = shaderRef.assetBundle:LoadAsset(shaderName)
        end
        if shader == nil then
            logInfo("shaderRef.assetBundle:LoadAsset也找不到指定的shader:    "..shaderName)
        end
        return shader
    end
end


--重新赋上shader 仅编辑器生效
function resetShader(gameObject)
    if not applicationConfig.macro.UNITY_EDITOR then
        return 
    end
    if gameObject == nil then
        return
    end

    local renderers = GameObjectUtility.GetComponentsInChildren(gameObject, "UnityEngine.Renderer,UnityEngine", true)
    for i=1, #renderers do
        local renderer = renderers[i]
        if renderer.sharedMaterials ~= nil and #renderer.sharedMaterials > 0 then
            for i = 1, #renderer.sharedMaterials do
                if renderer.sharedMaterials[i] ~= nil then
                     renderer.sharedMaterials[i].shader = Shader.Find(renderer.sharedMaterials[i].shader.name)
                end
            end   
        end
    end

    local particleRenderers = GameObjectUtility.GetComponentsInChildren(gameObject, "UnityEngine.ParticleSystemRenderer,UnityEngine", true)
    for i = 1, #particleRenderers do
        local particleRenderer = particleRenderers[i]
        if particleRenderer.sharedMaterials ~= nil and #particleRenderer.sharedMaterials > 0 then
            for i = 1, #particleRenderer.sharedMaterials do
                if particleRenderer.sharedMaterials[i] ~= nil then
                    particleRenderer.sharedMaterials[i].shader = Shader.Find(particleRenderer.sharedMaterials[i].shader.name)
                end
            end
        end
    end

    local meshRenders = GameObjectUtility.GetComponentsInChildren(gameObject, "UnityEngine.MeshRenderer,UnityEngine", true)
    for i = 1, #meshRenders do
        local meshRenderer = meshRenders[i]
        if meshRenderer.sharedMaterials ~= nil and #meshRenderer.sharedMaterials > 0 then
            for i = 1, #meshRenderer.sharedMaterials do
                if meshRenderer.sharedMaterials[i] ~= nil then
                    meshRenderer.sharedMaterials[i].shader = Shader.Find(meshRenderer.sharedMaterials[i].shader.name)
                end 
            end
        end
    end
end