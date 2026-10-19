local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local running = false

local function farm()
	while running do
		local candies = {}
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and v.Name == "Candy" then
				table.insert(candies, v)
			end
		end

		if #candies > 0 then
			for _, candy in ipairs(candies) do
				if not running then break end
				if candy and candy.Parent then
					hrp.CFrame = candy.CFrame + Vector3.new(0, 3, 0)
					task.wait(0.12)
				end
			end
		else
			task.wait(0.4)
		end
		task.wait()
	end
end

local function start()
	if running then return end
	running = true
	character = player.Character or player.CharacterAdded:Wait()
	hrp = character:WaitForChild("HumanoidRootPart")
	task.spawn(farm)
end

local function stop()
	running = false
end

local gui = Instance.new("ScreenGui")
gui.Name = "CandyFarm"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 140, 0, 70)
frame.Position = UDim2.new(0, 15, 0.5, -35)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.85, 0, 0, 38)
btn.Position = UDim2.new(0.075, 0, 0.5, -19)
btn.BackgroundColor3 = Color3.fromRGB(0, 160, 70)
btn.Text = "START"
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 15
btn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 5)
btnCorner.Parent = btn

btn.MouseButton1Click:Connect(function()
	if running then
		stop()
		btn.Text = "iniciar"
		btn.BackgroundColor3 = Color3.fromRGB(0, 160, 70)
	else
		start()
		btn.Text = "parar"
		btn.BackgroundColor3 = Color3.fromRGB(190, 40, 40)
	end
end)

player.CharacterAdded:Connect(function(char)
	character = charplay
	hrp = char:WaitForChild("HumanoidRootPart")
	if running then
		task.wait(0.8)
		task.spawn(farm)
	end
end)
