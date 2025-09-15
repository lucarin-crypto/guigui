-- Nama File: GUI.lua
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoFisherGUI"
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 400)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderColor3 = Color3.new(0, 0, 0)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 30)
Header.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Text = "Auto Fisher"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSans
Title.TextSize = 20
Title.BackgroundTransparency = 1
Title.Parent = Header

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
MinimizeButton.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.BackgroundColor3 = Color3.new(1, 0, 0)
CloseButton.Parent = Header

local FeaturesFrame = Instance.new("Frame")
FeaturesFrame.Size = UDim2.new(1, -20, 1, -40)
FeaturesFrame.Position = UDim2.new(0, 10, 0, 35)
FeaturesFrame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
FeaturesFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Parent = FeaturesFrame

local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame:TweenSize(UDim2.new(0, 100, 0, 30), "Out", "Sine", 0.3)
        MainFrame:TweenPosition(UDim2.new(1, -100, 0, 0), "Out", "Sine", 0.3)
    else
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 400), "Out", "Sine", 0.3)
        MainFrame:TweenPosition(UDim2.new(0.5, -125, 0.5, -200), "Out", "Sine", 0.3)
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)