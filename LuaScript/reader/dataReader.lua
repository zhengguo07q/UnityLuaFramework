 -- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: dataReader.lua
--  Creator 	: zg
--  Date		: 2016-11-10
--  Comment		: 配置读取
-- ***************************************************************


module("dataReader", package.seeall)

conf_radio  = 0.8 
conf_proto_radio = 0.9
per_add = 10
globalLuaScripts = {}

function loadConf()
    local luaPaths = nil
    local battleLuaPaths = nil
    local addHead = nil
    local addHead2 = nil

    if applicationConfig.macro.UNITY_EDITOR then    
        local path = PathUtility.LuaPath .. '/conf'
	    luaPaths = FileUtility.GetAllFileInPathWithSearchPattern(path, '*.lua')
	    local battlePath = PathUtility.LuaPath .. '/battle/conf'
	    battleLuaPaths= FileUtility.GetAllFileInPathWithSearchPattern(battlePath, '*.lua')
	    addHead = 'conf'
	    addHead2 = 'battle/conf'
    else
        luaPaths = ScriptManager.GetInstance():GetListFiles("conf/")
        battleLuaPaths = ScriptManager.GetInstance():GetListFiles("battle/conf/")
        addHead = ""
        addHead2 = ""
    end

	local c = coroutine.create(function()
	    local progressLen = luaPaths.Length + battleLuaPaths.Length
		for i=1, luaPaths.Length do
			luaPath = luaPaths[i]
			luaPath = fileUtility.getPathAndNotPrefix(luaPath, 'LuaScript/conf')
            require(addHead..luaPath)

			GameProgress.Instance:SetProgressTxt(startupLocalization.getLocal("login_loading_script"), "", (i / progressLen) * conf_radio)
			if i % per_add == 0 then
				--UnityEngine.Yield(WaitForEndOfFrame())
				Yield()
			end
		end

        for i=1, battleLuaPaths.Length do
            battleLuaPath = battleLuaPaths[i]
            battleLuaPath = fileUtility.getPathAndNotPrefix(battleLuaPath, 'LuaScript/battle/conf')
            require(addHead2..battleLuaPath)
            GameProgress.Instance:SetProgressTxt(startupLocalization.getLocal("login_loading_script"), "", ((luaPaths.Length + i) / progressLen) * conf_radio)
            if i % per_add == 0 then
                --UnityEngine.Yield(WaitForEndOfFrame())
                Yield()
            end
        end
		-- reload("applicationLoad")
	 --    reload("applicationLoadAfter")
		startupStatusManager.dataReaderComplete()
	end
	)
	coroutine.resume(c)
end


function addData(tbName, tb)
	if data[tbName] == nil then
		data[tbName] = tb
	else
		syntaxUtility.mergeTable(data[tbName], tb)
	end
end


function loadProtocal()
	local luaPaths = nil
	local addHead = nil
	if applicationConfig.macro.UNITY_EDITOR then
		local path = PathUtility.LuaPath .. '/protocal'
	    luaPaths = FileUtility.GetAllFileInPathWithSearchPattern(path, '*.lua')
	    addHead = 'protocal'
	else
        luaPaths = ScriptManager.GetInstance():GetListFiles("protocal/")
        addHead = ""
	end
	local c = coroutine.create(function()
		for i=1, luaPaths.Length do
			luaPath = luaPaths[i]
			luaPath = fileUtility.getPathAndNotPrefix(luaPath, 'LuaScript/protocal')
            local content = require(addHead..luaPath)	
			NetProtocal.Instance:ReadProtocalStr(content)
			GameProgress.Instance:SetProgressTxt(startupLocalization.getLocal("login_loading_script"),"", conf_radio + (i / luaPaths.Length) * (conf_proto_radio - conf_radio))
			if i % per_add == 0 then
				--UnityEngine.Yield(WaitForEndOfFrame())
				Yield()
			end
		end
		startupStatusManager.protocalReaderComplete()
	end)
	coroutine.resume(c)
end


-- 读取 applicationLoad 和 applicationAfterLoad 文件
function loadGlobalLua()
	local c = coroutine.create(function()
		local count = #globalLuaScripts
		logInfo("loadGlobalLua count = "..count)
		for i=1, count do
			reload(globalLuaScripts[i])
			GameProgress.Instance:SetProgressTxt(startupLocalization.getLocal("login_loading_script"),"", conf_proto_radio + (i / count) * 0.1)
			if i % per_add == 0 then
				--UnityEngine.Yield(WaitForEndOfFrame())
				Yield()
			end
		end
		logInfo("loadGlobalLua finish")
		startupStatusManager.globalLuaReaderComplete()
	end)
	coroutine.resume(c)
end


