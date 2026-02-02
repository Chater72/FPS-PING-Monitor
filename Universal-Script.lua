local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local START_POS = UDim2.new(0.02, 0, 0.05, 0)
local FRAME_SIZE = UDim2.new(0, 240, 0, 180)
local TOGGLE_KEY = Enum.KeyCode.RightShift

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FPSPingMonitor"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = FRAME_SIZE
MainFrame.Position = START_POS
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

local GlowStroke = Instance.new("UIStroke")
GlowStroke.Thickness = 4
GlowStroke.Transparency = 0.4
GlowStroke.Color = Color3.fromRGB(100, 150, 255)
GlowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
GlowStroke.Parent = MainFrame

local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.Position = UDim2.new(0, -20, 0, -20)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://6014261993"  -- стандартная Roblox тень (можно заменить)
Shadow.ImageTransparency = 0.6
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "FPS / Ping Monitor"
Title.TextColor3 = Color3.fromRGB(220, 220, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBlack
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 24
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 12)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Name = "FPS"
FPSLabel.Size = UDim2.new(1, -30, 0, 35)
FPSLabel.Position = UDim2.new(0, 15, 0, 50)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "FPS: ---"
FPSLabel.TextSize = 24
FPSLabel.Font = Enum.Font.GothamSemibold
FPSLabel.TextXAlignment = Enum.TextXAlignment.Left
FPSLabel.Parent = MainFrame

local PingLabel = Instance.new("TextLabel")
PingLabel.Name = "Ping"
PingLabel.Size = UDim2.new(1, -30, 0, 35)
PingLabel.Position = UDim2.new(0, 15, 0, 90)
PingLabel.BackgroundTransparency = 1
PingLabel.Text = "Ping: --- ms"
PingLabel.TextSize = 24
PingLabel.Font = Enum.Font.GothamSemibold
PingLabel.TextXAlignment = Enum.TextXAlignment.Left
PingLabel.Parent = MainFrame

local BottomBar = Instance.new("Frame")
BottomBar.Size = UDim2.new(1, -20, 0, 40)
BottomBar.Position = UDim2.new(0, 10, 1, -50)
BottomBar.BackgroundTransparency = 1
BottomBar.Parent = MainFrame

local MenuBtn = Instance.new("TextButton")
MenuBtn.Size = UDim2.new(0.45, 0, 1, 0)
MenuBtn.Position = UDim2.new(0, 0, 0, 0)
MenuBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
MenuBtn.Text = "Menu (50 Styles)"
MenuBtn.TextColor3 = Color3.new(1,1,1)
MenuBtn.Font = Enum.Font.GothamBold
MenuBtn.TextSize = 16
MenuBtn.Parent = BottomBar

local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 12)
MenuCorner.Parent = MenuBtn

local FPSSettingsBtn = Instance.new("TextButton")
FPSSettingsBtn.Size = UDim2.new(0.25, 0, 1, 0)
FPSSettingsBtn.Position = UDim2.new(0.48, 0, 0, 0)
FPSSettingsBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 60)
FPSSettingsBtn.Text = "FPS Set"
FPSSettingsBtn.TextColor3 = Color3.new(1,1,1)
FPSSettingsBtn.Font = Enum.Font.GothamBold
FPSSettingsBtn.TextSize = 14
FPSSettingsBtn.Parent = BottomBar

local PingSettingsBtn = Instance.new("TextButton")
PingSettingsBtn.Size = UDim2.new(0.25, 0, 1, 0)
PingSettingsBtn.Position = UDim2.new(0.75, 0, 0, 0)
PingSettingsBtn.BackgroundColor3 = Color3.fromRGB(40, 60, 100)
PingSettingsBtn.Text = "Ping Set"
PingSettingsBtn.TextColor3 = Color3.new(1,1,1)
PingSettingsBtn.Font = Enum.Font.GothamBold
PingSettingsBtn.TextSize = 14
PingSettingsBtn.Parent = BottomBar

local MenuFrame = Instance.new("ScrollingFrame")
MenuFrame.Size = UDim2.new(1, -20, 0.7, -60)
MenuFrame.Position = UDim2.new(0, 10, 0, 50)
MenuFrame.BackgroundTransparency = 0.5
MenuFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
MenuFrame.BorderSizePixel = 0
MenuFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
MenuFrame.ScrollBarThickness = 6
MenuFrame.Visible = false
MenuFrame.Parent = MainFrame

local MenuGrid = Instance.new("UIGridLayout")
MenuGrid.CellSize = UDim2.new(0, 100, 0, 40)
MenuGrid.CellPadding = UDim2.new(0, 10, 0, 10)
MenuGrid.SortOrder = Enum.SortOrder.LayoutOrder
MenuGrid.Parent = MenuFrame

local styles = {
    {name="Default", bg=Color3.fromRGB(20,20,30), trans=0.3, stroke=Color3.fromRGB(100,100,255), title=Color3.fromRGB(220,220,255), grad=false},
    {name="Neon Cyan", bg=Color3.fromRGB(0,20,40), trans=0.4, stroke=Color3.fromRGB(0,255,255), title=Color3.fromRGB(0,255,255), grad=false},
    {name="Gold Lux", bg=Color3.fromRGB(50,40,10), trans=0.3, stroke=Color3.fromRGB(255,215,0), title=Color3.fromRGB(255,215,0), grad=true},
    {name="Rainbow Wave", bg=nil, trans=0.6, stroke=Color3.fromRGB(255,255,255), title=Color3.new(1,1,1), grad=true, anim=true},
    {name="Dark Void", bg=Color3.fromRGB(5,5,10), trans=0.1, stroke=Color3.fromRGB(80,80,120), title=Color3.fromRGB(160,160,200), grad=false},
    {name="Cyber Pink", bg=Color3.fromRGB(30,0,30), trans=0.4, stroke=Color3.fromRGB(255,0,200), title=Color3.fromRGB(255,100,220), grad=false},
    {name="Mint Fresh", bg=Color3.fromRGB(10,40,30), trans=0.35, stroke=Color3.fromRGB(0,255,180), title=Color3.fromRGB(0,255,180), grad=false},
    {name="Fire Red", bg=Color3.fromRGB(40,10,10), trans=0.3, stroke=Color3.fromRGB(255,80,0), title=Color3.fromRGB(255,120,0), grad=true},
    {name="Ice Blue", bg=Color3.fromRGB(10,20,40), trans=0.4, stroke=Color3.fromRGB(100,200,255), title=Color3.fromRGB(150,220,255), grad=false},
    {name="Purple Haze", bg=Color3.fromRGB(30,10,40), trans=0.35, stroke=Color3.fromRGB(200,0,255), title=Color3.fromRGB(220,100,255), grad=false},
    {name="Glitch Green", bg=Color3.fromRGB(0,30,0), trans=0.5, stroke=Color3.fromRGB(0,255,0), title=Color3.fromRGB(0,255,0), grad=false, glitch=true},
    {name="Pastel Pink", bg=Color3.fromRGB(60,30,50), trans=0.4, stroke=Color3.fromRGB(255,180,220), title=Color3.fromRGB(255,200,230), grad=false},
    {name="Chrome Silver", bg=Color3.fromRGB(40,40,50), trans=0.2, stroke=Color3.fromRGB(200,200,220), title=Color3.fromRGB(220,220,240), grad=true},
    {name="Lava Orange", bg=Color3.fromRGB(50,20,0), trans=0.3, stroke=Color3.fromRGB(255,140,0), title=Color3.fromRGB(255,180,50), grad=true},
    {name="Emerald", bg=Color3.fromRGB(0,50,30), trans=0.3, stroke=Color3.fromRGB(0,200,100), title=Color3.fromRGB(50,255,150), grad=false},
    {name="Midnight Blue", bg=Color3.fromRGB(5,10,30), trans=0.15, stroke=Color3.fromRGB(50,100,255), title=Color3.fromRGB(100,150,255), grad=false},
    {name="Candy Crush", bg=Color3.fromRGB(70,20,50), trans=0.4, stroke=Color3.fromRGB(255,100,200), title=Color3.fromRGB(255,150,220), grad=true},
    {name="Toxic Green", bg=Color3.fromRGB(10,40,10), trans=0.45, stroke=Color3.fromRGB(150,255,0), title=Color3.fromRGB(200,255,50), grad=false},
    {name="Vintage Sepia", bg=Color3.fromRGB(60,40,20), trans=0.3, stroke=Color3.fromRGB(180,140,80), title=Color3.fromRGB(200,160,100), grad=false},
    {name="Electric Purple", bg=Color3.fromRGB(40,0,60), trans=0.4, stroke=Color3.fromRGB(200,0,255), title=Color3.fromRGB(220,100,255), grad=true},
    -- Добавляю ещё 30 (разные комбинации, чтобы было 50)
    {name="Ocean Wave", bg=Color3.fromRGB(0,30,60), trans=0.35, stroke=Color3.fromRGB(0,180,255), title=Color3.fromRGB(100,220,255), grad=true},
    {name="Sunset Glow", bg=Color3.fromRGB(60,30,0), trans=0.3, stroke=Color3.fromRGB(255,150,50), title=Color3.fromRGB(255,200,100), grad=true},
    {name="Forest Moss", bg=Color3.fromRGB(10,40,20), trans=0.3, stroke=Color3.fromRGB(100,200,80), title=Color3.fromRGB(150,255,120), grad=false},
    {name="Neon Yellow", bg=Color3.fromRGB(40,40,0), trans=0.4, stroke=Color3.fromRGB(255,255,0), title=Color3.fromRGB(255,255,100), grad=false},
    {name="Rose Gold", bg=Color3.fromRGB(60,30,40), trans=0.25, stroke=Color3.fromRGB(230,190,170), title=Color3.fromRGB(255,210,200), grad=true},
    {name="Galaxy Purple", bg=Color3.fromRGB(20,0,40), trans=0.5, stroke=Color3.fromRGB(150,0,255), title=Color3.fromRGB(200,100,255), grad=true},
    {name="Steel Gray", bg=Color3.fromRGB(30,30,40), trans=0.2, stroke=Color3.fromRGB(150,150,170), title=Color3.fromRGB(200,200,220), grad=false},
    {name="Hot Magenta", bg=Color3.fromRGB(50,0,40), trans=0.4, stroke=Color3.fromRGB(255,0,150), title=Color3.fromRGB(255,80,200), grad=false},
    {name="Lime Acid", bg=Color3.fromRGB(20,50,0), trans=0.45, stroke=Color3.fromRGB(180,255,0), title=Color3.fromRGB(220,255,80), grad=false},
    {name="Cotton Candy", bg=Color3.fromRGB(70,40,70), trans=0.4, stroke=Color3.fromRGB(255,180,255), title=Color3.fromRGB(255,220,255), grad=true},
    {name="Bronze Age", bg=Color3.fromRGB(60,40,20), trans=0.3, stroke=Color3.fromRGB(200,140,80), title=Color3.fromRGB(220,160,100), grad=false},
    {name="Electric Blue", bg=Color3.fromRGB(0,20,60), trans=0.35, stroke=Color3.fromRGB(0,150,255), title=Color3.fromRGB(80,200,255), grad=true},
    {name="Blood Red", bg=Color3.fromRGB(50,0,0), trans=0.3, stroke=Color3.fromRGB(255,50,50), title=Color3.fromRGB(255,100,100), grad=false},
    {name="Sky Blue", bg=Color3.fromRGB(10,40,70), trans=0.3, stroke=Color3.fromRGB(100,180,255), title=Color3.fromRGB(150,220,255), grad=false},
    {name="Matrix Green", bg=Color3.fromRGB(0,30,0), trans=0.4, stroke=Color3.fromRGB(0,200,0), title=Color3.fromRGB(0,255,0), grad=false},
    {name="Lavender Dream", bg=Color3.fromRGB(50,30,70), trans=0.35, stroke=Color3.fromRGB(200,150,255), title=Color3.fromRGB(220,180,255), grad=true},
    {name="Copper Rust", bg=Color3.fromRGB(60,30,20), trans=0.3, stroke=Color3.fromRGB(180,100,60), title=Color3.fromRGB(200,120,80), grad=false},
    {name="Aurora Borealis", bg=nil, trans=0.6, stroke=Color3.fromRGB(0,255,200), title=Color3.new(1,1,1), grad=true, anim=true},
    {name="Monochrome", bg=Color3.fromRGB(20,20,20), trans=0.1, stroke=Color3.fromRGB(150,150,150), title=Color3.fromRGB(220,220,220), grad=false},
    {name="Flamingo Pink", bg=Color3.fromRGB(70,20,50), trans=0.4, stroke=Color3.fromRGB(255,100,180), title=Color3.fromRGB(255,150,200), grad=false},
    {name="Deep Ocean", bg=Color3.fromRGB(0,10,40), trans=0.2, stroke=Color3.fromRGB(0,100,200), title=Color3.fromRGB(50,150,255), grad=true},
    {name="Sunflower Yellow", bg=Color3.fromRGB(70,50,0), trans=0.3, stroke=Color3.fromRGB(255,220,0), title=Color3.fromRGB(255,240,100), grad=false},
    {name="Violet Night", bg=Color3.fromRGB(30,10,50), trans=0.35, stroke=Color3.fromRGB(180,0,255), title=Color3.fromRGB(220,80,255), grad=false},
    {name="Pearl White", bg=Color3.fromRGB(50,50,60), trans=0.15, stroke=Color3.fromRGB(220,220,240), title=Color3.fromRGB(240,240,255), grad=true},
    {name="Shadow Black", bg=Color3.fromRGB(0,0,0), trans=0.05, stroke=Color3.fromRGB(80,80,100), title=Color3.fromRGB(150,150,180), grad=false},
    {name="Crystal Blue", bg=Color3.fromRGB(10,30,60), trans=0.4, stroke=Color3.fromRGB(100,200,255), title=Color3.fromRGB(150,230,255), grad=true},
    {name="Hot Lava", bg=Color3.fromRGB(60,10,0), trans=0.3, stroke=Color3.fromRGB(255,80,0), title=Color3.fromRGB(255,120,0), grad=true},
    {name="Sakura Pink", bg=Color3.fromRGB(70,30,50), trans=0.35, stroke=Color3.fromRGB(255,180,220), title=Color3.fromRGB(255,210,240), grad=false},
    {name="Tech Gray", bg=Color3.fromRGB(30,35,40), trans=0.2, stroke=Color3.fromRGB(140,160,180), title=Color3.fromRGB(200,210,230), grad=false},
    {name="Neon Orange", bg=Color3.fromRGB(50,20,0), trans=0.4, stroke=Color3.fromRGB(255,140,0), title=Color3.fromRGB(255,180,50), grad=false}
}

local rainbowConn, glitchConn

local function applyStyle(idx)
    local s = styles[idx]
    if not s then return end
    
    if rainbowConn then rainbowConn:Disconnect() rainbowConn = nil end
    if glitchConn then glitchConn:Disconnect() glitchConn = nil end
    
    local UIGrad = MainFrame:FindFirstChild("UIGradient") or Instance.new("UIGradient")
    UIGrad.Parent = MainFrame
    UIGrad.Enabled = s.grad or false
    
    if s.name:find("Rainbow") or s.name:find("Aurora") then
        UIGrad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255,127,0)),
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255,255,0)),
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0,255,0)),
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0,0,255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,255))
        }
        rainbowConn = RunService.Heartbeat:Connect(function()
            UIGrad.Offset = Vector2.new(math.sin(tick()*2)*0.5, 0)
        end)
    end
    
    MainFrame.BackgroundColor3 = s.bg or Color3.fromRGB(20,20,30)
    MainFrame.BackgroundTransparency = s.trans
    GlowStroke.Color = s.stroke
    Title.TextColor3 = s.title
    
    if s.glitch then
        glitchConn = RunService.Heartbeat:Connect(function()
            if math.random() < 0.05 then
                MainFrame.Position = MainFrame.Position + UDim2.new(0, math.random(-5,5), 0, math.random(-5,5))
                wait(0.05)
                MainFrame.Position = MainFrame.Position - UDim2.new(0, math.random(-5,5), 0, math.random(-5,5))
            end
        end)
    end
end

for i, s in ipairs(styles) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 40)
    btn.BackgroundColor3 = s.stroke or Color3.fromRGB(60,60,100)
    btn.Text = s.name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = MenuFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        applyStyle(i)
        MenuFrame.Visible = false
    end)
end

MenuFrame.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#styles / 2) * 50 + 20)

MenuBtn.MouseButton1Click:Connect(function()
    MenuFrame.Visible = not MenuFrame.Visible
end)

-- Settings FPS
local function createSettingsWindow(label, targetLabel)
    local SettingsFrame = Instance.new("Frame")
    SettingsFrame.Size = UDim2.new(0, 300, 0, 200)
    SettingsFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    SettingsFrame.BackgroundColor3 = Color3.fromRGB(20,20,30)
    SettingsFrame.BackgroundTransparency = 0.2
    SettingsFrame.Parent = ScreenGui
    SettingsFrame.Visible = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = SettingsFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,40)
    title.Text = label .. " Settings"
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(1,1,1)
    title.TextSize = 20
    title.Parent = SettingsFrame
    
    local posLabel = Instance.new("TextLabel")
    posLabel.Size = UDim2.new(1,0,0,30)
    posLabel.Position = UDim2.new(0,0,0,50)
    posLabel.Text = "Position (ScaleX,OffsetX,ScaleY,OffsetY):"
    posLabel.BackgroundTransparency = 1
    posLabel.TextColor3 = Color3.new(1,1,1)
    posLabel.Parent = SettingsFrame
    
    local posBox = Instance.new("TextBox")
    posBox.Size = UDim2.new(1,-20,0,30)
    posBox.Position = UDim2.new(0,10,0,80)
    posBox.Text = tostring(targetLabel.Position)
    posBox.Parent = SettingsFrame
    
    local sizeLabel = Instance.new("TextLabel")
    sizeLabel.Size = UDim2.new(1,0,0,30)
    sizeLabel.Position = UDim2.new(0,0,0,120)
    sizeLabel.Text = "Size (ScaleX,OffsetX,ScaleY,OffsetY):"
    sizeLabel.BackgroundTransparency = 1
    sizeLabel.TextColor3 = Color3.new(1,1,1)
    sizeLabel.Parent = SettingsFrame
    
    local sizeBox = Instance.new("TextBox")
    sizeBox.Size = UDim2.new(1,-20,0,30)
    sizeBox.Position = UDim2.new(0,10,0,150)
    sizeBox.Text = tostring(targetLabel.Size)
    sizeBox.Parent = SettingsFrame
    
    local applyBtn = Instance.new("TextButton")
    applyBtn.Size = UDim2.new(0.8,0,0,40)
    applyBtn.Position = UDim2.new(0.1,0,1,-50)
    applyBtn.Text = "Apply"
    applyBtn.BackgroundColor3 = Color3.fromRGB(60,180,60)
    applyBtn.TextColor3 = Color3.new(1,1,1)
    applyBtn.Parent = SettingsFrame
    
    applyBtn.MouseButton1Click:Connect(function()
        local success, newPos = pcall(function()
            local parts = string.split(posBox.Text, ",")
            return UDim2.new(tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3]), tonumber(parts[4]))
        end)
        if success then targetLabel.Position = newPos end
        
        local success2, newSize = pcall(function()
            local parts = string.split(sizeBox.Text, ",")
            return UDim2.new(tonumber(parts[1]), tonumber(parts[2]), tonumber(parts[3]), tonumber(parts[4]))
        end)
        if success2 then targetLabel.Size = newSize end
        
        SettingsFrame:Destroy()
    end)
    
    -- Close on outside click or something, but for simplicity
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0,30,0,30)
    close.Position = UDim2.new(1,-35,0,5)
    close.Text = "X"
    close.BackgroundColor3 = Color3.fromRGB(200,50,50)
    close.Parent = SettingsFrame
    
    close.MouseButton1Click:Connect(function()
        SettingsFrame:Destroy()
    end)
end

FPSSettingsBtn.MouseButton1Click:Connect(function()
    createSettingsWindow("FPS Label", FPSLabel)
end)

PingSettingsBtn.MouseButton1Click:Connect(function()
    createSettingsWindow("Ping Label", PingLabel)
end)

local dragging = false
local dragInput
local dragStart
local startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == TOGGLE_KEY then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

local counter = 0
RunService.RenderStepped:Connect(function()
    counter += 1
end)

spawn(function()
    while wait(1) do
        local fps = counter
        FPSLabel.Text = "FPS: " .. fps
        
        local ping = "N/A"
        pcall(function()
            ping = math.floor(LocalPlayer:GetNetworkPing() * 1000 + 0.5)
        end)
        if ping == "N/A" then
            pcall(function()
                ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5)
            end)
        end
        PingLabel.Text = "Ping: " .. (ping == "N/A" and "N/A" or ping .. " ms")
        
        if fps >= 100 then FPSLabel.TextColor3 = Color3.fromRGB(100,255,100)
        elseif fps >= 60 then FPSLabel.TextColor3 = Color3.fromRGB(255,255,120)
        elseif fps >= 30 then FPSLabel.TextColor3 = Color3.fromRGB(255,180,80)
        else FPSLabel.TextColor3 = Color3.fromRGB(255,80,80) end
        
        if type(ping) == "number" then
            if ping <= 50 then PingLabel.TextColor3 = Color3.fromRGB(100,255,100)
            elseif ping <= 100 then PingLabel.TextColor3 = Color3.fromRGB(255,255,120)
            elseif ping <= 200 then PingLabel.TextColor3 = Color3.fromRGB(255,180,80)
            else PingLabel.TextColor3 = Color3.fromRGB(255,80,80) end
        end
        
        counter = 0
    end
end)

applyStyle(1)
