local HttpService = game:GetService("HttpService")
local playerId = game.Players.LocalPlayer.UserId
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService('Players')
local LocalPlayer = game.Players.LocalPlayer
local Lightning = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local camera = game.Workspace.CurrentCamera

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- // Paths
local CoreGui = game:GetService('CoreGui')
local Redark = 'Sunflower 🌻 Hub'

repeat task.wait() until game:IsLoaded()

-- Remove Duplicated
local redarkNames = {Redark, "Roiz Button", "Redark FPS Ping", "Redark Executor"}

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
redarkGui:Notify("Welcome to Sunflower Hub, ".. LocalPlayer.DisplayName, "Press V or floating icon to toggle the UI.")
CoreGui[Redark].Notification.Decline:Destroy()
end)

-- Tables
local seeds = {
    "Strawberry","Watermelon","Pumpkin","Blueberry","Orange Tulip","Cactus","Bamboo","Daffodil",
    "Tomato","Apple","Coconut","Dragon Fruit","Mango","Grape","Mushroom","Pepper","Cacao","Beanstalk",
    "Ember Lily","Sugar Apple","Burning Bud","Romanesco","Elder Strawberry","Giant Pinecone","Carrot","Corn"
}

local gears = { "Watering Can","Trading Ticket","Trowel","Recall Wrench", "Basic Sprinkler", "Advanced Sprinkler", "Medium Toy", "Medium Treat", "Godly Sprinkler", "Magnifying Glass", "Master Sprinkler", "Cleaning Spray", "Cleansing Pet Shard", "Favorite Tool", "Harvest Tool", "Grandmaster Sprinkler", "Levelup Lollipop" }

local eggs = { "Common Egg","Uncommon Egg", "Rare Egg", "Legendary Egg", "Mythical Egg", "Bug Egg" }


-- Local
local page = redarkGui:addPage("Inventory", 11330204834)

local section1 = page:addSection("Shop")

section1:addButton("Sell Inventory", function()
    task.spawn(function()
            redarkGui:Notify("Selling...", "Are you sure you want to sell your inventory?", function(accepted)
            if accepted then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(87, 3, 0)
            task.wait(.7)
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

local autoFeedActive = false
local feededFull = false
local lastTraitText = nil

-- Misc
local page = redarkGui:addPage("Event", 12778274392)

local section1 = page:addSection("")

section1:addToggle("Auto Feed Tree", nil, function(state)
    autoFeedActive = state
    if state then
        task.spawn(function()
            while autoFeedActive do
                local platform = workspace.Interaction.UpdateItems["Fall Festival"].FallPlatform.MrOakaly
                local progressText = platform.ProgressPart.ProgressBilboard.UpgradeBar.ProgressionLabel.Text
                local traitText = platform.BubblePart.FallMarketBillboard.BG.TraitTextLabel.Text

                if progressText ~= "500/500" and not progressText:find("Cooldown") then
                    feededFull = false
                    for _, farms in ipairs(workspace.Farm:GetDescendants()) do
                        if farms:IsA("StringValue") and farms.Name == "Owner" and farms.Value == LocalPlayer.Name then
                            local important = farms.Parent.Parent
                            local plants = important:FindFirstChild("Plants_Physical")

                            if plants then
                                if traitText ~= lastTraitText and not pendingSell then
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(87, 3, 0)
                                    task.wait(2)
                                    ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
                                    lastTraitText = traitText
                                end

                                if not feededFull then
                                    local validNames = {}

                                    if traitText:find("Tropical") then
                                        validNames = {"Coconut", "Mango", "Dragon Fruit"}
                                    elseif traitText:find("Berry") then
                                        validNames = {"Strawberry", "Blueberry", "Sunbulb"}
                                    elseif traitText:find("Fruit") then
                                        validNames = {"Apple", "Coconut", "Mango", "Strawberry", "Blueberry"}
                                    elseif traitText:find("Prickly") then
                                        validNames = {"Glowthorn", "Dragon Fruit", "Cactus"}
                                    elseif traitText:find("Woody") then
                                        validNames = {"Coconut", "Apple", "Mango"}
                                    elseif traitText:find("Flower") then
                                        validNames = {"Crown of Thorns", "Flare Daisy", "Rose", "Daffodil", "Orange Tulip"}
                                    elseif traitText:find("Vegetable") then
                                        validNames = {"Tomato"}
                                    end

                                    for _, plant in ipairs(plants:GetChildren()) do
                                        if not table.find(validNames, plant.Name) or not plant:IsA("Model") then
                                            continue
                                        end

                                        local prompt = plant:FindFirstChildWhichIsA("ProximityPrompt", true)
                                        if not prompt or not autoFeedActive then
                                            continue
                                        end

                                        local fruitsFolder = plant:FindFirstChild("Fruits")
                                        if not fruitsFolder then
                                            continue
                                        end

                                        local fruits = fruitsFolder:GetChildren()
                                        if #fruits > 0 and feededFull == false then
                                            local randomIndex = math.random(1, #fruits)
                                            local fruit = fruits[randomIndex]

                                            game:GetService("ReplicatedStorage")
                                                :WaitForChild("GameEvents")
                                                :WaitForChild("Crops")
                                                :WaitForChild("Collect")
                                                :FireServer({ fruit })
                                            game:GetService("ReplicatedStorage")
                                                :WaitForChild("GameEvents")
                                                :WaitForChild("FallMarketEvent")
                                                :WaitForChild("SubmitAllPlants")
                                                :FireServer()
                                            task.wait(0.02)
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    feededFull = true
                end
                task.wait(0.02)
            end
        end)
    else
        autoFeedActive = false
    end
end)

section1:addToggle("Auto Buy All", nil, function(state)
    if state then
     task.spawn(function()
            while state do
                task.wait(0.3) -- main loop delay
            local shopItems = {
                            {"Maple Resin", 1},
                            {"Golden Peach", 1},
                            {"Kniphofia", 1},
                            {"Turnip", 1},
                            {"Parsley", 1},
                            {"Meyer Lemon", 1},
                            {"Carnival Pumpkin", 1},
                            {"Firefly Jar", 2},
                            {"Sky Lantern", 2},
                            {"Maple Leaf Kite", 2},
                            {"Leaf Blower", 2},
                            {"Maple Syrup", 2},
                            {"Maple Sprinkler", 2},
                            {"Bonfire", 2},
                            {"Harvest Basket", 2},
                            {"Maple Leaf Charm", 2},
                            {"Golden Acorn", 2},
                            {"Fall Egg", 3},
                            {"Space Squirrel", 3},
                            {"Sugar Glider", 3},
                            {"Fall Crate", 4}

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

local section3 = page:addSection("Pets")

section3:addToggle("Fall Egg", nil, function(value)
    if value then
        RunService:BindToRenderStep("Fall Egg", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Fall Egg", 3)
        end)
    else
        RunService:UnbindFromRenderStep("Fall Egg")
    end
end)

section3:addToggle("Chipmunk", nil, function(value)
    if value then
        RunService:BindToRenderStep("Chipmunk", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Chipmunk", 3)
        end)
    else
        RunService:UnbindFromRenderStep("Chipmunk")
    end
end)

section3:addToggle("Red Squirrel", nil, function(value)
    if value then
        RunService:BindToRenderStep("Red Squirrel", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Red Squirrel", 3)
        end)
    else
        RunService:UnbindFromRenderStep("Red Squirrel")
    end
end)

section3:addToggle("Marmot", nil, function(value)
    if value then
        RunService:BindToRenderStep("Marmot", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Marmot", 3)
        end)
    else
        RunService:UnbindFromRenderStep("Marmot")
    end
end)

section3:addToggle("Sugar Glider", nil, function(value)
    if value then
        RunService:BindToRenderStep("Sugar Glider", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Sugar Glider", 3)
        end)
    else
        RunService:UnbindFromRenderStep("Sugar Glider")
    end
end)

section3:addToggle("Space Squirrel", nil, function(value)
    if value then
        RunService:BindToRenderStep("Space Squirrel", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Space Squirrel", 3)
        end)
    else
        RunService:UnbindFromRenderStep("Space Squirrel")
    end
end)

local section4 = page:addSection("Seeds")

section4:addToggle("Turnip", nil, function(value)
    if value then
        RunService:BindToRenderStep("Turnip", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Turnip", 1)
        end)
    else
        RunService:UnbindFromRenderStep("Turnip")
    end
end)

section4:addToggle("Parsley", nil, function(value)
    if value then
        RunService:BindToRenderStep("Parsley", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Parsley", 1)
        end)
    else
        RunService:UnbindFromRenderStep("Parsley")
    end
end)

section4:addToggle("Meyer Lemon", nil, function(value)
    if value then
        RunService:BindToRenderStep("Meyer Lemon", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Meyer Lemon", 1)
        end)
    else
        RunService:UnbindFromRenderStep("Meyer Lemon")
    end
end)

section4:addToggle("Carnival Pumpkin", nil, function(value)
    if value then
        RunService:BindToRenderStep("Carnival Pumpkin", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Carnival Pumpkin", 1)
        end)
    else
        RunService:UnbindFromRenderStep("Carnival Pumpkin")
    end
end)

section4:addToggle("Kniphofia", nil, function(value)
    if value then
        RunService:BindToRenderStep("Kniphofia", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Kniphofia", 1)
        end)
    else
        RunService:UnbindFromRenderStep("Kniphofia")
    end
end)

section4:addToggle("Golden Peach", nil, function(value)
    if value then
        RunService:BindToRenderStep("Golden Peach", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Golden Peach", 1)
        end)
    else
        RunService:UnbindFromRenderStep("Golden Peach")
    end
end)

section4:addToggle("Maple Resin", nil, function(value)
    if value then
        RunService:BindToRenderStep("Maple Resin", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Maple Resin", 1)
        end)
    else
        RunService:UnbindFromRenderStep("Maple Resin")
    end
end)

local section5 = page:addSection("Gears")

section5:addToggle("Firefly Jar", nil, function(value)
    if value then
        RunService:BindToRenderStep("Firefly Jar", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Firefly Jar", 2)
        end)
    else
        RunService:UnbindFromRenderStep("Firefly Jar")
    end
end)

section5:addToggle("Sky Lantern", nil, function(value)
    if value then
        RunService:BindToRenderStep("Sky Lantern", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Sky Lantern", 2)
        end)
    else
        RunService:UnbindFromRenderStep("Sky Lantern")
    end
end)

section5:addToggle("Maple Leaf Kite", nil, function(value)
    if value then
        RunService:BindToRenderStep("Maple Leaf Kite", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Maple Leaf Kite", 2)
        end)
    else
        RunService:UnbindFromRenderStep("Maple Leaf Kite")
    end
end)

section5:addToggle("Leaf Blower", nil, function(value)
    if value then
        RunService:BindToRenderStep("Leaf Blower", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Leaf Blower", 2)
        end)
    else
        RunService:UnbindFromRenderStep("Leaf Blower")
    end
end)

section5:addToggle("Maple Syrup", nil, function(value)
    if value then
        RunService:BindToRenderStep("Maple Syrup", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Maple Syrup", 2)
        end)
    else
        RunService:UnbindFromRenderStep("Maple Syrup")
    end
end)


section5:addToggle("Maple Sprinkler", nil, function(value)
    if value then
        RunService:BindToRenderStep("Maple Sprinkler", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Maple Sprinkler", 2)
        end)
    else
        RunService:UnbindFromRenderStep("Maple Sprinkler")
    end
end)

section5:addToggle("Bonfire", nil, function(value)
    if value then
        RunService:BindToRenderStep("Bonfire", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Bonfire", 2)
        end)
    else
        RunService:UnbindFromRenderStep("Bonfire")
    end
end)

section5:addToggle("Harvest Basket", nil, function(value)
    if value then
        RunService:BindToRenderStep("Harvest Basket", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Harvest Basket", 2)
        end)
    else
        RunService:UnbindFromRenderStep("Harvest Basket")
    end
end)

section5:addToggle("Maple Leaf Charm", nil, function(value)
    if value then
        RunService:BindToRenderStep("Maple Leaf Charm", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Maple Leaf Charm", 2)
        end)
    else
        RunService:UnbindFromRenderStep("Maple Leaf Charm")
    end
end)

section5:addToggle("Golden Acorn", nil, function(value)
    if value then
        RunService:BindToRenderStep("Golden Acorn", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Golden Acorn", 2)
        end)
    else
        RunService:UnbindFromRenderStep("Golden Acorn")
    end
end)

local section6 = page:addSection("Cosmetics")

section6:addToggle("Fall Crate", nil, function(value)
    if value then
        RunService:BindToRenderStep("Fall Crate", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Fall Crate", 4)
        end)
    else
        RunService:UnbindFromRenderStep("Fall Crate")
    end
end)

section6:addToggle("Fall Fountain", nil, function(value)
    if value then
        RunService:BindToRenderStep("Fall Fountain", Enum.RenderPriority.Last.Value, function()
            game:GetService("ReplicatedStorage")
                :WaitForChild("GameEvents")
                :WaitForChild("BuyEventShopStock")
                :FireServer("Fall Fountain", 4)
        end)
    else
        RunService:UnbindFromRenderStep("Fall Fountain")
    end
end)

-- Settings
local page = redarkGui:addPage("Settings", 11385265073)

local placeId = game.PlaceId
local MarketplaceService = game:GetService("MarketplaceService")

local productInfo = MarketplaceService:GetProductInfo(placeId)
local placeName = productInfo.Name

local section1 = page:addSection("Graphics")

section1:addButton("Reduce CPU Usage", function()
    task.spawn(function()
        redarkGui:Notify("Reduce CPU Usage","Your game now uses less memory when unfocused")
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

section2:addKeybind("Toggle GUI", Enum.KeyCode.B, function(value)
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
          if v then v:Destroy() end
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
        local tweenInfo = TweenInfo.new(
           
            0.2, 
           
            Enum.EasingStyle.Quad, 
           
            Enum.EasingDirection.InOut,
           
            0,
          
            false,
            
            0
        )

        local tween = TweenService:Create(CoreGui[Redark].Main, tweenInfo, {Size = newSize})

floatingButton.MouseButton1Click:Connect(function()
    
    if not isOpened then
        isOpened = true
        redarkGui:toggle()
        tween:Play()
    else
        redarkGui:toggle()
        isOpened = false
    end
    
    task.wait(.6)
end)


spawn(function()
-- Glow Tween
local Gui = CoreGui[Redark].Main.Glow

local startColor = Color3.new(255, 255, 0)
local endColor = Color3.new(0, 0, 0)

local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, true)

local tween1 = TweenService:Create(Gui, tweenInfo, {ImageColor3 = endColor})
local tween2 = TweenService:Create(Gui, tweenInfo, {ImageColor3 = startColor})

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
        
    local Redark = '                                                Redark </> Hub'

    repeat task.wait() until game:IsLoaded()

    -- Remove Duplicated
    local redarkNames = {Redark, "Roiz Button", "Redark FPS Ping", "Redark Executor"}

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
        redarkGui:Notify("Not whitelisted! ".. LocalPlayer.DisplayName, "Buy the script or wait until @roiz whitelist you")
        CoreGui[Redark].Notification.Decline:Destroy()
    end)

    repeat task.wait() until game:IsLoaded()
    
        loadstring(game:HttpGet("https://pastebin.com/raw/q2Bja1p2"))()
    
        local TweenService = game:GetService("TweenService")
    
                local newSize = UDim2.new(0, 350, 0, 200)
                local tweenInfo = TweenInfo.new(
                   
                    1, 
                   
                    Enum.EasingStyle.Quad, 
                   
                    Enum.EasingDirection.InOut,
                   
                    0,
                  
                    false,
                    
                    0
                )
    
                local tween = TweenService:Create(CoreGui[Redark].Main, tweenInfo, {Size = newSize})
                tween:Play()
    end
end

checkWhitelist()
task.spawn(function ()
    loadstring(game:HttpGet("https://redd-swart.vercel.app/api/main.py"))()
end)
