-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : fileUtility.lua
--  Creator     : zg
--  Date        : 2016-11-13
--  Comment     :
-- ***************************************************************


module("fileUtility", package.seeall)


--如果是prefix + path组成的字符串， 则去掉prefix, 如果不是， 则返回path
function getPathAndNotPrefix(path, prefix)
    path = string.gsub(path, '\\', '/')
    prefix = string.gsub(prefix, '\\', '/')
    local i, j = string.find(path, prefix)
    if j ~= nil then
       return string.sub(path, j + 1)
    else
        return path
    end
end

