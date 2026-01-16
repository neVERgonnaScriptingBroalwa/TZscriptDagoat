local whitelist = {
    "tyntamaevperdeyn",
    "direc15",
    "lanotherdeadl",
    "vitika6606",
    "Maxiging_6",
    ""
}

local function isWhitelisted(name)
    for _, v in ipairs(whitelist) do
        if string.lower(v) == string.lower(name) then
            return true
        end
    end
    return false
end

local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
if not isWhitelisted(player.Name) then
    player:Kick("Not Whitelisted | Liquid-Hub")
    return
end

if _G.LiquidHubLoaded then return end
_G.LiquidHubLoaded = true

-- Настройки Instant Steal
local Settings = {
    ShowBeams = true,
    AutoTeleport = true,
    ShowStatus = true,
    RainbowMode = true,
    BeamColor1 = Color3.fromRGB(0, 170, 255),
    BeamColor2 = Color3.fromRGB(255, 140, 0),
    BeamWidth = 0.12,
    TeleportDelay = 0.05
}

-- FFlags настройки для Desync
local FFlags = {
    GameNetPVHeaderRotationalVelocityZeroCutoffExponent = -5000,
    LargeReplicatorWrite5 = true,
    LargeReplicatorEnabled9 = true,
    AngularVelociryLimit = 360,
    TimestepArbiterVelocityCriteriaThresholdTwoDt = 2147483646,
    S2PhysicsSenderRate = 15000,
    DisableDPIScale = true,
    MaxDataPacketPerSend = 2147483647,
    PhysicsSenderMaxBandwidthBps = 20000,
    TimestepArbiterHumanoidLinearVelThreshold = 21,
    MaxMissedWorldStepsRemembered = -2147483648,
    PlayerHumanoidPropertyUpdateRestrict = true,
    SimDefaultHumanoidTimestepMultiplier = 0,
    StreamJobNOUVolumeLengthCap = 2147483647,
    DebugSendDistInSteps = -2147483648,
    GameNetDontSendRedundantNumTimes = 1,
    CheckPVLinearVelocityIntegrateVsDeltaPositionThresholdPercent = 1,
    CheckPVDifferencesForInterpolationMinVelThresholdStudsPerSecHundredth = 1,
    LargeReplicatorSerializeRead3 = true,
    ReplicationFocusNouExtentsSizeCutoffForPauseStuds = 2147483647,
    CheckPVCachedVelThresholdPercent = 10,
    CheckPVDifferencesForInterpolationMinRotVelThresholdRadsPerSecHundredth = 1,
    GameNetDontSendRedundantDeltaPositionMillionth = 1,
    InterpolationFrameVelocityThresholdMillionth = 5,
    StreamJobNOUVolumeCap = 2147483647,
    InterpolationFrameRotVelocityThresholdMillionth = 5,
    CheckPVCachedRotVelThresholdPercent = 10,
    WorldStepMax = 30,
    InterpolationFramePositionThresholdMillionth = 5,
    TimestepArbiterHumanoidTurningVelThreshold = 1,
    SimOwnedNOUCountThresholdMillionth = 2147483647,
    GameNetPVHeaderLinearVelocityZeroCutoffExponent = -5000,
    NextGenReplicatorEnabledWrite4 = true,
    TimestepArbiterOmegaThou = 1073741823,
    MaxAcceptableUpdateDelay = 1,
    LargeReplicatorSerializeWrite4 = true
}

𝙔𝙤𝙪𝙨𝙝𝙪𝙖, [16.01.2026 20:56]
Александр, [16.01.2026 20:54]
local defaultFFlags = {
    GameNetPVHeaderRotationalVelocityZeroCutoffExponent = 8,
    LargeReplicatorWrite5 = false,
    LargeReplicatorEnabled9 = false,
    AngularVelociryLimit = 180,
    TimestepArbiterVelocityCriteriaThresholdTwoDt = 100,
    S2PhysicsSenderRate = 60,
    DisableDPIScale = false,
    MaxDataPacketPerSend = 1024,
    PhysicsSenderMaxBandwidthBps = 10000,
    TimestepArbiterHumanoidLinearVelThreshold = 10,
    MaxMissedWorldStepsRemembered = 10,
    PlayerHumanoidPropertyUpdateRestrict = false,
    SimDefaultHumanoidTimestepMultiplier = 1,
    StreamJobNOUVolumeLengthCap = 1000,
    DebugSendDistInSteps = 10,
    GameNetDontSendRedundantNumTimes = 10,
    CheckPVLinearVelocityIntegrateVsDeltaPositionThresholdPercent = 50,
    CheckPVDifferencesForInterpolationMinVelThresholdStudsPerSecHundredth = 100,
    LargeReplicatorSerializeRead3 = false,
    ReplicationFocusNouExtentsSizeCutoffForPauseStuds = 100,
    CheckPVCachedVelThresholdPercent = 50,
    CheckPVDifferencesForInterpolationMinRotVelThresholdRadsPerSecHundredth = 100,
    GameNetDontSendRedundantDeltaPositionMillionth = 100,
    InterpolationFrameVelocityThresholdMillionth = 100,
    StreamJobNOUVolumeCap = 1000,
    InterpolationFrameRotVelocityThresholdMillionth = 100,
    CheckPVCachedRotVelThresholdPercent = 50,
    WorldStepMax = 60,
    InterpolationFramePositionThresholdMillionth = 100,
    TimestepArbiterHumanoidTurningVelThreshold = 10,
    SimOwnedNOUCountThresholdMillionth = 1000,
    GameNetPVHeaderLinearVelocityZeroCutoffExponent = 8,
    NextGenReplicatorEnabledWrite4 = false,
    TimestepArbiterOmegaThou = 1000,
    MaxAcceptableUpdateDelay = 10,
    LargeReplicatorSerializeWrite4 = false
}

-- Переменные для Instant Steal
local pos1, pos2 = nil, nil
local beam1, beam2
local part1, part2
local desyncActive = false
local firstActivation = true

local targetPositions = {
    Vector3.new(-481.88, -3.79, 138.02),
    Vector3.new(-481.75, -3.79, 89.18),
    Vector3.new(-481.82, -3.79, 30.95),
    Vector3.new(-481.75, -3.79, -17.79),
    Vector3.new(-481.80, -3.79, -76.06),
    Vector3.new(-481.72, -3.79, -124.70),
    Vector3.new(-337.45, -3.85, -124.72),
    Vector3.new(-337.37, -3.85, -76.07),
    Vector3.new(-337.46, -3.79, -17.72),
    Vector3.new(-337.41, -3.79, 30.92),
    Vector3.new(-337.32, -3.79, 89.02),
    Vector3.new(-337.27, -3.79, 137.90),
    Vector3.new(-337.45, -3.79, 196.29),
    Vector3.new(-337.37, -3.79, 244.91),
    Vector3.new(-481.72, -3.79, 196.21),
    Vector3.new(-481.76, -3.79, 244.92)
}

-- Основное GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LiquidHubUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Фоновый эффект с водной тематикой
local backgroundLabel = Instance.new("TextLabel", gui)
backgroundLabel.Size = UDim2.new(1, 0, 1, 0)
backgroundLabel.Position = UDim2.new(0, 0, 0, 0)
backgroundLabel.BackgroundTransparency = 1
backgroundLabel.Text = "💧 LIQUID"
backgroundLabel.Font = Enum.Font.GothamBlack
backgroundLabel.TextSize = 140
backgroundLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
backgroundLabel.TextTransparency = 0.85
backgroundLabel.TextXAlignment = Enum.TextXAlignment.Center
backgroundLabel.TextYAlignment = Enum.TextYAlignment.Center
backgroundLabel.ZIndex = 0

-- Основное окно
local mainWindow = Instance.new("Frame", gui)
mainWindow.Size = UDim2.new(0, 340, 0, 420)
mainWindow.Position = UDim2.new(0.5, -170, 0.5, -210)
mainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
mainWindow.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
mainWindow.BackgroundTransparency = 0.1
mainWindow.Active = true
mainWindow.Draggable = true

local windowCorner = Instance.new("UICorner", mainWindow)
windowCorner.CornerRadius = UDim.new(0, 14)

local windowStroke = Instance.new("UIStroke", mainWindow)
windowStroke.Thickness = 2
windowStroke.Color = Color3.fromRGB(0, 150, 255)
windowStroke.Transparency = 0.3
windowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

𝙔𝙤𝙪𝙨𝙝𝙪𝙖, [16.01.2026 20:56]
Александр, [16.01.2026 20:54]
-- Шапка окна с градиентом
local header = Instance.new("Frame", mainWindow)
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(10, 20, 35)
header.BorderSizePixel = 0

local headerCorner = Instance.new("UICorner", header)
headerCorner.CornerRadius = UDim.new(0, 14)

local headerGradient = Instance.new("UIGradient", header)
headerGradient.Rotation = 90
headerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
})

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "💧 Liquid-Hub | Instant Steal"
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопка сворачивания
local toggleButton = Instance.new("TextButton", header)
toggleButton.Size = UDim2.new(0, 30, 0, 30)
toggleButton.Position = UDim2.new(1, -35, 0.5, -15)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
toggleButton.Text = "−"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 22
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.AutoButtonColor = false

local toggleCorner = Instance.new("UICorner", toggleButton)
toggleCorner.CornerRadius = UDim.new(0, 8)

-- Контейнер для контента
local contentFrame = Instance.new("Frame", mainWindow)
contentFrame.Size = UDim2.new(1, -20, 1, -70)
contentFrame.Position = UDim2.new(0, 10, 0, 55)
contentFrame.BackgroundTransparency = 1

-- Вкладки
local tabsFrame = Instance.new("Frame", contentFrame)
tabsFrame.Size = UDim2.new(1, 0, 0, 35)
tabsFrame.BackgroundTransparency = 1

local function createTab(text, x, isActive)
    local tab = Instance.new("TextButton", tabsFrame)
    tab.Size = UDim2.new(0.5, -5, 1, 0)
    tab.Position = UDim2.new(x, 0, 0, 0)
    tab.BackgroundColor3 = isActive and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(40, 40, 60)
    tab.Text = text
    tab.Font = Enum.Font.GothamMedium
    tab.TextSize = 14
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.AutoButtonColor = false
    
    local tabCorner = Instance.new("UICorner", tab)
    tabCorner.CornerRadius = UDim.new(0, 8)
    
    return tab
end

local stealTab = createTab("🎯 Instant Steal", 0, true)
local desyncTab = createTab("⚡️ Desync", 0.5, false)

-- Фреймы для вкладок
local stealContent = Instance.new("Frame", contentFrame)
stealContent.Size = UDim2.new(1, 0, 1, -40)
stealContent.Position = UDim2.new(0, 0, 0, 40)
stealContent.BackgroundTransparency = 1
stealContent.Visible = true

local desyncContent = Instance.new("Frame", contentFrame)
desyncContent.Size = UDim2.new(1, 0, 1, -40)
desyncContent.Position = UDim2.new(0, 0, 0, 40)
desyncContent.BackgroundTransparency = 1
desyncContent.Visible = false

𝙔𝙤𝙪𝙨𝙝𝙪𝙖, [16.01.2026 20:56]
Александр, [16.01.2026 20:54]
-- Функция создания кнопки
local function createButton(text, y, color, parent)
    local button = Instance.new("TextButton", parent)
    button.Size = UDim2.new(1, 0, 0, 42)
    button.Position = UDim2.new(0, 0, 0, y)
    button.BackgroundColor3 = color or Color3.fromRGB(30, 40, 60)
    button.BackgroundTransparency = 0.1
    button.Text = text
    button.Font = Enum.Font.GothamMedium
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(240, 240, 240)
    button.AutoButtonColor = false
    
    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(0, 8)
    
    local buttonStroke = Instance.new("UIStroke", button)
    buttonStroke.Thickness = 1
    buttonStroke.Color = Color3.fromRGB(0, 100, 200)
    buttonStroke.Transparency = 0.5
    
    -- Анимация при наведении
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0,
            BackgroundColor3 = Color3.fromRGB(0, 120, 220)
        }):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.2), {
            Transparency = 0
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.1,
            BackgroundColor3 = color or Color3.fromRGB(30, 40, 60)
        }):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.2), {
            Transparency = 0.5
        }):Play()
    end)
    
    -- Анимация нажатия
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(0.98, 0, 0, 40)
        }):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(1, 0, 0, 42)
        }):Play()
    end)
    
    return button
end

-- Функция создания переключателя
local function createToggle(text, y, defaultValue, callback, parent)
    local toggleFrame = Instance.new("Frame", parent)
    toggleFrame.Size = UDim2.new(1, 0, 0, 38)
    toggleFrame.Position = UDim2.new(0, 0, 0, y)
    toggleFrame.BackgroundTransparency = 1
    
    local toggleLabel = Instance.new("TextLabel", toggleFrame)
    toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = "   " .. text
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextSize = 14
    toggleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleButton = Instance.new("TextButton", toggleFrame)
    toggleButton.Size = UDim2.new(0, 50, 0, 26)
    toggleButton.Position = UDim2.new(1, -50, 0.5, -13)
    toggleButton.BackgroundColor3 = defaultValue and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    toggleButton.Text = defaultValue and "ON" or "OFF"
    toggleButton.Font = Enum.Font.GothamMedium
    toggleButton.TextSize = 12
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.AutoButtonColor = false
    
    local toggleCorner = Instance.new("UICorner", toggleButton)
    toggleCorner.CornerRadius = UDim.new(0, 13)
    
    toggleButton.MouseButton1Click:Connect(function()
        local newValue = not defaultValue
        defaultValue = newValue
        
        TweenService:Create(toggleButton, TweenInfo.new(0.3), {
            BackgroundColor3 = newValue and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
        }):Play()
        
        toggleButton.Text = newValue and "ON" or "OFF"
        
        if callback then
            callback(newValue)
        end
    end)
    
    return toggleFrame
end

-- Вкладка Instant Steal
local yOffset = 0
local setPosBtn = createButton("🎯 Установить позицию 1", yOffset, Color3.fromRGB(0, 100, 200), stealContent)
yOffset = yOffset + 47

𝙔𝙤𝙪𝙨𝙝𝙪𝙖, [16.01.2026 20:56]
Александр, [16.01.2026 20:54]
local showBeamsToggle = createToggle("Показывать лучи", yOffset, Settings.ShowBeams, function(value)
    Settings.ShowBeams = value
    if not value then
        if beam1 then beam1:Destroy() end
        if beam2 then beam2:Destroy() end
    end
end, stealContent)

yOffset = yOffset + 42

local autoTeleportToggle = createToggle("Авто-телепорт", yOffset, Settings.AutoTeleport, function(value)
    Settings.AutoTeleport = value
end, stealContent)

yOffset = yOffset + 42

local rainbowModeToggle = createToggle("Режим радуги", yOffset, Settings.RainbowMode, function(value)
    Settings.RainbowMode = value
end, stealContent)

yOffset = yOffset + 42

local infoBtn = createButton("📋 Информация о точках", yOffset, Color3.fromRGB(100, 100, 150), stealContent)

-- Вкладка Desync
local yOffsetDesync = 0
local desyncBtn = createButton("⚡️ Включить Desync", yOffsetDesync, Color3.fromRGB(200, 100, 0), desyncContent)
yOffsetDesync = yOffsetDesync + 47

local statusLabel = Instance.new("TextLabel", desyncContent)
statusLabel.Size = UDim2.new(1, 0, 0, 80)
statusLabel.Position = UDim2.new(0, 0, 0, 50)
statusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
statusLabel.BackgroundTransparency = 0.2
statusLabel.Text = "⚡️ Desync System\n\nStatus: READY\nFFlags: 35 параметров\nClick button to activate"
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 13
statusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.TextYAlignment = Enum.TextYAlignment.Center
statusLabel.TextWrapped = true

local statusCorner = Instance.new("UICorner", statusLabel)
statusCorner.CornerRadius = UDim.new(0, 10)

local statusStroke = Instance.new("UIStroke", statusLabel)
statusStroke.Thickness = 1
statusStroke.Color = Color3.fromRGB(0, 150, 255)

-- Футер
local footer = Instance.new("Frame", mainWindow)
footer.Size = UDim2.new(1, 0, 0, 35)
footer.Position = UDim2.new(0, 0, 1, -35)
footer.BackgroundColor3 = Color3.fromRGB(15, 25, 40)

local discordLink = Instance.new("TextLabel", footer)
discordLink.Size = UDim2.new(1, 0, 1, 0)
discordLink.BackgroundTransparency = 1
discordLink.Text = "https://discord.gg/2w7WevNJ"
discordLink.Font = Enum.Font.GothamMedium
discordLink.TextSize = 12
discordLink.TextColor3 = Color3.fromRGB(180, 180, 180)

-- Функционал вкладок
stealTab.MouseButton1Click:Connect(function()
    stealContent.Visible = true
    desyncContent.Visible = false
    stealTab.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    desyncTab.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
end)

desyncTab.MouseButton1Click:Connect(function()
    stealContent.Visible = false
    desyncContent.Visible = true
    stealTab.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    desyncTab.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
end)

-- Функционал сворачивания
local isMinimized = false
toggleButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    if isMinimized then
        TweenService:Create(mainWindow, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 340, 0, 45)
        }):Play()
        contentFrame.Visible = false
        footer.Visible = false
        toggleButton.Text = "+"
    else
        TweenService:Create(mainWindow, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 340, 0, 420)
        }):Play()
        contentFrame.Visible = true
        footer.Visible = true
        toggleButton.Text = "−"
    end
end)

-- Функции для Desync
local function applyFFlags(flags)
    for name, value in pairs(flags) do
        pcall(function()
            setfflag(tostring(name), tostring(value))
        end)
    end
end

𝙔𝙤𝙪𝙨𝙝𝙪𝙖, [16.01.2026 20:56]
Александр, [16.01.2026 20:54]
local function respawn(plr)
    local char = plr.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Dead)
        end
        char:ClearAllChildren()
        local newChar = Instance.new("Model")
        newChar.Parent = workspace
        plr.Character = newChar
        task.wait()
        plr.Character = char
        newChar:Destroy()
    end
end

-- Обработчик Desync кнопки
desyncBtn.MouseButton1Click:Connect(function()
    desyncActive = not desyncActive
    
    if desyncActive then
        applyFFlags(FFlags)
        if firstActivation then
            respawn(player)
            firstActivation = false
        end
        
        statusLabel.Text = "⚡️ Desync System\n\nStatus: ACTIVE\nFFlags: APPLIED (35)\nAnti-cheat bypassed"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
        
        desyncBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        desyncBtn.Text = "⚡️ Выключить Desync"
    else
        applyFFlags(defaultFFlags)
        
        statusLabel.Text = "⚡️ Desync System\n\nStatus: DISABLED\nFFlags: Restored to default\nClick to activate"
        statusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        
        desyncBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        desyncBtn.Text = "⚡️ Включить Desync"
    end
end)

-- Функция создания луча для Instant Steal
local function createBeam(position, color, index)
    if not Settings.ShowBeams then return end
    
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local part = Instance.new("Part", workspace)
    part.Size = Vector3.new(1,1,1)
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.CFrame = CFrame.new(position)

    local a0 = Instance.new("Attachment", part)
    local a1 = Instance.new("Attachment", char.HumanoidRootPart)

    local beam = Instance.new("Beam", workspace)
    beam.Attachment0 = a0
    beam.Attachment1 = a1
    beam.Width0 = Settings.BeamWidth
    beam.Width1 = Settings.BeamWidth
    beam.FaceCamera = true
    beam.Color = ColorSequence.new(color)

    if index == 1 then
        if beam1 then beam1:Destroy() end
        if part1 then part1:Destroy() end
        beam1, part1 = beam, part
    else
        if beam2 then beam2:Destroy() end
        if part2 then part2:Destroy() end
        beam2, part2 = beam, part
    end
end

-- Обработчик кнопки установки позиции
setPosBtn.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        pos1 = hrp.CFrame
        createBeam(pos1.Position, Settings.BeamColor1, 1)
        statusLabel.Text = "🎯 Instant Steal\n\nPosition 1: SET\nTarget positions: 16\nReady for stealing"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        
        task.wait(3)
        statusLabel.Text = "⚡️ Desync System\n\nStatus: READY\nFFlags: 35 параметров\nClick button to activate"
        statusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    end
end)

-- Кнопка информации
infoBtn.MouseButton1Click:Connect(function()
    statusLabel.Text = string.format("🎯 Instant Steal Info\n\nTarget positions: %d\nBeams: %s\nAuto-TP: %s",
        #targetPositions,
        Settings.ShowBeams and "ON" or "OFF",
        Settings.AutoTeleport and "ON" or "OFF"
    )
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    
    task.wait(3)
    if stealContent.Visible then
        statusLabel.Text = "🎯 Instant Steal\n\nPosition 1: READY\nTarget positions: 16\nClick to set position"
        statusLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
    else
        statusLabel.Text = "⚡️ Desync System\n\nStatus: READY\nFFlags: 35 параметров\nClick button to activate"
        statusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    end
end)

𝙔𝙤𝙪𝙨𝙝𝙪𝙖, [16.01.2026 20:56]
Александр, [16.01.2026 20:54]
-- Поиск ближайшей позиции
task.spawn(function()
    while true do
        task.wait(1)
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local closestDist = math.huge
            local closestPos = nil
            for _, v in ipairs(targetPositions) do
                local dist = (hrp.Position - v).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestPos = v
                end
            end
            if closestPos then
                pos2 = CFrame.new(closestPos)
                createBeam(pos2.Position, Settings.BeamColor2, 2)
            end
        end
    end
end)

-- Обработчик кражи
ProximityPromptService.PromptButtonHoldEnded:Connect(function(prompt, who)
    if who ~= player then return end
    if prompt.Name ~= "Steal" and prompt.ActionText ~= "Steal" then return end

    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        local carpet = backpack:FindFirstChild("Flying Carpet")
        if carpet and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:EquipTool(carpet)
        end
    end

    if pos1 then hrp.CFrame = pos1 end
    if pos2 and Settings.AutoTeleport then 
        task.wait(Settings.TeleportDelay)
        hrp.CFrame = pos2 
    end
end)

-- Анимации и эффекты
local hue = 0
RunService.RenderStepped:Connect(function(dt)
    hue = (hue + dt * 0.3) % 1
    
    -- Радужный эффект
    if Settings.RainbowMode then
        discordLink.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
        backgroundLabel.TextColor3 = Color3.fromHSV((hue + 0.3) % 1, 0.7, 0.9)
        title.TextColor3 = Color3.fromHSV((hue + 0.6) % 1, 0.9, 1)
    else
        discordLink.TextColor3 = Color3.fromRGB(180, 180, 180)
        backgroundLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    -- Вращение фона
    backgroundLabel.Rotation = backgroundLabel.Rotation + dt * 0.3
    
    -- Пульсация окна
    local pulse = math.sin(tick() * 2) * 0.1
    windowStroke.Transparency = 0.3 + pulse * 0.2
end)

-- Горячая клавиша
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    if input.KeyCode == Enum.KeyCode.RightControl then
        mainWindow.Visible = not mainWindow.Visible
    elseif input.KeyCode == Enum.KeyCode.Insert then
        isMinimized = not isMinimized
        toggleButton.MouseButton1Click:Fire()
    end
end)

print("💧 Liquid-Hub успешно загружен!")
print("📌 Горячие клавиши:")
print("   RightControl - Показать/Скрыть GUI")
print("   Insert - Свернуть/Развернуть окно")
print("🎮 Автор: github.com/ivangmff")
print("🔗 Discord: https://discord.gg/2w7WevNJ")
