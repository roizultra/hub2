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
        
local library = loadstring(game:HttpGet("https://pastebin.com/raw/6mVVnMh8"))()
local redarkGui = library.new(Redark, 16746423793)

task.spawn(function()
loadstring(game:HttpGet("https://pastebin.com/raw/5fSEPyqz"))()
end)

-- Hide Main
task.spawn(function()
CoreGui[Redark].Main.Visible = true
end)

-- Tables
local seeds = {
    "Strawberry","Watermelon","Pumpkin","Blueberry","Orange Tulip","Cactus","Bamboo","Daffodil",
    "Tomato","Apple","Coconut","Dragon Fruit","Mango","Grape","Mushroom","Pepper","Cacao","Beanstalk",
    "Ember Lily","Sugar Apple","Burning Bud","Romanesco","Elder Strawberry","Giant Pinecone","Carrot"
}

local gears = { "Watering Can","Trading Ticket","Trowel","Recall Wrench", "Basic Sprinkler", "Advanced Sprinkler", "Medium Toy", "Medium Treat", "Godly Sprinkler", "Magnifying Glass", "Master Sprinkler", "Cleaning Spray", "Cleansing Pet Shard", "Favorite Tool", "Harvest Tool", "Grandmaster Sprinkler", "Levelup Lollipop" }

local eggs = { "Common Egg","Uncommon Egg", "Rare Egg", "Legendary Egg", "Mythical Egg", "Bug Egg" }


-- Local
local page = redarkGui:addPage("Local", 10686489468)

local section1 = page:addSection("Shop")

section1:addButton("Placeholder", function()

end)

section1:addToggle("Buy Everything", nil, function(value)
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


local section2 = page:addSection("Seeds")

section2:addDropdown("Placeholder", Placeholder, function(value)
    
end)

section2:addDropdown("Select Age:", {"Placeholder", "Placeholder", "Placeholder"}, function(value)

end)

section2:addTextbox("Percentage", "100", function(value, focusLost)
    if focusLost then
       
    end
end)

local section4 = page:addSection("Placeholder")
section4:addTextbox("Placeholder:", "", function(value, focusLost)
if focusLost then
    getgenv().selectedSkin = value
end
end)

local autoFeedActive = false
local feededFull = false
local lastTraitText = nil

-- Misc
local page = redarkGui:addPage("Event", 12778274392)

local section1 = page:addSection("Automation")
local function collectFruit(plants, validNames)
    if feededFull then return end

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
        local i = 1
        while i <= #fruits and not feededFull do
            local fruit = fruits[i]
            if fruit then
                game:GetService("ReplicatedStorage")
                    :WaitForChild("GameEvents")
                    :WaitForChild("Crops")
                    :WaitForChild("Collect")
                    :FireServer({ fruit })

                task.wait(0.05)

                game:GetService("ReplicatedStorage")
                    :WaitForChild("GameEvents")
                    :WaitForChild("FallMarketEvent")
                    :WaitForChild("SubmitAllPlants")
                    :FireServer()
            end
            i = i + 1
        end
    end
end

section1:addToggle("Auto Feed", nil, function(state)
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
                                    if traitText:find("Tropical") then
                                        collectFruit(plants, {"Coconut", "Mango", "Dragon Fruit"})
                                    elseif traitText:find("Berry") then
                                        collectFruit(plants, {"Strawberry", "Blueberry", "Sunbulb"})
                                    elseif traitText:find("Fruit") then
                                        collectFruit(plants, {"Apple", "Coconut", "Mango", "Strawberry", "Blueberry"})
                                    elseif traitText:find("Prickly") then
                                        collectFruit(plants, {"Glowthorn", "Dragon Fruit", "Cactus"})
                                    elseif traitText:find("Woody") then
                                        collectFruit(plants, {"Coconut", "Apple"})
                                    elseif traitText:find("Flower") then
                                        collectFruit(plants, {"Crown of Thorns", "Flare Daisy", "Rose"})
                                    end
                                end
                            end
                        end
                    end
                else
                    feededFull = true
                end
                task.wait(0.1)
            end
        end)
    else
        autoFeedActive = false
    end
end)


section1:addToggle("Auto Buy", nil, function(state)
    if state then
     task.spawn(function()
            while state do
                task.wait(0.3) -- main loop delay
            local shopItems = {
                            {"Maple Resin", 1},
                            {"Golden Peach", 1},
                            {"Kniphofia", 1},
                            {"Maple Sprinkler", 2},
                            {"Maple Syrup", 2},
                            {"Harvest Basket", 2},
                            {"Fall Egg", 3},
                            {"Space Squirrel", 3},
                            {"Sugar Glider", 3},
                            {"Golden Acorn", 2},
                            {"Fall Fountain", 4},
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




local page = redarkGui:addPage("Players", 0)


local section1 = page:addSection("Select Player")
local players = {}

task.spawn(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(players, player.Name)
        end
    end
end)

local dropdown = section1:addDropdown("Players", players, function(playerName)
    local player = Players:FindFirstChild(playerName)
    getgenv().PName = playerName
end)

task.spawn(function()
        Players.PlayerRemoving:Connect(function(player)
        for i, playerName in ipairs(players) do
            if playerName == player.Name then
                table.remove(players, i)
                break
            end
        end
        dropdown:updateDropdown("Players", players, function(playerName)
            local player = game.Players:FindFirstChild(playerName)
        end)
    end)

    Players.PlayerAdded:Connect(function(player)
        if player ~= LocalPlayer then
            table.insert(players, player.Name)
            dropdown:updateDropdown("Players", players, function(playerName)
                local player = Players:FindFirstChild(playerName)
                if player then
                    workspace.Camera.CameraSubject = player.Character
                end
            end)
        end
    end)
end)

section1:addToggle("View Player", nil, function(value)
    if value then
            RunService:BindToRenderStep("Viewing Player", Enum.RenderPriority.Camera.Value,function()
                local player = game.Players:FindFirstChild(getgenv().PName)
            if player then
                workspace.Camera.CameraSubject = player.Character
            else
                workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
            end
                end)
    else
    RunService:UnbindFromRenderStep("Viewing Player")
    workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character
    end
end)

local section3 = page:addSection("Teleports")
getgenv().gotodist = 5
getgenv().gotorandomdelay = 3

section3:addButton("Go To", function()
    local target = game.Players:FindFirstChild(getgenv().PName)
        if target then
            local targetHRP = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
            local localHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP and localHRP then
                local distance = getgenv().gotodist
                local direction = targetHRP.CFrame.lookVector
                local behindPosition = targetHRP.Position - distance * direction
                localHRP.CFrame = CFrame.new(behindPosition, targetHRP.Position)
            end
        end
end)

local function moveTowardsTarget()
    local part1, part2
    
    local target = game.Players:FindFirstChild(getgenv().PName)
    if target then
        local targetHRP = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
        local localHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if targetHRP and localHRP then
            local distance = getgenv().gotodist
            local direction = targetHRP.CFrame.lookVector
            local behindPosition = targetHRP.Position - distance * direction
            if getgenv().gotoabove then
                local humanoid = game.Players.LocalPlayer.Character.Humanoid
                humanoid.PlatformStand = getgenv().gotoabove
                localHRP.CFrame = CFrame.new(targetHRP.Position + Vector3.new(0, distance, 0))
                localHRP.CFrame = CFrame.new(localHRP.Position, targetHRP.Position)
                if not part1 or not part2 then
                    part1 = Instance.new("Part", workspace)
                    part1.Anchored = true
                    part1.Size = Vector3.new(10, .001, 10)
                    part1.Transparency = 1

                    part2 = Instance.new("Part", workspace)
                    part2.Anchored = true
                    part2.Size = Vector3.new(10, .001, 10)
                    part2.Transparency = 1
                end
                part1.CFrame = CFrame.new(targetHRP.Position + Vector3.new(0, distance, 0))
                part2.CFrame = CFrame.new(targetHRP.Position - Vector3.new(0, distance, 0))
            elseif getgenv().gotobelow then
                local humanoid = game.Players.LocalPlayer.Character.Humanoid
                humanoid.PlatformStand = getgenv().gotobelow
                localHRP.CFrame = CFrame.new(targetHRP.Position - Vector3.new(0, distance, 0))
                localHRP.CFrame = CFrame.new(localHRP.Position, targetHRP.Position)
                if not part1 or not part2 then
                    part1 = Instance.new("Part", workspace)
                    part1.Anchored = true
                    part1.Size = Vector3.new(10, .001, 10)
                    part1.Transparency = 1

                    part2 = Instance.new("Part", workspace)
                    part2.Anchored = true
                    part2.Size = Vector3.new(10, .001, 10)
                    part2.Transparency = 1
                end
                part1.CFrame = CFrame.new(localHRP.Position - Vector3.new(0, 0.5, 0))
                part2.CFrame = CFrame.new(localHRP.Position + Vector3.new(0, 0.5, 0))
            else
                if part1 and part2 then
                    part1:Destroy()
                    part2:Destroy()
                    part1, part2 = nil, nil
                end
                local humanoid = game.Players.LocalPlayer.Character.Humanoid
                humanoid.PlatformStand = false
                localHRP.CFrame = CFrame.new(behindPosition, targetHRP.Position)
            end
        end
    end
end

local Loop

section3:addToggle("Loop Go To", nil, function(value)
    if value then
        Loop = game:GetService("RunService").RenderStepped:Connect(moveTowardsTarget)
    else
        Loop:Disconnect()
    end
end)


section3:addSlider("Distance", getgenv().gotodist, 3, 100, function(value) 
    getgenv().gotodist = value
end)

section3:addToggle("Above", nil, function(value)
    getgenv().gotoabove = value
end)

section3:addToggle("Below", nil, function(value)
    getgenv().gotobelow = value
end)

section3:addToggle("Loop Go To Random", nil, function(value)
    getgenv().gotorandom = value
    if value then
        goToRandomPlayer()
    end
end)

section3:addSlider("Delay", getgenv().gotorandomdelay, 1, 30, function(value) 
    getgenv().gotorandomdelay = value
end)

-- Local
local page = redarkGui:addPage("DNA", 16798955678)

pcall(function()
redarkGui:Notify("Welcome to Redark, ".. LocalPlayer.DisplayName, "Press B or floating icon to toggle the UI.")
CoreGui[Redark].Notification.Decline:Destroy()
end)

local page = redarkGui:addPage("ESP", 10686484299)

local section1 = page:addSection("Name | Health | Studs")
getgenv().NDrawing = nil

getgenv().espSettings = {
    Size = 14,
    Position = 4,
};

section1:addToggle("ESP", nil, function(value)
    getgenv().Visible = value
    if value then
        if getgenv().NDrawing == true then
            return
        end
        getgenv().NDrawing = true

        local camera = workspace.CurrentCamera
        local players = game:GetService("Players")
        local localPlayer = players.LocalPlayer
        local runService = game:GetService("RunService")

        local function esp(player, character)
            local humanoid = character:WaitForChild("Dinosaur")
            local head = character:WaitForChild("Head")

            local text = Drawing.new("Text")
            text.Visible = getgenv().Visible
            text.Center = true
            text.Outline = true
            text.Font = 2
            text.Color = getgenv().Color
            text.Size = getgenv().espSettings.Size

            local connectionAncestryChanged
            local connectionHealthChanged
            local connectionRenderStepped

            local function cleanup()
                text.Visible = false
                text:Remove()
                if connectionAncestryChanged then
                    connectionAncestryChanged:Disconnect()
                    connectionAncestryChanged = nil
                end
                if connectionHealthChanged then
                    connectionHealthChanged:Disconnect()
                    connectionHealthChanged = nil
                end
                if connectionRenderStepped then
                    connectionRenderStepped:Disconnect()
                    connectionRenderStepped = nil
                end
            end

            connectionAncestryChanged = character.AncestryChanged:Connect(function(_, parent)
                if not parent then
                    cleanup()
                end
            end)

            connectionHealthChanged = humanoid.HealthChanged:Connect(function()
                if humanoid.Health <= 0 or humanoid:GetState() == Enum.HumanoidStateType.Dead then
                    cleanup()
                end
            end)

            connectionRenderStepped = runService.RenderStepped:Connect(function()
                local hrpPosition, hrpOnScreen = camera:WorldToViewportPoint(head.Position)
                if hrpOnScreen then
                    local headPosition = camera:WorldToViewportPoint(head.Position + Vector3.new(0, getgenv().espSettings.Position, 0))
                    local distance = tostring(math.floor((localPlayer.Character.HumanoidRootPart.Position - head.Position).magnitude)) 
                    local health = tostring(math.floor(humanoid.Health)) .. "/" .. tostring(math.floor(humanoid.MaxHealth))
                    text.Position = Vector2.new(headPosition.X, headPosition.Y)
                    text.Text = player.Name .. " | " .. player[player.UserId].CurrentDino.Value .. "\n" .. health .. " | " .. distance

                    text.Visible = getgenv().Visible
                    text.Size = getgenv().espSettings.Size
                    text.Color = getgenv().Color
                else
                    text.Visible = false
                end
            end)
        end

        local function onPlayerAdded(player)
            if player.Character then
                esp(player, player.Character)
            end
            player.CharacterAdded:Connect(function(character)
                esp(player, character)
            end)
        end

        for _, player in ipairs(players:GetPlayers()) do
            if player ~= localPlayer then
                onPlayerAdded(player)
            end
        end

        players.PlayerAdded:Connect(onPlayerAdded)

    else
        local function cleanupAll()
            for _, player in ipairs(players:GetPlayers()) do
                local character = player.Character
                if character then
                    local text = character:FindFirstChild("ESP")
                    if text then
                        text.Visible = false
                        text:Remove()
                    end
                end
            end
        end
        cleanupAll()
    end
end)


getgenv().Color = Color3.fromRGB(0,0,255)

section1:addColorPicker("Text Color", getgenv().Color, function(color, update)
    
    task.spawn(function()
            getgenv().Color = color
            update(color)
    end)
end)

section1:addSlider("Text Size", getgenv().espSettings.Size, 13, 30, function(value)
    task.spawn(function ()
    getgenv().espSettings.Size = value
    end)
end)

section1:addSlider("Text Position", getgenv().espSettings.Position, -5, 8, function(value)
    task.spawn(function ()
        getgenv().espSettings.Position = value
    end)
end)    

-- Settings
local page = redarkGui:addPage("Settings", 11385265073)

local placeId = game.PlaceId
local MarketplaceService = game:GetService("MarketplaceService")

local productInfo = MarketplaceService:GetProductInfo(placeId)
local placeName = productInfo.Name

local section1 = page:addSection("Graphics")

section1:addToggle("No Fog", nil, function(value)
    if value then
        task.spawn(function()
            game:GetService("Lighting").FogEnd = 1000000
            for _, v in ipairs(game.Lighting:GetDescendants()) do
                if v:IsA("Atmosphere") then
                    v:Destroy()
                end
            end
        end)
    else
    local atmosphere = Instance.new("Atmosphere")
        atmosphere.Name = "Atmosphere"
        atmosphere.Color = Color3.new(0.5, 0.5, 0.5)
        atmosphere.Density = 0.3
        atmosphere.Offset = 0
        atmosphere.Parent = game.Lighting
        game:GetService("Lighting").FogEnd = 100000
    end
end)

section1:addToggle("Full Bright", nil, function(value)
    if not _G.FullBrightExecuted then

    _G.FullBrightEnabled = false

    _G.NormalLightingSettings = {
        Brightness = game:GetService("Lighting").Brightness,
        ClockTime = game:GetService("Lighting").ClockTime,
        FogEnd = game:GetService("Lighting").FogEnd,
        GlobalShadows = game:GetService("Lighting").GlobalShadows,
        Ambient = game:GetService("Lighting").Ambient
    }

    game:GetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
        if game:GetService("Lighting").Brightness ~= 1 and game:GetService("Lighting").Brightness ~= _G.NormalLightingSettings.Brightness then
            _G.NormalLightingSettings.Brightness = game:GetService("Lighting").Brightness
            if not _G.FullBrightEnabled then
                repeat
                    wait()
                until _G.FullBrightEnabled
            end
            game:GetService("Lighting").Brightness = 1
        end
    end)

    game:GetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
        if game:GetService("Lighting").ClockTime ~= 12 and game:GetService("Lighting").ClockTime ~= _G.NormalLightingSettings.ClockTime then
            _G.NormalLightingSettings.ClockTime = game:GetService("Lighting").ClockTime
            if not _G.FullBrightEnabled then
                repeat
                    wait()
                until _G.FullBrightEnabled
            end
            game:GetService("Lighting").ClockTime = 12
        end
    end)

    game:GetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
        if game:GetService("Lighting").FogEnd ~= 786543 and game:GetService("Lighting").FogEnd ~= _G.NormalLightingSettings.FogEnd then
            _G.NormalLightingSettings.FogEnd = game:GetService("Lighting").FogEnd
            if not _G.FullBrightEnabled then
                repeat
                    wait()
                until _G.FullBrightEnabled
            end
            game:GetService("Lighting").FogEnd = 786543
        end
    end)

    game:GetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
        if game:GetService("Lighting").GlobalShadows ~= false and game:GetService("Lighting").GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
            _G.NormalLightingSettings.GlobalShadows = game:GetService("Lighting").GlobalShadows
            if not _G.FullBrightEnabled then
                repeat
                    wait()
                until _G.FullBrightEnabled
            end
            game:GetService("Lighting").GlobalShadows = false
        end
    end)

    game:GetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
        if game:GetService("Lighting").Ambient ~= Color3.fromRGB(178, 178, 178) and game:GetService("Lighting").Ambient ~= _G.NormalLightingSettings.Ambient then
            _G.NormalLightingSettings.Ambient = game:GetService("Lighting").Ambient
            if not _G.FullBrightEnabled then
                repeat
                    wait()
                until _G.FullBrightEnabled
            end
            game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
        end
    end)

    game:GetService("Lighting").Brightness = 1
    game:GetService("Lighting").ClockTime = 12
    game:GetService("Lighting").FogEnd = 786543
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)

    local LatestValue = true
    spawn(function()
        repeat
            wait()
        until _G.FullBrightEnabled
        while wait() do
            if _G.FullBrightEnabled ~= LatestValue then
                if not _G.FullBrightEnabled then
                    game:GetService("Lighting").Brightness = _G.NormalLightingSettings.Brightness
                    game:GetService("Lighting").ClockTime = _G.NormalLightingSettings.ClockTime
                    game:GetService("Lighting").FogEnd = _G.NormalLightingSettings.FogEnd
                    game:GetService("Lighting").GlobalShadows = _G.NormalLightingSettings.GlobalShadows
                    game:GetService("Lighting").Ambient = _G.NormalLightingSettings.Ambient
                else
                    game:GetService("Lighting").Brightness = 1
                    game:GetService("Lighting").ClockTime = 12
                    game:GetService("Lighting").FogEnd = 786543
                    game:GetService("Lighting").GlobalShadows = false
                    game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
                end
                LatestValue = not LatestValue
            end
        end
    end)
    end

    _G.FullBrightExecuted = value
    _G.FullBrightEnabled = not _G.FullBrightEnabled
end)

section1:addButton("Anti-Lag", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/TrSGjpvm"))()
end)

section1:addButton("Future Lightning", function()
    spawn(function()
        local g = game
        local w = g.Workspace
        local l = g.Lighting
        local t = w.Terrain
        local sr = Instance.new("SunRaysEffect",l)
        sr.Intensity = 0.075
        sr.Spread = 0.01
        local df = Instance.new("DepthOfFieldEffect",l)
        df.FarIntensity = 0.01
        l.GlobalShadows = true
        l.Brightness = 0.7
        l.ClockTime = 13.5
        l.GeographicLatitude = 45
        l.TimeOfDay = 16
        sethiddenproperty(l,"Technology",4)
        sethiddenproperty(l,"ShadowSoftness",1)
        sethiddenproperty(t,"Decoration",true)
    end)
end)

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

section1:addSlider("Clock Time", Lightning.ClockTime, 0, 23, function(value)
    Lightning.ClockTime = value
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

local section3 = page:addSection("Current Place: ".. placeName)

section3:addButton("Place ID: ".. game.PlaceId, function()
    setclipboard(game.PlaceId)
end)

section3:addButton("Job ID: ".. game.JobId, function()
    setclipboard(game.JobId)
end)

section3:addButton("View Connected Places", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Roiiz/scripts/main/Place%20Viewer"))()
    end)
    redarkGui:Notify("Universal Place Viewer","Left click to teleport, right click to copy the Place ID.")
    CoreGui[Redark].Notification.Decline.Visible = false
    CoreGui[Redark].Notification.Accept:Destroy()
    task.wait(5)
    if CoreGui[Redark].Notification.Text.Text == "Left click to teleport, right click to copy the Place ID." then
        for _, Value in next, getconnections(CoreGui[Redark].Notification.Decline.MouseButton1Click) do
            Value:Fire()
        end
    end
end)

local section4 = page:addSection("GUI")

section4:addToggle("FPS/Ping Disabled", nil, function(value)
    game:GetService("CoreGui")["Redark FPS Ping"].PingAndFpsFrame.Visible = not value
end)

section4:addSlider("FPS/Ping Position", -510, -580, 500, function(value)
    local fpspingpos = value

    game:GetService("CoreGui")["Redark FPS Ping"].PingAndFpsFrame.Position =  UDim2.new(0.5, fpspingpos, 0, -29)
end)

section4:addButton("Restart GUI", function()
    redarkGui:Notify("Restarting GUI...", "Are you sure you want to restart the GUI?", function(accepted)
    if accepted then
        redarkGui:toggle(accepted)
        redarkGui:Notify("Restarting GUI...", "GUI is being restarted..")
        CoreGui[Redark].Notification.Accept:Destroy()
        CoreGui[Redark].Notification.Decline:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Roiiz/scripts/main/Redark"))()
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

local section5 = page:addSection("Webhook")

section5:addTextbox("URL:", "https://discord.com/api/webhooks/", function(value, focusLost)
    if focusLost then
        getgenv().WebhookPlayer = value
    end
end)

section5:addToggle("Notify DNA Amount", nil, function(value)
    getgenv().WebhookNotify = value

    if value then
        task.spawn(function()
            while true do
                if not getgenv().WebhookNotify then break end 

                local playerName = game.Players.LocalPlayer.Name

                local embed1 = {
                    ['title'] = "Player: "..playerName.. " | " .. " DNA Amount: ".. game.Players.LocalPlayer.PlayerGui.StartGui.Background.DinosaurSelection.DNAImage.CurrentDNA.Text,
                    ['description'] = tostring(os.date("``%m/%d/%y | %X``")),
                    ['color'] = 16711680
                }

                local response = http.request({
                    Url = getgenv().WebhookPlayer,
                    Headers = {['Content-Type'] = 'application/json'},
                    Body = game:GetService("HttpService"):JSONEncode({['embeds'] = {embed1}, ['content'] = ''}),
                    Method = "POST"
                })

                task.wait(getgenv().WebhookDelay)
            end
        end)
    end
end)

section5:addTextbox("Delay (Seconds)", "60", function(value, focusLost)
    if focusLost then
        getgenv().WebhookDelay = value
    end
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
buttonImage.Image = "rbxassetid://16944229078" 
buttonImage.Size = UDim2.new(1, 0, 1, 0)
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

local startColor = Color3.new(0, 0, 0)
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
    
    local library = loadstring(game:HttpGet("https://pastebin.com/raw/6mVVnMh8"))()
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
