-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: alertPanel.lua
--  Creator 	: zg
--  Date		: 2016-12-22
--  Comment		: 
-- ***************************************************************


AlertPanel = BaseClass(WindowLayerBase)


function AlertPanel:initialize()
	self.varCache.go_messageAlert:SetActive(false)
end


function AlertPanel:getMessageAlert()
	self.varCache.go_messageAlert:SetActive(true)
	if self.messageAlert == nil then
		self.messageAlert = ScriptManager.GetInstance():WrapperWindowControl(self.varCache.go_messageAlert, nil)
	end
	applicationGlobal.audioPlay:playAudio(audioConfig.Audio_PopUp_Tips)
end


--一个按钮的弹出框
function AlertPanel:alertSingle(title, message, callback, btnName, playAudio)
	self:getMessageAlert()
	self.messageAlert:alertSingle(title, message, callback, btnName)
	
end


--两个按钮的弹出框
function AlertPanel:alertTwo(title, message, callback1, callback2, btnNam1, btnName2)
	self:getMessageAlert()
	self.messageAlert:alertTwo(title, message, callback1, callback2, btnNam1, btnName2)
end


-- 弹出图文的二次确认框
function AlertPanel:alertTwoTeletext(title, message, callback1, callback2, btnNam1, btnName2)
	self:getMessageAlert()
	self.messageAlert:alertTwoTeletext(title, message, callback1, callback2, btnNam1, btnName2)
end


--关闭所有alert
function AlertPanel:closeAllAlert()
	self.messageAlert.gameObject:SetActive(false)
end
