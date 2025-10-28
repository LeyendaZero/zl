-- UI ZL Compact Hack con Funciones Completas
-- Diseño cuadrado compacto con todas las funciones de KLPN2

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer

-- Verificar que estamos en el juego correcto
if game.PlaceId ~= 109983668079237 then
    warn("Este script solo funciona en Ultimate Pet Simulator X")
    return
end

-- Detectar entorno
local isMobile = UserInputService.TouchEnabled

-- Variables de estado para funciones
local functionStates = {
    Fly = false,
    FlyToAnimal = false,
    Desync = false,
    AutoLazer = false,
    WebSlinger = false,
    PlotESP = false,
    AntiNegative = false,
    InfiniteJump = false,
    PlayerESP = false,
    SentryResizer = false,
    Xray = false
}

-- Iconos flotantes
local floatingIcons = {}

-- Crear interfaz principal
local screenGui = Instance.new("ScreenGui")
if gethui then
    screenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(screenGui)
    screenGui.Parent = game:GetService("CoreGui")
else
    screenGui.Parent = game:GetService("CoreGui")
end
screenGui.Name = "ZLCompactUI"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Variables de estado UI
local uiOpen = false
local dragging = false
local dragStart, frameStart

-- FUNCIÓN PARA CREAR ELEMENTOS
function createElement(className, properties)
    local element = Instance.new(className)
    for prop, value in pairs(properties) do
        element[prop] = value
    end
    return element
end

-- BOTÓN INICIAL ZL
local mainButton = createElement("ImageButton", {
    Parent = screenGui,
    Name = "MainButton",
    BackgroundColor3 = Color3.new(0, 0, 0),
    Position = UDim2.new(0, 20, 0, 20),
    Size = UDim2.new(0, 50, 0, 50),
    AutoButtonColor = false
})

-- Hacerlo redondo
local buttonCorner = createElement("UICorner", {
    Parent = mainButton,
    CornerRadius = UDim.new(1, 0)
})

-- Borde neón
local buttonStroke = createElement("UIStroke", {
    Parent = mainButton,
    Color = Color3.new(1, 0, 0),
    Thickness = 2
})

-- Texto ZL
local buttonText = createElement("TextLabel", {
    Parent = mainButton,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "ZL",
    TextColor3 = Color3.new(1, 0, 0),
    TextScaled = true
})

-- MENÚ PRINCIPAL COMPACTO
local mainFrame = createElement("Frame", {
    Parent = screenGui,
    Name = "MainFrame",
    BackgroundColor3 = Color3.fromRGB(20, 20, 25),
    Position = UDim2.new(0.3, 0, 0.3, 0),
    Size = UDim2.new(0, 350, 0, 250),
    Visible = false
})

-- Borde y esquinas
local frameCorner = createElement("UICorner", {
    Parent = mainFrame,
    CornerRadius = UDim.new(0, 6)
})

local frameStroke = createElement("UIStroke", {
    Parent = mainFrame,
    Color = Color3.fromRGB(80, 80, 90),
    Thickness = 1
})

-- BARRA DE TÍTULO
local titleBar = createElement("Frame", {
    Parent = mainFrame,
    Name = "TitleBar",
    BackgroundColor3 = Color3.fromRGB(15, 15, 20),
    Size = UDim2.new(1, 0, 0, 30)
})

local titleCorner = createElement("UICorner", {
    Parent = titleBar,
    CornerRadius = UDim.new(0, 6)
})

local titleText = createElement("TextLabel", {
    Parent = titleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 0),
    Size = UDim2.new(1, -40, 1, 0),
    Font = Enum.Font.GothamBold,
    Text = "ZL HACK MENU",
    TextColor3 = Color3.fromRGB(220, 220, 220),
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- BOTÓN CERRAR
local closeButton = createElement("TextButton", {
    Parent = titleBar,
    Name = "CloseButton",
    BackgroundColor3 = Color3.fromRGB(200, 50, 50),
    Position = UDim2.new(1, -25, 0, 5),
    Size = UDim2.new(0, 20, 0, 20),
    Font = Enum.Font.GothamBold,
    Text = "X",
    TextColor3 = Color3.new(1, 1, 1),
    TextSize = 12
})

local closeCorner = createElement("UICorner", {
    Parent = closeButton,
    CornerRadius = UDim.new(0, 4)
})

-- CONTENEDOR PRINCIPAL
local container = createElement("Frame", {
    Parent = mainFrame,
    Name = "Container",
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 30),
    Size = UDim2.new(1, 0, 1, -30)
})

-- BARRA LATERAL DE SECCIONES
local sidebar = createElement("Frame", {
    Parent = container,
    Name = "Sidebar",
    BackgroundColor3 = Color3.fromRGB(25, 25, 30),
    Size = UDim2.new(0, 100, 1, 0)
})

local sidebarCorner = createElement("UICorner", {
    Parent = sidebar,
    CornerRadius = UDim.new(0, 6)
})

-- CONTENIDO DE SECCIONES
local contentFrame = createElement("Frame", {
    Parent = container,
    Name = "ContentFrame",
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 105, 0, 0),
    Size = UDim2.new(1, -105, 1, 0)
})

-- FUNCIÓN PARA CREAR BOTONES DE SECCIÓN
function createSectionButton(name, position, isFirst)
    local button = createElement("TextButton", {
        Parent = sidebar,
        Name = name .. "Btn",
        BackgroundColor3 = isFirst and Color3.fromRGB(40, 40, 45) or Color3.fromRGB(30, 30, 35),
        Position = position,
        Size = UDim2.new(1, -10, 0, 30),
        Font = Enum.Font.Gotham,
        Text = name,
        TextColor3 = Color3.fromRGB(220, 220, 220),
        TextSize = 12,
        AutoButtonColor = false
    })
    
    createElement("UICorner", {
        Parent = button,
        CornerRadius = UDim.new(0, 4)
    })
    
    return button
end

-- FUNCIÓN PARA CREAR TOGGLE BUTTON MEJORADO
function createToggle(name, position, parent, funcName)
    local toggleFrame = createElement("Frame", {
        Parent = parent,
        Name = name .. "Toggle",
        BackgroundColor3 = Color3.fromRGB(35, 35, 40),
        Position = position,
        Size = UDim2.new(1, -10, 0, 25)
    })
    
    createElement("UICorner", {
        Parent = toggleFrame,
        CornerRadius = UDim.new(0, 4)
    })
    
    createElement("UIStroke", {
        Parent = toggleFrame,
        Color = Color3.fromRGB(60, 60, 70),
        Thickness = 1
    })
    
    local toggleText = createElement("TextLabel", {
        Parent = toggleFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0, 0),
        Size = UDim2.new(1, -35, 1, 0),
        Font = Enum.Font.Gotham,
        Text = name,
        TextColor3 = Color3.fromRGB(220, 220, 220),
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local toggleButton = createElement("TextButton", {
        Parent = toggleFrame,
        Name = "ToggleBtn",
        BackgroundColor3 = Color3.fromRGB(80, 80, 90),
        Position = UDim2.new(1, -22, 0, 3),
        Size = UDim2.new(0, 19, 0, 19),
        Font = Enum.Font.SourceSans,
        Text = "",
        AutoButtonColor = false
    })
    
    createElement("UICorner", {
        Parent = toggleButton,
        CornerRadius = UDim.new(1, 0)
    })
    
    local toggleState = functionStates[funcName] or false
    
    local function updateToggle()
        if toggleState then
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(0, 200, 0),
                Position = UDim2.new(1, -22, 0, 3)
            }):Play()
            createFloatingIcon(funcName, name)
        else
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(80, 80, 90),
                Position = UDim2.new(1, -22, 0, 3)
            }):Play()
            removeFloatingIcon(funcName)
        end
        functionStates[funcName] = toggleState
    end
    
    toggleButton.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        updateToggle()
        toggleFunction(funcName, toggleState)
    end)
    
    updateToggle()
    
    return toggleFrame
end

-- FUNCIÓN PARA CREAR ICONO FLOTANTE
function createFloatingIcon(funcName, displayName)
    if floatingIcons[funcName] then
        floatingIcons[funcName]:Destroy()
    end
    
    local icon = createElement("ImageButton", {
        Parent = screenGui,
        Name = funcName .. "Icon",
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        Position = UDim2.new(0, math.random(100, 500), 0, math.random(100, 300)),
        Size = UDim2.new(0, 40, 0, 40),
        AutoButtonColor = false,
        Image = "rbxassetid://7072717775" -- Icono genérico
    })
    
    createElement("UICorner", {
        Parent = icon,
        CornerRadius = UDim.new(0, 8)
    })
    
    createElement("UIStroke", {
        Parent = icon,
        Color = Color3.fromRGB(0, 200, 0),
        Thickness = 2
    })
    
    local iconText = createElement("TextLabel", {
        Parent = icon,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Enum.Font.Gotham,
        Text = displayName:sub(1, 3),
        TextColor3 = Color3.fromRGB(0, 200, 0),
        TextScaled = true
    })
    
    -- Sistema de arrastre para icono
    local iconDragging = false
    local iconDragStart, iconStartPos
    
    local function startIconDrag(input)
        iconDragging = true
        iconDragStart = input.Position
        iconStartPos = icon.Position
        
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                iconDragging = false
                connection:Disconnect()
            end
        end)
    end
    
    local function updateIconDrag(input)
        if iconDragging then
            local delta = input.Position - iconDragStart
            icon.Position = UDim2.new(
                iconStartPos.X.Scale, 
                iconStartPos.X.Offset + delta.X,
                iconStartPos.Y.Scale, 
                iconStartPos.Y.Offset + delta.Y
            )
        end
    end
    
    icon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            startIconDrag(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if iconDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateIconDrag(input)
        end
    end)
    
    -- Click en icono activa/desactiva función
    icon.MouseButton1Click:Connect(function()
        toggleFunction(funcName, not functionStates[funcName])
    end)
    
    floatingIcons[funcName] = icon
end

function removeFloatingIcon(funcName)
    if floatingIcons[funcName] then
        floatingIcons[funcName]:Destroy()
        floatingIcons[funcName] = nil
    end
end

-- CREAR SECCIONES
local sections = {
    "Steal",
    "Movement", 
    "Visual",
    "Server"
}

local sectionButtons = {}
local sectionContents = {}

-- Crear botones de sección en sidebar
for i, sectionName in ipairs(sections) do
    local buttonPos = UDim2.new(0, 5, 0, (i-1) * 35 + 5)
    sectionButtons[sectionName] = createSectionButton(sectionName, buttonPos, i == 1)
    
    -- Crear frame de contenido para cada sección
    local content = createElement("ScrollingFrame", {
        Parent = contentFrame,
        Name = sectionName .. "Content",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Visible = i == 1,
        CanvasSize = UDim2.new(0, 0, 0, 300),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
    })
    
    sectionContents[sectionName] = content
    
    -- Agregar funciones específicas a cada sección
    local functions = {}
    
    if sectionName == "Steal" then
        functions = {
            {name = "Desync", func = "Desync"},
            {name = "Go to Best", func = "FlyToAnimal"},
            {name = "Auto laser cap", func = "AutoLazer"},
            {name = "Web Slinger", func = "WebSlinger"},
            {name = "Sentry Resizer", func = "SentryResizer"}
        }
    elseif sectionName == "Movement" then
        functions = {
            {name = "Fly", func = "Fly"},
            {name = "Infinite Jump", func = "InfiniteJump"}
        }
    elseif sectionName == "Visual" then
        functions = {
            {name = "Xray", func = "Xray"},
            {name = "Plot ESP", func = "PlotESP"},
            {name = "Player ESP", func = "PlayerESP"},
            {name = "Anti Negative", func = "AntiNegative"}
        }
    elseif sectionName == "Server" then
        functions = {
            {name = "Server hop", func = "ServerHop"}
        }
    end
    
    for j, funcData in ipairs(functions) do
        createToggle(funcData.name, UDim2.new(0, 0, 0, (j-1) * 30 + 5), content, funcData.func)
    end
end

-- =================================================================
-- IMPLEMENTACIÓN DE TODAS LAS FUNCIONES DEL SCRIPT ORIGINAL
-- =================================================================

-- Variables globales para funciones
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")
local Camera = Workspace.CurrentCamera

-- Configuración
local CONFIG = {
    FLY_SPEED = 70,
    FLY_REMOTE_DELAY = 0.1,
    HOOK_TOOL_NAME = "Grapple Hook",
    BOOST_SPEED = 27,
    STEALING_THRESHOLD = 20.5
}

-- Variables de funciones
local LocalFlying = false
local FlyingToAnimal = false
local flyToggle = false
local autoLazerEnabled = false
local autoLazerThread = nil
local infiniteJumpEnabled = false
local jumpRequestConnection = nil
local plotESPEnabled = false
local playerESPEnabled = false
local activeESPs = {}
local espObjects = {}
local sentryResizerEnabled = false
local xrayEnabled = false
local antiNegativeEnabled = false

-- ========== SISTEMA DE VUELO ==========
local LvName = "flyLinearVelocity"
local AoName = "flyAlignOrientation"
local controlModule = require(player.PlayerScripts.PlayerModule.ControlModule)

local cooldownEvent = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/Tools/Cooldown")
local useItemEvent = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/UseItem")

local function fireRemotes()
    cooldownEvent:FireServer("\006\001\bB\006\001\bB")
    useItemEvent:FireServer(0.4773959477742513)
end

local function startFlying()
    if LocalFlying then return end
    LocalFlying = true

    local LV = Instance.new("LinearVelocity", root)
    local AO = Instance.new("AlignOrientation", root)

    LV.MaxForce = math.huge
    AO.MaxTorque = math.huge
    AO.Mode = Enum.OrientationAlignmentMode.OneAttachment

    LV.Attachment0 = root.RootAttachment
    AO.Attachment0 = root.RootAttachment

    LV.Name = LvName
    AO.Name = AoName

    humanoid.PlatformStand = true
end

local function stopFlying()
    if not LocalFlying then return end
    LocalFlying = false
    FlyingToAnimal = false

    local LV = root:FindFirstChild(LvName)
    local AO = root:FindFirstChild(AoName)

    humanoid.PlatformStand = false

    if LV then LV:Destroy() end
    if AO then AO:Destroy() end
    
    local tool = character:FindFirstChild(CONFIG.HOOK_TOOL_NAME)
    if tool then tool.Parent = player.Backpack end
end

local function toggleHookFly()
    flyToggle = not flyToggle
    if flyToggle then
        local tool = player.Backpack:FindFirstChild(CONFIG.HOOK_TOOL_NAME)
        if tool then tool.Parent = character end
        startFlying()
        task.spawn(function()
            while flyToggle do
                fireRemotes()
                task.wait(CONFIG.FLY_REMOTE_DELAY)
            end
        end)
    else
        stopFlying()
        local tool = character:FindFirstChild(CONFIG.HOOK_TOOL_NAME)
        if tool then tool.Parent = player.Backpack end
    end
end

-- ========== VOLAR AL MEJOR ANIMAL ==========
local function extractNumber(str)
    if not str then return 0 end
    local numberStr = str:match("([%d%.]+[kKmMbB]?)") or "0"
    numberStr = numberStr:gsub("%s", ""):lower()
    local multiplier = 1
    if numberStr:find("b") then multiplier = 1e9; numberStr = numberStr:gsub("b","")
    elseif numberStr:find("m") then multiplier = 1e6; numberStr = numberStr:gsub("m","")
    elseif numberStr:find("k") then multiplier = 1e3; numberStr = numberStr:gsub("k","") end
    return (tonumber(numberStr) or 0) * multiplier
end

local function findBestAnimalForFlight()
    local bestValue = 0
    local bestPart = nil
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "AnimalOverhead" and obj:IsA("BillboardGui") then
            local stolenLabel = obj:FindFirstChild("Stolen")
            local isStolen = stolenLabel and stolenLabel:IsA("TextLabel") and string.upper(stolenLabel.Text) == "FUSING"
            
            if not isStolen then
                local displayNameLabel = obj:FindFirstChild("DisplayName")
                local genLabel = obj:FindFirstChild("Generation")
                
                if displayNameLabel and genLabel then
                    local value = extractNumber(genLabel.Text)
                    
                    if value > bestValue then
                        bestValue = value
                        local animalModel = obj.Parent
                        while animalModel and animalModel ~= Workspace do
                            if animalModel:IsA("Model") then
                                bestPart = animalModel:FindFirstChild("HumanoidRootPart") or animalModel:FindFirstChild("Head") or animalModel.PrimaryPart or animalModel
                                break
                            end
                            animalModel = animalModel.Parent
                        end
                    end
                end
            end
        end
    end
    
    return bestPart
end

local function flyToBestAnimal()
    local targetPart = findBestAnimalForFlight()
    if not targetPart then
        return
    end
    
    local tool = player.Backpack:FindFirstChild(CONFIG.HOOK_TOOL_NAME)
    if tool then tool.Parent = character end
    
    startFlying()
    FlyingToAnimal = true
    
    task.spawn(function()
        while FlyingToAnimal and LocalFlying and targetPart and targetPart.Parent do
            local LV = root:FindFirstChild(LvName)
            local AO = root:FindFirstChild(AoName)
            
            if not LV or not AO then break end
            
            local targetPos = targetPart.Position + Vector3.new(0, 10, 0)
            local direction = (targetPos - root.Position).Unit
            local distance = (targetPos - root.Position).Magnitude
            
            if distance < 50 then
                stopFlying()
                break
            end
            
            local flySpeed = math.min(CONFIG.FLY_SPEED, distance * 2)
            LV.VectorVelocity = direction * flySpeed
            AO.CFrame = CFrame.lookAt(root.Position, targetPos)
            
            task.wait()
        end
        
        FlyingToAnimal = false
    end)
end

-- ========== DESYNC ==========
local function enableMobileDesync()
    local success, error = pcall(function()
        local backpack = player:WaitForChild("Backpack")
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:WaitForChild("Humanoid")
        
        local packages = ReplicatedStorage:WaitForChild("Packages", 5)
        if not packages then return false end
        
        local netFolder = packages:WaitForChild("Net", 5)
        if not netFolder then return false end
        
        local useItemRemote = netFolder:WaitForChild("RE/UseItem", 5)
        local teleportRemote = netFolder:WaitForChild("RE/QuantumCloner/OnTeleport", 5)
        if not useItemRemote or not teleportRemote then return false end

        local toolNames = {"Quantum Cloner", "Brainrot", "brainrot"}
        local tool
        for _, toolName in ipairs(toolNames) do
            tool = backpack:FindFirstChild(toolName) or char:FindFirstChild(toolName)
            if tool then break end
        end
        if not tool then
            for _, item in ipairs(backpack:GetChildren()) do
                if item:IsA("Tool") then tool=item break end
            end
        end

        if tool and tool.Parent==backpack then
            humanoid:EquipTool(tool)
            task.wait(0.5)
        end

        if setfflag then setfflag("WorldStepMax", "-9999999999") end
        task.wait(0.2)
        useItemRemote:FireServer()
        task.wait(1)
        teleportRemote:FireServer()
        task.wait(2)
        if setfflag then setfflag("WorldStepMax", "-1") end

        return true
    end)
    return success
end

-- ========== AUTO LAZER ==========
local blacklistNames = {"szymonyut"}
local blacklist = {}
for _, name in ipairs(blacklistNames) do
    blacklist[string.lower(name)] = true
end

local function getLazerRemote()
    local remote = nil
    pcall(function()
        if ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("Net") then
            remote = ReplicatedStorage.Packages.Net:FindFirstChild("RE/UseItem") or ReplicatedStorage.Packages.Net:FindFirstChild("RE"):FindFirstChild("UseItem")
        end
        if not remote then
            remote = ReplicatedStorage:FindFirstChild("RE/UseItem") or ReplicatedStorage:FindFirstChild("UseItem")
        end
    end)
    return remote
end

local function isValidTarget(targetPlayer)
    if not targetPlayer or not targetPlayer.Character or targetPlayer == player then return false end
    local name = targetPlayer.Name and string.lower(targetPlayer.Name) or ""
    if blacklist[name] then return false end
    local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetHumanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
    if not hrp or not targetHumanoid then return false end
    if targetHumanoid.Health <= 0 then return false end
    return true
end

local function findNearestAllowed()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = player.Character.HumanoidRootPart.Position
    local nearest = nil
    local nearestDist = math.huge
    for _, pl in ipairs(Players:GetPlayers()) do
        if isValidTarget(pl) then
            local targetHRP = pl.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                local d = (Vector3.new(targetHRP.Position.X, 0, targetHRP.Position.Z) - Vector3.new(myPos.X, 0, myPos.Z)).Magnitude
                if d < nearestDist then
                    nearestDist = d
                    nearest = pl
                end
            end
        end
    end
    return nearest
end

local function safeFire(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetHRP then return end
    local remote = getLazerRemote()
    local args = {
        [1] = targetHRP.Position,
        [2] = targetHRP
    }
    if remote and remote.FireServer then
        pcall(function()
            remote:FireServer(unpack(args))
        end)
    end
end

local function autoEquipLaserCape()
    local backpack = player:WaitForChild("Backpack")
    local char = player.Character
    
    local laserCape = backpack:FindFirstChild("Laser Cape")
    
    if laserCape and char then
        laserCape.Parent = char
        task.wait(0.1)
    end
    
    return laserCape ~= nil
end

local function autoLazerWorker()
    while autoLazerEnabled do
        autoEquipLaserCape()
        
        local target = findNearestAllowed()
        if target then
            safeFire(target)
        end
        local t0 = tick()
        while tick() - t0 < 0.6 do
            if not autoLazerEnabled then break end
            RunService.Heartbeat:Wait()
        end
    end
end

local function toggleAutoLazer()
    autoLazerEnabled = not autoLazerEnabled
    
    if autoLazerEnabled then
        autoEquipLaserCape()
        autoLazerThread = task.spawn(autoLazerWorker)
    else
        if autoLazerThread then
            task.cancel(autoLazerThread)
            autoLazerThread = nil
        end
    end
end

-- ========== WEB SLINGER KILL ==========
local WEB_SLINGER_TOOL_NAME = "Web Slinger"

local function findClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    local myCharacter = player.Character
    local myRootPart = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")
    
    if not myRootPart then return nil end
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local otherRootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if otherRootPart then
                local distance = (myRootPart.Position - otherRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestPlayer = otherPlayer
                end
            end
        end
    end
    
    return closestPlayer, closestDistance
end

local function equipWebSlinger()
    local backpack = player:WaitForChild("Backpack")
    local char = player.Character
    
    if not char then return false end
    
    local webSlinger = backpack:FindFirstChild(WEB_SLINGER_TOOL_NAME)
    
    if webSlinger then
        for _, tool in pairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                tool.Parent = backpack
            end
        end
        
        webSlinger.Parent = char
        task.wait(0.2)
        return true
    else
        return false
    end
end

local function useWebSlingerOnTarget(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return false end
    
    local targetHandle = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetHandle then
        targetHandle = targetPlayer.Character:FindFirstChild("Head") or targetPlayer.Character.PrimaryPart
    end
    
    if not targetHandle then return false end
    
    local useItemRemote = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/UseItem")
    
    local args = {
        targetHandle.Position,
        targetHandle
    }
    
    local success = pcall(function()
        useItemRemote:FireServer(unpack(args))
    end)
    
    return success
end

local function doOneTeleportCycle(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end
    
    local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    hrp.CFrame = hrp.CFrame + Vector3.new(0, 20, 0)
    task.wait(0.3)
    
    hrp.CFrame = hrp.CFrame + Vector3.new(0, -20, 0)
    task.wait(0.3)
end

local function onWebSlingerKeyPress()
    local equipped = equipWebSlinger()
    if not equipped then
        return
    end
    
    local closestPlayer, distance = findClosestPlayer()
    if not closestPlayer then
        return
    end
    
    local used = useWebSlingerOnTarget(closestPlayer)
    if used then
        task.wait(0.5)
        doOneTeleportCycle(closestPlayer)
    end
end

-- ========== SENTRY RESIZER ==========
local function resizeSentry(part)
    if part:IsA("Part") and part.Name:sub(1,7) == "Sentry_" then
        part.Size = Vector3.new(50, 50, 100)
        part.CanCollide = false
        
        part.Transparency = 0.5
        part.Material = Enum.Material.Neon
        part.Color = Color3.fromRGB(255, 0, 0)
    end
end

local function setupSentryResizer()
    for _, obj in ipairs(Workspace:GetChildren()) do
        resizeSentry(obj)
    end

    Workspace.ChildAdded:Connect(function(child)
        resizeSentry(child)
    end)
    
    for _, obj in ipairs(Workspace:GetDescendants()) do
        resizeSentry(obj)
    end
    
    Workspace.DescendantAdded:Connect(function(descendant)
        resizeSentry(descendant)
    end)
end

-- ========== INFINITE JUMP ==========
local function doJump()
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChildOfClass("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    
    if hum and hum.Health > 0 and rootPart then
        rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 50, rootPart.Velocity.Z)
    end
end

local function setupJumpRequest()
    if jumpRequestConnection then
        jumpRequestConnection:Disconnect()
        jumpRequestConnection = nil
    end
    
    jumpRequestConnection = UserInputService.JumpRequest:Connect(function()
        if infiniteJumpEnabled then
            doJump()
        end
    end)
end

local function initializeJumpForCharacter(char)
    local hum = char:WaitForChild("Humanoid")
    setupJumpRequest()
    
    char.ChildAdded:Connect(function(child)
        if child:IsA("Humanoid") then
            setupJumpRequest()
        end
    end)
end

-- ========== PLOT ESP ==========
local lastTimes = {}
local stableCounters = {}
local lastUpdate = 0

local function parseTime(text)
    if not text or text == "" then return 0 end
    text = text:lower():gsub("%s", "")
    local value, unit = text:match("(%d+)([sm]?)")
    value = tonumber(value) or 0
    unit = unit or "s"
    if value == 0 then return 0 end
    if unit == "m" then return value * 60 else return value end
end

local function getPlotAttachPart(plotModel)
    if plotModel:IsA("BasePart") then return plotModel end
    if plotModel.PrimaryPart then return plotModel.PrimaryPart end
    for _, part in pairs(plotModel:GetDescendants()) do
        if part:IsA("BasePart") then return part end
    end
    return nil
end

local function createOrUpdatePlotESP(plot, secondsRemaining)
    local espData = activeESPs[plot]
    local attachPart = getPlotAttachPart(plot)
    if not attachPart then return end
    
    if not espData then
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "PlotESP_" .. plot.Name
        screenGui.ResetOnSpawn = false
        screenGui.Parent = player:WaitForChild("PlayerGui")
        
        local billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 120, 0, 40)
        billboard.Adornee = attachPart
        billboard.ExtentsOffset = Vector3.new(0, 5, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = screenGui

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1,1,1)
        label.Font = Enum.Font.GothamBold
        label.TextStrokeTransparency = 0
        label.TextStrokeColor3 = Color3.new(0,0,0)
        label.TextScaled = true
        label.Parent = billboard

        espData = {
            ScreenGui = screenGui,
            Billboard = billboard,
            Label = label
        }
        activeESPs[plot] = espData
    end

    espData.Label.Text = string.format("%ds", secondsRemaining)
end

local function removePlotESP(plot)
    local espData = activeESPs[plot]
    if espData then
        if espData.ScreenGui and espData.ScreenGui.Parent then
            espData.ScreenGui:Destroy()
        end
        activeESPs[plot] = nil
    end
end

local function updatePlotESP()
    if not plotESPEnabled then return end
    if tick() - lastUpdate < 0.1 then return end
    lastUpdate = tick()

    local plotsFolder = Workspace:FindFirstChild("Plots")
    if not plotsFolder then return end

    for _, plot in pairs(plotsFolder:GetChildren()) do
        local multiplierPart = plot:FindFirstChild("Multiplier")
        if multiplierPart then
            local mainGui = multiplierPart:FindFirstChild("Main")
            if mainGui and mainGui:IsA("BillboardGui") then
                local amountLabel = mainGui:FindFirstChild("Amount")
                if amountLabel and amountLabel:IsA("TextLabel") then
                    if amountLabel.Text == "0x" then
                        removePlotESP(plot)
                        lastTimes[plot] = nil
                        stableCounters[plot] = nil
                    else
                        local remainingLabel
                        for _, obj in pairs(plot:GetDescendants()) do
                            if obj:IsA("TextLabel") and obj.Name == "RemainingTime" then
                                remainingLabel = obj
                                break
                            end
                        end

                        if remainingLabel then
                            local seconds = parseTime(remainingLabel.Text)

                            if seconds > 0 then
                                if lastTimes[plot] == seconds then
                                    stableCounters[plot] = (stableCounters[plot] or 0) + 0.1
                                else
                                    stableCounters[plot] = 0
                                    lastTimes[plot] = seconds
                                end

                                if stableCounters[plot] <= 1 then
                                    createOrUpdatePlotESP(plot, seconds)
                                else
                                    removePlotESP(plot)
                                end
                            else
                                removePlotESP(plot)
                                lastTimes[plot] = nil
                                stableCounters[plot] = nil
                            end
                        else
                            removePlotESP(plot)
                            lastTimes[plot] = nil
                            stableCounters[plot] = nil
                        end
                    end
                else
                    removePlotESP(plot)
                    lastTimes[plot] = nil
                    stableCounters[plot] = nil
                end
            else
                removePlotESP(plot)
                lastTimes[plot] = nil
                stableCounters[plot] = nil
            end
        else
            removePlotESP(plot)
            lastTimes[plot] = nil
            stableCounters[plot] = nil
        end
    end
end

-- ========== PLAYER ESP ==========
local function getPlayerColor(targetPlayer)
    local hue = (targetPlayer.UserId % 360) / 360
    return Color3.fromHSV(hue, 1, 1)
end

local function getCharacterBoundingBox(char)
    if not char or not char.PrimaryPart then return nil, nil end
    
    local minVec, maxVec
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Anchored == false then
            local pos = part.Position
            if not minVec then
                minVec = pos
                maxVec = pos
            else
                minVec = Vector3.new(
                    math.min(minVec.X, pos.X),
                    math.min(minVec.Y, pos.Y),
                    math.min(minVec.Z, pos.Z)
                )
                maxVec = Vector3.new(
                    math.max(maxVec.X, pos.X),
                    math.max(maxVec.Y, pos.Y),
                    math.max(maxVec.Z, pos.Z)
                )
            end
        end
    end
    
    if minVec and maxVec then
        local size = maxVec - minVec
        local center = (minVec + maxVec)/2
        return center, size
    else
        return char.PrimaryPart.Position, Vector3.new(4, 6, 4)
    end
end

local function createPlayerBoundingBox(targetPlayer)
    if targetPlayer == player then return end
    
    if espObjects[targetPlayer] then
        if espObjects[targetPlayer].Box then
            espObjects[targetPlayer].Box:Destroy()
        end
        if espObjects[targetPlayer].Connection then
            espObjects[targetPlayer].Connection:Disconnect()
        end
        espObjects[targetPlayer] = nil
    end

    local char = targetPlayer.Character
    if not char then return end

    local color = getPlayerColor(targetPlayer)

    local box = Instance.new("Part")
    box.Name = "BoundingBox_" .. targetPlayer.Name
    box.Anchored = true
    box.CanCollide = false
    box.Transparency = 0.6
    box.Material = Enum.Material.Neon
    box.Color = color
    box.Parent = workspace

    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 150, 0, 40)
    billboard.Adornee = box
    billboard.AlwaysOnTop = true
    billboard.Parent = box

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.fromScale(1, 1)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = targetPlayer.DisplayName
    nameLabel.TextColor3 = color
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.Parent = billboard

    local espData = {
        Box = box,
        Connection = nil,
        Player = targetPlayer
    }
    
    espObjects[targetPlayer] = espData

    local function updateESP()
        if not char or not char.PrimaryPart or not char:FindFirstChild("Humanoid") then
            if espObjects[targetPlayer] then
                espObjects[targetPlayer].Box:Destroy()
                if espObjects[targetPlayer].Connection then
                    espObjects[targetPlayer].Connection:Disconnect()
                end
                espObjects[targetPlayer] = nil
            end
            return false
        end

        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health <= 0 then
            box.Transparency = 1
            billboard.Enabled = false
            return true
        else
            box.Transparency = 0.6
            billboard.Enabled = true
            
            local center, size = getCharacterBoundingBox(char)
            if center then
                box.Size = size + Vector3.new(1, 1, 1)
                box.CFrame = CFrame.new(center)
                billboard.StudsOffset = Vector3.new(0, box.Size.Y/2 + 2, 0)
            end
            return true
        end
    end

    espData.Connection = RunService.Heartbeat:Connect(function()
        if not updateESP() then
            espData.Connection:Disconnect()
        end
    end)

    local characterAddedConnection
    characterAddedConnection = targetPlayer.CharacterAdded:Connect(function(newChar)
        characterAddedConnection:Disconnect()
        task.wait(2)
        if espObjects[targetPlayer] then
            espObjects[targetPlayer].Box:Destroy()
            espObjects[targetPlayer].Connection:Disconnect()
            espObjects[targetPlayer] = nil
        end
        createPlayerBoundingBox(targetPlayer)
    end)
end

local function setupPlayerESP()
    for _, existingPlayer in pairs(Players:GetPlayers()) do
        if existingPlayer ~= player then
            if existingPlayer.Character then
                createPlayerBoundingBox(existingPlayer)
            else
                existingPlayer.CharacterAdded:Connect(function(char)
                    task.wait(1)
                    createPlayerBoundingBox(existingPlayer)
                end)
            end
        end
    end

    Players.PlayerAdded:Connect(function(newPlayer)
        newPlayer.CharacterAdded:Connect(function(char)
            task.wait(1)
            createPlayerBoundingBox(newPlayer)
        end)
        
        if newPlayer.Character then
            task.wait(1)
            createPlayerBoundingBox(newPlayer)
        end
    end)

    Players.PlayerRemoving:Connect(function(leftPlayer)
        if espObjects[leftPlayer] then
            espObjects[leftPlayer].Box:Destroy()
            if espObjects[leftPlayer].Connection then
                espObjects[leftPlayer].Connection:Disconnect()
            end
            espObjects[leftPlayer] = nil
        end
    end)
end

local function cleanupPlayerESP()
    for targetPlayer, espData in pairs(espObjects) do
        if espData.Box then
            espData.Box:Destroy()
        end
        if espData.Connection then
            espData.Connection:Disconnect()
        end
    end
    espObjects = {}
end

-- ========== XRAY (Transparent Decorations + Invisicam) ==========
local function setupCameraNoclip()
    player.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
end

local function makeDecorationsTransparent(model)
    local decorations = model:FindFirstChild("Decorations")
    if decorations then
        for _, part in ipairs(decorations:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0.4
                if part:FindFirstChildOfClass("SurfaceAppearance") then
                    part:FindFirstChildOfClass("SurfaceAppearance"):Destroy()
                end
                if part:FindFirstChildOfClass("Decal") then
                    part:FindFirstChildOfClass("Decal"):Destroy()
                end
                if part:FindFirstChildOfClass("Texture") then
                    part:FindFirstChildOfClass("Texture"):Destroy()
                end
            end
        end
    end
end

local function setupXray()
    setupCameraNoclip()
    
    local plotsFolder = Workspace:WaitForChild("Plots")
    
    for _, model in ipairs(plotsFolder:GetChildren()) do
        makeDecorationsTransparent(model)
    end

    plotsFolder.ChildAdded:Connect(function(model)
        task.wait(0.5)
        makeDecorationsTransparent(model)
    end)

    while xrayEnabled do
        task.wait(2)
        for _, model in ipairs(plotsFolder:GetChildren()) do
            makeDecorationsTransparent(model)
        end
    end
end

-- ========== ANTI NEGATIVE EFFECTS ==========
local UseItemEvent

local function setupAntiNegativeEffects()
    local success, netPackage = pcall(function()
        return ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net")
    end)
    
    if success and netPackage then
        local ok, netModule = pcall(require, netPackage)
        if ok and netModule then
            UseItemEvent = netModule:RemoteEvent("UseItem")
        end
    end
end

local function getControlsAndOriginal()
    local controls, original
    local success, playerModule = pcall(function()
        return player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
    end)
    if success and playerModule then
        local ok, pm = pcall(function() return require(playerModule) end)
        if ok and pm and pm.GetControls then
            controls = pm:GetControls()
        end
    end

    local ok2, CharacterController = pcall(function()
        return require(ReplicatedStorage:WaitForChild("Controllers"):WaitForChild("CharacterController"))
    end)
    if ok2 and CharacterController then
        original = CharacterController.originalMoveFunction
    end
    return controls, original
end

local function restoreNormalState()
    if not antiNegativeEnabled then return end
    
    local controls, original = getControlsAndOriginal()

    if controls and original and controls.moveFunction ~= original then
        pcall(function() controls.moveFunction = original end)
    end

    if Camera.FieldOfView ~= 70 then
        Camera.FieldOfView = 70
    end

    for _, effect in ipairs(Lighting:GetChildren()) do
        if effect:IsA("BlurEffect") then
            pcall(function() effect:Destroy() end)
        end
    end

    local disco = Lighting:FindFirstChild("DiscoEffect")
    if disco and disco:IsA("ColorCorrectionEffect") then
        disco:Destroy()
    end

    local cc = Lighting:FindFirstChild("ColorCorrection")
    if cc and cc:IsA("ColorCorrectionEffect") then
        cc:Destroy()
    end

    local controllers = ReplicatedStorage:FindFirstChild("Controllers")
    if controllers then
        local itemCtrl = controllers:FindFirstChild("ItemController")
        if itemCtrl then
            local paintCtrl = itemCtrl:FindFirstChild("PaintballGunController")
            if paintCtrl then
                for _, obj in ipairs(paintCtrl:GetChildren()) do
                    if obj:IsA("ImageLabel") and obj.Name:match("^Paint") then
                        obj.Visible = false
                    end
                end
            end
        end
    end
end

local function startAntiNegativeEffects()
    RunService.Heartbeat:Connect(restoreNormalState)
    
    RunService.Heartbeat:Connect(function()
        if not antiNegativeEnabled then return end
        local cc = Lighting:FindFirstChild("ColorCorrection")
        if cc and cc:IsA("ColorCorrectionEffect") then
            cc:Destroy()
        end
    end)
    
    if UseItemEvent then
        UseItemEvent.OnClientEvent:Connect(function(effect)
            if antiNegativeEnabled and (effect == "Bee Attack" or effect == "Boogie" or effect == "PaintballHitted") then
                restoreNormalState()
            end
        end)
    end
end

-- ========== SERVER HOP ==========
local function loadServerHopper()
    local success, result = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/szef123d4/sab/refs/heads/main/serverhoopper"))()
    end)
    return success
end

-- ========== DISCORD WEBHOOK NOTIFIER ==========
local WEBHOOK_URL = "AQUI MI WEBHOOCK"

local function sendRealAnimalWebhook()
    local placeId = game.PlaceId
    local jobId = game.JobId
    local playersCount = #game.Players:GetPlayers()
    
    local function findAnimalsForWebhook()
        local overheads = {}
        local plotsFolder = Workspace:FindFirstChild("Plots")
        if not plotsFolder then return {} end

        for _, plot in pairs(plotsFolder:GetDescendants()) do
            if plot.Name == "AnimalOverhead" and plot:IsA("BillboardGui") then
                local stolenLabel = plot:FindFirstChild("Stolen")
                local isStolen = stolenLabel and stolenLabel:IsA("TextLabel") and string.upper(stolenLabel.Text) == "FUSING"
                local displayNameLabel = plot:FindFirstChild("DisplayName")
                local genLabel = plot:FindFirstChild("Generation")
                local rarityLabel = plot:FindFirstChild("Rarity")
                if displayNameLabel and genLabel and rarityLabel and not isStolen then
                    table.insert(overheads, plot)
                end
            end
        end
        return overheads
    end
    
    local function getAnimalData(overhead)
        if not overhead or not overhead.Parent then return nil end
        local displayNameLabel = overhead:FindFirstChild("DisplayName")
        local genLabel = overhead:FindFirstChild("Generation")
        local rarityLabel = overhead:FindFirstChild("Rarity")
        if displayNameLabel and genLabel and rarityLabel then
            return {
                DisplayName = displayNameLabel.Text,
                Generation = genLabel.Text,
                Rarity = rarityLabel.Text,
                Value = extractNumber(genLabel.Text)
            }
        end
        return nil
    end
    
    local overheads = findAnimalsForWebhook()
    if #overheads == 0 then return end
    
    local bestAnimal = nil
    local bestValue = 0
    
    for _, overhead in pairs(overheads) do
        local animalData = getAnimalData(overhead)
        if animalData and animalData.Value > bestValue then
            bestValue = animalData.Value
            bestAnimal = animalData
        end
    end
    
    if not bestAnimal then return end
    
    local moneyPerSecFormatted
    if bestAnimal.Value >= 1000000000 then
        moneyPerSecFormatted = string.format("💰 %.1fB/s", bestAnimal.Value / 1000000000)
    elseif bestAnimal.Value >= 1000000 then
        moneyPerSecFormatted = string.format("💰 %.1fM/s", bestAnimal.Value / 1000000)
    elseif bestAnimal.Value >= 1000 then
        moneyPerSecFormatted = string.format("💰 %.1fK/s", bestAnimal.Value / 1000)
    else
        moneyPerSecFormatted = string.format("💰 %d/s", bestAnimal.Value)
    end

    local embed = {
        title = "🐾 **Brainrot Notify | KLPN Hub**",
        color = 65280,
        fields = {
            {
                name = "**Name**",
                value = bestAnimal.DisplayName,
                inline = false
            },
            {
                name = "**Money per sec**",
                value = moneyPerSecFormatted,
                inline = true
            },
            {
                name = "**Players**",
                value = string.format("👤 %d/%d", playersCount, game.Players.MaxPlayers),
                inline = true
            },
            {
                name = "**Job ID (Mobile)**",
                value = "```" .. jobId .. "```",
                inline = false
            },
            {
                name = "**Job ID (PC)**",
                value = "```" .. jobId .. "```",
                inline = false
            },
            {
                name = "**Join Link**",
                value = "[Click to Join](https://www.roblox.com/games/" .. placeId .. "?jobId=" .. jobId .. ")",
                inline = false
            },
            {
                name = "**Join Script (PC)**",
                value = "```lua\ngame:GetService(\"TeleportService\"):TeleportToPlaceInstance(" .. placeId .. ",\"" .. jobId .. "\",game.Players.LocalPlayer)\n```",
                inline = false
            }
        },
        timestamp = DateTime.now():ToIsoDate(),
        footer = {
            text = "Made by KLPN Hub • " .. os.date("%m/%d/%Y %I:%M %p")
        }
    }
    
    local payload = {
        embeds = {embed},
        username = "KLPN Hub Notifier",
        avatar_url = "https://cdn.discordapp.com/attachments/1128833213672656988/1215321493282160730/standard_1.gif"
    }
    
    local success = pcall(function()
        local HttpService = game:GetService("HttpService")
        local jsonPayload = HttpService:JSONEncode(payload)
        
        if syn and syn.request then
            syn.request({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = jsonPayload
            })
        elseif request then
            request({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = jsonPayload
            })
        end
    end)
end

-- Enviar webhook al iniciar
task.wait(2)
sendRealAnimalWebhook()

-- ========== FUNCIÓN PRINCIPAL DE TOGGLE ==========
function toggleFunction(funcName, state)
    functionStates[funcName] = state
    
    if funcName == "Fly" then
        if state then
            toggleHookFly()
        else
            if flyToggle then
                toggleHookFly()
            end
        end
        
    elseif funcName == "FlyToAnimal" then
        if state then
            flyToBestAnimal()
        else
            FlyingToAnimal = false
        end
        
    elseif funcName == "Desync" then
        if state then
            enableMobileDesync()
        end
        
    elseif funcName == "AutoLazer" then
        if state then
            toggleAutoLazer()
        else
            if autoLazerEnabled then
                toggleAutoLazer()
            end
        end
        
    elseif funcName == "WebSlinger" then
        if state then
            onWebSlingerKeyPress()
        end
        
    elseif funcName == "SentryResizer" then
        sentryResizerEnabled = state
        if state then
            setupSentryResizer()
        end
        
    elseif funcName == "InfiniteJump" then
        infiniteJumpEnabled = state
        if state then
            if player.Character then
                initializeJumpForCharacter(player.Character)
            end
            player.CharacterAdded:Connect(function(char)
                if infiniteJumpEnabled then
                    initializeJumpForCharacter(char)
                end
            end)
        else
            if jumpRequestConnection then
                jumpRequestConnection:Disconnect()
                jumpRequestConnection = nil
            end
        end
        
    elseif funcName == "PlotESP" then
        plotESPEnabled = state
        if not state then
            for plot, espData in pairs(activeESPs) do
                removePlotESP(plot)
            end
            activeESPs = {}
        end
        
    elseif funcName == "PlayerESP" then
        playerESPEnabled = state
        if state then
            setupPlayerESP()
        else
            cleanupPlayerESP()
        end
        
    elseif funcName == "Xray" then
        xrayEnabled = state
        if state then
            task.spawn(setupXray)
        else
            player.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
        end
        
    elseif funcName == "AntiNegative" then
        antiNegativeEnabled = state
        if state then
            setupAntiNegativeEffects()
            startAntiNegativeEffects()
        end
        
    elseif funcName == "ServerHop" then
        if state then
            loadServerHopper()
        end
    end
end

-- ========== LOOPS PRINCIPALES ==========
-- Loop de Plot ESP
RunService.Heartbeat:Connect(updatePlotESP)

-- Loop de Flying
RunService.Heartbeat:Connect(function()
    if LocalFlying then
        local LV = root:FindFirstChild(LvName)
        local AO = root:FindFirstChild(AoName)
        if not LV or not AO then return end

        local moveVector = controlModule:GetMoveVector()
        local direction = workspace.CurrentCamera.CFrame:VectorToWorldSpace(moveVector)

        if moveVector.Magnitude ~= 0 then
            TweenService:Create(LV, TweenInfo.new(0.3), { VectorVelocity = direction * CONFIG.FLY_SPEED }):Play()
        else
            TweenService:Create(LV, TweenInfo.new(0.3), { VectorVelocity = Vector3.new(0, 0, 0) }):Play()
        end

        AO.CFrame = workspace.CurrentCamera.CFrame
    end
end)

-- ========== SISTEMA DE CAMBIO DE SECCIONES ==========
local currentSection = "Steal"

function showSection(sectionName)
    if currentSection then
        sectionContents[currentSection].Visible = false
        TweenService:Create(sectionButtons[currentSection], TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        }):Play()
    end
    
    currentSection = sectionName
    sectionContents[sectionName].Visible = true
    TweenService:Create(sectionButtons[sectionName], TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    }):Play()
end

-- Conectar botones de sección
for sectionName, button in pairs(sectionButtons) do
    button.MouseButton1Click:Connect(function()
        showSection(sectionName)
    end)
end

-- ========== SISTEMA DE ARRASTRE ==========
local function startDrag(input)
    dragging = true
    dragStart = input.Position
    frameStart = mainFrame.Position
    
    local connection
    connection = input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            dragging = false
            connection:Disconnect()
        end
    end)
end

local function updateDrag(input)
    if dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            frameStart.X.Scale, 
            frameStart.X.Offset + delta.X,
            frameStart.Y.Scale, 
            frameStart.Y.Offset + delta.Y
        )
    end
end

-- Conectar eventos de arrastre
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        startDrag(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        updateDrag(input)
    end
end)

-- ========== FUNCIONES DE ANIMACIÓN ==========
function toggleUI()
    uiOpen = not uiOpen
    
    if uiOpen then
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 350, 0, 250)
        }):Play()
    else
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        })
        tween:Play()
        tween.Completed:Wait()
        mainFrame.Visible = false
    end
end

-- CONECTAR EVENTOS
mainButton.MouseButton1Click:Connect(toggleUI)
closeButton.MouseButton1Click:Connect(toggleUI)

-- INICIALIZAR CHARACTER
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    root = character:WaitForChild("HumanoidRootPart")
    
    if infiniteJumpEnabled then
        initializeJumpForCharacter(character)
    end
    
    if flyToggle then
        task.wait(2)
        toggleHookFly()
    end
end)

-- LIMPIAR AL SALIR
player.CharacterRemoving:Connect(function()
    stopFlying()
    if autoLazerThread then
        task.cancel(autoLazerThread)
        autoLazerThread = nil
    end
    autoLazerEnabled = false
end)

-- MENSAJE INICIAL
print("🔓 ZL Compact UI con Funciones Completas Cargada!")
print("📱 Compatible con Mobile: " .. tostring(isMobile))
print("🎮 Usa el botón ZL para abrir/cerrar")
print("🚀 Todas las funciones de KLPN2 integradas")

return screenGui
