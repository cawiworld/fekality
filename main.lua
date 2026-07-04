local musicFileName = "umad_sci.mp3"
local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local function LogMessage(title, text, color)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3,
    })
end

local function PlaySCI()
    local success, asset = pcall(function()
        return getcustomasset(musicFileName)
    end)

    if success and asset then
        local sound = Instance.new("Sound")
        sound.Parent = workspace
        sound.SoundId = asset
        sound.Volume = 2
        sound:Play()
        LogMessage("СЦИ", "Победа! Включаю umad_sci.mp3")
        
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    else
        LogMessage("error", "file " .. musicFileName .. " dont finded!)
    end
end

task.spawn(function()
    while task.wait(1) do
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if playerGui and playerGui:FindFirstChild("MainGUI") then
            local gameUI = playerGui.MainGUI:FindFirstChild("Game")
            if gameUI and gameUI:FindFirstChild("CashOut") and gameUI.CashOut.Visible then
                if not workspace:FindFirstChild("SCIMusicFlag") then
                    local flag = Instance.new("BoolValue", workspace)
                    flag.Name = "SCIMusicFlag"
                    game:GetService("Debris"):AddItem(flag, 15)
                    PlaySCI()
                end
            end
        end
    end
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "FireServer" and tostring(self.Name) == "ShootGun" or tostring(self.Name) == "Throw" or tostring(args[1]) == "Shoot" then
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            if LocalPlayer.Character.Humanoid.Health <= 0 then
                LogMessage("fekality crack", "Missed due to death")
                return oldNamecall(self, ...)
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
    
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

LogMessage("fekality crack", "script loaded! author this shit: relosterpc")
