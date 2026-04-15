local WindUI

do
    local ok, result = pcall(function()
        return require("./src/init")
    end)
    
    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    end
end

-- 全局配置（主题、透明度）
WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

-- 梯度文本函数
local function gradient(text, startColor, endColor)
    local result = ""
    for i = 1, #text do
        local t = (i - 1) / (#text - 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
    end
    return result
end

-- 弹窗确认（先弹窗，再加载窗口）
local Confirmed = false
WindUI:Popup({
    Title = gradient("LSJ Script Hub", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
    Icon = "sparkles",
    IconThemed = true,
    Content = "欢迎使用洛杉矶脚本！\n最新版本 \n制作人『洛杉矶』\n脚本中心群聊1077022323",
    Buttons = {
        {
            Title = "取消",
            Callback = function() end,
            Variant = "Secondary"
        },
        {
            Title = "确认",
            Icon = "arrow-right",
            Callback = function() Confirmed = true end,
            Variant = "Primary"
        }
    }
})
repeat wait() until Confirmed

-- 用户界面创建（修复玩家昵称获取容错）
local UserGui = Instance.new("ScreenGui", game.CoreGui)
local UserLabel = Instance.new("TextLabel", UserGui)
local UIGradient = Instance.new("UIGradient")

UserGui.Name = "UserGui"
UserGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UserGui.Enabled = true
UserLabel.Name = "UserLabel"
UserLabel.BackgroundColor3 = Color3.new(1, 1, 1)
UserLabel.BackgroundTransparency = 1
UserLabel.BorderColor3 = Color3.new(0, 0, 0)
UserLabel.Position = UDim2.new(0.8, 0, 0.0009, 0) -- 简化Position参数（原0.8,0.8冗余）
UserLabel.Size = UDim2.new(0, 135, 0, 50)
UserLabel.Font = Enum.Font.GothamSemibold
-- 容错：角色未加载时显示玩家名，避免报错
local playerName = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Name or game.Players.LocalPlayer.Name
UserLabel.Text = "亲爱的：" .. playerName .. "欢迎使用洛杉矶脚本中心！"
UserLabel.TextColor3 = Color3.new(1, 1, 1)
UserLabel.TextScaled = true
UserLabel.TextSize = 14
UserLabel.TextWrapped = true
UserLabel.Visible = true

UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)),
    ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)),
    ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)),
    ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)),
    ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)),
    ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))
}
UIGradient.Rotation = 10
UIGradient.Parent = UserLabel

local TweenService = game:GetService("TweenService")
local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
tween:Play()

-- 唯一窗口创建（整合原两个窗口的所有配置，包含卡密系统）
local Window = WindUI:CreateWindow({
    -- 保留原两个窗口的核心配置
    Title = "牛逼脚本 | LSJ hub", -- 合并标题，兼顾两者
    Author = "牛逼版 |  .洛杉矶", -- 合并作者信息
    Folder = "洛杉矶_scriptHUB", -- 合并存储文件夹
    NewElements = true,
    Size = UDim2.fromOffset(480, 360),
    Theme = "Dark",
    HideSearchBar = false,
    SideBarWidth = 220,
    ScrollBarEnabled = true,
    
    -- 原第一个窗口的 OpenButton 配置
    OpenButton = {
        Title = "Open .LSJ hub UI",
        CornerRadius = UDim.new(1, 0), -- 全圆角
        StrokeThickness = 3,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Color = ColorSequence.new( -- 渐变按钮
            Color3.fromHex("#30FF6A"), 
            Color3.fromHex("#e7ff2f")
        )
    },
    
    -- 原第二个窗口的背景与用户配置
    Background = WindUI:Gradient({ -- 渐变背景
        ["0"] = {Color = Color3.fromHex("#0f0c29"), Transparency = 1},
        ["100"] = {Color = Color3.fromHex("#302b63"), Transparency = 0.9}
    }, {Rotation = 45}),
    Background = "rbxassetid://17394288621" -- 图片背景（覆盖渐变，按WindUI优先级）
    Icon = "rbxassetid://17629418832" -- 窗口图标
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            WindUI:Notify({
                Title = "您的用户ID：",
                Content = tostring(game.Players.LocalPlayer.UserId),
                Duration = 3
            })
        end
    },
    
    -- 卡密系统配置（核心功能，保留缩小图片）
    KeySystem = { 
        Key = { "洛杉矶牛逼", "洛杉矶NB", "洛杉矶牛逼666" },
        Note = "请输入卡密解锁功能\n官方群: 1077022323",
        Thumbnail = {
            Image = "rbxassetid://123576958702805"
            Size = UDim2.fromOffset(80, 80) -- 缩小图标
        },
        URL = "点击链接加入群聊【ROBLOX牛逼脚本 [联邦]】：https://qun.qq.com/universal-share/share?ac=1&authKey=cKQfS2Eq1sW7sR%2FxRfiffHQ20HrOrYAtK2wRU48%2B9GqeYzQrzQzAL98yDdafJBHV&busi_data=eyJncm91cENvZGUiOiIxMDc3MDIyMzIzIiwidG9rZW4iOiJMMjhNYmpEOHZLdlducGtIWHRCNUtodGorbmloalhHNmgva0ZMT2s3bDcvSE5IcVJnaWplZVdJRi9CNWdKUkdUIiwidWluIjoiMzg5Nzg4Njk0OSJ9&data=k51IhdGgfFjoLsqOjR11Qb8_fakNqmIEPbtb7g36Io_e456tUZQHB5SzasUCy63NcNZ3nvzYa9aAVB8OBFG1NA&svctype=4&tempid=h5_group_info",
        SaveKey = false -- 记住已验证卡密
    }
})

-- 表格转JSON与剪贴板函数（保留原功能）
local function parseJSON(luau_table, indent, level, visited)
    indent = indent or 2
    level = level or 0
    visited = visited or {}
    
    local currentIndent = string.rep(" ", level * indent)
    local nextIndent = string.rep(" ", (level + 1) * indent)
    
    if luau_table == nil then
        return "null"
    end
    
    local dataType = type(luau_table)
    
    if dataType == "table" then
        if visited[luau_table] then
            return "\"[Circular Reference]\""
        end
        
        visited[luau_table] = true
        
        local isArray = true
        local maxIndex = 0
        
        for k, _ in pairs(luau_table) do
            if type(k) == "number" and k > maxIndex then
                maxIndex = k
            end
            if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
                isArray = false
                break
            end
        end
        
        local count = 0
        for _ in pairs(luau_table) do
            count = count + 1
        end
        if count ~= maxIndex and isArray then
            isArray = false
        end
        
        if count == 0 then
            return "{}"
        end
        
        if isArray then
            if count == 0 then
                return "[]"
            end
            
            local result = "[\n"
            
            for i = 1, maxIndex do
                result = result .. nextIndent .. parseJSON(luau_table[i], indent, level + 1, visited)
                if i < maxIndex then
                    result = result .. ","
                end
                result = result .. "\n"
            end
            
            result = result .. currentIndent .. "]"
            return result
        else
            local result = "{\n"
            local first = true
            
            local keys = {}
            for k in pairs(luau_table) do
                table.insert(keys, k)
            end
            table.sort(keys, function(a, b)
                if type(a) == type(b) then
                    return tostring(a) < tostring(b)
                else
                    return type(a) < type(b)
                end
            end)
            
            for _, k in ipairs(keys) do
                local v = luau_table[k]
                if not first then
                    result = result .. ",\n"
                else
                    first = false
                end
                
                if type(k) == "string" then
                    result = result .. nextIndent .. "\"" .. k .. "\": "
                else
                    result = result .. nextIndent .. "\"" .. tostring(k) .. "\": "
                end
                
                result = result .. parseJSON(v, indent, level + 1, visited)
            end
            
            result = result .. "\n" .. currentIndent .. "}"
            return result
        end
    elseif dataType == "string" then
        local escaped = luau_table:gsub("\\", "\\\\")
        escaped = escaped:gsub("\"", "\\\"")
        escaped = escaped:gsub("\n", "\\n")
        escaped = escaped:gsub("\r", "\\r")
        escaped = escaped:gsub("\t", "\\t")
        
        return "\"" .. escaped .. "\""
    elseif dataType == "number" then
        return tostring(luau_table)
    elseif dataType == "boolean" then
        return luau_table and "true" or "false"
    elseif dataType == "function" then
        return "\"function\""
    else
        return "\"" .. dataType .. "\""
    end
end

local function tableToClipboard(luau_table, indent)
    indent = indent or 4
    local jsonString = parseJSON(luau_table, indent)
    setclipboard(jsonString)
    return jsonString
end

Window:SetBackgroundImageTransparency(0.7)

Window:Tag({
    Title = "WeChat脚本v0.1",
    Color = Color3.fromHex("#30ff6a")
})

local Tabs = {}

do

    Tabs.MainSection = Window:Section({Title = "力量传奇", Opened = true})
    
    Tabs.ParagraphTab = Tabs.MainSection:Tab({ Title = "关于", Icon = "zap" })
    Tabs.kenTab = Tabs.MainSection:Tab({ Title = "作者", Icon = "zap" })
    Tabs.playerTab = Tabs.MainSection:Tab({ Title = "玩家", Icon = "zap" })
    Tabs.ConfigTab = Tabs.MainSection:Tab({ Title = "主要", Icon = "zap" })
    Tabs.ExerciseTab = Tabs.MainSection:Tab({ Title = "锻炼", Icon = "zap" })
    Tabs.CrystalTab = Tabs.MainSection:Tab({ Title = "水晶", Icon = "zap" })
    Tabs.BuysTab = Tabs.MainSection:Tab({ Title = "宠物", Icon = "zap" })
    Tabs.EvolveTab = Tabs.MainSection:Tab({ Title = "进化", Icon = "zap" })
    Tabs.InfoTab = Tabs.MainSection:Tab({ Title = "信息", Icon = "zap" })
    Tabs.MianTab = Tabs.MainSection:Tab({ Title = "传送", Icon = "zap" })
end

Tabs.ParagraphTab:Paragraph({
    Title = "您的游戏名称：",
    Desc = ""..game:GetService("Players").LocalPlayer.DisplayName.."",
    Buttons = {
        {
            Title = "复制您的名称",
            Icon = "copy",
            Variant = "Primary",
            Callback = function() 
                setclipboard(game:GetService("Players").LocalPlayer.DisplayName)
            end
        }
    }
})

Tabs.ParagraphTab:Paragraph({
    Title = "您的游戏用户名：",
    Desc = ""..game:GetService("Players").LocalPlayer.Name.."",
    Buttons = {
        {
            Title = "复制您的用户名",
            Icon = "copy",
            Variant = "Primary",
            Callback = function() 
                setclipboard(game:GetService("Players").LocalPlayer.Name)
            end
        }
    }
})

Tabs.ParagraphTab:Paragraph({
    Title = "您的账号注册时间（天）：",
    Desc = ""..game:GetService("Players").LocalPlayer.AccountAge.."",
    Buttons = {
        {
            Title = "复制您的注册时间",
            Icon = "copy",
            Variant = "Primary",
            Callback = function() 
                setclipboard(game:GetService("Players").LocalPlayer.AccountAge)
            end
        }
    }
})

Tabs.ParagraphTab:Paragraph({
    Title = "您的用户名ID：",
    Desc = ""..game:GetService("Players").LocalPlayer.UserId.."",
    Buttons = {
        {
            Title = "复制您的用户名ID",
            Icon = "copy",
            Variant = "Primary",
            Callback = function() 
                setclipboard(game:GetService("Players").LocalPlayer.UserId)
            end
        }
    }
})

Tabs.ParagraphTab:Paragraph({
    Title = "您所在的服务器名称：",
    Desc = ""..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.."",
    Buttons = {
        {
            Title = "复制您所在的服务器名称",
            Icon = "copy",
            Variant = "Primary",
            Callback = function() 
                setclipboard(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
            end
        }
    }
})

Tabs.ParagraphTab:Paragraph({
    Title = "您所在的服务器ID：",
    Desc = ""..game.PlaceId.."",
    Buttons = {
        {
            Title = "复制您所在的服务器ID",
            Icon = "copy",
            Variant = "Primary",
            Callback = function() 
                setclipboard("无法复制")
            end
        }
    }
})

Tabs.ParagraphTab:Paragraph({
    Title = "您的注入器：",
    Desc = ""..identifyexecutor().."",
    Image = "rbxassetid://129287693322764",
    ImageSize = 42, -- default 30
    Thumbnail = "rbxassetid://94512740386917",
    ThumbnailSize = 120, -- Thumbnail height
    Buttons = {
        {
            Title = "测试您注入器的UNC",
            Variant = "Primary",
            Callback = function() 
                Window:Dialog({
                    Title = "冷寂脚本中心",
                    Content = "请勿点击多次，\n不然会造成游戏的卡顿!",
                    Icon = "bell",
                    Buttons = {
                        {
                            Title = "确定",
                            Variant = "Primary",
                            Callback = function() 
                                print("ok")
                            end,
                        }
                    }
                })
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/unc"))()
            end
        }
    }
})

local Sound = Instance.new("Sound", game:GetService("SoundService"))

Tabs.kenTab:Paragraph({
    Title = "脚本制作人『洛杉矶』",
    Desc = "后期还会更新",
    Buttons = {
        {
            Title = "复制作者QQ号",
            Icon = "copy",
            Variant = "Primary",
            Callback = function() 
                setclipboard(tostring(3897886949))
            end
        }
    }
})

Tabs.kenTab:Code({
    Title = "洛杉矶牛逼脚本群",
    Code = "点击链接加入群聊【ROBLOX牛逼脚本 [联邦]】：https://qun.qq.com/universal-share/share?ac=1&authKey=cKQfS2Eq1sW7sR%2FxRfiffHQ20HrOrYAtK2wRU48%2B9GqeYzQrzQzAL98yDdafJBHV&busi_data=eyJncm91cENvZGUiOiIxMDc3MDIyMzIzIiwidG9rZW4iOiJMMjhNYmpEOHZLdlducGtIWHRCNUtodGorbmloalhHNmgva0ZMT2s3bDcvSE5IcVJnaWplZVdJRi9CNWdKUkdUIiwidWluIjoiMzg5Nzg4Njk0OSJ9&data=k51IhdGgfFjoLsqOjR11Qb8_fakNqmIEPbtb7g36Io_e456tUZQHB5SzasUCy63NcNZ3nvzYa9aAVB8OBFG1NA&svctype=4&tempid=h5_group_info",
})

-- 力量输入框
Tabs.playerTab:Input({
    Title = "力量",
    Value = tostring(game:GetService("Players").LocalPlayer.leaderstats.Strength.Value),
    Callback = function(value)
        local strengthValue = game:GetService("Players").LocalPlayer.leaderstats.Strength
        -- 校验输入为数字，避免赋值错误
        if value and tonumber(value) then
            strengthValue.Value = tonumber(value)
        end
    end
})

-- 耐力输入框
Tabs.playerTab:Input({
    Title = "耐力",
    Value = tostring(game:GetService("Players").LocalPlayer.Durability.Value),
    Callback = function(value)
        local durabilityValue = game:GetService("Players").LocalPlayer.Durability
        if value and tonumber(value) then
            durabilityValue.Value = tonumber(value)
        end
    end
})

-- 敏捷输入框
Tabs.playerTab:Input({
    Title = "敏捷",
    Value = tostring(game:GetService("Players").LocalPlayer.Agility.Value),
    Callback = function(value)
        local agilityValue = game:GetService("Players").LocalPlayer.Agility
        if value and tonumber(value) then
            agilityValue.Value = tonumber(value)
        end
    end
})

-- 重生输入框
Tabs.playerTab:Input({
    Title = "重生",
    Value = tostring(game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value),
    Callback = function(value)
        local rebirthsValue = game:GetService("Players").LocalPlayer.leaderstats.Rebirths
        if value and tonumber(value) then
            rebirthsValue.Value = tonumber(value)
        end
    end
})

-- 宝石输入框
Tabs.playerTab:Input({
    Title = "宝石",
    Value = tostring(game:GetService("Players").LocalPlayer.Gems.Value),
    Callback = function(value)
        local gemsValue = game:GetService("Players").LocalPlayer.Gems
        if value and tonumber(value) then
            gemsValue.Value = tonumber(value)
        end
    end
})

Tabs.playerTab:Input({
    Title = "比赛次数",
    Value = tostring(game:GetService("Players").LocalPlayer.leaderstats.Brawls.Value),
    Callback = function(value)
        local brawlsValue = game:GetService("Players").LocalPlayer.leaderstats.Brawls
        if value and tonumber(value) then
            brawlsValue.Value = tonumber(value)
        end
    end
})

-- 邪恶业报输入框
Tabs.playerTab:Input({
    Title = "邪恶业报",
    Value = tostring(game:GetService("Players").LocalPlayer.evilKarma.Value),
    Callback = function(value)
        local evilKarmaValue = game:GetService("Players").LocalPlayer.evilKarma
        if value and tonumber(value) then
            evilKarmaValue.Value = tonumber(value)
        end
    end
})

-- 好人业报输入框
Tabs.playerTab:Input({
    Title = "好人业报",
    Value = tostring(game:GetService("Players").LocalPlayer.goodKarma.Value),
    Callback = function(value)
        local goodKarmaValue = game:GetService("Players").LocalPlayer.goodKarma
        if value and tonumber(value) then
            goodKarmaValue.Value = tonumber(value)
        end
    end
})

-- 总业报输入框
Tabs.playerTab:Input({
    Title = "总业报",
    Value = tostring(game:GetService("Players").LocalPlayer.leaderstats.Kills.Value),
    Callback = function(value)
        local killsValue = game:GetService("Players").LocalPlayer.leaderstats.Kills
        if value and tonumber(value) then
            killsValue.Value = tonumber(value)
        end
    end
})

-- 提前声明全局控制变量
local Interstellar = { Main = false }
local autopunch = false

-- 1. 自动加入战斗 - Toggle
Tabs.ConfigTab:Toggle({
    Title = "自动加入战斗",
    Value = false,
    Callback = function(state)
        Interstellar.Main = state
        if Interstellar.Main then
            while Interstellar.Main do
                game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
                wait()
            end
        end
    end
})

Tabs.ConfigTab:Toggle({
    Title = "自动收集全部宝箱",
    Value = false,
    Callback = function(state)
        -- 用独立变量控制循环，避免直接依赖toggle状态（防止状态同步延迟）
        local isRunning = state
        -- 循环间隔：0.5秒执行一次（可根据需求调整，建议不小于0.3秒）
        local loopDelay = 0.5

        -- 单独开启线程，避免阻塞UI
        spawn(function()
            while isRunning do
                -- 1. 先检查玩家角色是否存在（角色消失时停止操作，防止报错）
                local player = game.Players.LocalPlayer
                local character = player.Character
                if not character or not character:FindFirstChild("HumanoidRootPart") then
                    wait(loopDelay)
                    continue
                end
                local targetCFrame = character.HumanoidRootPart.CFrame

                -- 2. 定义宝箱列表（只保留游戏中实际存在的宝箱，删除不存在的）
                local chestNames = {
                    "mythicalChest", "goldenChest", "enchantedChest", "magmaChest",
                    "legendsChest", "saharaChest", "thunderChest", "ancientChest",
                    "midnightShadowChest", "groupRewardsCircle", "Daily Chest", "wonderChest"
                }

                -- 3. 批量处理宝箱，用pcall包裹避免单个宝箱报错导致循环中断
                for _, chestName in ipairs(chestNames) do
                    pcall(function()
                        local chest = game.Workspace:FindFirstChild(chestName)
                        if chest and chest:FindFirstChild("circleInner") then
                            -- 缓慢移动宝箱（而非瞬间传送，减少性能消耗）
                            chest.circleInner.CFrame = chest.circleInner.CFrame:Lerp(targetCFrame, 0.3)
                        end
                    end)
                end

                -- 4. 关键：添加间隔，给游戏线程喘息时间
                wait(loopDelay)

                -- 5. 同步toggle状态（关闭时停止循环）
                isRunning = state
            end
        end)
    end
})


-- 3. 收集宝石 - Button
Tabs.ConfigTab:Button({
    Title = "收集宝石",
    Callback = function()
        jk = {}
        for _, v in pairs(game:GetService("ReplicatedStorage").chestRewards:GetDescendants()) do
            if v.Name ~= "Light Karma Chest" and v.Name ~= "Evil Karma Chest" then
                table.insert(jk, v.Name)
            end
        end
        for i = 1, #jk do
            wait(2)
            game:GetService("ReplicatedStorage").rEvents.checkChestRemote:InvokeServer(jk[i])
        end
    end
})

-- 4. 自动挥拳 - Toggle
Tabs.ConfigTab:Toggle({
    Title = "自动挥拳",
    Value = false,
    Callback = function(Value)
        autopunch = Value
        game:GetService("RunService").Stepped:Connect(function()
            pcall(function()
                if autopunch then
                    local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(11)
                        game.Players.LocalPlayer.muscleEvent:FireServer("punch", "leftHand")
                        game.Players.LocalPlayer.muscleEvent:FireServer("punch", "rightHand")
                        local punchTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch")
                        if punchTool then
                            humanoid:EquipTool(punchTool)
                        end
                    end
                end
            end)
        end)
    end
})

-- 5. 自动抽奖 - Toggle
Tabs.ConfigTab:Toggle({
    Title = "自动抽奖",
    Value = false,
    Callback = function(state)
        while state do
            game:GetService("ReplicatedStorage").rEvents.openFortuneWheelRemote:InvokeServer("openFortuneWheel", game:GetService("ReplicatedStorage").fortuneWheelChances:FindFirstChild("Fortune Wheel"))
        end
    end
})

-- 6. 自动领取在线奖励 - Toggle
Tabs.ConfigTab:Toggle({
    Title = "自动领取在线奖励",
    Value = false,
    Callback = function(state)
        spawn(function()
            while state do
                pcall(function()
                    for i=1, 8 do
                        game:GetService("ReplicatedStorage").rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)
                    end
                end)
            end
        end)
    end
})

-- 7. 解锁全通行证 - Button
Tabs.ConfigTab:Button({
    Title = "解锁全通行证",
    Callback = function()
        for i, v in ipairs(game:GetService("ReplicatedStorage").gamepassIds:GetChildren()) do
            v.Parent = game.Players.LocalPlayer.ownedGamepasses
        end
    end
})

-- 选择工具 - Dropdown（修复：Options → Values）
Tabs.ExerciseTab:Dropdown({
    Title = "选择工具",
    Values = {"哑铃","俯卧撑","仰卧起坐","倒立"}, -- 关键修复：Options 改为 Values
    Callback = function(Value)
        Interstellar = Interstellar or {}
        if Value == "哑铃" then
            Interstellar.ToolName = "Weight"
        elseif Value == "俯卧撑" then
            Interstellar.ToolName = "Pushups"
        elseif Value == "仰卧起坐" then
            Interstellar.ToolName = "Situps"
        elseif Value == "倒立" then
            Interstellar.ToolName = "Handstands"
        end
    end
})

-- 自动锻炼 - Toggle（原逻辑保留）
Tabs.ExerciseTab:Toggle({
    Title = "自动锻炼",
    Value = false,
    Callback = function(state)
        Interstellar = Interstellar or {}
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ClassName == "Tool" and v.Name == Interstellar.ToolName then
                v.Parent = game.Players.LocalPlayer.Character
                local numValue = v:FindFirstChildOfClass("NumberValue")
                if numValue then
                    numValue.Value = 0
                end
                wait()
            end
        end
        Interstellar.Main = state
        if Interstellar.Main then
            while Interstellar.Main do
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                wait()
            end
        end
    end
})

-- 自动全锻炼全部工具 - Toggle（原逻辑保留）
Tabs.ExerciseTab:Toggle({
    Title = "自动全锻炼全部工具",
    Value = false,
    Callback = function(state)
        Interstellar = Interstellar or {}
        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ClassName == "Tool" and (v.Name == "Weight" or v.Name == "Handstands" or v.Name == "Pushups" or v.Name == "Situps") then
                v.Parent = game.Players.LocalPlayer.Character
                local numValue = v:FindFirstChildOfClass("NumberValue")
                if numValue then
                    numValue.Value = 0
                end
                wait()
            end
        end
        Interstellar.Main = state
        if Interstellar.Main then
            while Interstellar.Main do
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                wait()
            end
        end
    end
})

-- 选择石头 - Dropdown（修复：Options → Values）
Tabs.ExerciseTab:Dropdown({
    Title = "选择石头",
    Values = {"Frozen Rock","Inferno Rock","Rock Of Legends","Muscle King Mountain"}, -- 关键修复：Options 改为 Values
    Callback = function(Value)
        Interstellar = Interstellar or {}
        Interstellar.Rock = Value
    end
})

-- 自动打石头(隔空打石头) - Toggle（原逻辑保留）
Tabs.ExerciseTab:Toggle({
    Title = "自动打石头(隔空打石头)",
    Value = false,
    Callback = function(rocks)
        getgenv().rocks = rocks
        while getgenv().rocks do
            local punchTool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch")
            if punchTool then
                local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:EquipTool(punchTool)
                    punchTool:Activate()
                end
            end

            local rockFolder = game.workspace:FindFirstChild("machinesFolder")
            local rock = rockFolder and rockFolder:FindFirstChild(Interstellar.Rock) and rockFolder[Interstellar.Rock]:FindFirstChild("Rock")
            if rock then
                firetouchinterest(rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                firetouchinterest(rock, game.Players.LocalPlayer.Character.LeftHand, 1)
            end

            wait()
        end
    end
})

-- 选择跑步机 - Dropdown（修复：Options → Values）
Tabs.ExerciseTab:Dropdown({
    Title = "选择跑步机",
    Values = {"0", "20", "100", "250", "600", "2000", "3000", "3500"}, -- 关键修复：Options 改为 Values
    Callback = function(value)
        Interstellar = Interstellar or {}
        if value == "0" then
            Interstellar.selectedTreadmillPart = workspace.Treadmills:GetChildren()[16].treadmillPart
        elseif value == "20" then
            Interstellar.selectedTreadmillPart = workspace.Treadmills:GetChildren()[37].treadmillPart
        elseif value == "100" then
            Interstellar.selectedTreadmillPart = workspace.Treadmills:GetChildren()[47].treadmillPart
        elseif value == "250" then
            Interstellar.selectedTreadmillPart = workspace.Treadmills:GetChildren()[49].treadmillPart
        elseif value == "600" then
            Interstellar.selectedTreadmillPart = workspace.Treadmills:GetChildren()[38].treadmillPart
        elseif value == "2000" then
            Interstellar.selectedTreadmillPart = workspace.Treadmills:GetChildren()[33].treadmillPart
        elseif value == "3000" then
            Interstellar.selectedTreadmillPart = workspace.Treadmills["Frost Treadmill"].treadmillPart
        elseif value == "3500" then
            Interstellar.selectedTreadmillPart = workspace.Treadmills["Eternal Treadmill"].treadmillPart
        end
    end
})

-- 开始跑步 - Toggle（原逻辑保留）
Tabs.ExerciseTab:Toggle({
    Title = "开始跑步",
    Value = false,
    Callback = function(state)
        Interstellar = Interstellar or {}
        Interstellar.Main = state
        if state then
            while Interstellar.Main do
                local humanoidRootPart = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart and Interstellar.selectedTreadmillPart then
                    humanoidRootPart.CFrame = Interstellar.selectedTreadmillPart.CFrame
                    game:GetService("RunService"):BindToRenderStep("move", Enum.RenderPriority.Character.Value + 1, function()
                        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid:Move(Vector3.new(10000, 0, -1), true)
                        end
                    end)
                end
                wait()
            end
        end
    end
})

-- 选择深蹲架 - Dropdown（修复：Options → Values）
Tabs.ExerciseTab:Dropdown({
    Title = "选择深蹲架",
    Values = {"1500", "2500", "4000", "5000", "10000"}, -- 关键修复：Options 改为 Values
    Callback = function(value)
        Interstellar = Interstellar or {}
        if value == "1500" then
            Interstellar.selectedBarbell = workspace.machinesFolder:GetChildren()[145].Barbell
        elseif value == "2500" then
            Interstellar.selectedBarbell = workspace.machinesFolder:GetChildren()[33].Barbell
        elseif value == "4000" then
            Interstellar.selectedBarbell = workspace.machinesFolder:GetChildren()[93].Barbell
        elseif value == "5000" then
            Interstellar.selectedBarbell = workspace.machinesFolder["Frost Lift"].Barbell
        elseif value == "10000" then
            Interstellar.selectedBarbell = workspace.machinesFolder["Muscle King Lift"].Barbell
        end
    end
})

-- 开始深蹲 - Toggle（原逻辑保留）
Tabs.ExerciseTab:Toggle({
    Title = "开始深蹲",
    Value = false,
    Callback = function(state)
        Interstellar = Interstellar or {}
        Interstellar.Main = state
        if state then
            spawn(function()
                while Interstellar.Main do
                    wait()
                    if game.Players.LocalPlayer.machineInUse.Value == nil then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                    else
                        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep", Interstellar.selectedBarbell.interactSeat)
                    end
                end
            end)
        end
    end
})

-- 饮食选择下拉菜单（严格对齐 CombatTab 格式）
Tabs.ExerciseTab:Dropdown({
    Title = "选择吃的食物",
    Values = {"蛋白质棒", "能量棒", "健壮条", "蛋白质奶昔", "超级奶昔", "能量奶昔"},
    Value = "",
    Callback = function(value)
        Interstellar = Interstellar or {}
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character

        if value == "蛋白质棒" then
            Interstellar.foodName = "proteinBar"
            Interstellar.foodItem = character:FindFirstChild("proteinBar")
        elseif value == "能量棒" then
            Interstellar.foodName = "energyBar"
            Interstellar.foodItem = character:FindFirstChild("energyBar")
        elseif value == "健壮条" then
            Interstellar.foodName = "toughBar"
            Interstellar.foodItem = character:FindFirstChild("toughBar")
        elseif value == "蛋白质奶昔" then
            Interstellar.foodName = "proteinShake"
            Interstellar.foodItem = character:FindFirstChild("proteinShake")
        elseif value == "超级奶昔" then
            Interstellar.foodName = "ultraShake"
            Interstellar.foodItem = character:FindFirstChild("ultraShake")
        elseif value == "能量奶昔" then
            Interstellar.foodName = "energyShake"
            Interstellar.foodItem = character:FindFirstChild("energyShake")
        end

        player.muscleEvent:FireServer(Interstellar.foodName, Interstellar.foodItem)
    end
})

Tabs.CrystalTab:Toggle({
    Title = "蓝色水晶",
    Value = false,
    Callback = function(state)
        Interstellar.AutoOpen = state
        if Interstellar.AutoOpen then
            while Interstellar.AutoOpen do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Blue Crystal")
                wait()
            end
        end
    end
})

Tabs.CrystalTab:Toggle({
    Title = "绿色水晶",
    Value = false,
    Callback = function(state)
        Interstellar.AutoOpen = state
        if Interstellar.AutoOpen then
            while Interstellar.AutoOpen do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Green Crystal")
                wait()
            end
        end
    end
})

Tabs.CrystalTab:Toggle({
    Title = "冰霜水晶",
    Value = false,
    Callback = function(state)
        Interstellar.AutoOpen = state
        if Interstellar.AutoOpen then
            while Interstellar.AutoOpen do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Frost Crystal")
                wait()
            end
        end
    end
})

Tabs.CrystalTab:Toggle({
    Title = "神话水晶",
    Value = false,
    Callback = function(state)
        Interstellar.AutoOpen = state
        if Interstellar.AutoOpen then
            while Interstellar.AutoOpen do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Mythical Crystal")
                wait()
            end
        end
    end
})

Tabs.CrystalTab:Toggle({
    Title = "地狱火水晶",
    Value = false,
    Callback = function(state)
        Interstellar.AutoOpen = state
        if Interstellar.AutoOpen then
            while Interstellar.AutoOpen do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Inferno Crystal")
                wait()
            end
        end
    end
})

Tabs.CrystalTab:Toggle({
    Title = "传奇水晶",
    Value = false,
    Callback = function(state)
        Interstellar.AutoOpen = state
        if Interstellar.AutoOpen then
            while Interstellar.AutoOpen do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Legends Crystal")
                wait()
            end
        end
    end
})

Tabs.CrystalTab:Toggle({
    Title = "肌肉精英水晶",
    Value = false,
    Callback = function(state)
        Interstellar.AutoOpen = state
        if Interstellar.AutoOpen then
            while Interstellar.AutoOpen do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Muscle Elite Crystal")
                wait()
            end
        end
    end
})

Tabs.CrystalTab:Toggle({
    Title = "力量之王水晶",
    Value = false,
    Callback = function(state)
        Interstellar.AutoOpen = state
        if Interstellar.AutoOpen then
            while Interstellar.AutoOpen do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Galaxy Oracle Crystal")
                wait()
            end
        end
    end
})

Tabs.CrystalTab:Toggle({
    Title = "古老丛林岩石水晶",
    Value = false,
    Callback = function(state)
        Interstellar.AutoOpen = state
        if Interstellar.AutoOpen then
            while Interstellar.AutoOpen do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Ancient Jungle Rock")
                wait()
            end
        end
    end
})

Tabs.CrystalTab:Toggle({
    Title = "天蚀水晶",
    Value = false,
    Callback = function(state)
        Interstellar.AutoOpen = state
        if Interstellar.AutoOpen then
            while Interstellar.AutoOpen do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Sky Eclipse Crystal")
                wait()
            end
        end
    end
})

Tabs.CrystalTab:Toggle({
    Title = "战斗传奇水晶",
    Value = false,
    Callback = function(state)
        Interstellar.AutoOpen = state
        if Interstellar.AutoOpen then
            while Interstellar.AutoOpen do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Battle Legends Crystal")
                wait()
            end
        end
    end
})

Tabs.CrystalTab:Toggle({
    Title = "暗星云水晶",
    Value = false,
    Callback = function(state)
        Interstellar.AutoOpen = state
        if Interstellar.AutoOpen then
            while Interstellar.AutoOpen do
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Dark Nebula Crystal")
                wait()
            end
        end
    end
})

Tabs.BuysTab:Toggle({
    Title = "自动购买暗星猎人",
    Value = false,
    Callback = function(state)
        Interstellar.Main = state
        if Interstellar.Main then
            while Interstellar.Main do
                local pet = game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild("Darkstar Hunter")
                if pet then
                    game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(pet)
                end
                wait()
            end
        end
    end
})

Tabs.BuysTab:Toggle({
    Title = "自动购买小金人",
    Value = false,
    Callback = function(state)
        Interstellar.Main = state
        if Interstellar.Main then
            while Interstellar.Main do
                local pet = game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild("Gold Warrior")
                if pet then
                    game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(pet)
                end
                wait()
            end
        end
    end
})

Tabs.BuysTab:Toggle({
    Title = "自动购买以太精灵兔子",
    Value = false,
    Callback = function(state)
        Interstellar.Main = state
        if Interstellar.Main then
            while Interstellar.Main do
                local pet = game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild("Aether Spirit Bunny")
                if pet then
                    game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(pet)
                end
                wait()
            end
        end
    end
})

Tabs.BuysTab:Toggle({
    Title = "自动购买肌肉王光环",
    Value = false,
    Callback = function(state)
        Interstellar.Main = state
        if Interstellar.Main then
            while Interstellar.Main do
                local pet = game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild("Muscle King")
                if pet then
                    game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(pet)
                end
                wait()
            end
        end
    end
})

Tabs.BuysTab:Toggle({
    Title = "自动购买控制论对决龙",
    Value = false,
    Callback = function(state)
        Interstellar.Main = state
        if Interstellar.Main then
            while Interstellar.Main do
                local pet = game:GetService("ReplicatedStorage").cPetShopFolder:FindFirstChild("Cybernetic Showdown Dragon")
                if pet then
                    game:GetService("ReplicatedStorage").cPetShopRemote:InvokeServer(pet)
                end
                wait()
            end
        end
    end
})

Tabs.EvolveTab:Toggle({
    Title = "自动进化暗星猎人",
    Value = false,
    Callback = function(state)
        Interstellar.Main = state
        if Interstellar.Main then
            while Interstellar.Main do
                game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer("evolvePet", "Darkstar Hunter")
                wait()
            end
        end
    end
})

Tabs.EvolveTab:Toggle({
    Title = "自动进化小金人",
    Value = false,
    Callback = function(state)
        Interstellar.Main = state
        if Interstellar.Main then
            while Interstellar.Main do
                game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer("evolvePet", "Gold Warrior")
                wait()
            end
        end
    end
})

Tabs.EvolveTab:Toggle({
    Title = "自动进化以太精灵兔子",
    Value = false,
    Callback = function(state)
        Interstellar.Main = state
        if Interstellar.Main then
            while Interstellar.Main do
                game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer("evolvePet", "Aether Spirit Bunny")
                wait()
            end
        end
    end
})

Tabs.EvolveTab:Toggle({
    Title = "自动进化控制论对决龙",
    Value = false,
    Callback = function(state)
        Interstellar.Main = state
        if Interstellar.Main then
            while Interstellar.Main do
                game:GetService("ReplicatedStorage").rEvents.petEvolveEvent:FireServer("evolvePet", "Cybernetic Showdown Dragon")
                wait()
            end
        end
    end
})

-- 传送到出生点
Tabs.MianTab:Button({
    Title = "传送到出生点",
    Desc = "快速返回初始出生位置",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char then char.HumanoidRootPart.CFrame = CFrame.new(7, 3, 108) end
    end
})

-- 传送到冰霜健身房
Tabs.MianTab:Button({
    Title = "传送到冰霜健身房",
    Desc = "前往冰霜训练场地",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char then char.HumanoidRootPart.CFrame = CFrame.new(-2543, 13, -410) end
    end
})

-- 传送到神话健身房
Tabs.MianTab:Button({
    Title = "传送到神话健身房",
    Desc = "前往神话训练场地",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char then char.HumanoidRootPart.CFrame = CFrame.new(2177, 13, 1070) end
    end
})

-- 传送到永恒健身房
Tabs.MianTab:Button({
    Title = "传送到永恒健身房",
    Desc = "前往永恒训练场地",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char then char.HumanoidRootPart.CFrame = CFrame.new(-6686, 13, -1284) end
    end
})

-- 传送到传说健身房
Tabs.MianTab:Button({
    Title = "传送到传说健身房",
    Desc = "前往传说训练场地",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char then char.HumanoidRootPart.CFrame = CFrame.new(4676, 997, -3915) end
    end
})

-- 传送到肌肉之王健身房
Tabs.MianTab:Button({
    Title = "传送到肌肉之王健身房",
    Desc = "前往肌肉之王训练场地",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char then char.HumanoidRootPart.CFrame = CFrame.new(-8554, 22, -5642) end
    end
})

-- 传送到安全岛
Tabs.MianTab:Button({
    Title = "传送到安全岛",
    Desc = "前往无干扰的安全区域",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char then char.HumanoidRootPart.CFrame = CFrame.new(-39, 10, 1838) end
    end
})

local selectedPlrName = ""
-- 【新增】直接存储下拉框实例变量
local playerDropdown

-- 玩家选择下拉框（适配新格式，Tab 名保持 Tabs.InfoTab）
playerDropdown = Tabs.InfoTab:Dropdown({
    Title = "选择玩家",
    Values = {},
    Value = "",
    Callback = function(option)
        selectedPlrName = option
    end
})

-- 重置玩家列表按钮（归属 Tab 仍为 Tabs.InfoTab）
Tabs.InfoTab:Button({
    Title = "重置玩家名字",
    Callback = function()
        local plrs = {}
        for _, p in ipairs(game.Players:GetPlayers()) do
            table.insert(plrs, p.Name)
        end
        -- 直接通过存储的实例调用Refresh方法
        if playerDropdown then
            playerDropdown:Refresh(plrs)
        end
    end
})

-- 复制玩家信息按钮（归属 Tab 仍为 Tabs.InfoTab）
Tabs.InfoTab:Button({
    Title = "复制他的信息",
    Callback = function()
        local target = game.Players:FindFirstChild(selectedPlrName)
        if not target then return end
        pcall(function()
            local tLeaderstats = target.leaderstats
            local info = string.format(
                "名字: %s\n力量: %d\n耐力: %d\n敏捷: %d\n重生: %d\n宝石数量: %d\n坏人业报: %d\n好人业报: %d\n总业报: %d",
                target.Name, tLeaderstats.Strength.Value, target.Durability.Value,
                target.Agility.Value, tLeaderstats.Rebirths.Value, target.Gems.Value,
                target.evilKarma.Value, target.goodKarma.Value, tLeaderstats.Kills.Value
            )
            setclipboard(info)
        end)
    end
})

-- 【新增】下拉框初始化刷新逻辑
local function initPlayerDropdown()
    local plrs = {}
    for _, p in ipairs(game.Players:GetPlayers()) do
        table.insert(plrs, p.Name)
    end
    if playerDropdown then
        playerDropdown:Refresh(plrs)
    end
end
initPlayerDropdown()