 -- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: data.lua
--  Creator 	: zg
--  Date		: 2016-11-10
--  Comment		: 配置读取, 这个data里面持有所有的配置, 可以直接通过data.xxx来获取整个配置table
-- ***************************************************************

module("data", package.seeall)


--返回多列, 包含特定key的值为value的项
function foreach(data, key, value)
	if type(data) ~= 'table' then
		error('data conf  type is not table :' .. type(data))
	end
	tb = {}
	table.foreach(data, function(k, v)
		if v[key] == nil then
			error('data column not exist key : ' .. key)
		end
		if v[key] == value then
			tb[k] = v
		end
	end)
	return tb
end


--返回一列, 查找到第一个匹配此key, v的项,例子：conf.foreachOne(conf.farmSeed, "seedId", 400001)
function foreachOne(data, key, value)
	if type(data) ~= 'table' then
		error('data conf  type is not table :' .. type(data))
	end
	local ret = nil
	table.foreach(data, function(k, v)
		if v[key] == nil then
			error('data column not exist key : ' .. key)
		end
		if v[key] == value then
			ret = v
		end
	end)
	return ret
end

_G['conf'] = data