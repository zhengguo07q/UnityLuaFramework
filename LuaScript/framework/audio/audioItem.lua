-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: audioItem.lua
--  Creator 	: zg
--  Date		: 2016-12-17
--  Comment		: 
-- ***************************************************************


AudioItem = BaseClass()


function AudioItem:initialize(audioData)
	self.audioData = audioData
	self:initAudio()
end


--播放
function AudioItem:initAudio()
	local audioAsset = applicationGlobal.audioPlay:getAudioAsset(self.audioData.id .. '')
	if audioAsset == nil then
		AssetLoader.instance:asyncLoad("Audio/" .. self.audioData.id, function(asset)
			applicationGlobal.audioPlay:addAudioAsset(self.audioData.id .. '', asset)
			self:loadResoureFinish(asset)
		end)
	else
		self:loadResoureFinish(audioAsset)
	end
end


function AudioItem:loadResoureFinish(asset)
	if self.destroy == true then return end
	self.audioSource = self.gameObject:AddComponent(AudioSource)
	self.audioSource.clip = asset.mainObject

	if self.audioData.isBackground == 0 then
		self.audioSource.volume = applicationGlobal.audioPlay.otherVolume * self.audioData.volume
	else
		self.audioSource.volume = applicationGlobal.audioPlay.bgMusicVolume * self.audioData.volume
	end
	
	self.audioSource.loop = syntaxUtility.getTrueOrFalse(self.audioData.loop)
	self.audioSource:Play()
	if not syntaxUtility.getTrueOrFalse(self.audioData.isBackground) then
		self.releaseTime = LuaTimer.Add(self.audioSource.clip.length * 1000, 0, function()
			applicationGlobal.audioPlay:releaseAudioItem(self.audioData.id .. '', self)
			LuaTimer.Delete(self.releaseTime)
			self.releaseTime = nil
			return false
		end)
	end
end


function AudioItem:playAudio()
	if self.audioSource ~= nil then
		self.audioSource:Play()

		if not syntaxUtility.getTrueOrFalse(self.audioData.isBackground) then
			if self.releaseTime ~= nil then
				LuaTimer.Delete(self.releaseTime)
				self.releaseTime = nil
			end
			self.releaseTime = LuaTimer.Add(self.audioSource.clip.length * 1000, 0, function()
				applicationGlobal.audioPlay:releaseAudioItem(self.audioData.id .. '', self)
				LuaTimer.Delete(self.releaseTime)
				self.releaseTime = nil
				return false
			end)
		end
	end
end


function AudioItem:isBgMusic()
	 if self.audioData.isBackground == 0 then 
		return false
	 else
		return true
	 end
end


function AudioItem:setVolume(value)
	if self.audioSource ~= nil then
		self.audioSource.volume = value * self.audioData.volume
	end
end


function AudioItem:onDestroy()
	self.destroy = true
	if self.releaseTime ~= nil then
		LuaTimer.Delete(self.releaseTime)
		self.releaseTime = nil
	end
end
