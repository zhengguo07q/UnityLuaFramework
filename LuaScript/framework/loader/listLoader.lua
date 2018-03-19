-- ***************************************************************
--  Copyright(c) Yeto
--  FileName	: listLoader.lua
--  Creator 	: zg
--  Date		: 2017-1-13
--  Comment		: 顺序载入器， 进入场景后，这个要不要释放值得商榷， 因为这里可能需要保持一些引用
-- ***************************************************************


ListLoader = BaseClass()


function ListLoader:ctor()
	self.waitList = {}
	self.assetListT = {}
	self.loadTaskList = {}
	self.callbackLoadComplete = nil
	self.lastWait = nil

	self.loadTotal = 0                   --总下载队列数量
	self.loadCount = 0                   --剩余还在下载的数量
    
    self.combProgress = 0
	self.removeTaskList = {}
end


function ListLoader:putWaitLoad(waitLoadResource)
	table.insert(self.waitList, waitLoadResource)
end


--启动装载
function ListLoader:load()
	if #self.waitList == 0 and self.callbackLoadComplete ~= nil then  				--检查是否有需要装载的， 没有直接回调
		self.callbackLoadComplete()
	end
    self.loadTotal = #self.waitList													--初始化载入的数量
    self.loadCount = #self.waitList	
    for i = 1, #self.waitList do
        local loadTask = AssetLoader.instance:asyncLoad(self.waitList[i])			--启动异步载入资源
        if loadTask == nil then
            self.loadCount = self.loadCount - 1										--如果发现这个载入为nil, 则代表这个载入可能已经完成了， 去掉一个载入的
        else
        	table.insert(self.loadTaskList, loadTask)								--把这个放入载入列表
        end
        if i == #self.waitList then
            self.lastWait = self.waitList[i]
        end
    end
    self.waitList = {}
    self.isStart = true
end


--启动以后每帧都去更新载入资源， 载入完成后这个对象需要被删除
function ListLoader:update()	
    if self.isStart == false then																		--没有开始返回
        return
    end

    local currentCombProgress = 0
    for k,v in pairs(self.loadTaskList) do
        local loadTask = v
        if loadTask:isDone() then																		--如果装载任务完成了
            local loadState = loadTask:getLoadState()
            if loadState == assetBB.enumLoadState.success then	
               local assetTemp = AssetLoader.instance:getAsset(loadTask.path)
				if assetTemp ~= nil then 
					assetTemp:AddRef()
				end
                table.insert(self.assetListT, assetTemp)		
            else
                logInfo("加载资源失败: " .. loadTask.path .. " 失败原因:" .. loadTask.failReason)		--不然失败报告失败原因
            end
            self.loadCount = self.loadCount - 1	
            table.remove(self.loadTaskList, k)														--如果载入完成后， 则载入数量-1											--载入完成后放入载入列表
        else
            currentCombProgress = currentCombProgress + (loadTask.progress / self.loadTotal)	     --调整当前的进度
        end
    end

    if self.loadTotal ~= 0 or currentCombProgress ~= 0 then
        self.combProgress = (self.loadTotal - self.loadCount) / self.loadTotal + currentCombProgress
    end
    if self.combProgress < 0 then self.combProgress = 0 end


    if self.loadCount == 0 and self.callbackLoadComplete ~= nil then
        if self.lastWait ~= nil then
		    self.isStart = false
            self.callbackLoadComplete(self.lastWait)
        else 
            self.isStart = false 
        end
        self.combProgress = 1
    end
end


function ListLoader:setCallback(callbackFun)
	self.callbackLoadComplete = callbackFun
end


function ListLoader:dispose()
    if self.assetListT ~= nil then
        for i = 1, #self.assetListT do
            local asset = self.assetListT[i]
            asset:ReleaseRef()
        end
        self.assetListT = nil
    end
    self.callbackLoadComplete = nil
end