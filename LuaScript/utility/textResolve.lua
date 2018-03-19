-- ***************************************************************
--  Copyright(c) Yeto
--  FileName    : textResolve.lua
--  Creator     : sf
--  Date        : 2017-4-25 
--  Comment     : 
                --1.Resolve Original         //显示文本为原始值Value
                --2.Resolve Xml              //显示文本为根据Value读取XML得到的数据
                --3.Resolve Json             //显示文本为根据Json格式的Value解析得到的数据
                --4.Resolve LS               //显示文本为根据Value通过localization解析得到的string数据
                --5.Resolve LSCharp          //显示文本为根据Value(除开'#')通过localization解析得到的string数据
-- ***************************************************************

module("textResolve", package.seeall) 

enmuOnPressURLType = 
{
    Player = 1,
    Item = 2,
    Card = 3,
}

enumRewardType = 
{
	None = 0,
	Item = 1,
	Gold = 2,
	Diamond = 3,
	PlayerExp = 4,
	Card = 5,
	GangCoin = 6,
	GeneralExp = 8,
	Ration = 9,
}
fixedTemplateFunctionDic = {}
--[[

public class GameTextResolve : IDispose
{
    private bool isInitialize = false;
    private static char separator = '_';
    private static Dictionary<string, Func<string, string>> fixedTemplateFunctionDic;

    public override void Initialize()
    {
        if (isInitialize)
            return;

        isInitialize = true;
        fixedTemplateFunctionDic = new Dictionary<string, Func<string, string>>();
        SetFixedTemplateFunctionDic();
    }--]]


function setFixedTemplateFunctionDic()
    fixedTemplateFunctionDic["Original"]			= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["PLAYER_ID_NAME"] 		= function(value) return resolveXmlPlayerIdName(value) end 
	fixedTemplateFunctionDic["PLAYER_NAME"] 	    = function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["PLAYER_NAME_1"] 	    = function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["ENEMY_NAME"] 	 		= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["GANG_NAME"] 			= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["ENEMY_GANG_NAME"] 	= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["CONTENT"] 			= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["STRATEGOS_NAME"] 		= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["CITY_NAME"] 			= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["REWARDS"] 			= function(value) return resolveJsonRewards(value) end 
	fixedTemplateFunctionDic["GANG_WAR_POINT"] 		= function(value) return resolveXmlLSGangWarPoint(value) end 
	fixedTemplateFunctionDic["WINS"] 				= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["HOUR_MINUTE_TIME"] 	= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["MINUTE"] 				= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["TREASURE_NAME"]	 	= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["ITEM_NAME"]	 		= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["RANK_NAME"] 			= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["GANG_JOB_NAME"] 		= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["CARD_NAME"] 			= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["GANG_COIN"] 			= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["GANG_CONT"] 			= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["STAR"] 				= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["TASK_NAME"] 			= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["WORSHIP_TYPE_NAME"] 	= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["QUALITY"] 			= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["LEVEL"] 				= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["DEGREE_NAME"] 		= function(value) return resolveLS(value) end 
	fixedTemplateFunctionDic["WAR_GOD_DIFFICULTY"] 	= function(value) return resolveLS(value) end 
	fixedTemplateFunctionDic["DUNGEON_NAME"] 		= function(value) return resolveLS(value) end 
	fixedTemplateFunctionDic["SCORE"] 				= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["RANK"] 				= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["COUNT"] 				= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["DIAMOND"] 			= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["DIAMOND_1"] 			= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["GANG_BOSS_NAME"]		= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["TECHNOLOGY_NAME"]		= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["GOLD"]				= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["RED_ENVELOPE_NAME"]	= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["CONTEST_TITLE"]		= function(value) return resolveLSCharp(value) end 
	fixedTemplateFunctionDic["PROGRESS"]			= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["RECORD_KEY"]			= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["MESSAGE"]				= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["INDEX"]				= function(value) return resolveOriginal(value) end 
	fixedTemplateFunctionDic["CHILD_INDEX"]			= function(value) return resolveOriginal(value) end 
end
-- /**
--      * 录像key
--      */
--     String RECORD_KEY = "RECORD_KEY";
    
--     /**
--      * 附加消息
--      */
--     String MESSAGE = "MESSAGE";
    
--     /**
--      * 一级索引
--      */
--     String INDEX = "INDEX";
    
--     /**
--      * 二级索引
--      */
--     String CHILD_INDEX = "CHILD_INDEX";
	
function textParseKeyLua(scr, param)
	return textParseKey(scr, param)
end

	
function textParseKey(src, param)
	if #fixedTemplateFunctionDic == 0 then 
		setFixedTemplateFunctionDic()
	end
	
	local text = src  
	if param == nil or #param == 0 then 
		return text 
	end
	
	for i, v in pairs(param) do 
		if v ~= nil then 
			if v.paramKey ~= nil and v.paramKey ~= "" then 
				local valueText = ""
				if fixedTemplateFunctionDic[v.paramKey] == nil then
					valueText = resolveOriginal(v.paramValue) 
				else
					valueText = fixedTemplateFunctionDic[v.paramKey](v.paramValue)
				end
				text = stringUtility.replaceStr(text, "{" .. v.paramKey .. "}", {valueText})
			end
		end
	end
	return text
end



function resolveOriginal(value)
   return value
end


function resolveJsonRewards(value)
	if value == nil or value == "" then 
		return value
	end
	local text = ""
	local array = json.decode(value)

	for i, v in pairs(array) do 
		if i > 1 then 
			text = text .. "/"
		end
		
		local rewardItem = {}
		rewardItem.id = v.id
		rewardItem.num = v.count
		rewardItem.type = v.type
		
		local name = ""
		local color = ""
		
		if rewardItem.type == enumRewardType.None or 
		   rewardItem.type == enumRewardType.Item or 
		   rewardItem.type == enumRewardType.Gold or 
		   rewardItem.type == enumRewardType.Diamond or 
		   rewardItem.type == enumRewardType.PlayerExp or 
		   rewardItem.type == enumRewardType.GangCoin or 
		   rewardItem.type == enumRewardType.GeneralExp or 
		   rewardItem.type == enumRewardType.Ration then 
			
		   local itemData = conf.item[tostring(rewardItem.id)]
		   name = L(string.sub(itemData.name, 2))
		   color = colorUtility.getColorByQuality(itemData.quality)
		elseif rewardItem.type == enumRewardType.Card then 
			local cardData = conf.card[tostring(rewardItem.id)]
			name = L(string.sub(cardData.name, 2))
			local colorQuality = 5
			color = colorUtility.getColorByQuality(colorQuality)
		end 
		
		text = text .. string.format(stringUtility.rejuctSymbol("[{0}]{1}[-] * {2}"), color, name, rewardItem.num)
	end
		
	return text 
end


function resolveLS(value)
    if value == nil or value == "" then 
      return value
	end 

    return L(value)
end


function resolveLSCharp(value)
    if value == nil or value == "" then 
		return value
	end
    
	return L(string.sub(value, 2))
end


function resolveXmlPlayerIdName(value)
	if value == nil or value == "" then 
		return value
	end

	local text = ""
	
	local underlineIndex = string.find(value, "_")   --因为名字中可以带有'_',所以此处用下标索引
	local playerID = string.sub(value, 0, -string.len(value) + string.find(value, "_") -2 )
	local playerName = string.sub(value, string.find(value, "_") + 1 )
	
	text = string.format(stringUtility.rejuctSymbol("[url={0}_{1}]{2}[/url]"), playerID, enmuOnPressURLType.Player, playerName) --原来的URL
	return text
end


function resolveXmlItemIdName(value)
	if value == nil or value == "" then 
		return value
	end

	local text = ""

	local values = stringUtility.split(value, '_')

	local itemId = values[1]
	local data = conf.item[tostring(itemId)]
	text = string.format(stringUtility.rejuctSymbol("[url={0}_{1}]{2}[/url]"), itemId, enmuOnPressURLType.Item, data.name)
	return text
end


function resolveXmlLSGangWarPoint(value)
	if value == nil or value == "" then 
		return value
	end

    local data = conf.gang_war_point[tostring(tonumber(value) + 1)]   --服务端与前端表格差1
    return L(data.name)
end