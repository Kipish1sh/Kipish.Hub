--[[
    KIPISH HUB v1.0
    Load: loadstring(game:HttpGet("https://raw.githubusercontent.com/Kipish1sh/Kipish.Hub/main/universan.lua"))()
]]

local VERSION = "v1.0"
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Colors = {
    bg = Color3.fromRGB(15, 15, 17),
    sidebar = Color3.fromRGB(22, 22, 25),
    element = Color3.fromRGB(35, 35, 40),
    accent = Color3.fromRGB(0, 122, 255),
    text = Color3.fromRGB(255, 255, 255),
    subtext = Color3.fromRGB(150, 150, 150),
    off = Color3.fromRGB(60, 60, 65),
    ok = Color3.fromRGB(80, 200, 80),
    fail = Color3.fromRGB(220, 80, 80),
    warn = Color3.fromRGB(220, 180, 60)
}

local LOAD_START = os.clock()

local function getParent()
    if gethui then local ok, r = pcall(gethui); if ok and r then return r end end
    local cg = LocalPlayer:FindFirstChild("PlayerGui")
    return cg or game:GetService("CoreGui")
end

local hasDrawing = pcall(function()
    local d = Drawing.new("Square"); d:Remove()
end)

local function getHumanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function Main()
local guiParent = getParent()
for _, gui in pairs(guiParent:GetChildren()) do
    if gui.Name == "KipishHub" then pcall(function() gui:Destroy() end) end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KipishHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = guiParent

local CircleBtn = Instance.new("TextButton")
CircleBtn.Size = UDim2.fromOffset(50, 50)
CircleBtn.Position = UDim2.new(0, 20, 0.5, -25)
CircleBtn.BackgroundColor3 = Colors.bg
CircleBtn.Text = "K"
CircleBtn.TextColor3 = Colors.accent
CircleBtn.Font = Enum.Font.GothamBold
CircleBtn.TextSize = 24
CircleBtn.BorderSizePixel = 0
CircleBtn.Visible = false
CircleBtn.ZIndex = 100
CircleBtn.Active = true
CircleBtn.AutoButtonColor = false
CircleBtn.Parent = ScreenGui
Instance.new("UICorner", CircleBtn).CornerRadius = UDim.new(1, 0)
local UIStroke = Instance.new("UIStroke", CircleBtn)
UIStroke.Color = Colors.accent
UIStroke.Thickness = 2

local MainWindow = Instance.new("Frame")
MainWindow.Size = UDim2.fromOffset(450, 280)
MainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
MainWindow.Position = UDim2.fromScale(0.5, 0.5)
MainWindow.BackgroundColor3 = Colors.bg
MainWindow.BorderSizePixel = 0
MainWindow.Active = true
MainWindow.ZIndex = 10
MainWindow.Parent = ScreenGui
Instance.new("UICorner", MainWindow).CornerRadius = UDim.new(0, 8)

local UIScale = Instance.new("UIScale")
UIScale.Scale = 0.85
UIScale.Parent = MainWindow

local TopBar = Instance.new("TextButton")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Colors.bg
TopBar.Text = ""
TopBar.BorderSizePixel = 0
TopBar.Active = true
TopBar.AutoButtonColor = false
TopBar.ZIndex = 11
TopBar.Parent = MainWindow
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Kipish Hub"
Title.TextColor3 = Colors.text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 12
Title.Active = false
Title.Parent = TopBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.fromOffset(30, 30)
MinBtn.AnchorPoint = Vector2.new(0.5, 0.5)
MinBtn.Position = UDim2.new(1, -30, 0.5, 0)
MinBtn.BackgroundTransparency = 1
MinBtn.Text = "—"
MinBtn.TextColor3 = Colors.text
MinBtn.TextSize = 20
MinBtn.Font = Enum.Font.GothamBold
MinBtn.ZIndex = 12
MinBtn.Parent = TopBar
MinBtn.MouseButton1Click:Connect(function()
    MainWindow.Visible = false
    CircleBtn.Visible = true
end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Colors.sidebar
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 11
Sidebar.Parent = MainWindow
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 8)

local SidebarList = Instance.new("Frame")
SidebarList.Size = UDim2.new(1, -10, 1, -10)
SidebarList.Position = UDim2.new(0, 5, 0, 5)
SidebarList.BackgroundTransparency = 1
SidebarList.ZIndex = 12
SidebarList.Parent = Sidebar
Instance.new("UIListLayout", SidebarList).Padding = UDim.new(0, 3)

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -120, 1, -40)
ContentArea.Position = UDim2.new(0, 120, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.ZIndex = 11
ContentArea.Parent = MainWindow

local Pages = {}

local function CreateTab(name, order)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 32)
    tabBtn.BackgroundColor3 = Colors.sidebar
    tabBtn.Text = "  " .. name
    tabBtn.TextColor3 = Colors.subtext
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 12
    tabBtn.TextXAlignment = Enum.TextXAlignment.Left
    tabBtn.LayoutOrder = order
    tabBtn.ZIndex = 12
    tabBtn.Parent = SidebarList
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.Visible = false
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Colors.accent
    page.CanvasSize = UDim2.new(0, 0, 0, 400)
    page.ZIndex = 12
    page.Parent = ContentArea

    local pPad = Instance.new("UIPadding", page)
    pPad.PaddingLeft = UDim.new(0, 10)
    pPad.PaddingTop = UDim.new(0, 10)
    pPad.PaddingRight = UDim.new(0, 10)

    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    tabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, t in pairs(SidebarList:GetChildren()) do
            if t:IsA("TextButton") then
                t.TextColor3 = Colors.subtext
                t.BackgroundTransparency = 1
            end
        end
        page.Visible = true
        tabBtn.TextColor3 = Colors.text
        tabBtn.BackgroundTransparency = 0
        tabBtn.BackgroundColor3 = Colors.element
    end)

    Pages[name] = page
    return page
end

local function CreateToggle(parent, titleText, descText, order, defaultState, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundColor3 = Colors.element
    frame.LayoutOrder = order
    frame.ZIndex = 12
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -60, 0, 18)
    title.Position = UDim2.new(0, 10, 0, 4)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.TextColor3 = Colors.text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 12
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 13
    title.Parent = frame

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -60, 0, 14)
    desc.Position = UDim2.new(0, 10, 0, 20)
    desc.BackgroundTransparency = 1
    desc.Text = descText
    desc.TextColor3 = Colors.subtext
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 10
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.ZIndex = 13
    desc.Parent = frame

    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.fromOffset(34, 18)
    toggleBg.Position = UDim2.new(1, -44, 0.5, -9)
    toggleBg.BackgroundColor3 = defaultState and Colors.accent or Colors.off
    toggleBg.ZIndex = 13
    toggleBg.Parent = frame
    Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.fromOffset(14, 14)
    circle.Position = defaultState and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    circle.BackgroundColor3 = Colors.text
    circle.ZIndex = 14
    circle.Parent = toggleBg
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromScale(1, 1)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 15
    btn.Parent = frame

    local isOn = defaultState
    local function setState(nv, trig)
        isOn = nv
        toggleBg.BackgroundColor3 = isOn and Colors.accent or Colors.off
        TweenService:Create(circle, TweenInfo.new(0.15), {
            Position = isOn and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        }):Play()
        if trig and callback then pcall(callback, isOn) end
    end

    btn.MouseButton1Click:Connect(function() setState(not isOn, true) end)
    return { Set = function(v) if v ~= isOn then setState(v, true) end end, Get = function() return isOn end }
end

local function CreateSlider(parent, titleText, min, max, default, order, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundColor3 = Colors.element
    frame.LayoutOrder = order
    frame.ZIndex = 12
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -60, 0, 18)
    title.Position = UDim2.new(0, 10, 0, 4)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.TextColor3 = Colors.text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 12
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 13
    title.Parent = frame

    local valText = Instance.new("TextLabel")
    valText.Size = UDim2.new(0, 40, 0, 18)
    valText.Position = UDim2.new(1, -50, 0, 4)
    valText.BackgroundTransparency = 1
    valText.Text = tostring(default)
    valText.TextColor3 = Colors.accent
    valText.Font = Enum.Font.GothamBold
    valText.TextSize = 12
    valText.TextXAlignment = Enum.TextXAlignment.Right
    valText.ZIndex = 13
    valText.Parent = frame

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -20, 0, 4)
    track.Position = UDim2.new(0, 10, 1, -10)
    track.BackgroundColor3 = Colors.off
    track.ZIndex = 13
    track.Parent = frame
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Colors.accent
    fill.ZIndex = 14
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dragBtn = Instance.new("TextButton")
    dragBtn.Size = UDim2.new(1, 0, 0, 24)
    dragBtn.Position = UDim2.new(0, 0, 0.5, -12)
    dragBtn.BackgroundTransparency = 1
    dragBtn.Text = ""
    dragBtn.ZIndex = 15
    dragBtn.Parent = track

    local dragging = false
    dragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local rel = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + (max - min) * rel + 0.5)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            valText.Text = tostring(val)
            if callback then pcall(callback, val) end
        end
    end)
      local pageAim = CreateTab("Аимбот", 1)
local pageVis = CreateTab("Визуал", 2)
local pageEsp = CreateTab("ESP", 3)
local pageMisc = CreateTab("Разное", 4)
local pageDiag = CreateTab("Диагностика", 5)

pageAim.Visible = true
local firstTab = nil
for _, c in pairs(SidebarList:GetChildren()) do if c:IsA("TextButton") then firstTab = c; break end end
if firstTab then
    firstTab.BackgroundTransparency = 0
    firstTab.BackgroundColor3 = Colors.element
    firstTab.TextColor3 = Colors.text
end

local AimState = { smoothEnabled = false, snapEnabled = false, smoothSpeed = 0.18, fov = 150, showFov = false, fovCircle = nil }

local function getNearestTarget()
    local closest, minDist = nil, AimState.fov
    local center = Camera.ViewportSize / 2
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local char = p.Character
        local head = char and char:FindFirstChild("Head")
        if not head then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
        if not onScreen then continue end
        local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
        if dist < minDist then minDist = dist; closest = head end
    end
    return closest
end

local smoothCtrl, snapCtrl

smoothCtrl = CreateToggle(pageAim, "Тихое наведение", "Плавно ведёт к цели", 1, false, function(on)
    AimState.smoothEnabled = on
    if on and snapCtrl and snapCtrl.Get() then snapCtrl.Set(false) end
end)

snapCtrl = CreateToggle(pageAim, "Резкое наведение", "Мгновенный снэп на цель", 2, false, function(on)
    AimState.snapEnabled = on
    if on and smoothCtrl and smoothCtrl.Get() then smoothCtrl.Set(false) end
end)

CreateSlider(pageAim, "Радиус (FOV)", 20, 400, 150, 3, function(val) AimState.fov = val end)
CreateToggle(pageAim, "Показывать круг", "Отрисовка зоны поиска", 4, false, function(on)
    AimState.showFov = on
    if not on and AimState.fovCircle then AimState.fovCircle.Visible = false end
end)

local BrightSaved = nil
CreateToggle(pageVis, "Полная яркость", "Убирает тени и тьму", 1, false, function(on)
    if on then
        if not BrightSaved then
            BrightSaved = { Brightness = Lighting.Brightness, Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient, ClockTime = Lighting.ClockTime }
        end
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(200, 200, 200)
        Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
        Lighting.ClockTime = 12
    else
        if BrightSaved then
            Lighting.Brightness = BrightSaved.Brightness
            Lighting.Ambient = BrightSaved.Ambient
            Lighting.OutdoorAmbient = BrightSaved.OutdoorAmbient
            Lighting.ClockTime = BrightSaved.ClockTime
            BrightSaved = nil
        end
    end
end)

local ESPState = { enabled = false, boxes = {} }
local function clearESP()
    for _, box in pairs(ESPState.boxes) do pcall(function() box:Remove() end) end
    ESPState.boxes = {}
end

CreateToggle(pageEsp, "Квадраты", "Рамки вокруг игроков", 1, false, function(on)
    if not hasDrawing then warn("[Kipish Hub] Drawing API недоступен") return end
    ESPState.enabled = on
    if not on then clearESP() end
end)
Players.PlayerRemoving:Connect(function(p)
    if ESPState.boxes[p] then pcall(function() ESPState.boxes[p]:Remove() end); ESPState.boxes[p] = nil end
end)  end
local MoveState = { WalkSpeed = 16, JumpPower = 50, Noclip = false }
local function applyWalkSpeed() local hum = getHumanoid(); if hum then hum.WalkSpeed = MoveState.WalkSpeed end end
local function applyJumpPower() local hum = getHumanoid(); if hum then hum.JumpPower = MoveState.JumpPower; hum.UseJumpPower = true end end

LocalPlayer.CharacterAdded:Connect(function() task.wait(0.5); applyWalkSpeed(); applyJumpPower() end)
if LocalPlayer.Character then task.defer(applyWalkSpeed); task.defer(applyJumpPower) end

CreateSlider(pageMisc, "Скорость", 16, 100, 16, 1, function(val) MoveState.WalkSpeed = val; applyWalkSpeed() end)
CreateSlider(pageMisc, "Прыжок", 50, 200, 50, 2, function(val) MoveState.JumpPower = val; applyJumpPower() end)

local infJumpConn
CreateToggle(pageMisc, "Бесконечный прыжок", "Прыжок в воздухе", 3, false, function(on)
    if not on and infJumpConn then infJumpConn:Disconnect(); infJumpConn = nil end
    if on and not infJumpConn then
        infJumpConn = UserInputService.JumpRequest:Connect(function()
            local hum = getHumanoid(); if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    end
end)

CreateToggle(pageMisc, "Noclip", "Проход сквозь стены", 4, false, function(on) MoveState.Noclip = on end)

local antiAfkConn
CreateToggle(pageMisc, "Анти-АФК", "Защита от кика", 5, false, function(on)
    if not on and antiAfkConn then antiAfkConn:Disconnect(); antiAfkConn = nil end
    if on and not antiAfkConn then
        antiAfkConn = LocalPlayer.Idled:Connect(function()
            pcall(function() VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end)
        end)
    end
end)

local FPSBoost = { enabled = false, savedShadows = nil, savedEffects = {}, wsConn = nil, lightConn = nil }
local function isEffect(obj) return obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("PostEffect") end
local function disableEffect(obj)
    if not obj or not obj.Parent then return end
    if FPSBoost.savedEffects[obj] == nil then FPSBoost.savedEffects[obj] = obj.Enabled end
    pcall(function() obj.Enabled = false end)
end
local function scanEffects()
    for _, obj in pairs(workspace:GetDescendants()) do if isEffect(obj) then disableEffect(obj) end end
    for _, obj in pairs(Lighting:GetDescendants()) do if isEffect(obj) then disableEffect(obj) end end
end
local function restoreEffects()
    for obj, en in pairs(FPSBoost.savedEffects) do if obj and obj.Parent then pcall(function() obj.Enabled = en end) end end
    FPSBoost.savedEffects = {}
end

CreateToggle(pageMisc, "Boost FPS", "Отключает частицы и тени", 6, false, function(on)
    FPSBoost.enabled = on
    if on then
        if FPSBoost.savedShadows == nil then FPSBoost.savedShadows = Lighting.GlobalShadows end
        Lighting.GlobalShadows = false
        scanEffects()
        FPSBoost.wsConn = workspace.DescendantAdded:Connect(function(obj) if FPSBoost.enabled and isEffect(obj) then disableEffect(obj) end end)
        FPSBoost.lightConn = Lighting.DescendantAdded:Connect(function(obj) if FPSBoost.enabled and isEffect(obj) then disableEffect(obj) end end)
    else
        if FPSBoost.savedShadows ~= nil then Lighting.GlobalShadows = FPSBoost.savedShadows; FPSBoost.savedShadows = nil end
        restoreEffects()
        if FPSBoost.wsConn then FPSBoost.wsConn:Disconnect(); FPSBoost.wsConn = nil end
        if FPSBoost.lightConn then FPSBoost.lightConn:Disconnect(); FPSBoost.lightConn = nil end
    end
end)

local Diag = { rows = {}, fpsFrames = 0, currentFps = 0, lastUpdate = os.clock() }
local LOAD_TIME_MS = (os.clock() - LOAD_START) * 1000
local function addDiagRow(parent, order, titleText, getValue)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 32)
    row.BackgroundColor3 = Colors.element
    row.LayoutOrder = order
    row.ZIndex = 12
    row.Parent = parent
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(0.55, -10, 1, 0); t.Position = UDim2.new(0, 10, 0, 0); t.BackgroundTransparency = 1
    t.Text = titleText; t.TextColor3 = Colors.text; t.Font = Enum.Font.GothamBold; t.TextSize = 11; t.TextXAlignment = Enum.TextXAlignment.Left; t.ZIndex = 13; t.Parent = row
    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0.45, -10, 1, 0); v.Position = UDim2.new(0.55, 0, 0, 0); v.BackgroundTransparency = 1
    v.Text = "—"; v.TextColor3 = Colors.subtext; v.Font = Enum.Font.GothamBold; v.TextSize = 11; v.TextXAlignment = Enum.TextXAlignment.Right; v.ZIndex = 13; v.Parent = row
    table.insert(Diag.rows, {label = v, getValue = getValue})
end

local function refreshDiag()
    for _, row in ipairs(Diag.rows) do
        local ok, res = pcall(row.getValue)
        if ok and res and res.text then
            row.label.Text = res.text
            if res.status == "ok" then row.label.TextColor3 = Colors.ok
            elseif res.status == "fail" then row.label.TextColor3 = Colors.fail
            elseif res.status == "warn" then row.label.TextColor3 = Colors.warn
            else row.label.TextColor3 = Colors.subtext end
        else row.label.Text = "err"; row.label.TextColor3 = Colors.fail end
    end
end

addDiagRow(pageDiag, 1, "Версия", function() return {text = VERSION, status = "ok"} end)
addDiagRow(pageDiag, 2, "Drawing API", function() if hasDrawing then return {text = "есть", status = "ok"} end return {text = "нет", status = "fail"} end)
addDiagRow(pageDiag, 3, "Родитель GUI", function() local ok = pcall(function() return guiParent.Name end) if not ok then return {text = "?", status = "fail"} end return {text = guiParent.Name, status = (guiParent == game:GetService("CoreGui")) and "ok" or "warn"} end)
addDiagRow(pageDiag, 4, "VirtualUser", function() local ok = pcall(function() VirtualUser:CaptureController() end) if ok then return {text = "есть", status = "ok"} end return {text = "нет", status = "fail"} end)
addDiagRow(pageDiag, 5, "Персонаж", function() if LocalPlayer.Character then return {text = "загружен", status = "ok"} end return {text = "нет", status = "warn"} end)
addDiagRow(pageDiag, 6, "Humanoid", function() if getHumanoid() then return {text = "есть", status = "ok"} end return {text = "нет", status = "fail"} end)
addDiagRow(pageDiag, 7, "Платформа", function()
    local touch, kb = UserInputService.TouchEnabled, UserInputService.KeyboardEnabled
    if touch and kb then return {text = "гибрид", status = "ok"} end
    if touch then return {text = "Android", status = "ok"} end
    if kb then return {text = "PC", status = "ok"} end
    return {text = "?", status = "warn"}
end)
addDiagRow(pageDiag, 8, "Lighting", function() local ok = pcall(function() local b = Lighting.Brightness end) if ok then return {text = "доступ", status = "ok"} end return {text = "закрыт", status = "fail"} end)
addDiagRow(pageDiag, 9, "Вкладок создано", function()
    local c = 0; for _, ch in pairs(SidebarList:GetChildren()) do if ch:IsA("TextButton") then c = c + 1 end end
    return {text = tostring(c) .. "/5", status = (c == 5) and "ok" or "fail"}
end)
addDiagRow(pageDiag, 10, "Элементов UI", function() local c = #ScreenGui:GetDescendants() return {text = tostring(c), status = (c > 20) and "ok" or "warn"} end)
addDiagRow(pageDiag, 11, "Время загрузки", function() return {text = string.format("%d мс", math.floor(LOAD_TIME_MS)), status = "ok"} end)
addDiagRow(pageDiag, 12, "FPS (живой)", function() return {text = tostring(math.floor(Diag.currentFps)), status = "ok"} end)
addDiagRow(pageDiag, 13, "Пинг (живой)", function()
    local ok, ping = pcall(function() return Stats.Network.ServerStatsItem["Data Ping"]:GetValue() end)
    if ok and ping then return {text = math.floor(ping) .. " мс", status = "ok"} end
    return {text = "n/a", status = "warn"}
end)

local recheckBtn = Instance.new("TextButton")
recheckBtn.Size = UDim2.new(1, 0, 0, 36)
recheckBtn.BackgroundColor3 = Colors.accent
recheckBtn.Text = "Перепроверить"
recheckBtn.TextColor3 = Colors.text
recheckBtn.Font = Enum.Font.GothamBold
recheckBtn.TextSize = 12
recheckBtn.LayoutOrder = 100
recheckBtn.ZIndex = 12
recheckBtn.Parent = pageDiag
Instance.new("UICorner", recheckBtn).CornerRadius = UDim.new(0, 6)
recheckBtn.MouseButton1Click:Connect(refreshDiag)
refreshDiag()
RunService.RenderStepped:Connect(function()
    Diag.fpsFrames = Diag.fpsFrames + 1
    local now = os.clock()
    if now - Diag.lastUpdate >= 1 then
        Diag.currentFps = Diag.fpsFrames / (now - Diag.lastUpdate)
        Diag.fpsFrames = 0; Diag.lastUpdate = now
        if pageDiag.Visible then refreshDiag() end
    end

    if AimState.showFov and hasDrawing then
        if not AimState.fovCircle then
            local ok, c = pcall(function() local ci = Drawing.new("Circle"); ci.Thickness = 1; ci.Color = Colors.accent; ci.Filled = false; ci.NumSides = 60; return ci end)
            if ok then AimState.fovCircle = c end
        end
        if AimState.fovCircle then
            AimState.fovCircle.Visible = true
            AimState.fovCircle.Position = Camera.ViewportSize / 2
            AimState.fovCircle.Radius = AimState.fov
        end
    elseif AimState.fovCircle then AimState.fovCircle.Visible = false end

    if AimState.smoothEnabled or AimState.snapEnabled then
        local hum = getHumanoid()
        if hum and hum.Health > 0 then
            local target = getNearestTarget()
            if target and (Camera.CFrame.Position - target.Position).Magnitude > 0.1 then
                local goal = CFrame.lookAt(Camera.CFrame.Position, target.Position)
                if AimState.snapEnabled then Camera.CFrame = goal
                elseif AimState.smoothEnabled then Camera.CFrame = Camera.CFrame:Lerp(goal, AimState.smoothSpeed) end
            end
        end
    end

    if ESPState.enabled and hasDrawing then
        for _, player in pairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local head = char and char:FindFirstChild("Head")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hrp or not head or not hum or hum.Health <= 0 then
                if ESPState.boxes[player] then ESPState.boxes[player].Visible = false end
                continue
            end
            if not ESPState.boxes[player] then
                local ok, b = pcall(function() local bx = Drawing.new("Square"); bx.Thickness = 1; bx.Color = Colors.accent; bx.Filled = false; bx.Visible = false; return bx end)
                if ok then ESPState.boxes[player] = b end
            end
            local box = ESPState.boxes[player]
            if box then
                local headTop = head.Position + Vector3.new(0, 0.5, 0)
                local feetPos = hrp.Position - Vector3.new(0, 2.8, 0)
                local headScr, headOn = Camera:WorldToViewportPoint(headTop)
                local feetScr, feetOn = Camera:WorldToViewportPoint(feetPos)
                if not headOn or not feetOn then box.Visible = false; continue end
                local h = math.abs(feetScr.Y - headScr.Y)
                local w = h * 0.55
                box.Size = Vector2.new(w, h)
                box.Position = Vector2.new(headScr.X - w / 2, headScr.Y)
                box.Visible = true
            end
        end
    end
end)

RunService.Stepped:Connect(function()
    if not MoveState.Noclip then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in pairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end
end)

local wDragging, wDragStart, wStartPos = false, Vector2.zero, UDim2.new()
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        wDragging = true; wDragStart = Vector2.new(input.Position.X, input.Position.Y); wStartPos = MainWindow.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if wDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local dx, dy = input.Position.X - wDragStart.X, input.Position.Y - wDragStart.Y
        MainWindow.Position = UDim2.new(wStartPos.X.Scale, wStartPos.X.Offset + dx, wStartPos.Y.Scale, wStartPos.Y.Offset + dy)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then wDragging = false end
end)

local cDragging, cDragStart, cStartPos, cMovedFar = false, Vector2.zero, UDim2.new(), false
CircleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        cDragging = true; cDragStart = Vector2.new(input.Position.X, input.Position.Y); cStartPos = CircleBtn.Position; cMovedFar = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if cDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local dx, dy = input.Position.X - cDragStart.X, input.Position.Y - cDragStart.Y
        if math.abs(dx) > 8 or math.abs(dy) > 8 then cMovedFar = true end
        CircleBtn.Position = UDim2.new(cStartPos.X.Scale, cStartPos.X.Offset + dx, cStartPos.Y.Scale, cStartPos.Y.Offset + dy)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then cDragging = false end
end)
CircleBtn.MouseButton1Click:Connect(function()
    if cMovedFar then return end
    MainWindow.Visible = true
    CircleBtn.Visible = false
end)
end -- Конец функции Main

local ok, err = pcall(Main)
if not ok then
    warn("[Kipish Hub] CRASH:", err)
    pcall(function()
        local fb = Instance.new("ScreenGui"); fb.Name = "KipishHubFallback"; fb.ResetOnSpawn = false; fb.Parent = getParent()
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.fromOffset(320, 90); lbl.Position = UDim2.new(0, 10, 0, 10); lbl.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
        lbl.TextColor3 = Color3.new(1, 1, 1); lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 13
        lbl.Text = "⚠ Kipish Hub: ошибка загрузки\n" .. tostring(err) .. "\nF9 для деталей"; lbl.TextWrapped = true
        Instance.new("UICorner", lbl).CornerRadius = UDim.new(0, 8)
        lbl.Parent = fb
    end)
end
print("[Kipish Hub] " .. VERSION .. " загружен!")
