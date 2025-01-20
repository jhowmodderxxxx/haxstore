-- Carregar a Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/Library.lua"))()

-- Definir algumas variáveis essenciais
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local character = Player.Character or Player.CharacterAdded:Wait()
local autoFarmEnabled = false
local meleeWeapon = "Katana"  -- Troque pelo nome da sua arma de melee

-- Referências para os módulos e serviços
local rs_Monsters = ReplicatedStorage:WaitForChild("MonsterSpawn")
local Monsters = workspace:WaitForChild("Monster")
local OtherEvent = ReplicatedStorage:WaitForChild("OtherEvent")
local Cooldown = Player:WaitForChild("Cooldown")
local Ability = Player:WaitForChild("Ability")
local PlayerData = Player:WaitForChild("PlayerData")
local PlayerLevel = PlayerData:WaitForChild("Level")

-- Função para verificar se o jogador está vivo
local function isPlayerAlive()
    return character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0
end

-- Função para encontrar alvos (inimigos) para o auto-farm
local function findFarmableTarget()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj.Humanoid.Health > 0 then
            return obj
        end
    end
    return nil
end

-- Função para realizar ataque melee no alvo
local function meleeAttack(target)
    local weapon = character:FindFirstChild(meleeWeapon)
    if weapon and isPlayerAlive() then
        local humanoid = target:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:TakeDamage(10)  -- Dano fixo de 10, ajuste conforme necessário
            print("Atacando: " .. target.Name)
        end
    else
        print("Arma de melee não encontrada ou jogador está morto!")
    end
end

-- Função para iniciar o auto-farm
local function startAutoFarm()
    while autoFarmEnabled do
        local target = findFarmableTarget()
        if target then
            meleeAttack(target)
        end
        wait(1)  -- Delay entre as ações
    end
end

-- Função para parar o auto-farm
local function stopAutoFarm()
    autoFarmEnabled = false
    print("Auto-farm parado")
end

-- Função para equipar a arma de melee
local function equipWeapon()
    local weapon = character:FindFirstChild(meleeWeapon)
    if weapon and isPlayerAlive() then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:EquipTool(weapon)
            print("Arma equipada: " .. meleeWeapon)
        end
    else
        print("Arma não encontrada!")
    end
end

-- Criar o menu de interface com Orion
local Window = OrionLib:MakeWindow({
    Name = "Meme Sea Menu",
    HidePremium = true,
    IntroEnabled = false
})

-- Seção Auto-Farm
local AutoFarmTab = Window:Tab({
    Name = "Auto-Farm",
    Icon = "rbxassetid://12345678",  -- Use um ícone adequado
})

AutoFarmTab:Button({
    Name = "Iniciar Auto-Farm",
    Callback = function()
        autoFarmEnabled = not autoFarmEnabled
        if autoFarmEnabled then
            startAutoFarm()
        else
            stopAutoFarm()
        end
    end
})

-- Seção Equipar Arma
local EquipTab = Window:Tab({
    Name = "Equipar Arma",
    Icon = "rbxassetid://12345678",  -- Use um ícone adequado
})

EquipTab:Button({
    Name = "Equipar Katana",
    Callback = function()
        equipWeapon()
    end
})

-- Seção de Habilidades
local AbilitiesTab = Window:Tab({
    Name = "Habilidades",
    Icon = "rbxassetid://12345678",  -- Use um ícone adequado
})

AbilitiesTab:Button({
    Name = "Usar Habilidade: Aura",
    Callback = function()
        -- Verifica se a habilidade está desbloqueada e a usa
        if Ability:FindFirstChild("Aura") then
            OtherEvent.MainEvents.Ability:InvokeServer("Aura")
            print("Usando habilidade Aura")
        else
            print("Habilidade Aura não desbloqueada")
        end
    end
})

-- Seção de Quests
local QuestsTab = Window:Tab({
    Name = "Quests",
    Icon = "rbxassetid://12345678",  -- Use um ícone adequado
})

QuestsTab:Button({
    Name = "Fazer Quest",
    Callback = function()
        -- Lógica para iniciar ou completar uma quest
        print("Iniciando Quest...")
        -- Adicione a lógica necessária para interagir com NPCs ou completar quests
    end
})

-- Notificação quando o script for carregado
OrionLib:MakeNotification({
    Name = "Script Carregado",
    Content = "Meme Sea Menu Carregado com sucesso!",
    Time = 5
})

-- Atualização do nível do jogador na interface
local function updateLevelDisplay()
    local label = Player.PlayerGui.MainGui.PlayerName
    local Level = PlayerLevel.Value
    local IsMax = Level >= 100  -- Ajuste o nível máximo conforme necessário
    label.Text = ("%s • Lv. %i%s"):format("Anonymous", Level, IsMax and " (Max)" or "")
end

-- Conectar o evento de atualização do nível
Player.PlayerData.Level:GetPropertyChangedSignal("Value"):Connect(updateLevelDisplay)
updateLevelDisplay()
