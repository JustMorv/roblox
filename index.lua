-- создаём папку для плиток
local folder = workspace:FindFirstChild("Tiles") or Instance.new("Folder", workspace)

folder.Name = "Tiles"

-- два типа плиток: прыгучая и быстрая
local effects = {

	-- Прыжок выше
	{
		name = "High Jump",                  -- название эффекта
		color = BrickColor.new("Bright red"), -- цвет плитки
		func = function(h)                   -- что делает
			h.UseJumpPower = true
			h.JumpPower = 100
		end
	},

	-- Бег быстрее
	{
		name = "Speed Boost",                 -- название эффекта
		color = BrickColor.new("Bright green"), -- цвет плитки
		func = function(h)                    -- что делает
			h.WalkSpeed = 30
		end
	}

}
-- показываем над плиткой название эффекта
local function showLabel(part, text)
	local gui = Instance.new("BillboardGui")
	gui.Size = UDim2.new(0,150,0,50)
	gui.StudsOffset = Vector3.new(0,3,0)
	gui.Adornee = part
	gui.AlwaysOnTop = true
	gui.Parent = workspace

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255,255,0)
	label.TextScaled = true
	label.Font = Enum.Font.SourceSansBold
	label.Parent = gui

	for i = 1, 50 do
		gui.StudsOffset = gui.StudsOffset + Vector3.new(0,0.1,0)
		task.wait(0.03)
	end
	task.wait(2)
	gui:Destroy()
end


-- создаём плитку
local function spawnTile()
	local tile = Instance.new("Part")
	tile.Size = Vector3.new(4,1,4)
	tile.Position = Vector3.new(math.random(-20,20),1,math.random(-20,20))
	tile.Anchored = true
	local e = effects[math.random(1,#effects)]
	tile.BrickColor = e.color
	tile.Parent = folder

	tile.Touched:Connect(function(hit)
		local h = hit.Parent:FindFirstChild("Humanoid")
		if h then
			e.func(h)           -- даём эффект
			showLabel(tile, e.name) -- показываем надпись
			tile:Destroy()
			-- через 5 секунд возвращаем всё к норме
			task.spawn(function()
				task.wait(5)
				h.JumpPower = 50
				h.WalkSpeed = 16
				h.UseJumpPower = true
			end)
		end
	end)
	-- если плитку никто не коснулся, удаляем через 10 секунд
	task.spawn(function()
		task.wait(10)
		if tile.Parent then
			tile:Destroy()
		end
	end)
end
-- создаём новые плитки каждые 2 секунды
while true do
	spawnTile()
	task.wait(2)
end
