-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: windowCamera.lua
--  Creator     : xujianlong
--  Date        : 2018/1/15
--  Comment	    : 管理UI摄像机
-- ***************************************************************


WindowCamera = BaseClass()


function WindowCamera:initialize()
	local uiRoot = GameObject.Find("UI Root")
    self.uiCamera = GameObjectUtility.FindAndGet("Camera", uiRoot, "UnityEngine.Camera,UnityEngine")
    self.cameraShock = CameraShock.new()
    self.cameraShock:initialize()
    self.cameraShock:initCamera(self.uiCamera.transform)
end


function WindowCamera:getUICamera()
	return self.uiCamera
end


function WindowCamera:update()
    if self.cameraShock ~= nil then
        self.cameraShock:shockUpdate()
    end
end


--震屏
function WindowCamera:onShockScreen(mode, time, x, y, z)
	if self.cameraShock ~= nil then
        self.cameraShock:onShock(mode, time, x, y, z)
    end
end


function WindowCamera:dispose()
	self.cameraShock:dispose()
	self.cameraShock = nil

    self.delete(self)
end


WindowCamera.instance = WindowCamera.new()