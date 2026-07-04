local musicFileName = "umad_sci.mp3"
local musicUrl = "https://raw.githubusercontent.com/cawiworld/fekality/refs/heads/main/umad_sci.mp3"

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")

local HttpParent = CoreGui:FindFirstChild("RobloxGui") or CoreGui
local NotificationGui = HttpParent:FindFirstChild("FekalityNotifications")

if not NotificationGui then
    NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "FekalityNotifications"
    NotificationGui.ResetOnSpawn = false
    local successUI = pcall(function() NotificationGui.Parent = HttpParent end)
    if not successUI then
        NotificationGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
end

local Container = NotificationGui:FindFirstChild("Container")
if not Container then
    Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Size = UDim2.new(0, 300, 1, -20)
    Container.Position = UDim2.new(1, -320, 0, 10)
    Container.BackgroundTransparency = 1
    Container.Parent = NotificationGui
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.Parent = Container
end

local function LogMessage(title, text)
    task.spawn(function()
        local NotificationFrame = Instance.new("Frame")
        NotificationFrame.Size = UDim2.new(1, 0, 0, 55)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.BackgroundTransparency = 1
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = NotificationFrame
        
        local Accent = Instance.new("Frame")
        Accent.Size = UDim2.new(0, 4, 1, 0)
        Accent.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        Accent.BorderSizePixel = 0
        Accent.BackgroundTransparency = 1
        Accent.Parent = NotificationFrame
        
        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Size = UDim2.new(1, -20, 0, 22)
        TitleLabel.Position = UDim2.new(0, 14, 0, 4)
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TitleLabel.TextSize = 13
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.Text = title
        TitleLabel.TextTransparency = 1
        TitleLabel.Parent = NotificationFrame

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -20, 0, 22)
        TextLabel.Position = UDim2.new(0, 14, 0, 24)
        TextLabel.BackgroundTransparency = 1
        TextLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
        TextLabel.TextSize = 12
        TextLabel.Font = Enum.Font.Gotham
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.Text = text
        TextLabel.TextTransparency = 1
        TextLabel.Parent = NotificationFrame

        NotificationFrame.LayoutOrder = #Container:GetChildren() + 1
        NotificationFrame.Parent = Container

        NotificationFrame.Position = UDim2.new(1, 300, 0, 0)
        TweenService:Create(NotificationFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15}):Play()
        TweenService:Create(Accent, TweenInfo.new(0.25), {BackgroundTransparency = 0}):Play()
        TweenService:Create(TitleLabel, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
        TweenService:Create(TextLabel, TweenInfo.new(0.25), {TextTransparency = 0}):Play()
        
        task.wait(3)

        TweenService:Create(NotificationFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Accent, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
        TweenService:Create(TitleLabel, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        TweenService:Create(TextLabel, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        
        task.wait(0.25)
        NotificationFrame:Destroy()
    end)
end

if type(isfile) == "function" and not isfile(musicFileName) then
    LogMessage("fekality crack", "downloading umad_sci.mp3...")
    local success, fileData = pcall(function()
        return game:HttpGet(musicUrl)
    end)
    
    if success and fileData and not fileData:find("404: Not Found") then
        if type(writefile) == "function" then
            writefile(musicFileName, fileData)
            LogMessage("fekality crack", "music downloaded!")
        end
    else
        LogMessage("error", "failed to download music!")
    end
end

local function PlaySCI()
    local success, asset = pcall(function()
        if type(getsynasset) == "function" then return getsynasset(musicFileName) end
        if type(getcustomasset) == "function" then return getcustomasset(musicFileName) end
        return nil
    end)

    if success and asset then
        local sound = Instance.new("Sound")
        sound.Parent = SoundService
        sound.SoundId = asset
        sound.Volume = 2
        sound:Play()
        LogMessage("fekality crack", "Победа! Включаю umad_sci.mp3")
        
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    else
        LogMessage("error", "executor failed to load custom mp3!")
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

local oldNamecall

local function hookLogic(self, ...)
    local args = {...}
    local method = ""
    
    if type(getnamecallmethod) == "function" then
        method = getnamecallmethod()
    else
        method = "FireServer"
    end

    if method == "FireServer" and typeof(self) == "Instance" then
        if self.Name == "ShootGun" or self.Name == "Throw" or tostring(args[1]) == "Shoot" then
            
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                if LocalPlayer.Character.Humanoid.Health <= 0 then
                    LogMessage("fekality crack", "Missed due to death")
                    if type(oldNamecall) == "function" then return oldNamecall(self, ...) end
                    return
                end
            end
            
            local targetArg = args[2] 
            task.spawn(function()
                task.wait(0.05)
                if typeof(targetArg) == "Instance" and targetArg.Parent and targetArg.Parent:FindFirstChild("Humanoid") then
                    local victimName = targetArg.Parent.Name
                    LogMessage("fekality crack", "Harmed " .. victimName .. " in head for 100 hp")
                else
                    LogMessage("fekality crack", "Missed due to spread")
                end
            end)
        end
    end
    
    if type(oldNamecall) == "function" then 
        return oldNamecall(self, ...) 
    end
end

local hookSuccess, hookError = pcall(function()
    if type(hookmetamethod) == "function" then
        oldNamecall = hookmetamethod(game, "__namecall", hookLogic)
    else
        local mt = getrawmetatable(game)
        oldNamecall = mt.__namecall
        if type(setreadonly) == "function" then setreadonly(mt, false) end
        
        if type(newcclosure) == "function" then
            mt.__namecall = newcclosure(hookLogic)
        else
            mt.__namecall = hookLogic
        end
        
        if type(setreadonly) == "function" then setreadonly(mt, true) end
    end
end)

if not hookSuccess then
    LogMessage("Hook Error", "script has lived")
end

LogMessage("fekality crack", "script loaded! author this shii: relosterpc")
