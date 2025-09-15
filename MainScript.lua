-- Nama File: MainScript.lua
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local autoFishingEnabled = false
local autoPerfectEnabled = false
local fastFishingEnabled = false
local autoTeleportEnabled = false
local autoSellEnabled = false
local autoBuyEnabled = false
local antiAFKEnabled = true

local function toggleScript(buttonName, enabled)
    if buttonName == "Auto Fishing" then autoFishingEnabled = enabled end
    if buttonName == "Auto Perfect" then autoPerfectEnabled = enabled end
    if buttonName == "Fast Fishing" then fastFishingEnabled = enabled end
    if buttonName == "Auto Teleport" then autoTeleportEnabled = enabled end
    if buttonName == "Auto Sell" then autoSellEnabled = enabled end
    if buttonName == "Auto Buy" then autoBuyEnabled = enabled end
    if buttonName == "Anti AFK" then antiAFKEnabled = enabled end
end

local function createToggleButton(name)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, 0, 0, 30)
    button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.Parent = PlayerGui.AutoFisherGUI.MainFrame.FeaturesFrame
    button.MouseButton1Click:Connect(function()
        local currentState = button.Text:match(": (%a+)") == "ON"
        toggleScript(name, not currentState)
        button.Text = name .. ": " .. (not currentState and "ON" or "OFF")
    end)
    button.Text = name .. ": OFF"
    if name == "Anti AFK" then
        button.Text = name .. ": ON"
        toggleScript(name, true)
    end
end

createToggleButton("Auto Fishing")
createToggleButton("Auto Perfect")
createToggleButton("Fast Fishing")
createToggleButton("Auto Teleport")
createToggleButton("Auto Sell")
createToggleButton("Auto Buy")
createToggleButton("Anti AFK")

-- PENTING! Ganti nama Remote Events dan koordinat
local remoteEvents = {
    cast = ReplicatedStorage:WaitForChild("YourCastRemoteEvent"),
    reel = ReplicatedStorage:WaitForChild("YourReelRemoteEvent"),
    sell = ReplicatedStorage:WaitForChild("YourSellRemoteEvent"),
    buy = ReplicatedStorage:WaitForChild("YourBuyRemoteEvent")
}

local locations = {
    fishingSpot = Vector3.new(100, 50, 200),
    eventSpot = Vector3.new(50, 50, -300)
}

local function handleFishing()
    if not autoFishingEnabled then return end
    -- Logika untuk memancing
end

local function handleTeleport()
    if not autoTeleportEnabled then return end
    local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:WaitForChild("HumanoidRootPart", 0.1)
    if not humanoidRootPart then return end
    humanoidRootPart.CFrame = CFrame.new(locations.fishingSpot)
end

local function handleTransactions()
    if autoSellEnabled then
        for _, item in ipairs(LocalPlayer.Backpack:GetChildren()) do
            if item.Name ~= "SecretFish" then
                remoteEvents.sell:FireServer(item.Name)
                task.wait(0.1)
            end
        end
    end
    if autoBuyEnabled then
        remoteEvents.buy:FireServer("RodName")
        remoteEvents.buy:FireServer("BobberName")
        remoteEvents.buy:FireServer("WeatherName")
    end
end

local function handleAntiAFK()
    if not antiAFKEnabled then return end
    local camera = Workspace.CurrentCamera
    camera.CFrame = camera.CFrame * CFrame.Angles(0, math.rad(0.5), 0)
end

RunService.Stepped:Connect(function()
    handleFishing()
    handleTeleport()
    handleAntiAFK()
end)

task.spawn(function()
    while task.wait(300) do
        handleTransactions()
    end
end)