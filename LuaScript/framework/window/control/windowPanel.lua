-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: windowPanel.lua
--  Creator 	: zg
--  Date		: 2017-1-10
--  Comment		: 
-- ***************************************************************


WindowPanel = BaseClass()


function WindowPanel:initialize( ... )
	
end


function WindowPanel:afterInitialize( ... )
	
end


--关闭再次打开时需要重置UI
function WindowPanel:resetUI()
	
end


function WindowPanel:close()
	self.window:close()
end


--打开窗口之后
function WindowPanel:afterOpen()
end


--关闭窗口之后
function WindowPanel:afterClose()

end


function WindowPanel:onDestroy()
	self:dispose()
end


function WindowPanel:dispose( ... )
	
end


function WindowPanel:refresh()
	self:resetUI()
end