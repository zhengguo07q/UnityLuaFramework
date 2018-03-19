-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: audioPlay.lua
--  Creator 	: zg
--  Date		: 2016-12-16
--  Comment		: 
-- ***************************************************************


AudioPlay = BaseClass()


function AudioPlay:initialize()
	self.allAudioList  = {}
	self.audioCache    = {}
	self.audioAsset    = {}
	self.audioKeyIndex = 0
	self.currBgMusic   = nil
	self.lastBgMusic   = nil
	self.guideAudioId  = nil
	self.bgMusicVolume = PlayerPrefs.GetFloat("bgMusicvolume", 0.5)
	self.otherVolume   = PlayerPrefs.GetFloat("otherVolume", 0.5)

	self.gameObject:AddComponent(AudioListener)
end


--允许播放
function AudioPlay:allowSound()
	self.allowPlay = true
end


--禁止声音
function AudioPlay:forbidSound()
	self.allowPlay = false
	self.stopAllAudio()
end


--播放一个声音片段
function AudioPlay:playAudio(key)
	if type(key) ~= "string" or self.allowPlay == false then return end
	if data.audio == nil then return end
	local audioData = data.audio[key]
	if audioData == nil then return end
	local aduioItem = self:getAudioItem(key)
	aduioItem:playAudio()
end


function AudioPlay:getAudioItem(key)
	local audioItem = nil
	if self.audioCache[key] ~= nil and #self.audioCache[key] > 0 then
		audioItem = self.audioCache[key][1]
		table.remove(self.audioCache[key], 1)
		audioItem.gameObject:SetActive(true)
		return audioItem
	end

	local audioData = data.audio[key]
	audioItem = self:createAudioItem(key, audioData)
	return audioItem
end


function AudioPlay:createAudioItem(key, audioData)
	local go = GameObject(key)
	go.transform.parent = self.transform
	local audioScript = ScriptManager.GetInstance():WrapperWindowControl(go, 'framework/audio/audioItem')
	audioScript:initialize(audioData)

	if self.allAudioList[key] == nil then
		self.allAudioList[key] = {}
	end
	table.insert(self.allAudioList[key], audioScript)
	return audioScript
end


function AudioPlay:getAudioAsset(key)
	return self.audioAsset[key]
end


function AudioPlay:addAudioAsset(key, asset)
	if self.audioAsset[key] == nil then
		self.audioAsset[key] = asset
		self.audioAsset[key]:AddRef()
	end
end


function AudioPlay:releaseAudioItem(key, audioItem)
	audioItem.gameObject:SetActive(false)
	if self.audioCache[key] == nil then
		self.audioCache[key] = {}
	end
	table.insert(self.audioCache[key], audioItem)
end


--删除声音
function AudioPlay:stopAudio(key)
	if key == nil or type(key) ~= "string" then
		return
	end

	local audioItems = self.allAudioList[key]
	if audioItems == nil then
		return
	end

	for _, audioItem in pairs(audioItems) do
		audioItem:onDestroy()
		GameObjectUtility.DestroyGameObject(audioItem.gameObject, false)
	end

	self.audioCache[key]   = {}
	self.allAudioList[key] = {}
end


--停止所有声音
function AudioPlay:stopAllAudio()
	for k, v in pairs(self.allAudioList) do
		self:stopAudio(k)
	end

	for _, asset in pairs(self.audioAsset) do
		asset:ReleaseRef()
	end

	self.audioCache   = {}
	self.allAudioList = {}
	self.audioAsset   = {}
end


function AudioPlay:playBgMusic(key,isBattle)
	if isBattle == false then
		if self.currBgMusic ~= nil then
			if self.currBgMusic ~= key then
				self:stopAudio(self.currBgMusic)
				self:playAudio(key)
				self.currBgMusic = key
			end
		else
			self:playAudio(key)
			self.currBgMusic = key
		end
	else 
		self:playAudio(key)
		self.currBgMusic = key
	end 
end


function AudioPlay:playGuideMusic(key)
	self:stopAudio(self.guideAudioId)
	self:playAudio(key)
	self.guideAudioId = key
end


function AudioPlay:stopBgMusic()
	if self.currBgMusic ~= nil then
		self:stopAudio(self.currBgMusic)
		self.currBgMusic = nil
	end
end


function AudioPlay:getRandomBgMusic(isBattle)
	if isBattle == nil then isBattle = false end

	local musicList  = self.bgMusicList
	if isBattle == true then
		musicList = self.battleMusicList
	end

	if musicList == nil then
		if isBattle == true then
			self.battleMusicList = { audioConfig.Audio_Battle_Background_music_1 }
			-- for i = 3, 3 do
			-- 	table.insert(self.battleMusicList, audioConfig["Audio_Battle_Background_music_" .. i])
			-- end
			musicList = self.battleMusicList
		else
			self.bgMusicList = { audioConfig.Audio_Normal_Background_music_1 }
			musicList        = self.bgMusicList
		end
	end
	local musicIndex = math.random(1, #musicList)
	return musicList[musicIndex]
end


function AudioPlay:playGeneralTroopAudio(generalOrTroopId)
	-- print(generalOrTroopId)
	local audioData = conf.roleAudio[tostring(generalOrTroopId)]
	--print_t(audioData)
	if audioData == nil then 
		return 
	end 

	local randomAudioListData = audioData.audio
	if randomAudioListData == nil then 
		return 
	end 

	local randomAudioList = stringUtility.split(randomAudioListData, ",")
	--print(musicList[math.random(1, #randomAudioList))

	applicationGlobal.audioPlay:playAudio(randomAudioList[math.random(1, #randomAudioList)])
end


function AudioPlay:setSoundVolume(key, value)
	local isBackground = false
	if key == "bgMusicvolume" then
		self.bgMusicVolume = value
		isBackground = true
	else
		self.otherVolume = value
	end
	PlayerPrefs.SetFloat(key, value)
	for key, audioItemList in pairs(self.allAudioList) do
		for _, audioItem in pairs(audioItemList) do
			if audioItem:isBgMusic() == isBackground then
				audioItem:setVolume(value)
			end
		end
	end
end


function AudioPlay:dispose()

end


