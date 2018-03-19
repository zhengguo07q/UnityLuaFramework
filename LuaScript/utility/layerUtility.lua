-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : layerUtility.lua
--  Creator     : zg
--  Date        : 2017-1-7
--  Comment     : 
-- ***************************************************************


module("layerUtility", package.seeall)


function setLayer(gameobject, layer)
    gameobject.layer = layer
    local trans = gameobject.transform

    for i=1, trans.childCount do
        local child = trans:GetChild(i-1)
        setLayer(child.gameObject, layer)
    end
end
