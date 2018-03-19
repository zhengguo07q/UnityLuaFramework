-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: debugUtility.lua
--  Creator 	: zg
--  Date		: 2016-11-10
--  Comment		: 调试lua
-- ***************************************************************


module("debugUtility", package.seeall)


_print = print


function _list_table(tb, table_list, level)
    local ret = ""
    local indent = string.rep(" ", level*4)

    for k, v in pairs(tb) do
        local quo = type(k) == "string" and "\"" or ""
        ret = ret .. indent .. "[" .. quo .. tostring(k) .. quo .. "] = "

        if type(v) == "table" then
            local t_name = table_list[v]
            if t_name then
                ret = ret .. tostring(v) .. " -- > [\"" .. t_name .. "\"]\n"
            else
                table_list[v] = tostring(k)
                ret = ret .. "{\n"
                ret = ret .. _list_table(v, table_list, level+1)
                ret = ret .. indent .. "},\n"
            end
        elseif type(v) == "string" then
            ret = ret .. "\"" .. tostring(v) .. "\"" .. "," .. "\n"  
            --"\"" .. tostring(v) .. "\"n"
        else
            ret = ret .. tostring(v) .. "," .. "\n"
        end
    end

    -- local mt = getmetatable(tb)
    -- if mt then
    --     ret = ret .. "\n"
    --     local t_name = table_list[mt]
    --     ret = ret .. indent .. "<metatable> = "

    --     if t_name then
    --         ret = ret .. tostring(mt) .. " -- > [\"" .. t_name .. "\"]\n"
    --     else
    --         ret = ret .. "{\n"
    --         ret = ret .. _list_table(mt, table_list, level+1)
    --         ret = ret .. indent .. "}\n"
    --     end

    -- end

   return ret
end


function _tableToString(tb)
	if type(tb) ~= "table" then
		error("Sorry, it's not table, it is " .. type(tb) .. ".")
	end

	local ret = " = {\n"
	local table_list = {}
    table_list[tb] = "root table"
    ret = ret .. _list_table(tb, table_list, 1)
    ret = ret .. "}"
    return ret
end


function printTable(tb)
	_print(tostring(tb) .. _tableToString(tb))
end


function getPrintTable(tb)
    return tostring(tb) .. _tableToString(tb)
end


function printCallStack()
    local startLevel = 2 --0表示getinfo本身,1表示调用getinfo的函数(printCallStack),2表示调用printCallStack的函数,可以想象一个getinfo(0级)在顶的栈.
    local maxLevel = 10 --最大递归10层
 
    for level = startLevel, maxLevel do
        -- 打印堆栈每一层
        local info = debug.getinfo( level, "nSl") 
        if info == nil then break end
        _print( string.format("[ line : %-4d]  %-20s :: %s", info.currentline, info.name or "", info.source or "" ) )
 
        -- 打印该层的参数与局部变量
        local index = 1 --1表示第一个参数或局部变量, 依次类推
        while true do
            local name, value = debug.getlocal( level, index )
            if name == nil then break end
 
            local valueType = type( value )
            local valueStr
            if valueType == 'string' then
                valueStr = value
            elseif valueType == "number" then
                valueStr = string.format("%.2f", value)
            end
            if valueStr ~= nil then
                _print( string.format( "\t%s = %s\n", name, value ) )
            end
            index = index + 1
        end
    end
end


enumColor = 
{
    R = "<color=red>",
    G = "<color=green>",
    B = "<color=blue>",
    W = "<color=write>",
    Y = "<color=yellow>"
}


function printColor(...)
    local arg = {...}
    if #arg == 1 then
        _print(...)
        return
    end

    local c = arg[#arg]
    local color = enumColor[c]
    if color ~= nil then
        _print(color, unpack(arg), "</color>")
    else
        _print(...)
    end
end


_G['print_t'] = printTable

--_G['print'] = printColor