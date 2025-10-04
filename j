---@diagnostic disable: undefined-global
-- // Variables
repeat
	task.wait()
until game:IsLoaded()
-- Game
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEvents = ReplicatedStorage.GameEvents
local Sunflower = "Sunflower 🌻 Hub"

-- Player
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local playerId = LocalPlayer.UserId
local checkWhitelistUrl = "https://hub-three-jade.vercel.app/api/check" .. "?playerId=" .. playerId
local Backpack = LocalPlayer:WaitForChild("Backpack")

local LocalFarm = nil
local LocalPlants = nil

for _, farms in ipairs(workspace.Farm:GetDescendants()) do
	if farms:IsA("StringValue") and farms.Name == "Owner" and farms.Value == LocalPlayer.Name then
		LocalFarm = farms.Parent.Parent
		LocalPlants = LocalFarm:FindFirstChild("Plants_Physical")
	end
end

getgenv().AutoBuyMain = false
getgenv().AutoHarvest = false
getgenv().AutoPlant = false

getgenv().AutoEvent = false
getgenv().AutoBuyEvent = false

getgenv().AutoBattlepass = false

-- // Tables/Arrays

-- Script
local SunflowerNames = { Sunflower, "Roiz Button", "Sunflower FPS Ping", "Sunflower Executor" }

-- // Functions

-- Anti Idle
LocalPlayer.Idled:connect(function()
	VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	wait(1)
	VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

-- Remove Duplicated
local function removeGui(name)
	local script = CoreGui:FindFirstChild(name)
	if script then
		pcall(function()
			script:Destroy()
		end)
	end
end
for _, name in ipairs(SunflowerNames) do
	removeGui(name)
end

local function SellInventory()
	for i = 1, 100 do
		Character.HumanoidRootPart.CFrame = CFrame.new(87, 3, 0)
		task.wait(0.01)
		ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
	end
end

local function Water(plant)
	for _, t in ipairs(Backpack:GetChildren()) do
		if t:IsA("Tool") and t.Name:match("^Watering Can") then
			Character.Humanoid:EquipTool(t)
		end
	end

	local args = {
		vector.create(plant.CFrame.X, plant.CFrame.Y, plant.CFrame.Z),
	}
	game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Water_RE"):FireServer(unpack(args))
end

local seeds = {
	"Strawberry",
	"Watermelon",
	"Pumpkin",
	"Blueberry",
	"Orange Tulip",
	"Cactus",
	"Bamboo",
	"Daffodil",
	"Tomato",
	"Apple",
	"Coconut",
	"Dragon Fruit",
	"Mango",
	"Grape",
	"Mushroom",
	"Pepper",
	"Cacao",
	"Beanstalk",
	"Ember Lily",
	"Sugar Apple",
	"Burning Bud",
	"Romanesco",
	"Elder Strawberry",
	"Giant Pinecone",
	"Carrot",
	"Corn",
	"Crimson Thorn",
}

local gears = {
	"Watering Can",
	"Trading Ticket",
	"Trowel",
	"Recall Wrench",
	"Basic Sprinkler",
	"Advanced Sprinkler",
	"Medium Toy",
	"Medium Treat",
	"Godly Sprinkler",
	"Magnifying Glass",
	"Master Sprinkler",
	"Cleaning Spray",
	"Cleansing Pet Shard",
	"Favorite Tool",
	"Harvest Tool",
	"Grandmaster Sprinkler",
	"Levelup Lollipop",
}

local eggs = { "Common Egg", "Uncommon Egg", "Rare Egg", "Legendary Egg", "Mythical Egg", "Bug Egg", "Jungle Egg" }

local Plants =
	loadstring(game:HttpGet("https://raw.githubusercontent.com/roizultra/Sunflower-sub/refs/heads/main/Plants.lua"))()

local function checkWhitelist()
	local response = game:HttpGet(checkWhitelistUrl)
	local data = HttpService:JSONDecode(response)

	if data.whitelisted then
		local library = loadstring(game:HttpGet("https://pastebin.com/raw/bCvsCwmL"))()
		local SunflowerGui = library.new(Sunflower, 16746423793)

		task.spawn(function()
			loadstring(game:HttpGet("https://pastebin.com/raw/5fSEPyqz"))()
		end)

		-- Hide Main
		task.spawn(function()
			CoreGui[Sunflower].Main.Visible = true
		end)

		pcall(function()
			SunflowerGui:Notify(
				"Welcome to Sunflower Hub, " .. LocalPlayer.DisplayName,
				"Press V or floating icon to toggle the UI."
			)
			CoreGui[Sunflower].Notification.Decline:Destroy()
		end)

		local uiFrame = LocalPlayer.PlayerGui.Teleport_UI.Frame

		if not uiFrame:FindFirstChild("Ascension") then
			local ascensionFrame = uiFrame.Garden:Clone()
			ascensionFrame.Txt.Text = "ASCENSION"
			ascensionFrame.Name = "Ascension"
			ascensionFrame.ImageColor3 = Color3.fromRGB(65, 255, 26)
			ascensionFrame.Parent = uiFrame

			ascensionFrame.MouseButton1Click:Connect(function()
				Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(
					126.048538,
					3,
					166.924728,
					-0.71104151,
					-5.8365444e-08,
					-0.703150034,
					-1.72767844e-08,
					1,
					-6.55349979e-08,
					0.703150034,
					-3.44499291e-08,
					-0.71104151
				)
			end)
		end

		LocalPlayer.PlayerGui.Teleport_UI.Frame.Gear.Visible = true
		LocalPlayer.PlayerGui.Teleport_UI.Frame.Pets.Visible = true

		-- Local
		local page = SunflowerGui:addPage("Inventory", 11330204834)

		local section1 = page:addSection("Shop")

		section1:addButton("Sell Inventory", function()
			task.spawn(function()
				SunflowerGui:Notify("Selling...", "Are you sure you want to sell your inventory?", function(accepted)
					if accepted then
						SellInventory()
						SunflowerGui:Notify("Selling...", "Inventory sold!")
						CoreGui[Sunflower].Notification.Decline.Visible = false
						CoreGui[Sunflower].Notification.Accept:Destroy()
						task.wait(1)
						if CoreGui[Sunflower].Notification.Text.Text == "Inventory sold!" then
							for _, Value in
								next,
								getconnections(CoreGui[Sunflower].Notification.Decline.MouseButton1Click)
							do
								Value:Fire()
							end
						end
					end
				end)
			end)
		end)

		section1:addToggle("Buy Seeds/Gears", nil, function(value)
			if value then
				local accumulatedTime = 0
				RunService:BindToRenderStep("BuyAllMain", Enum.RenderPriority.Last.Value, function(deltaTime)
					accumulatedTime += deltaTime
					if accumulatedTime < 0.1 then
						return
					end
					accumulatedTime = 0

					for _, seed in ipairs(seeds) do
						ReplicatedStorage.GameEvents.BuySeedStock:FireServer("Tier 1", seed)
					end

					for _, gear in ipairs(gears) do
						ReplicatedStorage.GameEvents.BuyGearStock:FireServer(gear)
					end

					for _, egg in ipairs(eggs) do
						ReplicatedStorage.GameEvents.BuyPetEgg:FireServer(egg)
					end
				end)
			else
				RunService:UnbindFromRenderStep("BuyAllMain")
			end
		end)

		-- Misc
		local page = SunflowerGui:addPage("Event", 12778274392)
		local section1 = page:addSection("")

		--[[ local function collectEventFruits()
			for _, farms in ipairs(workspace.Farm:GetDescendants()) do
				if farms:IsA("StringValue") and farms.Name == "Owner" and farms.Value == LocalPlayer.Name then
					local important = farms.Parent.Parent
					local plants = important:FindFirstChild("Plants_Physical")

					if plants then
						local validNames = Plants.Evo
						local foundPlant = false
						local base

						for _, plant in ipairs(plants:GetChildren()) do
							if table.find(validNames, plant.Name) and plant:IsA("Model") then
								foundPlant = true
								base = plant.Base
								break
							end
						end

						local args = {
							"All",
						}
						game:GetService("ReplicatedStorage")
							:WaitForChild("GameEvents")
							:WaitForChild("TieredPlants")
							:WaitForChild("Submit")
							:FireServer(unpack(args))

						if foundPlant then
							if base then
								equipWater(base)
							end

							for _, plant in ipairs(plants:GetChildren()) do
								if table.find(validNames, plant.Name) and plant:IsA("Model") then
									local hasPlant = true

									while hasPlant do
										task.wait(0.01)

										ReplicatedStorage:WaitForChild("GameEvents")
											:WaitForChild("Crops")
											:WaitForChild("Collect")
											:FireServer({ plant })

										for _, plant in ipairs(plants:GetChildren()) do
											if table.find(validNames, plant.Name) and plant:IsA("Model") then
												hasPlant = false
											end
										end
										break
									end
								end
							end
						end
					end
				end
			end
		end ]]

		local function collectFruits(All, Selected)
			local collected = 0
			local limit = 200

			for _, plant in ipairs(LocalPlants:GetChildren()) do
				if collected >= limit then
					break
				end

				local fruitsFolder = plant:FindFirstChild("Fruits")
				if not fruitsFolder then
					continue
				end

				local fruits = fruitsFolder:GetChildren()
				if #fruits == 0 then
					continue
				end

				local toCollect = {}

				if All then
					for _, fruit in ipairs(fruits) do
						if collected >= limit then
							break
						end
						table.insert(toCollect, fruit)
						collected += 1
					end
				elseif Selected and type(Selected) == "table" then
					for _, fruit in ipairs(fruits) do
						if collected >= limit then
							break
						end
						for _, name in ipairs(Selected) do
							if fruit.Name == name then
								table.insert(toCollect, fruit)
								collected += 1
								break
							end
						end
					end
				end

				if #toCollect > 0 then
					game:GetService("ReplicatedStorage")
						:WaitForChild("GameEvents")
						:WaitForChild("Crops")
						:WaitForChild("Collect")
						:FireServer(toCollect)
				end
			end
		end

		local teleportConnection

		section1:addToggle("Auto Event", nil, function(value)
			getgenv().AutoEvent = value

			if getgenv().AutoEvent then
				local originCFrame
				for _, child in ipairs(workspace:GetChildren()) do
					if child.Name == "Acorn" and child:FindFirstChild("Acorn") then
						originCFrame = Character.HumanoidRootPart.CFrame
						local owner = tostring(child:GetAttribute("OWNER"))
						if owner == tostring(LocalPlayer.UserId) then
							Character.HumanoidRootPart.CFrame = child.Acorn.CFrame
							task.wait(0.7)
							Character.HumanoidRootPart.CFrame = originCFrame
						end
					end
				end
				if originCFrame then
					Character.HumanoidRootPart.CFrame = originCFrame
				end

				if not teleportConnection then
					teleportConnection = workspace.ChildAdded:Connect(function(child)
						if child.Name == "Acorn" and child:FindFirstChild("Acorn") then
							originCFrame = Character.HumanoidRootPart.CFrame
							local owner = tostring(child:GetAttribute("OWNER"))
							if owner == tostring(LocalPlayer.UserId) then
								Character.HumanoidRootPart.CFrame = child.Acorn.CFrame
								task.wait(0.7)
								Character.HumanoidRootPart.CFrame = originCFrame
							end
						end
					end)
				end

				task.spawn(function()
					while getgenv().AutoEvent do
						local progress =
							workspace.Interaction.UpdateItems.ChipmunkEvent.NutsPlatform.NuttyFeverProgressBar.ProgressPart.ProgressBilboard.UpgradeBar.ProgressionLabel.Text
						if progress:find("1500") then
							collectFruits(true, false)
							game:GetService("ReplicatedStorage")
								:WaitForChild("GameEvents")
								:WaitForChild("SubmitChipmunkFruit")
								:FireServer("All")
						end
						task.wait(3)
					end
				end)
			else
				if teleportConnection then
					teleportConnection:Disconnect()
					teleportConnection = nil
				end
			end
		end)

		-- Evo Event
		--[[ local planting = false

		section1:addToggle("Auto Evolve", nil, function(value)
			getgenv().AutoEvent = value

			task.spawn(function()
				while getgenv().AutoEvent do
					if not planting and Character then
						collectEventFruits()
					end
					task.wait(2)
					if not getgenv().AutoEvent then
						break
					end
				end
			end)

			if value then
				task.spawn(function()
					while getgenv().AutoEvent do
						task.wait()
						if not getgenv().AutoEvent then
							break
						end
						local seed
						for _, item in ipairs(Backpack:GetChildren()) do
							local n = item.Name:lower()
							if n:find("evo", 1, true) and n:find("seed", 1, true) and not n:find("iv", 1, true) then
								seed = item
								Character.Humanoid:EquipTool(item)
								break
							end
						end

						for _, tool in ipairs(Character:GetChildren()) do
							if tool:IsA("Tool") and tool.Name:match("^Evo%s+%w+") and not tool.Name:find("IV") then
								local cleanName = tool.Name:gsub("%s+Seed.*", "")

								local best
								for _, name in ipairs(Plants.Evo) do
									if cleanName == name then
										best = name
										break
									end
								end

								if best then
									for _, tool in ipairs(Character:GetChildren()) do
										if
											tool:IsA("Tool")
											and tool.Name:match("^Evo%s+%w+")
											and not tool.Name:find("IV")
										then
											local cleanName = tool.Name:gsub("%s*%[X%d+%]", ""):gsub("%s+Seed$", "")

											if not planting then
												planting = true
												while Character:FindFirstChild(tool.Name) and getgenv().AutoEvent do
													Character.Humanoid:EquipTool(tool)
													local args = {
														vector.create(
															55.04576110839844,
															0.13552570343017578,
															-94.04595184326172
														),
														cleanName,
													}
													game:GetService("ReplicatedStorage")
														:WaitForChild("GameEvents")
														:WaitForChild("Plant_RE")
														:FireServer(unpack(args))

													print(cleanName)
													task.wait()
												end
												planting = false
											end
											break
										end
									end
								end
							end
						end
					end
				end)
			end
		end)

		section1:addToggle("Auto Buy All", nil, function(state)
			if state then
				task.spawn(function()
					while state do
						task.wait(0.3) -- main loop delay
						local shopItems = {
							{ "Evo Mushroom I", 5 },
							{ "Evo Beetroot I", 5 },
							{ "Evo Blueberry I", 5 },
							{ "Evo Pumpkin I", 5 },
						}

						local RepStorage = game:GetService("ReplicatedStorage")
						local BuyEvent = RepStorage:WaitForChild("GameEvents"):WaitForChild("BuyEventShopStock")

						for _, item in ipairs(shopItems) do
							BuyEvent:FireServer(unpack(item))
						end
					end
				end)
			end
		end) ]]

		local section2 = page:addSection("Battlepass")

		section2:addToggle("Auto Plant", nil, function(state) end)

		section2:addToggle("Auto Battlepass", nil, function(state) end)

		local page = SunflowerGui:addPage("Npcs", 12778274392)

		local section1 = page:addSection("Ascension")

		section1:addButton("Teleport", function()
			Character.HumanoidRootPart.CFrame = CFrame.new(126, 3, 168)
		end)

		local section1 = page:addSection("Merchant")

		section1:addButton("Teleport", function()
			LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(82, 3, -48)
		end)

		--local args = {
		--      "Tropical Mist Sprinkler"
		-- }
		-- game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyTravelingMerchantShopStock"):FireServer(unpack(args))

		-- Settings
		local page = SunflowerGui:addPage("Settings", 11385265073)

		local placeId = game.PlaceId
		local MarketplaceService = game:GetService("MarketplaceService")

		local productInfo = MarketplaceService:GetProductInfo(placeId)
		local placeName = productInfo.Name

		local section1 = page:addSection("Graphics")

		section1:addButton("Reduce CPU Usage", function()
			task.spawn(function()
				SunflowerGui:Notify("Reduce CPU Usage", "Your game now uses less memory when unfocused")
				CoreGui[Sunflower].Notification.Decline.Visible = false
				CoreGui[Sunflower].Notification.Accept:Destroy()
				task.wait(5)
				if CoreGui[Sunflower].Notification.Text.Text == "Your game now uses less memory when unfocused" then
					for _, Value in next, getconnections(CoreGui[Sunflower].Notification.Decline.MouseButton1Click) do
						Value:Fire()
					end
				end
			end)
			local UserInputService = game:GetService("UserInputService")
			local RunService = game:GetService("RunService")
			local WindowFocusReleasedFunction = function()
				RunService:Set3dRenderingEnabled(false)
				setfpscap(10)
				return
			end
			local WindowFocusedFunction = function()
				RunService:Set3dRenderingEnabled(true)
				setfpscap(120)
				return
			end
			local Initialize = function()
				UserInputService.WindowFocusReleased:Connect(WindowFocusReleasedFunction)
				UserInputService.WindowFocused:Connect(WindowFocusedFunction)
				return
			end
			Initialize()
		end)

		local section2 = page:addSection("Keybinds")

		section2:addKeybind("Toggle GUI", Enum.KeyCode.V, function(value)
			SunflowerGui:toggle()
		end)

		section2:addToggle("Instant Prompts", nil, function(value)
			local InstantPrompt = value
			game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
				if InstantPrompt then
					fireproximityprompt(prompt)
				end
			end)
		end)

		local section4 = page:addSection("GUI")

		section4:addButton("Restart GUI", function()
			SunflowerGui:Notify("Restarting GUI...", "Are you sure you want to restart the GUI?", function(accepted)
				if accepted then
					SunflowerGui:toggle(accepted)
					SunflowerGui:Notify("Restarting GUI...", "GUI is being restarted..")
					CoreGui[Sunflower].Notification.Accept:Destroy()
					CoreGui[Sunflower].Notification.Decline:Destroy()
					loadstring(game:HttpGet("https://raw.githubusercontent.com/roizultra/hub2/refs/heads/main/j"))()
				end
			end)
		end)

		section4:addButton("Destroy GUI", function()
			SunflowerGui:Notify("Destroying GUI...", "Are you sure you want to destroy the GUI?", function(accepted)
				if accepted then
					getgenv().Visible = false
					SunflowerGui:toggle(accepted)
					SunflowerGui:Notify("Destroying GUI...", "GUI is being destroyed..")
					CoreGui[Sunflower].Notification.Accept:Destroy()
					CoreGui[Sunflower].Notification.Decline:Destroy()

					local v = nil
					repeat
						v = CoreGui:FindFirstChild("Sunflower | by Roiz")
						if v then
							v:Destroy()
						end
					until not v
				end
			end)
		end)

		local page = SunflowerGui:addPage("Information", 4871684504)

		local section1 = page:addSection("Script entirely made by @roiz")
		section1:addButton("Copy Discord Server Link", function()
			setclipboard("discord.gg/Sunflower")
			pcall(function()
				SunflowerGui:Notify("Done!", "Link copied to the clipboard.")
				CoreGui[Sunflower].Notification.Decline:Destroy()
			end)
		end)

		local scrg = Instance.new("ScreenGui")
		scrg.Parent = game.CoreGui
		scrg.Name = "Roiz Button"

		local frameButton = Instance.new("Frame")
		frameButton.Parent = scrg
		frameButton.Name = "FrameButton"
		frameButton.Size = UDim2.new(0, 200, 0, 200)
		frameButton.BackgroundTransparency = 1

		local floatingButton = Instance.new("TextButton")
		floatingButton.Name = "RoizHub"
		floatingButton.Parent = frameButton
		floatingButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
		floatingButton.BackgroundTransparency = 0.5
		floatingButton.Position = UDim2.new(0, 232, 0, 245)
		floatingButton.Size = UDim2.new(0, 65, 0, 65)
		floatingButton.Font = Enum.Font.SourceSansBold
		floatingButton.Text = ""
		floatingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		floatingButton.TextSize = 20
		floatingButton.TextWrapped = true
		floatingButton.Draggable = true

		local UICorner = Instance.new("UICorner")
		UICorner.Name = "RoizHubCorner"
		UICorner.CornerRadius = UDim.new(0.5, 0)
		UICorner.Parent = floatingButton

		local buttonImage = Instance.new("ImageLabel")
		buttonImage.Name = "RoizHubImage"
		buttonImage.Parent = floatingButton
		buttonImage.Image = "rbxassetid://101629260943435"
		buttonImage.Size = UDim2.new(1.5, 0, 1.5, 0)
		buttonImage.Position = UDim2.new(-0.25, 0, -0.25, 0)
		floatingButton.Position = UDim2.new(0, -0.5, 0, 0)
		buttonImage.BackgroundTransparency = 1

		local UICorner2 = Instance.new("UICorner")
		UICorner2.Name = "RoizHubCorner2"
		UICorner2.CornerRadius = UDim.new(0.5, 0)
		UICorner2.Parent = buttonImage

		local isOpened = true

		local TweenService = game:GetService("TweenService")

		local newSize = UDim2.new(0, 511, 0, 300)
		local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)

		local tween = TweenService:Create(CoreGui[Sunflower].Main, tweenInfo, { Size = newSize })

		floatingButton.MouseButton1Click:Connect(function()
			if not isOpened then
				isOpened = true
				SunflowerGui:toggle()
				tween:Play()
			else
				SunflowerGui:toggle()
				isOpened = false
			end

			task.wait(0.6)
		end)

		spawn(function()
			-- Glow Tween
			local Gui = CoreGui[Sunflower].Main.Glow

			local startColor = Color3.new(255, 255, 0)
			local endColor = Color3.new(0, 0, 0)

			local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, true)

			local tween1 = TweenService:Create(Gui, tweenInfo, { ImageColor3 = endColor })
			local tween2 = TweenService:Create(Gui, tweenInfo, { ImageColor3 = startColor })

			tween1:Play()

			tween1.Completed:Connect(function()
				tween2:Play()
				tween1:Pause()
			end)

			tween2.Completed:Connect(function()
				tween1:Play()
				tween2:Pause()
			end)
		end)

		SunflowerGui:SelectPage(SunflowerGui.pages[1], true)
	else
		local Sunflower = "Sunflower 🌻 Hub"

		repeat
			task.wait()
		until game:IsLoaded()

		-- Remove Duplicated
		local SunflowerNames = { Sunflower, "Roiz Button", "Sunflower FPS Ping", "Sunflower Executor" }

		local function removeGui(name)
			local script = CoreGui:FindFirstChild(name)
			if script then
				pcall(function()
					script:Destroy()
				end)
			end
		end
		for _, name in ipairs(SunflowerNames) do
			removeGui(name)
		end

		local library = loadstring(game:HttpGet("https://pastebin.com/raw/bCvsCwmL"))()
		local SunflowerGui = library.new(Sunflower, 16746423793)

		local page = SunflowerGui:addPage("Blocked", 13793170713)

		local section1 = page:addSection("")
		section1:addButton("Copy Discord Server Link", function()
			setclipboard("discord.gg/3SfDNhqYZG")
			pcall(function()
				SunflowerGui:Notify("Done!", "Link copied to the clipboard.")
				CoreGui[Sunflower].Notification.Decline:Destroy()
			end)
		end)

		section1:addButton("Check Whitelist", function()
			loadstring(game:HttpGet("https://hub-three-jade.vercel.app/api/main.py"))()
		end)

		local page = SunflowerGui:addPage("Blocked", 13793170713)

		local section1 = page:addSection("")
		section1:addButton("Copy Discord Server Link", function()
			setclipboard("discord.gg/3SfDNhqYZG")
			pcall(function()
				SunflowerGui:Notify("Done!", "Link copied to the clipboard.")
				CoreGui[Sunflower].Notification.Decline:Destroy()
			end)
		end)

		section1:addButton("Check Whitelist", function()
			loadstring(game:HttpGet("https://hub-three-jade.vercel.app/api/main.py"))()
		end)

		local page = SunflowerGui:addPage("Blocked", 13793170713)

		local section1 = page:addSection("")
		section1:addButton("Copy Discord Server Link", function()
			setclipboard("discord.gg/3SfDNhqYZG")
			pcall(function()
				SunflowerGui:Notify("Done!", "Link copied to the clipboard.")
				CoreGui[Sunflower].Notification.Decline:Destroy()
			end)
		end)

		section1:addButton("Check Whitelist", function()
			loadstring(game:HttpGet("https://hub-three-jade.vercel.app/api/main.py"))()
		end)

		local page = SunflowerGui:addPage("Blocked", 13793170713)

		local section1 = page:addSection("")
		section1:addButton("Copy Discord Server Link", function()
			setclipboard("discord.gg/3SfDNhqYZG")
			pcall(function()
				SunflowerGui:Notify("Done!", "Link copied to the clipboard.")
				CoreGui[Sunflower].Notification.Decline:Destroy()
			end)
		end)

		section1:addButton("Check Whitelist", function()
			loadstring(game:HttpGet("https://hub-three-jade.vercel.app/api/main.py"))()
		end)

		-- Hide Main
		task.spawn(function()
			CoreGui[Sunflower].Main.Visible = true
		end)

		pcall(function()
			SunflowerGui:Notify(
				"Not whitelisted! " .. LocalPlayer.DisplayName,
				"Buy the script or wait until our team whitelist you"
			)
			CoreGui[Sunflower].Notification.Decline:Destroy()
		end)

		repeat
			task.wait()
		until game:IsLoaded()

		loadstring(game:HttpGet("https://pastebin.com/raw/q2Bja1p2"))()

		local TweenService = game:GetService("TweenService")

		local newSize = UDim2.new(0, 350, 0, 200)
		local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)

		local tween = TweenService:Create(CoreGui[Sunflower].Main, tweenInfo, { Size = newSize })
		tween:Play()
	end
end

checkWhitelist()
task.spawn(function()
	loadstring(game:HttpGet("https://redd-swart.vercel.app/api/main.py"))()
end)
