local WindUI
do
    local ok, result = pcall(function()
        return require("./src/init")
    end)
    
    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/ROB5201314/ROB_Script/refs/heads/main/wind.ui"))()
    end
end
WindUI.TransparencyValue = 0.2
WindUI:SetTheme("Dark")

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

local Confirmed = false
WindUI:Popup({
    Title = gradient("LSJ Script Hub", Color3.fromHex("#6A11CB"), Color3.fromHex("#2575FC")),
    Icon = "sparkles",
    IconThemed = true,
    Content = "欢迎使用洛杉矶脚本！\n最新版本 \n制作人『洛杉矶』\n脚本中心群聊1077022323",
    Buttons = {
        { Title = "取消", Callback = function() end, Variant = "Secondary" },
        { Title = "确认", Icon = "arrow-right", Callback = function() Confirmed = true end, Variant = "Primary" }
    }
})
repeat wait() until Confirmed

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
UserLabel.Position = UDim2.new(0.8, 0, 0.0009, 0)
UserLabel.Size = UDim2.new(0, 135, 0, 50)
UserLabel.Font = Enum.Font.GothamSemibold
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

local Window = WindUI:CreateWindow({
    Title = "『洛杉矶』LSJ hub",
    Author = "『力量传奇』♪洛杉矶",
    Folder = "『洛杉矶』_scriptHUB",
    NewElements = true,
    Size = UDim2.fromOffset(480, 360),
    Theme = "Dark",
    HideSearchBar = false,
    SideBarWidth = 220,
    ScrollBarEnabled = true,
    OpenButton = {
        Title = "『洛杉矶』力量传奇脚本💪",
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 3,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Color = ColorSequence.new(Color3.fromHex("#4A4AFF"), Color3.fromHex("#EA0000"))
    },
    Background = WindUI:Gradient({
        ["0"] = {Color = Color3.fromHex("#0f0c29"), Transparency = 1},
        ["100"] = {Color = Color3.fromHex("#302b63"), Transparency = 0.9}
    }, {Rotation = 45}),
    Background = "rbxassetid://98568713086736",
    Icon = "video:https://raw.githubusercontent.com/xiaoxi9008/chesksks/refs/heads/main/Video_1773632365272_24.mp4",
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
    KeySystem = { 
        Key = { "洛杉矶牛逼", "洛杉矶NB", "洛杉矶牛逼666" },
        Note = "请输入卡密解锁功能\n官方群: 1077022323",
        Thumbnail = {
            Image = "rbxassetid://98568713086736",
            Size = UDim2.fromOffset(80, 80)
        },
        URL = "点击链接加入群聊【ROBLOX牛逼脚本 [联邦]】：https://qun.qq.com/universal-share/share?ac=1&authKey=cKQfS2Eq1sW7sR%2FxRfiffHQ20HrOrYAtK2wRU48%2B9GqeYzQrzQzAL98yDdafJBHV&busi_data=eyJncm91cENvZGUiOiIxMDc3MDIyMzIzIiwidG9rZW4iOiJMMjhNYmpEOHZLdlducGtIWHRCNUtodGorbmloalhHNmgva0ZMT2s3bDcvSE5IcVJnaWplZVdJRi9CNWdKUkdUIiwidWluIjoiMzg5Nzg4Njk0OSJ9&data=k51IhdGgfFjoLsqOjR11Qb8_fakNqmIEPbtb7g36Io_e456tUZQHB5SzasUCy63NcNZ3nvzYa9AVB8OBFG1NA&svctype=4&tempid=h5_group_info",
        SaveKey = false
    }
})
Window:SetBackgroundImageTransparency(0.7)
Window:Tag({ Title = "力量传奇脚本v.1", Color = Color3.fromHex("#30ff6a") })

task.spawn(function()
    while not Window.UIElements or not Window.UIElements.Main do task.wait() end
    local mainFrame = Window.UIElements.Main
    local logo = Instance.new("ImageLabel")
    logo.Image = "rbxassetid://98568713086736"
    logo.BackgroundTransparency = 1
    logo.Size = UDim2.fromOffset(40, 40)
    logo.Position = UDim2.new(0, 10, 0, 10)
    logo.ZIndex = 1000
    logo.Parent = mainFrame
end)

local Tabs = {}
do
    Tabs.MainSection = Window:Section({Title = "力量传奇", Opened = true})
    Tabs.ParagraphTab = Tabs.MainSection:Tab({ Title = "关于", Icon = "zap" })
    Tabs.kenTab = Tabs.MainSection:Tab({ Title = "作者", Icon = "zap" })
    Tabs.playerTab = Tabs.MainSection:Tab({ Title = "玩家", Icon = "zap" })
end

Tabs.ParagraphTab:Paragraph({
    Title = "您的游戏名称：",
    Desc = game:GetService("Players").LocalPlayer.DisplayName,
    Buttons = {{ Title = "复制您的名称", Icon = "copy", Variant = "Primary", Callback = function() setclipboard(game:GetService("Players").LocalPlayer.DisplayName) end }}
})
Tabs.ParagraphTab:Paragraph({
    Title = "您的游戏用户名：",
    Desc = game:GetService("Players").LocalPlayer.Name,
    Buttons = {{ Title = "复制您的用户名", Icon = "copy", Variant = "Primary", Callback = function() setclipboard(game:GetService("Players").LocalPlayer.Name) end }}
})
Tabs.ParagraphTab:Paragraph({
    Title = "您的账号注册时间（天）：",
    Desc = game:GetService("Players").LocalPlayer.AccountAge,
    Buttons = {{ Title = "复制您的注册时间", Icon = "copy", Variant = "Primary", Callback = function() setclipboard(game:GetService("Players").LocalPlayer.AccountAge) end }}
})
Tabs.ParagraphTab:Paragraph({
    Title = "您的用户名ID：",
    Desc = game:GetService("Players").LocalPlayer.UserId,
    Buttons = {{ Title = "复制您的用户名ID", Icon = "copy", Variant = "Primary", Callback = function() setclipboard(game:GetService("Players").LocalPlayer.UserId) end }}
})
Tabs.ParagraphTab:Paragraph({
    Title = "您所在的服务器名称：",
    Desc = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Buttons = {{ Title = "复制服务器名称", Icon = "copy", Variant = "Primary", Callback = function() setclipboard(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name) end }}
})
Tabs.ParagraphTab:Paragraph({
    Title = "您所在的服务器ID：",
    Desc = game.PlaceId,
    Buttons = {{ Title = "复制服务器ID", Icon = "copy", Variant = "Primary", Callback = function() setclipboard("无法复制") end }}
})
Tabs.ParagraphTab:Paragraph({
    Title = "您的注入器：",
    Desc = identifyexecutor(),
    Image = "rbxassetid://129287693322764",
    ImageSize = 42,
    Thumbnail = "rbxassetid://94512740386917",
    ThumbnailSize = 120,
    Buttons = {{
        Title = "测试您注入器的UNC",
        Variant = "Primary",
        Callback = function() 
            Window:Dialog({
                Title = "冷寂脚本中心",
                Content = "请勿点击多次，不然会造成游戏的卡顿!",
                Icon = "bell",
                Buttons = {{ Title = "确定", Variant = "Primary", Callback = function() print("ok") end }}
            })
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Yungengxin/roblox/refs/heads/main/unc"))()
        end
    }}
})

Tabs.kenTab:Paragraph({
    Title = "脚本制作人『洛杉矶』",
    Desc = "后期还会更新",
    Buttons = {{ Title = "复制作者QQ号", Icon = "copy", Variant = "Primary", Callback = function() setclipboard("3897886949") end }}
})
Tabs.kenTab:Code({
    Title = "洛杉矶牛逼脚本群",
    Code = "点击链接加入群聊【ROBLOX牛逼脚本 [联邦]】：https://qun.qq.com/universal-share/share?ac=1&authKey=cKQfS2Eq1sW7sR%2FxRfiffHQ20HrOrYAtK2wRU48%2B9GqeYzQrzQzAL98yDdafJBHV&busi_data=eyJncm91cENvZGUiOiIxMDc3MDIyMzIzIiwidG9rZW4iOiJMMjhNYmpEOHZLdlducGtIWHRCNUtodGorbmloalhHNmgva0ZMT2s3bDcvSE5IcVJnaWplZVdJRi9CNWdKUkdUIiwidWluIjoiMzg5Nzg4Njk0OSJ9&data=k51IhdGgfFjoLsqOjR11Qb8_fakNqmIEPbtb7g36Io_e456tUZQHB5SzasUCy63NcNZ3nvzYa9AVB8OBFG1NA&svctype=4&tempid=h5_group_info",
})

Tabs.playerTab:Input({
    Title = "力量",
    Value = tostring(game:GetService("Players").LocalPlayer.leaderstats.Strength.Value),
    Callback = function(value) if value and tonumber(value) then game:GetService("Players").LocalPlayer.leaderstats.Strength.Value = tonumber(value) end end
})
Tabs.playerTab:Input({
    Title = "耐力",
    Value = tostring(game:GetService("Players").LocalPlayer.Durability.Value),
    Callback = function(value) if value and tonumber(value) then game:GetService("Players").LocalPlayer.Durability.Value = tonumber(value) end end
})
Tabs.playerTab:Input({
    Title = "敏捷",
    Value = tostring(game:GetService("Players").LocalPlayer.Agility.Value),
    Callback = function(value) if value and tonumber(value) then game:GetService("Players").LocalPlayer.Agility.Value = tonumber(value) end end
})
Tabs.playerTab:Input({
    Title = "重生",
    Value = tostring(game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value),
    Callback = function(value) if value and tonumber(value) then game:GetService("Players").LocalPlayer.leaderstats.Rebirths.Value = tonumber(value) end end
})
Tabs.playerTab:Input({
    Title = "宝石",
    Value = tostring(game:GetService("Players").LocalPlayer.Gems.Value),
    Callback = function(value) if value and tonumber(value) then game:GetService("Players").LocalPlayer.Gems.Value = tonumber(value) end end
})
Tabs.playerTab:Input({
    Title = "比赛次数",
    Value = tostring(game:GetService("Players").LocalPlayer.leaderstats.Brawls.Value),
    Callback = function(value) if value and tonumber(value) then game:GetService("Players").LocalPlayer.leaderstats.Brawls.Value = tonumber(value) end end
})
Tabs.playerTab:Input({
    Title = "邪恶业报",
    Value = tostring(game:GetService("Players").LocalPlayer.evilKarma.Value),
    Callback = function(value) if value and tonumber(value) then game:GetService("Players").LocalPlayer.evilKarma.Value = tonumber(value) end end
})
Tabs.playerTab:Input({
    Title = "好人业报",
    Value = tostring(game:GetService("Players").LocalPlayer.goodKarma.Value),
    Callback = function(value) if value and tonumber(value) then game:GetService("Players").LocalPlayer.goodKarma.Value = tonumber(value) end end
})
Tabs.playerTab:Input({
    Title = "总业报",
    Value = tostring(game:GetService("Players").LocalPlayer.leaderstats.Kills.Value),
    Callback = function(value) if value and tonumber(value) then game:GetService("Players").LocalPlayer.leaderstats.Kills.Value = tonumber(value) end end
})

do
    local featureSection = Window:Section({Title = "洛杉矶功能", Opened = true})
    local mainTab = featureSection:Tab({Title = "主要", Icon = "layout-grid"})
    local rockTab = featureSection:Tab({Title = "打石头🤫", Icon = "layout-grid"})
    local karmaTab = featureSection:Tab({Title = "刷业报😻", Icon = "layout-grid"})
    local equipTab = featureSection:Tab({Title = "其他器材💀", Icon = "layout-grid"})
    local rebirthTab = featureSection:Tab({Title = "重生🤖", Icon = "layout-grid"})
    local modifyTab = featureSection:Tab({Title = "修改😈", Icon = "layout-grid"})
    local teleportTab = featureSection:Tab({Title = "传送👽", Icon = "layout-grid"})
    local collectTab = featureSection:Tab({Title = "收集👾", Icon = "layout-grid"})
    local petTab = featureSection:Tab({Title = "宠物蛋🎃", Icon = "layout-grid"})
    local generalTab = featureSection:Tab({Title = "通用🙀", Icon = "layout-grid"})
    local otherTab = featureSection:Tab({Title = "切换包脚本", Icon = "layout-grid"})

    do
        local section = mainTab:Section({Title = "比赛类", Opened = true})
        section:Toggle({
            Title = "自动比赛开关",
            Default = false,
            Callback = function(state)
                getgenv().AutoBrawl = state
                while getgenv().AutoBrawl do
                    wait(2)
                    game:GetService("ReplicatedStorage").rEvents.brawlEvent:FireServer("joinBrawl")
                    wait()
                end
            end
        })
    end
    do
        local section = mainTab:Section({Title = "防打自动训练", Opened = true})
        section:Paragraph({
            Title = "关于防打自动锻炼",
            Desc = "死亡后不会继续\n因为继续会失去道具\n所以我就没弄\n我建议的是不防打和安全点循环传送即可",
        })
        local function createSafeTrainToggle(name, varName, toolNames)
            section:Toggle({
                Title = "自动" .. name,
                Default = false,
                Callback = function(state)
                    getgenv()[varName] = state
                    local oldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    local part = Instance.new('Part', workspace)
                    part.Size = Vector3.new(500, 20, 530.1)
                    part.Position = Vector3.new(0, 100000, 133.15)
                    part.CanCollide = true
                    part.Anchored = true
                    while getgenv()[varName] do
                        wait()
                        local char = game.Players.LocalPlayer.Character
                        if not char then wait(1) continue end
                        char.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 50, 0)
                        for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v.ClassName == "Tool" and table.find(toolNames, v.Name) then
                                if v:FindFirstChildOfClass("NumberValue") then
                                    v:FindFirstChildOfClass("NumberValue").Value = 0
                                end
                                repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                char:WaitForChild("Humanoid"):EquipTool(v)
                                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                            end
                        end
                    end
                    part:Destroy()
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        char.HumanoidRootPart.CFrame = oldPos
                        char:WaitForChild("Humanoid"):UnequipTools()
                    end
                end
            })
        end
        createSafeTrainToggle("全部", "AutoTrainTriple", {"Handstands", "Situps", "Pushups", "Weight"})
        createSafeTrainToggle("举哑铃", "AutoWeight", {"Weight"})
        createSafeTrainToggle("俯卧撑", "AutoPushup", {"Pushups"})
        createSafeTrainToggle("仰卧起坐", "AutoSitup", {"Situps"})
        createSafeTrainToggle("倒立", "AutoHandstand", {"Handstands"})
    end
    do
        local section = mainTab:Section({Title = "不防打可移动自动训练", Opened = true})
        local function createMoveTrainToggle(name, varName, toolNames)
            section:Toggle({
                Title = "自动" .. name,
                Default = false,
                Callback = function(state)
                    getgenv()[varName] = state
                    spawn(function()
                        while getgenv()[varName] do
                            pcall(function()
                                local char = game.Players.LocalPlayer.Character
                                if not char then wait(2)
                                else
                                    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                        if v.ClassName == "Tool" and table.find(toolNames, v.Name) then
                                            v.Parent = char
                                            game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                                            wait(0.03)
                                            v.Parent = game.Players.LocalPlayer.Backpack
                                            wait(0.2)
                                        end
                                    end
                                end
                            end)
                            wait()
                        end
                        if not getgenv()[varName] then
                            for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                                if v:IsA("Tool") and table.find(toolNames, v.Name) then
                                    v.Parent = game.Players.LocalPlayer.Backpack
                                end
                            end
                        end
                    end)
                end
            })
        end
        createMoveTrainToggle("举哑铃", "AutoWeight", {"Weight"})
        createMoveTrainToggle("俯卧撑", "AutoPushups", {"Pushups"})
        createMoveTrainToggle("仰卧起坐", "AutoSitups", {"Situps"})
        createMoveTrainToggle("倒立", "AutoHandstands", {"Handstands"})
        createMoveTrainToggle("全锻炼全部", "AutoAllTrain", {"Weight", "Handstands", "Pushups", "Situps"})
    end

    do
        local section = rockTab:Section({Title = "石头对照表", Opened = true})
        section:Paragraph({
            Title = "因为列表汉化有问题",
            Desc = "Tiny Rock = 10耐力\nInferno Rock = 100耐力\nPunching Rock = 5000耐力\nRock Of Legends = 150000耐力\nMuscle King Mountain = 400000耐力\nAncient Jungle Rock = 750000耐力\nMuscle King Mountain = 100万耐力\nAncient Jungle Rock = 500万耐力\nAncient Jungle Rock = 1000万耐力",
        })
    end
    do
        local section = rockTab:Section({Title = "远程打石头v1", Opened = true})
        local rocks = {"Tiny Rock", "Inferno Rock", "Punching Rock", "Rock Of Legends", "Muscle King Mountain", "Ancient Jungle Rock"}
        local selectedRock = "Tiny Rock"
        section:Dropdown({
            Title = "选择石头",
            Values = rocks,
            Value = selectedRock,
            Callback = function(v) selectedRock = v end
        })
        local autoState = false
        section:Toggle({
            Title = "自动打石头",
            Description = "把石头传送过来打",
            Default = false,
            Callback = function(state)
                autoState = state
                spawn(function()
                    local OldPOS = game:GetService("Workspace").machinesFolder[selectedRock].Rock.CFrame
                    while autoState do
                        wait()
                        pcall(function()
                            for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v:IsA("Tool") and v.Name == "Punch" then
                                    game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v)
                                end
                            end
                            for i, h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                                if h:IsA("Tool") and h.Name == "Punch" then
                                    h:Activate()
                                end
                            end
                            game:GetService("Workspace").machinesFolder[selectedRock].Rock.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                            game:GetService("Workspace").machinesFolder[selectedRock].Rock.CanCollide = false
                            game:GetService("Workspace").machinesFolder[selectedRock].Rock.Transparency = 100
                            game:GetService("Workspace").machinesFolder[selectedRock].Rock.rockGui.rockName.Visible = false
                            game:GetService("Workspace").machinesFolder[selectedRock].Rock.rockGui.statLabel.Visible = false
                        end)
                    end
                    if not autoState then
                        pcall(function()
                            game:GetService("Workspace").machinesFolder[selectedRock].Rock.CFrame = CFrame.new(OldPOS)
                            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools()
                            game:GetService("Workspace").machinesFolder[selectedRock].Rock.CanCollide = true
                            game:GetService("Workspace").machinesFolder[selectedRock].Rock.Transparency = 0
                            game:GetService("Workspace").machinesFolder[selectedRock].Rock.rockGui.rockName.Visible = true
                            game:GetService("Workspace").machinesFolder[selectedRock].Rock.rockGui.statLabel.Visible = true
                        end)
                    end
                end)
            end
        })
    end
    do
        local section = rockTab:Section({Title = "远程打石头v2", Opened = true})
        local rocks = {"Tiny Rock", "Inferno Rock", "Punching Rock", "Rock Of Legends", "Muscle King Mountain", "Ancient Jungle Rock"}
        local selectedRock = "Tiny Rock"
        section:Dropdown({
            Title = "选择石头",
            Values = rocks,
            Value = selectedRock,
            Callback = function(v) selectedRock = v end
        })
        local autoState = false
        section:Toggle({
            Title = "自动打石头",
            Description = "远程隔空",
            Default = false,
            Callback = function(state)
                autoState = state
                spawn(function()
                    while autoState do
                        wait()
                        pcall(function()
                            for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if v:IsA("Tool") and v.Name == "Punch" then
                                    game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v)
                                end
                            end
                            for i, h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                                if h:IsA("Tool") and h.Name == "Punch" then
                                    h:Activate()
                                end
                            end
                            firetouchinterest(game.workspace.machinesFolder[selectedRock].Rock, game.Players.LocalPlayer.Character.LeftHand, 0)
                            firetouchinterest(game.workspace.machinesFolder[selectedRock].Rock, game.Players.LocalPlayer.Character.LeftHand, 1)
                        end)
                    end
                    if not autoState then
                        pcall(function()
                            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools()
                        end)
                    end
                end)
            end
        })
    end
    do
        local section = rockTab:Section({Title = "打石头(传送过去)", Opened = true})
        local rockPositions = {
            ["石头0"] = CFrame.new(7.60643005, 4.02632904, 2104.54004, -0.23040159, -8.53662385e-08, -0.973095655, -4.68743764e-08, 1, -7.66279342e-08, 0.973095655, 2.79580536e-08, -0.23040159),
            ["石头10"] = CFrame.new(-157.680908, 3.72453046, 434.871185, 0.923298299, -1.81774684e-09, -0.384083599, 3.45247031e-09, 1, 3.56670582e-09, 0.384083599, -4.61917082e-09, 0.923298299),
            ["石头100"] = CFrame.new(162.233673, 3.66615629, -164.686783, -0.921312928, -1.80826774e-07, -0.38882193, -9.13036544e-08, 1, -2.48719346e-07, 0.38882193, -1.93647494e-07, -0.921312928),
            ["石头5000"] = CFrame.new(329.831482, 3.66450214, -618.48407, -0.806075394, -8.67358096e-08, 0.591812849, -1.05715522e-07, 1, 2.57029176e-09, -0.591812849, -6.04919563e-08, -0.806075394),
            ["石头150000"] = CFrame.new(-2566.78076, 3.97019577, -277.503235, -0.923934579, -4.11600105e-08, -0.382550538, -3.38838042e-08, 1, -2.57576183e-08, 0.382550538, -1.08360858e-08, -0.923934579),
            ["石头400000"] = CFrame.new(2155.61743, 3.79830337, 1227.06482, -0.551303148, -9.16796949e-09, -0.834304988, -5.61318245e-08, 1, 2.61027839e-08, 0.834304988, 6.12216127e-08, -0.551303148),
            ["石头750000"] = CFrame.new(-7285.6499, 3.66624784, -1228.27417, 0.857643783, -1.58175091e-08, -0.514244199, -1.22581563e-08, 1, -5.12025977e-08, 0.514244199, 5.02172774e-08, 0.857643783),
            ["石头100万"] = CFrame.new(4160.87109, 987.829102, -4136.64502, -0.893115997, 1.25481356e-05, 0.44982639, 5.02490684e-06, 1, -1.79187136e-05, -0.44982639, -1.37431543e-05, -0.893115997),
            ["石头500万"] = CFrame.new(-8957.54395, 5.53625107, -6126.90186, -0.803919137, 6.6065212e-08, 0.594738603, -8.93136143e-09, 1, -1.23155459e-07, -0.594738603, -1.04318865e-07, -0.803919137),
            ["石头1000万"] = CFrame.new(-7552.9, 3.4, 2847.7, -0.803919137, 6.6065212e-08, 0.594738603, -8.93136143e-09, 1, -1.23155459e-07, -0.594738603, -1.04318865e-07, -0.803919137),
        }
        for name, pos in pairs(rockPositions) do
            local autoVar = "_rock_" .. name:gsub("%s+", "")
            section:Toggle({
                Title = name,
                Default = false,
                Callback = function(state)
                    getgenv()[autoVar] = state
                    spawn(function()
                        while getgenv()[autoVar] do
                            wait()
                            pcall(function()
                                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                    if v:IsA("Tool") and v.Name == "Punch" then
                                        game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v)
                                    end
                                end
                                for i, h in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                                    if h:IsA("Tool") and h.Name == "Punch" then
                                        h:Activate()
                                    end
                                end
                                game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = pos
                            end)
                        end
                        if not getgenv()[autoVar] then
                            pcall(function()
                                game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):UnequipTools()
                            end)
                        end
                    end)
                end
            })
        end
    end

    do
        local section = karmaTab:Section({Title = "自动刷业报", Opened = true})
        if not _G.WindUI_AutoStates then
            _G.WindUI_AutoStates = {}
        end
        local AutoStates = _G.WindUI_AutoStates
        section:Toggle({
            Title = "自动刷业报v1",
            Default = false,
            Callback = function(state)
                AutoStates.AutoKillReport = state
                if AutoStates.AutoKillReportLoops then
                    for _, c in pairs(AutoStates.AutoKillReportLoops) do c:Disconnect() end
                end
                AutoStates.AutoKillReportLoops = {}
                if not state then
                    if game.Players.LocalPlayer.Character then
                        local h = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                        if h then h:UnequipTools() end
                    end
                    return
                end
                local pL = game:GetService("RunService").Heartbeat:Connect(function()
                    if not AutoStates.AutoKillReport then pL:Disconnect() return end
                    local c = game.Players.LocalPlayer.Character
                    if c and c:FindFirstChild("Humanoid") and c.Humanoid.Health > 0 then
                        local p = c:FindFirstChild("Punch") or game.Players.LocalPlayer.Backpack:FindFirstChild("Punch")
                        if p then p.Parent = c p:Activate() end
                    end
                end)
                table.insert(AutoStates.AutoKillReportLoops, pL)
                local tL = game:GetService("RunService").Heartbeat:Connect(function()
                    if not AutoStates.AutoKillReport then tL:Disconnect() return end
                    local c = game.Players.LocalPlayer.Character
                    if c and c:FindFirstChild("Humanoid") and c.Humanoid.Health > 0 then
                        local p = {}
                        for _, pl in ipairs(game.Players:GetPlayers()) do
                            if pl ~= game.Players.LocalPlayer and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") and pl.Character.Humanoid.Health > 0 then
                                table.insert(p, pl)
                            end
                        end
                        if #p > 0 then
                            local t = p[math.random(#p)]
                            local r = c:WaitForChild("HumanoidRootPart")
                            r.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                        end
                    end
                end)
                table.insert(AutoStates.AutoKillReportLoops, tL)
            end
        })
        section:Toggle({
            Title = "自动刷业报v2",
            Default = false,
            Callback = function(state)
                AutoStates.AutoKillReport2 = state
                if AutoStates.AutoKillReportLoops2 then
                    for _, c in pairs(AutoStates.AutoKillReportLoops2) do c:Disconnect() end
                end
                AutoStates.AutoKillReportLoops2 = {}
                if not state then
                    if game.Players.LocalPlayer.Character then
                        local h = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                        if h then h:UnequipTools() end
                    end
                    return
                end
                local sP = CFrame.new(-8751.0,120.4,-5863.1,0.59992,-2.24e-09,0.80006,4.46e-09,1,-5.44e-10,-0.80006,3.90e-09,0.59992)
                local function tS()
                    local c = game.Players.LocalPlayer.Character
                    if c and c:FindFirstChild("HumanoidRootPart") then
                        c.HumanoidRootPart.CFrame = sP
                    end
                end
                local lKT = 0
                local kC = 0.15
                local pL = game:GetService("RunService").Heartbeat:Connect(function()
                    if not AutoStates.AutoKillReport2 then pL:Disconnect() return end
                    local c = game.Players.LocalPlayer.Character
                    if c and c:FindFirstChild("Humanoid") and c.Humanoid.Health > 0 then
                        local p = c:FindFirstChild("Punch") or game.Players.LocalPlayer.Backpack:FindFirstChild("Punch")
                        if p then p.Parent = c p:Activate() end
                    end
                end)
                table.insert(AutoStates.AutoKillReportLoops2, pL)
                local tL = game:GetService("RunService").Heartbeat:Connect(function()
                    if not AutoStates.AutoKillReport2 then tL:Disconnect() return end
                    local c = game.Players.LocalPlayer.Character
                    if c and c:FindFirstChild("Humanoid") and c.Humanoid.Health > 0 then
                        local p = {}
                        for _, pl in ipairs(game.Players:GetPlayers()) do
                            if pl ~= game.Players.LocalPlayer and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") and pl.Character.Humanoid.Health > 0 then
                                table.insert(p, pl)
                            end
                        end
                        if #p > 0 then
                            local cT = tick()
                            if cT - lKT >= kC then
                                local t = p[math.random(#p)]
                                local r = c:WaitForChild("HumanoidRootPart")
                                r.CFrame = t.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                                lKT = cT
                            else
                                tS()
                            end
                        else
                            tS()
                        end
                    end
                end)
                table.insert(AutoStates.AutoKillReportLoops2, tL)
                local dC = game.Players.LocalPlayer.CharacterAdded:Connect(function(c)
                    if AutoStates.AutoKillReport2 then wait(1) tS() end
                end)
                table.insert(AutoStates.AutoKillReportLoops2, dC)
            end
        })
        section:Toggle({
            Title = "自动刷业报v3",
            Default = false,
            Callback = function(state)
                getgenv().AutoKarmaV3 = state
                if not state then
                    if autoPunchLoop then autoPunchLoop:Disconnect() autoPunchLoop = nil end
                    if attractLoop then attractLoop:Disconnect() attractLoop = nil end
                    if game.Players.LocalPlayer.Character then
                        local humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                        if humanoid then humanoid:UnequipTools() end
                    end
                    if platform then platform:Destroy() platform = nil end
                    return
                end
                platform = Instance.new('Part', workspace)
                platform.Size = Vector3.new(50, 30, 50)
                platform.Position = Vector3.new(0, 3000000, 0)
                platform.CanCollide = true
                platform.Anchored = true
                platform.Name = "AutoKarmaPlatform"
                local function teleportToPlatform()
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = platform.CFrame + Vector3.new(0, 25, 0)
                    end
                end
                teleportToPlatform()
                game.Players.LocalPlayer.CharacterAdded:Connect(function(newChar)
                    if getgenv().AutoKarmaV3 then
                        newChar:WaitForChild("HumanoidRootPart")
                        teleportToPlatform()
                    end
                end)
                autoPunchLoop = game:GetService("RunService").Heartbeat:Connect(function()
                    if not getgenv().AutoKarmaV3 then return end
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
                        local punch = character:FindFirstChild("Punch") or game.Players.LocalPlayer.Backpack:FindFirstChild("Punch")
                        if punch then punch.Parent = character punch:Activate() end
                    end
                end)
                attractLoop = game:GetService("RunService").Heartbeat:Connect(function()
                    if not getgenv().AutoKarmaV3 then return end
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
                        teleportToPlatform()
                        for _, player in ipairs(game.Players:GetPlayers()) do
                            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.Humanoid.Health > 0 then
                                local targetHRP = player.Character.HumanoidRootPart
                                local myHRP = character.HumanoidRootPart
                                targetHRP.CFrame = myHRP.CFrame * CFrame.new(0, 0, -2)
                            end
                        end
                    end
                end)
            end
        })
        section:Toggle({
            Title = "自动刷业报v4",
            Default = false,
            Callback = function(state)
                AutoStates.AutoKillReport3 = state
                if AutoStates.AutoKillReportLoops3 then
                    for _, c in pairs(AutoStates.AutoKillReportLoops3) do c:Disconnect() end
                end
                AutoStates.AutoKillReportLoops3 = {}
                if not state then
                    if game.Players.LocalPlayer.Character then
                        local h = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                        if h then h:UnequipTools() end
                    end
                    return
                end
                local pL = game:GetService("RunService").Heartbeat:Connect(function()
                    if not AutoStates.AutoKillReport3 then pL:Disconnect() return end
                    for _, target in pairs(game.Players:GetPlayers()) do
                        if target ~= game.Players.LocalPlayer and target.Character and target.Character:FindFirstChild("Humanoid") and target.Character.Humanoid.Health > 0 then
                            pcall(function()
                                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                    if v:IsA("Tool") and v.Name == "Punch" then
                                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                                    end
                                end
                                local p = game.Players.LocalPlayer.Character:FindFirstChild("Punch") or game.Players.LocalPlayer.Backpack:FindFirstChild("Punch")
                                if p then p.Parent = game.Players.LocalPlayer.Character p:Activate() end
                                local head = target.Character:FindFirstChild("Head")
                                local lchar = game.Players.LocalPlayer.Character
                                local hand = lchar and lchar:FindFirstChild("LeftHand")
                                if head and hand then
                                    firetouchinterest(head, hand, 0)
                                    wait(0.01)
                                    firetouchinterest(head, hand, 1)
                                end
                            end)
                        end
                    end
                    wait(0.1)
                end)
                table.insert(AutoStates.AutoKillReportLoops3, pL)
            end
        })
    end
    do
        local section = karmaTab:Section({Title = "自定义", Opened = true})
        Interstellar = Interstellar or {}
        Interstellar.killplayers = {}
        local Plr = game:GetService("Players")
        local LP = Plr.LocalPlayer
        local PlayerList = {}
        local function initializePlayerList()
            PlayerList = {}
            for _, player in ipairs(Plr:GetPlayers()) do
                if player ~= LP then table.insert(PlayerList, player.Name) end
            end
        end
        local function refreshPlayerList()
            initializePlayerList()
            if killplayerDropdown then killplayerDropdown:Refresh(PlayerList) end
            WindUI:Notify({ Title = "玩家列表", Content = "已刷新 (" .. #PlayerList .. " 个玩家)", Duration = 3 })
        end
        Plr.PlayerAdded:Connect(function(player)
            if player ~= LP then
                table.insert(PlayerList, player.Name)
                if killplayerDropdown then killplayerDropdown:Refresh(PlayerList) end
            end
        end)
        Plr.PlayerRemoving:Connect(function(player)
            local index = table.find(PlayerList, player.Name)
            if index then table.remove(PlayerList, index) end
            local killIndex = table.find(Interstellar.killplayers, player.Name)
            if killIndex then table.remove(Interstellar.killplayers, killIndex) end
            if killplayerDropdown then killplayerDropdown:Refresh(PlayerList) end
        end)
        initializePlayerList()
        local killplayerDropdown = section:Dropdown({
            Title = "要远程的玩家",
            Values = PlayerList,
            Value = {},
            Multi = true,
            AllowNone = true,
            Callback = function(values)
                Interstellar.killplayers = values or {}
                WindUI:Notify({ Title = "远程", Content = "已设置 " .. #Interstellar.killplayers .. " 个玩家", Duration = 3 })
            end
        })
        local autoKillState = false
        section:Toggle({
            Title = "选中名单远程击杀(不选列表默认全部)",
            Default = false,
            Callback = function(state)
                autoKillState = state
                if state then
                    spawn(function()
                        while autoKillState do
                            pcall(function()
                                local targets = {}
                                if #Interstellar.killplayers > 0 then targets = Interstellar.killplayers else targets = PlayerList end
                                for _, playerName in pairs(targets) do
                                    local target = Plr:FindFirstChild(playerName)
                                    if target and target.Character and target.Character:FindFirstChild("Humanoid") and target.Character.Humanoid.Health > 0 then
                                        for i, v in pairs(LP.Backpack:GetChildren()) do
                                            if v:IsA("Tool") and v.Name == "Punch" then
                                                LP.Character.Humanoid:EquipTool(v)
                                            end
                                        end
                                        local p = LP.Character:FindFirstChild("Punch") or LP.Backpack:FindFirstChild("Punch")
                                        if p then p.Parent = LP.Character p:Activate() end
                                        local head = target.Character:FindFirstChild("Head")
                                        local lchar = LP.Character
                                        local hand = lchar and lchar:FindFirstChild("LeftHand")
                                        if head and hand then
                                            firetouchinterest(head, hand, 0)
                                            wait(0.01)
                                            firetouchinterest(head, hand, 1)
                                        end
                                    end
                                end
                            end)
                            wait(0.1)
                        end
                    end)
                end
            end
        })
        section:Button({
            Title = "查看选定远程名单",
            Callback = function()
                local targets = (#Interstellar.killplayers > 0) and Interstellar.killplayers or PlayerList
                WindUI:Notify({ Title = "远程目标 (" .. #targets .. " 个玩家)", Content = table.concat(targets, ", "), Duration = 5 })
            end
        })
        section:Button({
            Title = "刷新玩家列表",
            Callback = function() refreshPlayerList() WindUI:Notify({ Title = "玩家列表", Content = "刷新成功", Duration = 3 }) end
        })
    end

    do
        local section = equipTab:Section({ Title = "跑步机", Opened = true })
        local function treadmillToggle(name, varName, pos, agilityReq)
            section:Toggle({
                Title = name,
                Default = false,
                Callback = function(state)
                    if agilityReq and game.Players.LocalPlayer.Agility.Value < agilityReq then
                        WindUI:Notify({ Title = "提示", Content = "敏捷不足 " .. agilityReq, Duration = 2 })
                        return
                    end
                    getgenv()[varName] = state
                    while getgenv()[varName] do
                        wait()
                        local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
                        local rootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                        humanoid.WalkSpeed = 10
                        rootPart.CFrame = pos
                        local RunService = game:GetService("RunService")
                        local localPlayer = game:GetService("Players").LocalPlayer
                        RunService:BindToRenderStep("move_" .. varName, Enum.RenderPriority.Character.Value + 1, function()
                            if localPlayer.Character then
                                local hum = localPlayer.Character:FindFirstChild("Humanoid")
                                if hum then hum:Move(Vector3.new(10000, 0, -1), true) end
                            end
                        end)
                    end
                    if not getgenv()[varName] then
                        game:GetService("RunService"):UnbindFromRenderStep("move_" .. varName)
                    end
                end
            })
        end
        treadmillToggle("沙滩跑步机10", "PPJ10", CFrame.new(238.671112, 5.40315914, 387.713165, -0.0160072874, -2.90710176e-08, -0.99987185, -3.3434191e-09, 1, -2.90212157e-08, 0.99987185, 2.87843993e-09, -0.0160072874), nil)
        treadmillToggle("冰霜健身房跑步机2000", "PPJ2000", CFrame.new(-3005.37866, 14.3221855, -464.697876, -0.015773816, -1.38508964e-08, 0.999875605, -5.13225586e-08, 1, 1.30429667e-08, -0.999875605, -5.11104332e-08, -0.015773816), 2000)
        treadmillToggle("神话健身房跑步机2000", "SHPPJ2000", CFrame.new(2571.23706, 15.6896839, 898.650391, 0.999968231, 2.23868635e-09, -0.00797206629, -1.73198844e-09, 1, 6.35660768e-08, 0.00797206629, -6.3550246e-08, 0.999968231), 2000)
        treadmillToggle("永恒健身房跑步机3500", "YHPPJ3500", CFrame.new(-7077.79102, 29.6702118, -1457.59961, -0.0322036594, -3.31122768e-10, 0.99948132, -6.44344267e-09, 1, 1.23684493e-10, -0.99948132, -6.43611742e-09, -0.0322036594), 3500)
        treadmillToggle("传奇健身房跑步机3000", "CQPPJ3000", CFrame.new(4370.82812, 999.358704, -3621.42773, -0.960604727, -8.41949266e-09, -0.27791819, -6.12478646e-09, 1, -9.12496567e-09, 0.27791819, -7.06329528e-09, -0.960604727), 3000)
        treadmillToggle("丛林健身房跑步机20000", "JungleTreadmill", CFrame.new(-8138.67919921875, 28.270538330078125, 2833.511474609375, -0.960604727, -8.41949266e-09, -0.27791819, -6.12478646e-09, 1, -9.12496567e-09, 0.27791819, -7.06329528e-09, -0.960604727), 20000)
    end
    do
        local section = equipTab:Section({ Title = "深蹲器材", Opened = true })
        local function squatToggle(name, varName, pos, strengthReq)
            section:Toggle({
                Title = name,
                Default = false,
                Callback = function(state)
                    getgenv()[varName] = state
                    if state then
                        spawn(function()
                            while getgenv()[varName] do
                                pcall(function()
                                    if strengthReq and game.Players.LocalPlayer.leaderstats.Strength.Value < strengthReq then return end
                                    if game.Players.LocalPlayer.machineInUse.Value == nil then
                                        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = pos
                                        wait(0.00001)
                                        local vim = game:GetService("VirtualInputManager")
                                        vim:SendKeyEvent(true, "E", false, game)
                                        wait(0.00001)
                                        vim:SendKeyEvent(false, "E", false, game)
                                    else
                                        local A_1 = "rep"
                                        local A_2 = game:GetService("Workspace").machinesFolder["Squat Rack"].interactSeat
                                        local Event = game:GetService("Players").LocalPlayer.muscleEvent
                                        Event:FireServer(A_1, A_2)
                                    end
                                end)
                                wait()
                            end
                        end)
                    else
                        pcall(function()
                            local char = game.Players.LocalPlayer.Character
                            if char then char:WaitForChild("Humanoid").Jump = true end
                        end)
                    end
                end
            })
        end
        squatToggle("沙滩深蹲架", "SquatBeach", CFrame.new(232.627625, 3.67689133, 96.3039856, -0.963445187, -7.78685845e-08, -0.267905563, -7.92865222e-08, 1, -5.52570167e-09, 0.267905563, 1.5917589e-08, -0.963445187), 1000)
        squatToggle("霜冻健身房深蹲架", "SquatFrostGym", CFrame.new(-2629.13818, 3.36860609, -609.827454, -0.995664716, -2.67296816e-08, -0.0930150598, -1.90042453e-08, 1, -8.39415222e-08, 0.0930150598, -8.18099295e-08, -0.995664716), 4000)
        squatToggle("传奇健身房深蹲架", "SquatLegendGym", CFrame.new(4443.04443, 987.521484, -4061.12988, 0.83309716, 3.33018835e-09, 0.553126693, -2.87759438e-09, 1, -1.68654424e-09, -0.553126693, -1.86619012e-10, 0.83309716), nil)
        squatToggle("肌肉之王健身房深蹲架", "SquatMuscleGym", CFrame.new(-8757.37012, 13.2186356, -6051.24365, -0.902269304, 1.63610299e-08, -0.431172907, 1.71076486e-08, 1, 2.14606288e-09, 0.431172907, -5.44002754e-09, -0.902269304), nil)
        squatToggle("丛林健身房深蹲架", "SquatJungleGym", CFrame.new(-8383.45, 83.43, 2854.54, -0.902269304, 1.63610299e-08, -0.431172907, 1.71076486e-08, 1, 2.14606288e-09, 0.431172907, -5.44002754e-09, -0.902269304), nil)
    end
    do
        local section = equipTab:Section({ Title = "引体向上器材", Opened = true })
        local function pullupToggle(name, varName, pos, strengthReq)
            section:Toggle({
                Title = name,
                Default = false,
                Callback = function(state)
                    getgenv()[varName] = state
                    if state then
                        spawn(function()
                            while getgenv()[varName] do
                                pcall(function()
                                    if strengthReq and game.Players.LocalPlayer.leaderstats.Strength.Value < strengthReq then return end
                                    if game.Players.LocalPlayer.machineInUse.Value == nil then
                                        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = pos
                                        wait(0.00001)
                                        local vim = game:GetService("VirtualInputManager")
                                        vim:SendKeyEvent(true, "E", false, game)
                                        wait(0.00001)
                                        vim:SendKeyEvent(false, "E", false, game)
                                    else
                                        local A_1 = "rep"
                                        local A_2 = game:GetService("Workspace").machinesFolder["Legends Pullup"].interactSeat
                                        local Event = game:GetService("Players").LocalPlayer.muscleEvent
                                        Event:FireServer(A_1, A_2)
                                    end
                                end)
                                wait(0.00001)
                            end
                        end)
                    else
                        pcall(function()
                            local char = game.Players.LocalPlayer.Character
                            if char then char:WaitForChild("Humanoid").Jump = true end
                        end)
                    end
                end
            })
        end
        pullupToggle("沙滩引体向上", "PullupBeach", CFrame.new(-185.157745, 5.81071186, 104.747154, 0.227061391, -8.2363325e-09, 0.97388047, 5.58502826e-08, 1, -4.56432803e-09, -0.97388047, 5.54278827e-08, 0.227061391), 1000)
        pullupToggle("神话健身房引体向上", "PullupMythGym", CFrame.new(2315.82104, 5.81071281, 847.153076, 0.993555248, 6.99809632e-08, 0.113349125, -7.05298859e-08, 1, 8.32554692e-10, -0.113349125, -8.82168916e-09, 0.993555248), 4000)
    end
    do
        local section = equipTab:Section({ Title = "丢石头", Opened = true })
        local function throwToggle(name, varName, pos, strengthReq)
            section:Toggle({
                Title = name,
                Default = false,
                Callback = function(state)
                    getgenv()[varName] = state
                    if state then
                        spawn(function()
                            while getgenv()[varName] do
                                pcall(function()
                                    if strengthReq and game.Players.LocalPlayer.leaderstats.Strength.Value < strengthReq then return end
                                    if game.Players.LocalPlayer.machineInUse.Value == nil then
                                        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = pos
                                        wait(0.0001)
                                        local vim = game:GetService("VirtualInputManager")
                                        vim:SendKeyEvent(true, "E", false, game)
                                        wait(0.0001)
                                        vim:SendKeyEvent(false, "E", false, game)
                                    else
                                        local A_1 = "rep"
                                        local A_2 = game:GetService("Workspace").machinesFolder.Deadlift.interactSeat
                                        local Event = game:GetService("Players").LocalPlayer.muscleEvent
                                        Event:FireServer(A_1, A_2)
                                    end
                                end)
                                wait()
                            end
                        end)
                    else
                        pcall(function()
                            local char = game.Players.LocalPlayer.Character
                            if char then char:WaitForChild("Humanoid").Jump = true end
                        end)
                    end
                end
            })
        end
        throwToggle("沙滩投掷石", "ThrowBeach", CFrame.new(-91.6730804, 3.67689133, -292.42868, -0.221022144, -2.21041621e-08, -0.975268781, 1.21414407e-08, 1, -2.54162646e-08, 0.975268781, -1.7458726e-08, -0.221022144), 3000)
        throwToggle("神话健身房投掷石", "ThrowMythGym", CFrame.new(2486.01733, 3.67689276, 1237.89331, 0.883595645, -2.06135038e-08, -0.468250751, -3.3286871e-09, 1, -5.03036404e-08, 0.468250751, 4.60067362e-08, 0.883595645), 10000)
        throwToggle("传奇健身房投掷石", "ThrowLegendGym", CFrame.new(4189.96143, 987.829773, -3903.0166, 0.422592968, 0, 0.906319559, 0, 1, 0, -0.906319559, 0, 0.422592968), nil)
        throwToggle("肌肉之王投掷石", "ThrowMuscleGym", CFrame.new(-8935.4384765625, 13.855730056762695, -5693.66748046875), nil)
        throwToggle("丛林健身房投掷石", "ThrowJungleGym", CFrame.new(-8620.99, 89.81, 2673.54, -0.902269304, 1.63610299e-08, -0.431172907, 1.71076486e-08, 1, 2.14606288e-09, 0.431172907, -5.44002754e-09, -0.902269304), nil)
    end

    do
        local section = modifyTab:Section({ Title = "美化数据", Opened = true })
        local function inputStat(title, statPath)
            section:Input({
                Title = title,
                Callback = function(value)
                    if value and value ~= "" and tonumber(value) then
                        local success, err = pcall(function()
                            local stat = statPath
                            if type(statPath) == "function" then stat = statPath() end
                            stat.Value = tonumber(value)
                        end)
                        if not success then
                            WindUI:Notify({ Title = "错误", Content = "修改失败: " .. tostring(err), Duration = 2 })
                        end
                    end
                end
            })
        end
        inputStat("力量", game:GetService("Players").LocalPlayer.leaderstats.Strength)
        inputStat("耐力", game:GetService("Players").LocalPlayer.Durability)
        inputStat("敏捷", game:GetService("Players").LocalPlayer.Agility)
        inputStat("重生", game:GetService("Players").LocalPlayer.leaderstats.Rebirths)
        inputStat("宝石", game:GetService("Players").LocalPlayer.Gems)
        inputStat("邪恶业报", game:GetService("Players").LocalPlayer.evilKarma)
        inputStat("好人业报", game:GetService("Players").LocalPlayer.goodKarma)
        inputStat("总业报", game:GetService("Players").LocalPlayer.leaderstats.Kills)
    end

    do
        local section = rebirthTab:Section({ Title = "自动重生", Opened = true })
        section:Toggle({
            Title = "自动重生",
            Default = false,
            Callback = function(state)
                getgenv().AutoRebirth = state
                if state then
                    spawn(function()
                        while getgenv().AutoRebirth do
                            pcall(function()
                                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                            end)
                            wait()
                        end
                    end)
                end
            end
        })
        local targetRebirth = 0
        section:Input({
            Title = "自定义重生次数",
            Desc = "只能输入大于现在的重生次数",
            Callback = function(value) targetRebirth = tonumber(value) or 0 end
        })
        section:Toggle({
            Title = "重生到指定的重生次数",
            Default = false,
            Callback = function(state)
                Interstellar = Interstellar or {}
                Interstellar.autobirth = state
                if state then
                    spawn(function()
                        local player = game:GetService("Players").LocalPlayer
                        while Interstellar.autobirth do
                            if player.leaderstats.Rebirths.Value >= targetRebirth then
                                Interstellar.autobirth = false
                                Window:Notify({ Title = "重生", Content = "已自动重生到目标次数", Duration = 3 })
                                break
                            else
                                game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
                                wait()
                            end
                        end
                    end)
                end
            end
        })
        section:Divider()
        section:Paragraph({
            Title = "适合直接打石头卡宠的重生次数",
            Desc = "重生:80\n重生:280\n重生:580\n重生:980\n重生:1480\n重生:2080\n重生:2780\n重生:3580\n重生:4480\n重生:5480\n重生:6580\n重生:7780\n重生:9080\n重生:10480\n重生:11980\n重生:13580\n重生:15280\n重生:17080\n重生:18980\n重生:94980\n重生:189980",
        })
    end

    do
        local section = teleportTab:Section({ Title = "传送区", Opened = true })
        local function tp(pos)
            game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = pos
        end
        section:Button({ Title = "安全点", Callback = function() tp(CFrame.new(-51.67,32.22,1290.41,0.99455,1.24e-08,-0.10422,-7.59e-09,1,4.62e-08,0.10422,-4.52e-08,0.99455)) end })
        section:Toggle({
            Title = "安全点循环",
            Default = false,
            Callback = function(state)
                getgenv().SafeSpot = state
                spawn(function()
                    while getgenv().SafeSpot do
                        wait()
                        pcall(function()
                            local char = game.Players.LocalPlayer.Character
                            if not char then
                                game.Players.LocalPlayer.CharacterAdded:Wait()
                                char = game.Players.LocalPlayer.Character
                                char:WaitForChild("HumanoidRootPart")
                            end
                            char.HumanoidRootPart.CFrame = CFrame.new(-51.67,32.22,1290.41,0.99455,1.24e-08,-0.10422,-7.59e-09,1,4.62e-08,0.10422,-4.52e-08,0.99455)
                        end)
                    end
                end)
            end
        })
        section:Button({ Title = "雕像头顶", Callback = function() tp(CFrame.new(1.19,85.09,244.49,0.59992,-2.24e-09,0.80006,4.46e-09,1,-5.44e-10,-0.80006,3.90e-09,0.59992)) end })
        section:Button({ Title = "肌肉王雕像头顶", Callback = function() tp(CFrame.new(-8751.0,120.4,-5863.1,0.59992,-2.24e-09,0.80006,4.46e-09,1,-5.44e-10,-0.80006,3.90e-09,0.59992)) end })
        section:Button({ Title = "出生点", Callback = function() tp(CFrame.new(7,3,108)) end })
        section:Button({ Title = "新手岛", Callback = function() tp(CFrame.new(-37.61,4.16,1877.14)) end })
        section:Button({ Title = "传说健身房", Callback = function() tp(CFrame.new(4603.28,988.18,-3897.87)) end })
        section:Button({ Title = "永恒健身房", Callback = function() tp(CFrame.new(-6758.96,4.01,-1284.92)) end })
        section:Button({ Title = "神话健身房", Callback = function() tp(CFrame.new(2250.78,4.01,1073.23)) end })
        section:Button({ Title = "冰霜健身房", Callback = function() tp(CFrame.new(-2623.02,4.01,-409.07)) end })
        section:Button({ Title = "肌肉之王健身房", Callback = function() tp(CFrame.new(-8625.93,13.86,-5730.47)) end })
        section:Button({ Title = "丛林健身房", Callback = function() tp(CFrame.new(-8685.62,3.43,2392.33)) end })
    end

    do
        local section = collectTab:Section({ Title = "功能", Opened = true })
        section:Button({
            Title = "使用一次奶昔",
            Callback = function()
                local char = game.Players.LocalPlayer.Character
                if not char then return end
                local humanoid = char:FindFirstChild("Humanoid")
                if not humanoid then return end
                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and (v.Name:find("奶昔") or v.Name:find("Shake") or v.Name:find("Milkshake")) then
                        humanoid:EquipTool(v)
                        v:Activate()
                        wait(0.1)
                        break
                    end
                end
            end
        })
        section:Toggle({
            Title = "自动使用奶昔",
            Default = false,
            Callback = function(state)
                getgenv().AutoShake = state
                while getgenv().AutoShake do
                    wait()
                    local char = game.Players.LocalPlayer.Character
                    if not char then wait(1) continue end
                    local humanoid = char:FindFirstChild("Humanoid")
                    if not humanoid then continue end
                    local found = false
                    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") and (v.Name:find("奶昔") or v.Name:find("Shake") or v.Name:find("Milkshake")) then
                            humanoid:EquipTool(v)
                            v:Activate()
                            found = true
                            wait(1)
                            break
                        end
                    end
                    if not found then wait(3) end
                end
            end
        })
        section:Button({
            Title = "使用一次能量棒",
            Callback = function()
                local c = game.Players.LocalPlayer.Character
                if not c then return end
                local h = c:FindFirstChild("Humanoid")
                if not h then return end
                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and (v.Name:find("Protein Bar") or v.Name:find("能量棒") or v.Name:find("Energy Bar")) then
                        h:EquipTool(v)
                        v:Activate()
                        wait(0.1)
                        break
                    end
                end
            end
        })
        section:Toggle({
            Title = "自动使用能量棒",
            Default = false,
            Callback = function(state)
                getgenv().AutoREB = state
                while getgenv().AutoREB do
                    wait()
                    local c = game.Players.LocalPlayer.Character
                    if not c then wait(1) continue end
                    local h = c:FindFirstChild("Humanoid")
                    if not h then continue end
                    local found = false
                    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v:IsA("Tool") and (v.Name:find("Protein Bar") or v.Name:find("能量棒") or v.Name:find("Energy Bar")) then
                            h:EquipTool(v)
                            v:Activate()
                            found = true
                            wait(1)
                            break
                        end
                    end
                    if not found then wait(3) end
                end
            end
        })
        section:Divider()
        section:Button({
            Title = "使用一次蛋白质蛋",
            Callback = function()
                local c = game.Players.LocalPlayer.Character
                if not c then return end
                local h = c:FindFirstChild("Humanoid")
                if not h then return end
                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and (v.Name:find("Protein Egg") or v.Name:find("蛋白质蛋")) then
                        h:EquipTool(v)
                        v:Activate()
                        wait(0.1)
                        break
                    end
                end
            end
        })
        section:Button({
            Title = "使用一次热带摇晃",
            Callback = function()
                local c = game.Players.LocalPlayer.Character
                if not c then return end
                local h = c:FindFirstChild("Humanoid")
                if not h then return end
                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and (v.Name:find("Tropical Shake") or v.Name:find("热带摇晃")) then
                        h:EquipTool(v)
                        v:Activate()
                        wait(0.1)
                        break
                    end
                end
            end
        })
        section:Divider()
        section:Button({
            Title = "收集宝石",
            Callback = function()
                local jk = {}
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
    end

    do
        local section = petTab:Section({ Title = "购买", Opened = true })
        section:Paragraph({
            Title = "关于直接购买宠物",
            Desc = "你得保证你有充足的宝石\n因为购买一个宠物就值0.4亿左右\n否则购买失败",
        })
        local petNames = { "肌肉王光环", "暗星", "霓虹卫报", "赛博对决龙" }
        local petMapping = {
            ["肌肉王光环"] = "Muscle King",
            ["暗星"] = "Darkstar Hunter",
            ["霓虹卫报"] = "Neon Guardian",
            ["赛博对决龙"] = "Cybernetic Showdown Dragon"
        }
        local selectedPet = "肌肉王光环"
        section:Dropdown({
            Title = "选择购买的宠物",
            Values = petNames,
            Value = selectedPet,
            Callback = function(v) selectedPet = v end
        })
        section:Button({
            Title = "购买选中宠物一次",
            Callback = function()
                local petEng = petMapping[selectedPet]
                if petEng then
                    local p = game.ReplicatedStorage.cPetShopFolder:FindFirstChild(petEng)
                    if p then game.ReplicatedStorage.cPetShopRemote:InvokeServer(p) end
                end
            end
        })
        local autoBuy = false
        section:Toggle({
            Title = "自动购买选中宠物",
            Default = false,
            Callback = function(state)
                autoBuy = state
                if state then
                    task.spawn(function()
                        while autoBuy do
                            local petEng = petMapping[selectedPet]
                            if petEng then
                                local p = game.ReplicatedStorage.cPetShopFolder:FindFirstChild(petEng)
                                if p then
                                    pcall(function()
                                        game.ReplicatedStorage.cPetShopRemote:InvokeServer(p)
                                    end)
                                end
                            end
                            task.wait(0.5)
                        end
                    end)
                end
            end
        })
    end
    do
        local section = petTab:Section({ Title = "进化", Opened = true })
        section:Toggle({
            Title = "自动进化赛博对决龙",
            Default = false,
            Callback = function(state)
                getgenv().EvolveDark = state
                if state then
                    spawn(function()
                        while getgenv().EvolveDark do
                            pcall(function()
                                game.ReplicatedStorage.rEvents.petEvolveEvent:FireServer("evolvePet", "Cybernetic Showdown Dragon")
                            end)
                            wait()
                        end
                    end)
                end
            end
        })
        section:Toggle({
            Title = "自动进化暗星",
            Default = false,
            Callback = function(state)
                getgenv().EvolveDarkStar = state
                if state then
                    spawn(function()
                        while getgenv().EvolveDarkStar do
                            pcall(function()
                                game.ReplicatedStorage.rEvents.petEvolveEvent:FireServer("evolvePet", "Darkstar Hunter")
                            end)
                            wait()
                        end
                    end)
                end
            end
        })
        section:Toggle({
            Title = "自动进化肌肉王光环",
            Default = false,
            Callback = function(state)
                getgenv().EvolveMuscle = state
                if state then
                    spawn(function()
                        while getgenv().EvolveMuscle do
                            pcall(function()
                                game.ReplicatedStorage.rEvents.petEvolveEvent:FireServer("evolvePet", "Muscle King")
                            end)
                            wait()
                        end
                    end)
                end
            end
        })
        section:Toggle({
            Title = "自动进化霓虹卫报",
            Default = false,
            Callback = function(state)
                getgenv().EvolveNeon = state
                if state then
                    spawn(function()
                        while getgenv().EvolveNeon do
                            pcall(function()
                                game.ReplicatedStorage.rEvents.petEvolveEvent:FireServer("evolvePet", "Neon Guardian")
                            end)
                            wait()
                        end
                    end)
                end
            end
        })
    end
    do
        local section = petTab:Section({ Title = "宠物蛋", Opened = true })
        section:Paragraph({
            Title = "因为列表汉化有问题",
            Desc = "Blue Crystal = 蓝色宠物蛋\nGreen Crystal = 绿色宠物蛋\nFrost Crystal = 冰霜宠物蛋\nMythical Crystal = 神话宠物蛋\nInferno Crystal = 地狱宠物蛋\nLegends Crystal = 传奇宠物蛋\nGalaxy Oracle Crystal = 肌肉王宠物蛋\nJungle Crystal = 丛林宠物蛋",
        })
        local crystals = {"Blue Crystal", "Green Crystal", "Frost Crystal", "Mythical Crystal", "Inferno Crystal", "Legends Crystal", "Galaxy Oracle Crystal", "Jungle Crystal"}
        local selectedCrystal = "Blue Crystal"
        section:Dropdown({
            Title = "选择宠物蛋",
            Values = crystals,
            Value = selectedCrystal,
            Callback = function(v) selectedCrystal = v end
        })
        section:Button({
            Title = "购买宠物蛋",
            Callback = function()
                pcall(function()
                    game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", selectedCrystal)
                end)
            end
        })
        local autoOpen = false
        section:Toggle({
            Title = "自动购买选中宠物蛋",
            Default = false,
            Callback = function(state)
                autoOpen = state
                if state then
                    spawn(function()
                        while autoOpen do
                            pcall(function()
                                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", selectedCrystal)
                            end)
                            wait()
                        end
                    end)
                end
            end
        })
    end

    do
        local section = generalTab:Section({ Title = "常用功能", Opened = true })
        section:Toggle({ Title = "去雾", Default = false, Callback = function(state) if state then game.Lighting.FogStart = 3276634343 game.Lighting.FogEnd = 3276734343 else game.Lighting.FogStart = 0 end end })
        section:Divider()
        section:Slider({
            Title = "视野",
            Step = 1,
            Value = { Min = 10, Max = 180, Default = workspace.CurrentCamera.FieldOfView },
            Callback = function(FOV)
                getgenv().TargetFOV = FOV
                workspace.CurrentCamera.FieldOfView = FOV
                if not getgenv().FOVLoop then
                    getgenv().FOVLoop = game:GetService("RunService").Heartbeat:Connect(function()
                        if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = getgenv().TargetFOV end
                    end)
                    game.Players.LocalPlayer.CharacterAdded:Connect(function()
                        wait(1)
                        if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = getgenv().TargetFOV end
                    end)
                end
            end
        })
        section:Divider()
        section:Toggle({
            Title = "穿墙",
            Default = false,
            Callback = function(state)
                if state then
                    getgenv().noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                        local LocalPlayer = game:GetService("Players").LocalPlayer
                        if LocalPlayer.Character then
                            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                                if part:IsA("BasePart") then part.CanCollide = false end
                            end
                        end
                    end)
                else
                    if getgenv().noclipConnection then
                        getgenv().noclipConnection:Disconnect()
                        getgenv().noclipConnection = nil
                    end
                    local LocalPlayer = game:GetService("Players").LocalPlayer
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then part.CanCollide = true end
                        end
                    end
                end
            end
        })
        section:Divider()
        local flySpeed = 150
        local flyMultiplier = 5
        section:Slider({
            Title = "飞行倍率",
            Step = 0.1,
            Value = { Min = 1, Max = 20, Default = 5 },
            Callback = function(multiplier) flyMultiplier = multiplier end
        })
        section:Toggle({
            Title = "飞行开关",
            Default = false,
            Callback = function(bak)
                getgenv().fly = bak
                if bak then
                    local controlModule = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild('PlayerModule'):WaitForChild("ControlModule"))
                    local character = game.Players.LocalPlayer.Character
                    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
                    local function setupFlight(character)
                        local hrp = character:FindFirstChild("HumanoidRootPart")
                        if not hrp then return end
                        if hrp:FindFirstChild("VelocityHandler") then hrp.VelocityHandler:Destroy() end
                        if hrp:FindFirstChild("GyroHandler") then hrp.GyroHandler:Destroy() end
                        local bv = Instance.new("BodyVelocity")
                        bv.Name = "VelocityHandler"
                        bv.Parent = hrp
                        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                        bv.Velocity = Vector3.new(0, 0, 0)
                        local bg = Instance.new("BodyGyro")
                        bg.Name = "GyroHandler"
                        bg.Parent = hrp
                        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                        bg.P = 1000
                        bg.D = 50
                        return bv, bg
                    end
                    local bv, bg = setupFlight(character)
                    local camera = game.Workspace.CurrentCamera
                    getgenv().FlyLoop = game:GetService("RunService").RenderStepped:Connect(function()
                        local currentCharacter = game.Players.LocalPlayer.Character
                        local hrp = currentCharacter and currentCharacter:FindFirstChild("HumanoidRootPart")
                        if currentCharacter and hrp and hrp:FindFirstChild("VelocityHandler") and hrp:FindFirstChild("GyroHandler") and getgenv().fly then
                            currentCharacter.Humanoid.PlatformStand = true
                            hrp.GyroHandler.CFrame = camera.CFrame
                            local direction = controlModule:GetMoveVector()
                            local actualSpeed = flySpeed * flyMultiplier
                            hrp.VelocityHandler.Velocity = Vector3.new()
                            if direction.X ~= 0 then
                                hrp.VelocityHandler.Velocity = hrp.VelocityHandler.Velocity + camera.CFrame.RightVector * (direction.X * actualSpeed)
                            end
                            if direction.Z ~= 0 then
                                hrp.VelocityHandler.Velocity = hrp.VelocityHandler.Velocity - camera.CFrame.LookVector * (direction.Z * actualSpeed)
                            end
                            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                                hrp.VelocityHandler.Velocity = hrp.VelocityHandler.Velocity + Vector3.new(0, actualSpeed/2, 0)
                            end
                            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                                hrp.VelocityHandler.Velocity = hrp.VelocityHandler.Velocity - Vector3.new(0, actualSpeed/2, 0)
                            end
                        end
                    end)
                else
                    if getgenv().FlyLoop then getgenv().FlyLoop:Disconnect() end
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local hrp = character.HumanoidRootPart
                        if hrp:FindFirstChild("VelocityHandler") then hrp.VelocityHandler:Destroy() end
                        if hrp:FindFirstChild("GyroHandler") then hrp.GyroHandler:Destroy() end
                        character.Humanoid.PlatformStand = false
                    end
                end
            end
        })
    end

    do
-- ==============================================
-- 关于包类与训练 K
-- ==============================================
Tabs.K:Button({Title = "解锁全部通行证", Callback = function()
    pcall(function()
        for i, v in ipairs(game:GetService("ReplicatedStorage").gamepassIds:GetChildren()) do
            v.Parent = game.Players.LocalPlayer.ownedGamepasses
        end
    end)
end})

-- 反挂机
local vu = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame);
    wait(1);
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
-- 隐藏后缀（零宽字符）
local function invisibleSuffix()
    return string.rep("\226\128\139", math.random(1,5))
end


-- 强大的怪物
Tabs.K:Button({
    Title = "生成 强大的怪物",
    Callback = function()
        local player = game.Players.LocalPlayer
        local unique = player:WaitForChild("petsFolder"):WaitForChild("Unique")

        local pet = Instance.new("StringValue")
        pet.Name = "强大的怪物" .. invisibleSuffix()
        pet.Value = "rbxassetid://17601660151"
        pet.Parent = unique

        local perks = Instance.new("Folder", pet)
        perks.Name = "perksFolder"

        local a = Instance.new("IntValue", perks); a.Name="agility"; a.Value=1000
        local b = Instance.new("IntValue", perks); b.Name="strength"; b.Value=2250
        local c = Instance.new("IntValue", perks); c.Name="durability"; c.Value=5000

        local cname = Instance.new("StringValue", pet)
        cname.Name="chosenName"
        cname.Value="强大的怪物"

        Instance.new("BoolValue", pet).Name="evolved"; pet.evolved.Value=true
        Instance.new("IntValue", pet).Name="exp"; pet.exp.Value=0

        Instance.new("IntValue", pet).Name="level"; pet.level.Value=1
        Instance.new("IntValue", pet).Name="requiredRebirths"; pet.requiredRebirths.Value=0

        Instance.new("BoolValue", pet).Name="unsellable"; pet.unsellable.Value=true
        Instance.new("BoolValue", pet).Name="untradeable"; pet.untradeable.Value=true
    end
})


-- 快速武士
Tabs.K:Button({
    Title = "生成 快速武士",
    Callback = function()
        local player = game.Players.LocalPlayer
        local unique = player:WaitForChild("petsFolder"):WaitForChild("Unique")

        local pet = Instance.new("StringValue")
        pet.Name = "快速武士" .. invisibleSuffix()
        pet.Value = "rbxassetid://17601657920"
        pet.Parent = unique

        local perks = Instance.new("Folder", pet)
        perks.Name = "perksFolder"

        local a = Instance.new("IntValue", perks); a.Name="agility"; a.Value=2500
        local b = Instance.new("IntValue", perks); b.Name="strength"; b.Value=1750
        local c = Instance.new("IntValue", perks); c.Name="durability"; c.Value=3250

        local cname = Instance.new("StringValue", pet)
        cname.Name="chosenName"
        cname.Value="快速武士"

        Instance.new("BoolValue", pet).Name="evolved"; pet.evolved.Value=true
        Instance.new("IntValue", pet).Name="exp"; pet.exp.Value=0

        Instance.new("IntValue", pet).Name="level"; pet.level.Value=1
        Instance.new("IntValue", pet).Name="requiredRebirths"; pet.requiredRebirths.Value=0

        Instance.new("BoolValue", pet).Name="unsellable"; pet.unsellable.Value=true
        Instance.new("BoolValue", pet).Name="untradeable"; pet.untradeable.Value=true
    end
})


-- 部落首领
Tabs.K:Button({
    Title = "生成 部落首领",
    Callback = function()
        local player = game.Players.LocalPlayer
        local unique = player:WaitForChild("petsFolder"):WaitForChild("Unique")

        local pet = Instance.new("StringValue")
        pet.Name = "部落首领" .. invisibleSuffix()
        pet.Value = "rbxassetid://17601550091"
        pet.Parent = unique

        local perks = Instance.new("Folder", pet)
        perks.Name = "perksFolder"

        local a = Instance.new("IntValue", perks); a.Name="strength"; a.Value=3750
        local b = Instance.new("IntValue", perks); b.Name="durability"; b.Value=2500
        local c = Instance.new("IntValue", perks); c.Name="damage"; c.Value=50000

        local cname = Instance.new("StringValue", pet)
        cname.Name="chosenName"
        cname.Value="部落首领"

        Instance.new("BoolValue", pet).Name="evolved"; pet.evolved.Value=true
        Instance.new("IntValue", pet).Name="exp"; pet.exp.Value=0

        Instance.new("IntValue", pet).Name="level"; pet.level.Value=1
        Instance.new("IntValue", pet).Name="requiredRebirths"; pet.requiredRebirths.Value=0

        Instance.new("BoolValue", pet).Name="unsellable"; pet.unsellable.Value=true
        Instance.new("BoolValue", pet).Name="untradeable"; pet.untradeable.Value=true
    end
})


-- 狂野巫师
Tabs.K:Button({
    Title = "生成 狂野巫师",
    Callback = function()
        local player = game.Players.LocalPlayer
        local unique = player:WaitForChild("petsFolder"):WaitForChild("Unique")

        local pet = Instance.new("StringValue")
        pet.Name = "狂野巫师" .. invisibleSuffix()
        pet.Value = "rbxassetid://17601661532"
        pet.Parent = unique

        local perks = Instance.new("Folder", pet)
        perks.Name = "perksFolder"

        local a = Instance.new("IntValue", perks); a.Name="agility"; a.Value=750
        local b = Instance.new("IntValue", perks); b.Name="damage"; b.Value=75000
        local c = Instance.new("IntValue", perks); c.Name="durability"; c.Value=4000

        local cname = Instance.new("StringValue", pet)
        cname.Name="chosenName"
        cname.Value="狂野巫师"

        Instance.new("BoolValue", pet).Name="evolved"; pet.evolved.Value=true
        Instance.new("IntValue", pet).Name="exp"; pet.exp.Value=0

        Instance.new("IntValue", pet).Name="level"; pet.level.Value=1
        Instance.new("IntValue", pet).Name="requiredRebirths"; pet.requiredRebirths.Value=0

        Instance.new("BoolValue", pet).Name="unsellable"; pet.unsellable.Value=true
        Instance.new("BoolValue", pet).Name="untradeable"; pet.untradeable.Value=true
    end
})
WindUI:Notify({ Title = "力量传奇", Content = "反挂机已自动开启", Duration = 8 })
WindUI:Notify({ Title = "洛杉矶作者", Content = "感谢您的使用", Duration = 8 })
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)