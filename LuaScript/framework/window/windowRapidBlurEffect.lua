-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : windowRapidBlurEffect.lua
--  Creator     : sf
--  Date        : 2017-10-25
--  Comment     : 毛玻璃
-- ***************************************************************


WindowRapidBlurEffect = BaseClass()


function WindowRapidBlurEffect:initData()
    self.init = false 
    self.commandBuffer = nil
    self.material = nil 
    self.copyTexId = nil
    self.tempTexID = nil 
    self.shaderName = "Yeto/UI/Rapid Blur"
    self.downSampleNum = 2
    self.blurSpreadSize = 2
    self.blurIterations = 3
    self.show = false
end


function WindowRapidBlurEffect:enableRapidBlurEffect()
    if self.init == nil or not self.init then 
        self:initData()
        self.init = true
    end 
    if self.show then 
        return 
    end 

    self.show = true
    self.material = nil 
    self.material = Material(shaderUtility.getShader(self.shaderName))
    self.material:SetFloat("_AntiAliasing", QualitySettings.antiAliasing)
    
    self.commandBuffer = Rendering.CommandBuffer()
    self.commandBuffer.name = "RapidBlurEffect"

    self.srcTex     = Shader.PropertyToID("srcTex")
    self.commandBuffer:GetTemporaryRT(self.srcTex,     -1, -1, 0, FilterMode.Bilinear)
    self.tempTexId1 = Shader.PropertyToID("tempTex1")
    self.commandBuffer:GetTemporaryRT(self.tempTexId1, -3, -3, 0, FilterMode.Bilinear)
    self.tempTexId2 = Shader.PropertyToID("tempTex2");
    self.commandBuffer:GetTemporaryRT(self.tempTexId2, -3, -3, 0, FilterMode.Bilinear)

    self.commandBuffer:Blit(SLuaSupportUtility.RenderTargetIdentifier(1, Rendering.BuiltinRenderTextureType.CurrentActive), SLuaSupportUtility.RenderTargetIdentifier(2, self.srcTex)) 
    self.commandBuffer:Blit(SLuaSupportUtility.RenderTargetIdentifier(2, self.srcTex), SLuaSupportUtility.RenderTargetIdentifier(2, self.tempTexId1), self.material, 0) 
    
    for i = 0, self.blurIterations - 1 do
        local iterationOffs = i * 1.0
        self.material:SetFloat("_DownSampleValue", self.blurSpreadSize * (1.0 / (1.0 * 4)) + iterationOffs)

        self.commandBuffer:Blit(SLuaSupportUtility.RenderTargetIdentifier(2, self.tempTexId1), SLuaSupportUtility.RenderTargetIdentifier(2, self.tempTexId2), self.material, 1)
        self.commandBuffer:Blit(SLuaSupportUtility.RenderTargetIdentifier(2, self.tempTexId2), SLuaSupportUtility.RenderTargetIdentifier(2, self.tempTexId1), self.material, 2)
    end

    self.commandBuffer:Blit(SLuaSupportUtility.RenderTargetIdentifier(2, self.tempTexId1), SLuaSupportUtility.RenderTargetIdentifier(1, Rendering.BuiltinRenderTextureType.CameraTarget))
    local camera = self.gameObject:GetComponent(Camera)
    camera:AddCommandBuffer(Rendering.CameraEvent.AfterForwardAlpha, self.commandBuffer)
end 


function WindowRapidBlurEffect:disableRapidBlurEffect()
    if not self.show then 
        return 
    end 
    
    self.show = false
    local camera2 = self.gameObject:GetComponent(Camera)
    if self.commandBuffer ~= nil then 
        self.commandBuffer:ReleaseTemporaryRT(self.srcTex)
        self.commandBuffer:ReleaseTemporaryRT(self.tempTexId1)
        self.commandBuffer:ReleaseTemporaryRT(self.tempTexId2)
        camera2:RemoveCommandBuffer(Rendering.CameraEvent.AfterForwardAlpha, self.commandBuffer)
    --camera2:RemoveAllCommandBuffers()
        self.commandBuffer:Clear()
    end 

      --self.material


end 