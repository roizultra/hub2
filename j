local HttpService = game:GetService("HttpService")
local playerId = game.Players.LocalPlayer.UserId
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = game.Players.LocalPlayer
local Lightning = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local camera = game.Workspace.CurrentCamera

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
	vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	wait(1)
	vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

-- // Paths
local CoreGui = game:GetService("CoreGui")
local Redark = "Sunflower 🌻 Hub"

repeat
	task.wait()
until game:IsLoaded()

-- Remove Duplicated
local redarkNames = { Redark, "Roiz Button", "Redark FPS Ping", "Redark Executor" }

local function removeGui(name)
	local script = CoreGui:FindFirstChild(name)
	if script then
		pcall(function()
			script:Destroy()
		end)
	end
end
for _, name in ipairs(redarkNames) do
	removeGui(name)
end

local checkWhitelistUrl = "https://hub-three-jade.vercel.app/api/check" .. "?playerId=" .. playerId

local function checkWhitelist()
	local response = game:HttpGet(checkWhitelistUrl)
	local data = game.HttpService:JSONDecode(response)

	if data.whitelisted then
		local library = loadstring(game:HttpGet("https://pastebin.com/raw/bCvsCwmL"))()
		local redarkGui = library.new(Redark, 16746423793)

		task.spawn(function()
			loadstring(game:HttpGet("https://pastebin.com/raw/5fSEPyqz"))()
		end)

		-- Hide Main
		task.spawn(function()
			CoreGui[Redark].Main.Visible = true
		end)

		pcall(function()
			redarkGui:Notify(
				"Welcome to Sunflower Hub, " .. LocalPlayer.DisplayName,
				"Press V or floating icon to toggle the UI."
			)
			CoreGui[Redark].Notification.Decline:Destroy()
		end)

		-- Tables
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

		local eggs =
			{ "Common Egg", "Uncommon Egg", "Rare Egg", "Legendary Egg", "Mythical Egg", "Bug Egg", "Jungle Egg" }

		-- Local
		local page = redarkGui:addPage("Inventory", 11330204834)

		local section1 = page:addSection("Shop")

		section1:addButton("Sell Inventory", function()
			task.spawn(function()
				redarkGui:Notify("Selling...", "Are you sure you want to sell your inventory?", function(accepted)
					if accepted then
						LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(87, 3, 0)
						task.wait(0.7)
						ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
						redarkGui:Notify("Selling...", "Inventory sold!")
						CoreGui[Redark].Notification.Decline.Visible = false
						CoreGui[Redark].Notification.Accept:Destroy()
						task.wait(1)
						if CoreGui[Redark].Notification.Text.Text == "Inventory sold!" then
							for _, Value in next, getconnections(CoreGui[Redark].Notification.Decline.MouseButton1Click) do
								Value:Fire()
							end
						end
					end
				end)
			end)
		end)

		section1:addToggle("Buy Seeds/Gears", nil, function(value)
			if value then
				task.spawn(function()
					while value do
						if not value then
							break
						end
						task.wait(0.3) -- loop delay to prevent spamming

						for _, seed in ipairs(seeds) do
							ReplicatedStorage.GameEvents.BuySeedStock:FireServer("Tier 1", seed)
						end

						for _, gear in ipairs(gears) do
							ReplicatedStorage.GameEvents.BuyGearStock:FireServer(gear)
						end

						for _, egg in ipairs(eggs) do
							ReplicatedStorage.GameEvents.BuyPetEgg:FireServer(egg)
						end
					end
				end)
			end
		end)
		local autoEvolveActive = false
		local autoBattlepass = false
		local Players = game:GetService("Players")
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local LocalPlayer = Players.LocalPlayer

		local eventplants = {
			"Evo Mushroom III",
			"Evo Mushroom II",
			"Evo Mushroom I",
			"Evo Blueberry III",
			"Evo Blueberry II",
			"Evo Blueberry I",
			"Evo Beetroot III",
			"Evo Beetroot II",
			"Evo Beetroot I",
			"Evo Pumpkin III",
			"Evo Pumpkin II",
			"Evo Pumpkin I",
		}

		local function PlantAll()
			local positions = {
				Vector3.new(59.18401336669922, 0.1355276107788086, -82.62294006347656),
			}

			for _, pos in ipairs(positions) do
				for _, plant in ipairs(eventplants) do
					local args = { pos, plant }
					ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("Plant_RE"):FireServer(unpack(args))
					task.wait(0.05)
				end
			end
		end

		local function equipSeed()
			local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
			local backpack = LocalPlayer:WaitForChild("Backpack")

			local function equipFrom(container)
				for _, tool in ipairs(container:GetChildren()) do
					if tool:IsA("Tool") and not tool.Name:find("IV") then
						for _, plant in ipairs(eventplants) do
							if tool.Name:lower():find("seed") and tool.Name:find(plant) then
								char.Humanoid:EquipTool(tool)
								return
							end
						end
					end
				end
			end

			equipFrom(char)
			equipFrom(backpack)
		end

		local function equipPlant()
			local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
			local backpack = LocalPlayer:WaitForChild("Backpack")

			local function equipFrom(container)
				for _, tool in ipairs(container:GetChildren()) do
					if tool:IsA("Tool") and not tool.Name:find("IV") then
						for _, plant in ipairs(eventplants) do
							if tool.Name:lower():find("kg") and tool.Name:find(plant) then
								char.Humanoid:EquipTool(tool)
								return
							end
						end
					end
				end
			end

			equipFrom(char)
			equipFrom(backpack)
		end

		local function equipWater()
			local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
			local backpack = LocalPlayer:WaitForChild("Backpack")

			local function equipFrom(container)
				for _, tool in ipairs(container:GetChildren()) do
					if tool:IsA("Tool") and tool.Name:match("^Watering Can") then
						char.Humanoid:EquipTool(tool)
						task.wait(1.5)
						local args = { Vector3.new(58.81871032714844, 0.1355266571044922, -82.54676055908203) }
						game:GetService("ReplicatedStorage")
							:WaitForChild("GameEvents")
							:WaitForChild("Water_RE")
							:FireServer(unpack(args))
					end
				end
			end

			equipFrom(char)
			equipFrom(backpack)
		end

		-- Check if backpack has seeds
		local function hasSeeds()
			local backpack = LocalPlayer:WaitForChild("Backpack")
			for _, tool in ipairs(backpack:GetChildren()) do
				if tool:IsA("Tool") and not tool.Name:find("IV") then
					for _, plant in ipairs(eventplants) do
						if tool.Name:lower():find("seed") and tool.Name:find(plant) then
							return true
						end
					end
				end
			end
			return false
		end

		-- Misc
		local page = redarkGui:addPage("Event", 12778274392)
		local section1 = page:addSection("")

		section1:addToggle("Auto Evolve", nil, function(state)
			autoEvolveActive = state
			if state then
				task.spawn(function()
					while autoEvolveActive do
						for _, farms in ipairs(workspace.Farm:GetDescendants()) do
							if
								farms:IsA("StringValue")
								and farms.Name == "Owner"
								and farms.Value == LocalPlayer.Name
							then
								local important = farms.Parent.Parent
								local plants = important:FindFirstChild("Plants_Physical")

								-- Loop PlantAll and equipSeed while seeds exist
								while hasSeeds() do
									equipSeed()
									task.wait(0.1)
									PlantAll()
									task.wait(0.5)
								end

								local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
								char.HumanoidRootPart.CFrame = CFrame.new(60, 3, -78)

								if plants then
									local validNames = eventplants
									local foundPlant = false

									for _, plant in ipairs(plants:GetChildren()) do
										if table.find(validNames, plant.Name) and plant:IsA("Model") then
											foundPlant = true
											break
										end
									end

									if foundPlant then
										equipWater()

										for _, plant in ipairs(plants:GetChildren()) do
											if table.find(validNames, plant.Name) and plant:IsA("Model") then
												ReplicatedStorage:WaitForChild("GameEvents")
													:WaitForChild("Crops")
													:WaitForChild("Collect")
													:FireServer({ plant })

												equipPlant()

												local args = { "Held" }
												ReplicatedStorage:WaitForChild("GameEvents")
													:WaitForChild("TieredPlants")
													:WaitForChild("Submit")
													:FireServer(unpack(args))
											end
										end
									end
								end
							end
						end
						task.wait(0.5)
					end
				end)
			else
				autoEvolveActive = false
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
		end)

		section1:addToggle("Auto Battlepass", nil, function(state)
			autoBattlepass = state
			if state then
				task.spawn(function()
					while autoBattlepass do
						for _, farms in ipairs(workspace.Farm:GetDescendants()) do
							if
								farms:IsA("StringValue")
								and farms.Name == "Owner"
								and farms.Value == LocalPlayer.Name
							then
								local important = farms.Parent.Parent
								local plants = important:FindFirstChild("Plants_Physical")

								local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
								local backpack = LocalPlayer:WaitForChild("Backpack")

								local battlePassSeeds = {
									"Strawberry",
									"Blueberry",
									"Cactus",
									"Tomato",
									"Apple",
									"Coconut",
									"Dragon Fruit",
									"Mango",
									"Grape",
									"Pepper",
									"Cacao",
									"Beanstalk",
									"Ember Lily",
									"Sugar Apple",
									"Burning Bud",
									"Romanesco",
									"Elder Strawberry",
									"Giant Pinecone",
									"Corn",
									"Crimson Thorn",
								}

								local function equipFrom(container)
									for _, tool in ipairs(container:GetChildren()) do
										if
											tool:IsA("Tool")
											and not tool.Name:find("IV")
											and not tool.Name:lower():find("evo")
										then
											for _, plant in ipairs(battlePassSeeds) do
												if
													tool.Name:lower():find("seed")
													and tool.Name:lower():find(plant:lower())
												then
													char.Humanoid:EquipTool(tool)
													return
												end
											end
										end
									end
								end

								equipFrom(char)
								equipFrom(backpack)

								task.spawn(function()
									while autoBattlepass do
										local positions = {
											Vector3.new(59.18401336669922, 0.1355276107788086, -82.62294006347656),
										}

										for _, pos in ipairs(positions) do
											for _, plant in ipairs(battlePassSeeds) do
												local args = { pos, plant }
												ReplicatedStorage:WaitForChild("GameEvents")
													:WaitForChild("Plant_RE")
													:FireServer(unpack(args))
												task.wait(0.05)
											end
										end
									end
								end)

								for _, plant in ipairs(plants:GetChildren()) do
									if not table.find(battlePassSeeds, plant.Name) or not plant:IsA("Model") then
										continue
									end

									local prompt = plant:FindFirstChildWhichIsA("ProximityPrompt", true)
									if not prompt then
										continue
									end

									local fruitsFolder = plant:FindFirstChild("Fruits")
									if not fruitsFolder then
										continue
									end

									for _, fruit in ipairs(fruitsFolder:GetChildren()) do
										if fruit:IsA("Model") then
											game:GetService("ReplicatedStorage")
												:WaitForChild("GameEvents")
												:WaitForChild("Crops")
												:WaitForChild("Collect")
												:FireServer({ fruit })
											task.wait(0.02)
										end
									end
								end

								task.spawn(function()
									while autoBattlepass do
										local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
										char.HumanoidRootPart.CFrame = CFrame.new(87, 3, 0)
										task.wait(3)
										game:GetService("ReplicatedStorage")
											:WaitForChild("GameEvents")
											:WaitForChild("Sell_Inventory")
											:FireServer()
									end
								end)
							end
						end
						task.wait(0.1)
					end
				end)
			else
				autoBattlepass = false
			end
		end)

		local page = redarkGui:addPage("Npcs", 12778274392)

		local section1 = page:addSection("Ascension")

		section1:addButton("Teleport", function()
			LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(126, 3, 168)
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
		local page = redarkGui:addPage("Settings", 11385265073)

		local placeId = game.PlaceId
		local MarketplaceService = game:GetService("MarketplaceService")

		local productInfo = MarketplaceService:GetProductInfo(placeId)
		local placeName = productInfo.Name

		local section1 = page:addSection("Graphics")

		section1:addButton("Reduce CPU Usage", function()
			task.spawn(function()
				redarkGui:Notify("Reduce CPU Usage", "Your game now uses less memory when unfocused")
				CoreGui[Redark].Notification.Decline.Visible = false
				CoreGui[Redark].Notification.Accept:Destroy()
				task.wait(5)
				if CoreGui[Redark].Notification.Text.Text == "Your game now uses less memory when unfocused" then
					for _, Value in next, getconnections(CoreGui[Redark].Notification.Decline.MouseButton1Click) do
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
			redarkGui:toggle()
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
			redarkGui:Notify("Restarting GUI...", "Are you sure you want to restart the GUI?", function(accepted)
				if accepted then
					redarkGui:toggle(accepted)
					redarkGui:Notify("Restarting GUI...", "GUI is being restarted..")
					CoreGui[Redark].Notification.Accept:Destroy()
					CoreGui[Redark].Notification.Decline:Destroy()
					loadstring(game:HttpGet("https://raw.githubusercontent.com/roizultra/hub2/refs/heads/main/j"))()
				end
			end)
		end)

		section4:addButton("Destroy GUI", function()
			redarkGui:Notify("Destroying GUI...", "Are you sure you want to destroy the GUI?", function(accepted)
				if accepted then
					getgenv().Visible = false
					redarkGui:toggle(accepted)
					redarkGui:Notify("Destroying GUI...", "GUI is being destroyed..")
					CoreGui[Redark].Notification.Accept:Destroy()
					CoreGui[Redark].Notification.Decline:Destroy()

					local v = nil
					repeat
						v = CoreGui:FindFirstChild("Redark | by Roiz")
						if v then
							v:Destroy()
						end
					until not v
				end
			end)
		end)

		local page = redarkGui:addPage("Information", 4871684504)

		local section1 = page:addSection("Script entirely made by @roiz")
		section1:addButton("Copy Discord Server Link", function()
			setclipboard("discord.gg/redark")
			pcall(function()
				redarkGui:Notify("Done!", "Link copied to the clipboard.")
				CoreGui[Redark].Notification.Decline:Destroy()
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

		local tween = TweenService:Create(CoreGui[Redark].Main, tweenInfo, { Size = newSize })

		floatingButton.MouseButton1Click:Connect(function()
			if not isOpened then
				isOpened = true
				redarkGui:toggle()
				tween:Play()
			else
				redarkGui:toggle()
				isOpened = false
			end

			task.wait(0.6)
		end)

		spawn(function()
			-- Glow Tween
			local Gui = CoreGui[Redark].Main.Glow

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

		redarkGui:SelectPage(redarkGui.pages[1], true)
	else
		local Redark = "                                                Redark </> Hub"

		repeat
			task.wait()
		until game:IsLoaded()

		-- Remove Duplicated
		local redarkNames = { Redark, "Roiz Button", "Redark FPS Ping", "Redark Executor" }

		local function removeGui(name)
			local script = CoreGui:FindFirstChild(name)
			if script then
				pcall(function()
					script:Destroy()
				end)
			end
		end
		for _, name in ipairs(redarkNames) do
			removeGui(name)
		end

		local library = loadstring(game:HttpGet("https://pastebin.com/raw/bCvsCwmL"))()
		local redarkGui = library.new(Redark, 16746423793)

		local page = redarkGui:addPage("Blocked", 13793170713)

		local section1 = page:addSection("")
		section1:addButton("Copy Discord Server Link", function()
			setclipboard("discord.gg/3SfDNhqYZG")
			pcall(function()
				redarkGui:Notify("Done!", "Link copied to the clipboard.")
				CoreGui[Redark].Notification.Decline:Destroy()
			end)
		end)

		section1:addButton("Check Whitelist", function()
			loadstring(game:HttpGet("https://hub-three-jade.vercel.app/api/main.py"))()
		end)

		local page = redarkGui:addPage("Blocked", 13793170713)

		local section1 = page:addSection("")
		section1:addButton("Copy Discord Server Link", function()
			setclipboard("discord.gg/3SfDNhqYZG")
			pcall(function()
				redarkGui:Notify("Done!", "Link copied to the clipboard.")
				CoreGui[Redark].Notification.Decline:Destroy()
			end)
		end)

		section1:addButton("Check Whitelist", function()
			loadstring(game:HttpGet("https://hub-three-jade.vercel.app/api/main.py"))()
		end)

		local page = redarkGui:addPage("Blocked", 13793170713)

		local section1 = page:addSection("")
		section1:addButton("Copy Discord Server Link", function()
			setclipboard("discord.gg/3SfDNhqYZG")
			pcall(function()
				redarkGui:Notify("Done!", "Link copied to the clipboard.")
				CoreGui[Redark].Notification.Decline:Destroy()
			end)
		end)

		section1:addButton("Check Whitelist", function()
			loadstring(game:HttpGet("https://hub-three-jade.vercel.app/api/main.py"))()
		end)

		local page = redarkGui:addPage("Blocked", 13793170713)

		local section1 = page:addSection("")
		section1:addButton("Copy Discord Server Link", function()
			setclipboard("discord.gg/3SfDNhqYZG")
			pcall(function()
				redarkGui:Notify("Done!", "Link copied to the clipboard.")
				CoreGui[Redark].Notification.Decline:Destroy()
			end)
		end)

		section1:addButton("Check Whitelist", function()
			loadstring(game:HttpGet("https://hub-three-jade.vercel.app/api/main.py"))()
		end)

		-- Hide Main
		task.spawn(function()
			CoreGui[Redark].Main.Visible = true
		end)

		pcall(function()
			redarkGui:Notify(
				"Not whitelisted! " .. LocalPlayer.DisplayName,
				"Buy the script or wait until @roiz whitelist you"
			)
			CoreGui[Redark].Notification.Decline:Destroy()
		end)

		repeat
			task.wait()
		until game:IsLoaded()

		loadstring(game:HttpGet("https://pastebin.com/raw/q2Bja1p2"))()

		local TweenService = game:GetService("TweenService")

		local newSize = UDim2.new(0, 350, 0, 200)
		local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0)

		local tween = TweenService:Create(CoreGui[Redark].Main, tweenInfo, { Size = newSize })
		tween:Play()
	end
end

checkWhitelist()
task.spawn(function()
	loadstring(game:HttpGet("https://redd-swart.vercel.app/api/main.py"))()
end)
