local musicFileName = "umad_sci.mp3"
local musicUrl = "https://raw.githubusercontent.com/cawiworld/fekality/refs/heads/main/umad_sci.mp3"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local Lighting = game:GetService("Lighting")

local Config = {
    Nightmode = false,
    Fullbright = false,
    LogHarmed = true,
    LogSpread = true,
    LogDeath = true,
    SCIMusic = true
}

local OrigClockTime = Lighting.ClockTime
local OrigBrightness = Lighting.Brightness
local OrigOutdoorAmbient = Lighting.OutdoorAmbient

local HttpParent = CoreGui:FindFirstChild("RobloxGui") or CoreGui
if not HttpParent then HttpParent = LocalPlayer:WaitForChild("PlayerGui") end

if HttpParent:FindFirstChild("NeverPuzoUI") then HttpParent.NeverPuzoUI:Destroy() end

local NeverPuzoUI = Instance.new("ScreenGui")
NeverPuzoUI.Name = "NeverPuzoUI"
NeverPuzoUI.ResetOnSpawn = false
NeverPuzoUI.Parent = HttpParent

local NotifyContainer = Instance.new("Frame")
NotifyContainer.Name = "NotifyContainer"
NotifyContainer.Size = UDim2.new(0, 300, 1, -20)
NotifyContainer.Position = UDim2.new(1, -320, 0, 10)
NotifyContainer.BackgroundTransparency = 1
NotifyContainer.Parent = NeverPuzoUI

local NotifyLayout = Instance.new("UIListLayout")
NotifyLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifyLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
NotifyLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifyLayout.Padding = UDim.new(0, 8)
NotifyLayout.Parent = NotifyContainer

local function LogMessage(title, text)
    task.spawn(function()
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 0, 50)
        Frame.BackgroundColor3 = Color3.fromRGB(10, 14, 22)
        Frame.BorderSizePixel = 0
        Frame.BackgroundTransparency = 1
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 4)
        Corner.Parent = Frame
        
        local Accent = Instance.new("Frame")
        Accent.Size = UDim2.new(0, 3, 1, 0)
        Accent.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
        Accent.BorderSizePixel = 0
        Accent.BackgroundTransparency = 1
        Accent.Parent = Frame

        local Tl = Instance.new("TextLabel")
        Tl.Size = UDim2.new(1, -20, 0, 20)
        Tl.Position = UDim2.new(0, 12, 0, 4)
        Tl.BackgroundTransparency = 1
        Tl.TextColor3 = Color3.fromRGB(0, 162, 255)
        Tl.TextSize = 13
        Tl.Font = Enum.Font.GothamBold
        Tl.TextXAlignment = Enum.TextXAlignment.Left
        Tl.Text = title
        Tl.TextTransparency = 1
        Tl.Parent = Frame

        local Tx = Instance.new("TextLabel")
        Tx.Size = UDim2.new(1, -20, 0, 20)
        Tx.Position = UDim2.new(0, 12, 0, 22)
        Tx.BackgroundTransparency = 1
        Tx.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tx.TextSize = 12
        Tx.Font = Enum.Font.Gotham
        Tx.TextXAlignment = Enum.TextXAlignment.Left
        Tx.Text = text
        Tx.TextTransparency = 1
        Tx.Parent = Frame

        Frame.LayoutOrder = #NotifyContainer:GetChildren() + 1
        Frame.Parent = NotifyContainer

        Frame.Position = UDim2.new(1, 300, 0, 0)
        TweenService:Create(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.1}):Play()
        TweenService:Create(Accent, TweenInfo.new(0.25), {BackgroundTransparency = 0}):Play()
        TweenService:Create(Tl, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
        TweenService:Create(Tx, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
        
        task.wait(3)

        TweenService:Create(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Accent, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Tl, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        TweenService:Create(Tx, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        
        task.wait(0.25)
        Frame:Destroy()
    end)
end

if type(isfile) == "function" and not isfile(musicFileName) then
    LogMessage("NeverPuzo", "Downloading umad_sci.mp3...")
    local success, fileData = pcall(function() return game:HttpGet(musicUrl) end)
    if success and fileData and not fileData:find("404: Not Found") then
        if type(writefile) == "function" then
            writefile(musicFileName, fileData)
            LogMessage("NeverPuzo", "Music downloaded successfully!")
        end
    else
        LogMessage("NeverPuzo", "Failed to download audio from GitHub.")
    end
end

local Loader = Instance.new("Frame")
Loader.Size = UDim2.new(0, 320, 0, 160)
Loader.Position = UDim2.new(0.5, -160, 0.5, -80)
Loader.BackgroundColor3 = Color3.fromRGB(11, 14, 22)
Loader.BorderSizePixel = 0
Loader.Parent = NeverPuzoUI

local LoaderCorner = Instance.new("UICorner")
LoaderCorner.CornerRadius = UDim.new(0, 6)
LoaderCorner.Parent = Loader

local LoaderStroke = Instance.new("UIStroke")
LoaderStroke.Color = Color3.fromRGB(0, 120, 255)
LoaderStroke.Thickness = 1.5
LoaderStroke.Parent = Loader

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 0, 40)
LogoText.Position = UDim2.new(0, 0, 0, 25)
LogoText.BackgroundTransparency = 1
LogoText.TextSize = 26
LogoText.Font = Enum.Font.GothamBold
LogoText.RichText = true
LogoText.Text = '<font color="rgb(0, 162, 255)">Never</font><font color="rgb(255, 255, 255)">Puzo</font>'
LogoText.Parent = Loader

local InjectStatus = Instance.new("TextLabel")
InjectStatus.Size = UDim2.new(1, 0, 0, 20)
InjectStatus.Position = UDim2.new(0, 0, 0, 65)
InjectStatus.BackgroundTransparency = 1
InjectStatus.TextColor3 = Color3.fromRGB(150, 160, 180)
InjectStatus.TextSize = 12
InjectStatus.Font = Enum.Font.Gotham
local phrases = {"Injecting...", "Checking assets...", "Hooking Remotes...", "Ready!"}
InjectStatus.Text = phrases[1]
InjectStatus.Parent = Loader

local AuthorText = Instance.new("TextLabel")
AuthorText.Size = UDim2.new(1, 0, 0, 20)
AuthorText.Position = UDim2.new(0, 0, 1, -25)
AuthorText.BackgroundTransparency = 1
AuthorText.TextColor3 = Color3.fromRGB(70, 80, 100)
AuthorText.TextSize = 11
AuthorText.Font = Enum.Font.GothamItalic
AuthorText.Text = "author this shii: relosterpc"
AuthorText.Parent = Loader

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 240, 0, 4)
BarBg.Position = UDim2.new(0.5, -120, 0, 100)
BarBg.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
BarBg.BorderSizePixel = 0
BarBg.Parent = Loader

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBg

task.spawn(function()
    for i = 2, #phrases do
        task.wait(1)
        InjectStatus.Text = phrases[i]
    end
end)
local loadTween = TweenService:Create(BarFill, TweenInfo.new(3.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)})
loadTween:Play()
loadTween.Completed:Wait()

TweenService:Create(Loader, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
TweenService:Create(LoaderStroke, TweenInfo.new(0.3), {Thickness = 0}):Play()
LogoText:Destroy() InjectStatus:Destroy() AuthorText:Destroy() BarBg:Destroy()
task.wait(0.3)
Loader:Destroy()

local MainMenu = Instance.new("Frame")
MainMenu.Size = UDim2.new(0, 460, 0, 310)
MainMenu.Position = UDim2.new(0.5, -230, 0.5, -155)
MainMenu.BackgroundColor3 = Color3.fromRGB(8, 11, 18)
MainMenu.BorderSizePixel = 0
MainMenu.Visible = true
MainMenu.Parent = NeverPuzoUI

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainMenu

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(18, 26, 40)
MainStroke.Thickness = 1
MainStroke.Parent = MainMenu

local dragging, dragInput, dragStart, startPos
MainMenu.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true dragStart = input.Position startPos = MainMenu.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
MainMenu.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseBehavior then dragInput = input end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainMenu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(11, 15, 24)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainMenu

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 6)
SideCorner.Parent = Sidebar

local SideFix = Instance.new("Frame")
SideFix.Size = UDim2.new(0, 10, 1, 0)
SideFix.Position = UDim2.new(1, -10, 0, 0)
SideFix.BackgroundColor3 = Color3.fromRGB(11, 15, 24)
SideFix.BorderSizePixel = 0
SideFix.Parent = Sidebar

local MenuTitle = Instance.new("TextLabel")
MenuTitle.Size = UDim2.new(1, 0, 0, 40)
MenuTitle.Position = UDim2.new(0, 12, 0, 10)
MenuTitle.BackgroundTransparency = 1
MenuTitle.TextSize = 18
MenuTitle.Font = Enum.Font.GothamBold
MenuTitle.RichText = true
MenuTitle.TextXAlignment = Enum.TextXAlignment.Left
MenuTitle.Text = '<font color="rgb(0, 162, 255)">Never</font>Puzo'
MenuTitle.Parent = Sidebar

local Pages = Instance.new("Frame")
Pages.Size = UDim2.new(1, -130, 1, -20)
Pages.Position = UDim2.new(0, 125, 0, 10)
Pages.BackgroundTransparency = 1
Pages.Parent = MainMenu

local WorldPage = Instance.new("Frame")
WorldPage.Size = UDim2.new(1, 0, 1, 0)
WorldPage.BackgroundTransparency = 1
WorldPage.Visible = true
WorldPage.Parent = Pages

local DetectorPage = Instance.new("Frame")
DetectorPage.Size = UDim2.new(1, 0, 1, 0)
DetectorPage.BackgroundTransparency = 1
DetectorPage.Visible = false
DetectorPage.Parent = Pages

local TabsList = Instance.new("Frame")
TabsList.Size = UDim2.new(1, 0, 1, -60)
TabsList.Position = UDim2.new(0, 0, 0, 50)
TabsList.BackgroundTransparency = 1
TabsList.Parent = Sidebar

local TabsLayout = Instance.new("UIListLayout")
TabsLayout.Padding = UDim.new(0, 4)
TabsLayout.Parent = TabsList

local function CreateTabBtn(name, pageToShow)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 30)
    Btn.Position = UDim2.new(0, 5, 0, 0)
    Btn.BackgroundTransparency = 1
    Btn.TextColor3 = pageToShow.Visible and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 130, 150)
    Btn.TextSize = 13
    Btn.Font = Enum.Font.GothamBold
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Text = "  " .. name
    Btn.Parent = TabsList

    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages:GetChildren()) do p.Visible = false end
        for _, b in pairs(TabsList:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(120, 130, 150) end end
        pageToShow.Visible = true
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
end

CreateTabBtn("World", WorldPage)
CreateTabBtn("Detector", DetectorPage)

local function ApplyPageLayout(page)
    local L = Instance.new("UIListLayout")
    L.Padding = UDim.new(0, 8)
    L.Parent = page
end
ApplyPageLayout(WorldPage)
ApplyPageLayout(DetectorPage)

local function CreateToggle(parent, text, configKey, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 35)
    Frame.BackgroundColor3 = Color3.fromRGB(12, 17, 28)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(220, 225, 235)
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Text = text
    Label.Parent = Frame

    local Box = Instance.new("TextButton")
    Box.Size = UDim2.new(0, 35, 0, 18)
    Box.Position = UDim2.new(1, -45, 0.5, -9)
    Box.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 130, 255) or Color3.fromRGB(30, 38, 55)
    Box.BorderSizePixel = 0
    Box.Text = ""
    Box.Parent = Frame

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 9)
    BoxCorner.Parent = Box

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 12, 0, 12)
    Dot.Position = Config[configKey] and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dot.BorderSizePixel = 0
    Dot.Parent = Box
    Instance.new("UICorner", Dot).CornerRadius = UDim.new(0, 6)

    Box.MouseButton1Click:Connect(function()
        Config[configKey] = not Config[configKey]
        TweenService:Create(Box, TweenInfo.new(0.2), {BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 130, 255) or Color3.fromRGB(30, 38, 55)}):Play()
        TweenService:Create(Dot, TweenInfo.new(0.2), {Position = Config[configKey] and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)}):Play()
        if callback then callback(Config[configKey]) end
    end)
end

CreateToggle(WorldPage, "Nightmode (Темная ночь)", "Nightmode", function(val)
    if val then
        if Config.Fullbright then Config.Fullbright = false end
        Lighting.ClockTime = 0
        Lighting.Brightness = 0.4
        Lighting.OutdoorAmbient = Color3.fromRGB(15, 15, 35)
    else
        Lighting.ClockTime = OrigClockTime
        Lighting.Brightness = OrigBrightness
        Lighting.OutdoorAmbient = OrigOutdoorAmbient
    end
end)

CreateToggle(WorldPage, "Fullbright (Без теней)", "Fullbright", function(val)
    if val then
        if Config.Nightmode then Config.Nightmode = false end
        Lighting.ClockTime = 14
        Lighting.Brightness = 2
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.ClockTime = OrigClockTime
        Lighting.Brightness = OrigBrightness
        Lighting.OutdoorAmbient = OrigOutdoorAmbient
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Config.Nightmode then
            Lighting.ClockTime = 0
            Lighting.Brightness = 0.4
            Lighting.OutdoorAmbient = Color3.fromRGB(15, 15, 35)
        elseif Config.Fullbright then
            Lighting.ClockTime = 14
            Lighting.Brightness = 2
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        end
    end
end)

CreateToggle(DetectorPage, "Log: Harmed (Попадания)", "LogHarmed")
CreateToggle(DetectorPage, "Log: Missed due to spread (Промахи)", "LogSpread")
CreateToggle(DetectorPage, "Log: Missed due to death (Смерть)", "LogDeath")
CreateToggle(DetectorPage, "SCI Victory Music (Музыка победы)", "SCIMusic")

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and (input.KeyCode == Enum.KeyCode.Insert or input.KeyCode == Enum.KeyCode.RightShift) then
        MainMenu.Visible = not MainMenu.Visible
    end
end)

local function PlaySCI()
    if not Config.SCIMusic then return end
    local success, asset = pcall(function()
        if type(getsynasset) == "function" then return getsynasset(musicFileName) end
        return getcustomasset(musicFileName)
    end)

    if success and asset then
        local sound = Instance.new("Sound")
        sound.Parent = SoundService
        sound.SoundId = asset
        sound.Volume = 2
        sound:Play()
        LogMessage("NeverPuzo", "Победа! Включаю umad_sci.mp3")
        sound.Ended:Connect(function() sound:Destroy() end)
    end
end

task.spawn(function()
    while task.wait(0.5) do
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if playerGui then
            local mainGui = playerGui:FindFirstChild("MainGui") or playerGui:FindFirstChild("MainGUI")
            if mainGui then
                local gameUI = mainGui:FindFirstChild("Game")
                if gameUI then
                    local cashOut = gameUI:FindFirstChild("CashOut")
                    if cashOut and cashOut.Visible then
                        if not SoundService:FindFirstChild("SCIMusicFlag") then
                            local flag = Instance.new("BoolValue", SoundService)
                            flag.Name = "SCIMusicFlag"
                            game:GetService("Debris"):AddItem(flag, 12)
                            PlaySCI()
                        end
                    end
                end
            end
        end
    end
end)

local mt = getrawmetatable(game)
local original_namecall = mt.__namecall

if type(original_namecall) == "function" then
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if not checkcaller() and method == "FireServer" and typeof(self) == "Instance" then
            if self.Name == "ShootGun" or self.Name == "Throw" or tostring(args[1]) == "Shoot" then
                
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    if LocalPlayer.Character.Humanoid.Health <= 0 then
                        if Config.LogDeath then
                            LogMessage("NeverPuzo", "Missed due to death")
                        end
                        if original_namecall then return original_namecall(self, ...) end
                        return
                    end
                end
                
                local targetArg = args[2] 
                
                task.spawn(function()
                    task.wait(0.05)
                    if typeof(targetArg) == "Instance" and targetArg.Parent and targetArg.Parent:FindFirstChild("Humanoid") then
                        if Config.LogHarmed then
                            local victimName = targetArg.Parent.Name
                            LogMessage("NeverPuzo", "Harmed " .. victimName .. " in head for 100 hp")
                        end
                    else
                        if Config.LogSpread then
                            LogMessage("NeverPuzo", "Missed due to spread")
                        end
                    end
                end)
            end
        end
        
        if original_namecall then return original_namecall(self, ...) end
    end)
    setreadonly(mt, true)
end

LogMessage("NeverPuzo", "script loaded! author this shii: relosterpc")
