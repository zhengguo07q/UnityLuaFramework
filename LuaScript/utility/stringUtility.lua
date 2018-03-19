-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : stringUtility.lua
--  Creator     : lyf
--  Date        : 2016-12-26
--  Comment     : 
-- ***************************************************************


module("stringUtility", package.seeall) 

----分割字符串
function split(szFullString, szSeparator)  
    local nFindStartIndex = 1  
    local nSplitIndex = 1  
    local nSplitArray = {}  
    while true do  
       local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)  
       if not nFindLastIndex then  
          nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))  
        break  
       end  
       nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
       nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
       nSplitIndex = nSplitIndex + 1  
    end  
    return nSplitArray  
end 


----剔除{0}这样的符号
function rejuctSymbol(fullStr)
	local tempStr = split(fullStr,"{")
	local allStr =""
	for i,k in ipairs(tempStr) do
       local str = split(k,"}")
       if table.getn(str)>1 then
           str[1] = "%s"
           allStr =allStr .. str[1] .. str[2]
       else
         allStr =allStr .. k
       	end
	end

   return allStr
end


-- -- 检查是否又敏感词汇
-- function hasSensitiveWord(str)
--   local isFind = false
--   for k,v in pairs(conf.filterNameString) do
--     if string.find(str,v.info) ~=nil then
--       isFind=true
--       break
--     end
--   end
--   return isFind
-- end


function hasSensitiveWord(str)
  for k,v in pairs(conf.filterNameString) do
    local isFind2 = true 
    local tStr = v.info

    if string.find(tStr, "%[") ~= nil then
      tStr = string.gsub(tStr, "%[", " ")
    end
    if string.find(tStr, "%]") ~= nil then
      tStr = string.gsub(tStr, "%]", " ")
    end
    if string.find(tStr, "%%") ~= nil then
      tStr = string.gsub(tStr, "%%", " ")
    end
    

    local n=string.len(tStr)
    local list1 = {}
    for i=1,n do
      list1[i]=string.sub(tStr,i,i)
    end

    local findIndex = 1
    for i=1,n do
      if list1[i] == "(" then
        if string.find(str, "%(") == nil then 
           isFind2 = false
        end
      elseif list1[i] == ")" then
        if string.find(str, "%)") == nil then 
           isFind2 = false
        end       
      else
        local tStart, tEnd = string.find(str, list1[i], findIndex)
        if tStart == nil then
          isFind2 = false
        else 
            findIndex = tEnd
        end
      end
    end

    if isFind2 == true then 
      return true 
    end 

  end
  return false
end 


---依次替换目标字符串
function replaceStr(source, rStr, replacements)
	for i=1, #replacements do
		source = string.gsub(source,rStr,replacements[i], 1)
	end
	return source
end


-- 获取字符串的宽度
function strlen(str, fontSize)
  local curByte = string.byte(str, i)
  local byteCount = 1;
  if curByte>0 and curByte<=127 then
      byteCount = 1
  elseif curByte>=192 and curByte<223 then
      byteCount = 2
  elseif curByte>=224 and curByte<239 then
      byteCount = 3
  elseif curByte>=240 and curByte<=247 then
      byteCount = 4
  end
   
  if byteCount == 1 then
      width = fontSize * 0.5
  else
      width = fontSize
  end
 
  return width  --13.29一个字符的宽度，C#直接用NGUIText.GetGlyphWidth(string.byte(' '), 0) 
end


--数字转换字符串格式
function num2str(num)
  local numStr = ""

  if num >= 0 and num < 1000 then
    numStr = ""
  elseif num >= 1000 and num < 1000000 then
    num = (num/1000)
    numStr = "K"
  elseif num >= 1000000 then
    num = (num/1000000)
    numStr = "M"
  end

  num = num - num%0.01

  return num .. numStr
end


-- 计算字符串宽度，中文两个位置，英文一个位置
function length(inputstr)
  inputstr = tostring(inputstr)

  local lenInByte = #inputstr
  local width = 0
  local i = 1
  while (i<=lenInByte) 
  do
    local curByte = string.byte(inputstr, i)
    local byteCount = 1;
    if curByte>0 and curByte<=127 then
        byteCount = 1                                               --1字节字符
    elseif curByte>=192 and curByte<223 then
        byteCount = 2                                               --双字节字符
    elseif curByte>=224 and curByte<239 then
        byteCount = 3                                               --汉字
    elseif curByte>=240 and curByte<=247 then
        byteCount = 4                                               --4字节字符
    end

    local char = string.sub(inputstr, i, i+byteCount-1)
    i = i + byteCount                                               -- 重置下一字节的索引

    if byteCount == 1 then
        width = width + 1                                               -- 字符的个数（长度）
    else
        width = width + 2                                               -- 字符的个数（长度） 
    end
  end

  return width
end