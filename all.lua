local player = game.Players.LocalPlayer
local gui = script.Parent

local mainFrame = gui:WaitForChild("MainFrame")
local keyFrame = gui:WaitForChild("KeyFrame")

local keyInput = keyFrame:WaitForChild("KeyInput")
local keyBtn = keyFrame:WaitForChild("KeyBtn")

local REAL_KEY = "baokun2829"

mainFrame.Visible = false
keyFrame.Visible = true

keyBtn.MouseButton1Click:Connect(function()
	if keyInput.Text == REAL_KEY then
		keyFrame.Visible = false
		mainFrame.Visible = true
	else
		keyInput.Text = "SAI KEY!"
	end
end)

local frame = mainFrame

local flyInput = frame:WaitForChild("FlyInput")
local flyOnBtn = frame:WaitForChild("FlyOnBtn")
local flyOffBtn = frame:WaitForChild("FlyOffBtn")

local speedInput = frame:WaitForChild("SpeedInput")
local speedBtn = frame:WaitForChild("SpeedBtn")

local jumpInput = frame:WaitForChild("JumpInput")
local jumpBtn = frame:WaitForChild("JumpBtn")

local resetBtn = frame:WaitForChild("ResetBtn")
local statusLabel = frame:WaitForChild("StatusLabel")

local defaultSpeed = 16
local defaultJump = 50

local currentFly = 0
local currentSpeed = defaultSpeed
local currentJump = defaultJump

local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end

local function updateStatus()
	statusLabel.Text =
		"✈️ BAY: "..currentFly..
		"\n⚡ CHẠY: "..currentSpeed..
		"\n🦘 NHẢY: "..currentJump
end

updateStatus()

flyOnBtn.MouseButton1Click:Connect(function()
	local value = tonumber(flyInput.Text)
	if not value then return end

	local char = getChar()
	local hrp = char:WaitForChild("HumanoidRootPart")

	if hrp:FindFirstChild("FlyForce") then
		hrp.FlyForce:Destroy()
	end

	local bv = Instance.new("BodyVelocity")
	bv.Name = "FlyForce"
	bv.MaxForce = Vector3.new(0, math.huge, 0)
	bv.Velocity = Vector3.new(0, value, 0)
	bv.Parent = hrp

	currentFly = value
	updateStatus()
end)

flyOffBtn.MouseButton1Click:Connect(function()
	local char = getChar()
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if hrp and hrp:FindFirstChild("FlyForce") then
		hrp.FlyForce:Destroy()
	end
	currentFly = 0
	updateStatus()
end)

speedBtn.MouseButton1Click:Connect(function()
	local value = tonumber(speedInput.Text)
	if not value then return end

	local humanoid = getChar():WaitForChild("Humanoid")
	humanoid.WalkSpeed = value

	currentSpeed = value
	updateStatus()
end)

jumpBtn.MouseButton1Click:Connect(function()
	local value = tonumber(jumpInput.Text)
	if not value then return end

	local humanoid = getChar():WaitForChild("Humanoid")
	humanoid.JumpPower = value

	currentJump = value
	updateStatus()
end)

resetBtn.MouseButton1Click:Connect(function()
	local char = getChar()
	local humanoid = char:WaitForChild("Humanoid")
	local hrp = char:WaitForChild("HumanoidRootPart")

	if hrp:FindFirstChild("FlyForce") then
		hrp.FlyForce:Destroy()
	end

	humanoid.WalkSpeed = defaultSpeed
	humanoid.JumpPower = defaultJump

	currentFly = 0
	currentSpeed = defaultSpeed
	currentJump = defaultJump

	updateStatus()
end)