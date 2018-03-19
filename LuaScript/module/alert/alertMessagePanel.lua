-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: alertMessagePanel.lua
--  Creator 	: zg
--  Date		: 2016-12-22
--  Comment		: 
-- ***************************************************************


AlertMessagePanel = BaseClass(WindowLayerBase)


AlertMessagePanel.constAlertType = {"eatSingleButton", "eatTwoButton"}
AlertMessagePanel.enumAlertType = syntaxUtility.createEnum(AlertMessagePanel.constAlertType)


function AlertMessagePanel:initialize()

end


function AlertMessagePanel:clickButton(go, btnName)
	applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Button_Click)
	self.gameObject:SetActive(false)
	if btnName == "btn_ok_1" then
		if self.callback ~= nil then
			self:callback()
		end
		applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Click_Tips)
	elseif btnName == "btn_ok_2" then
		if self.callback1 ~= nil then
			self:callback1()
		end
		applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Click_Tips)
	elseif btnName == "btn_cancel_2" then
		if self.callback2 ~= nil then
			self:callback2()
		end
		applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Click_Tips)
	end
end


--显示只有一个确定按钮的提示框
function AlertMessagePanel:alertSingle(title, message, callback, btnName)
    applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Warn_Tips)
	self.alertType = AlertMessagePanel.enumAlertType.eatSingleButton
	self.varCache.label_teletext.gameObject:SetActive(false)
	self.callback = callback
	self.varCache.lbl_title.text = title
	self.varCache.lbl_message.text = message
	self.varCache.lbl_message.gameObject:SetActive(true)
	if btnName ~= nil then
		self.varCache.lbl_ok_1.text = btnName
	end
	self:showGameObject(self.alertType)
end


--显示有两个按钮的提示框
function AlertMessagePanel:alertTwo(title, message, callback1, callback2, btnNam1, btnName2)
	applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Warn_Tips)
	self.alertType = AlertMessagePanel.enumAlertType.eatTwoButton
	self.varCache.label_teletext.gameObject:SetActive(false)
	self.callback1 = callback1
	self.callback2 = callback2
	self.varCache.lbl_message.text = message
	self.varCache.lbl_message.gameObject:SetActive(true)
	if btnNam1 ~= nil then
		self.varCache.lbl_ok_2.text = btnNam1
	else 
		self.varCache.lbl_ok_2.text = L("common_button_1")
	end
	if btnName2 ~= nil then
		self.varCache.lbl_cancel_2.text = btnName2
	else 
		self.varCache.lbl_cancel_2.text = L("common_button_2")
	end
	self.varCache.lbl_title.text = title
	self:showGameObject(self.alertType)
end


--显示有两个按钮的图文提示框
function AlertMessagePanel:alertTwoTeletext(title, message, callback1, callback2, btnNam1, btnName2)
	applicationGlobal.audioPlay:playAudio(audioConfig.Audio_Warn_Tips)
	self.varCache.lbl_message.gameObject:SetActive(false)
	self.alertType = AlertMessagePanel.enumAlertType.eatTwoButton
	self.callback1 = callback1
	self.callback2 = callback2
	
	if btnNam1 ~= nil then
		self.varCache.lbl_ok_2.text = btnNam1
	else
		self.varCache.lbl_ok_2.text = L("common_button_1")
	end

	if btnName2 ~= nil then
		self.varCache.lbl_cancel_2.text = btnName2
	else
		self.varCache.lbl_cancel_2.text = L("common_button_2")
	end

	self.varCache.lbl_title.text = title
	self.varCache.label_teletext.text = message
	self.varCache.label_teletext.gameObject:SetActive(true)
	self:showGameObject(self.alertType)

	self.teletextScript = ScriptManager.GetInstance():WrapperWindowControl(self.varCache.label_teletext.gameObject, nil)
	if self.teletextScript ~= nil then
		self.teletextScript:removeSelfImage()
		self.teletextScript:setOffset(5, 35)
		-- local splitColor = string.gsub(message, "ef8a1d", "") --stringUtility.replaceStr(message, "[ef8a1d]", "")
		-- splitColor = string.gsub(splitColor, "-", "")
		-- splitColor = string.gsub(splitColor, "%[]", "")
		self.teletextScript:addItem(message)
		self.teletextScript:setCenter()
	end
end


--根据提示类型， 调整大小
function AlertMessagePanel:showGameObject(alertType)
	self:hideButton()

	if alertType == AlertMessagePanel.enumAlertType.eatSingleButton then
		self.varCache.go_single:SetActive(true);
	elseif alertType == AlertMessagePanel.enumAlertType.eatTwoButton then
		self.varCache.go_two:SetActive(true)
	end
end


--调整2层背景大小
function AlertMessagePanel:setFrameObjectSize(w, h, iw, ih)
	self.varCache.sp_background.width = w
	self.varCache.sp_background.height = h
end


function AlertMessagePanel:hideButton()
	self.varCache.go_single:SetActive(false)
	self.varCache.go_two:SetActive(false)
end
