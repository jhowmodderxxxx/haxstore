local DataStoreService = game:GetService("DataStoreService")
local KeyDataStore = DataStoreService:GetDataStore("KeyDataStore")
local KeyGuardLibrary = loadstring(game:HttpGet("https://cdn.keyguardian.org/library/v1.0.0.lua"))()
local trueData = "3b3a486187d94877a0b19cb729b4e4f8"
local falseData = "e980d435d0594895811af42243ce90b1"

KeyGuardLibrary.Set({
    publicToken = "28be885d7e124572bc1980f892becb6d",
    privateToken = "0a7a15979ac74b4cbea133ccdbbd81ff",
    trueData = trueData,
    falseData = falseData,
})

local key = ""
local saveKeyCheckbox = false

local function saveKey(newKey)
    key = newKey
    if saveKeyCheckbox then
        local success, err = pcall(function() KeyDataStore:SetAsync("UserKey", newKey) end)
        if success then
            print("Chave salva permanentemente.")
        else
            warn("Erro ao salvar a chave: " .. tostring(err))
        end
    end
end

local function loadSavedKey()
    local savedKey
    local success, err = pcall(function() savedKey = KeyDataStore:GetAsync("UserKey") end)
    if success and savedKey then
        key = savedKey
    else
        key = ""
        if err then
            warn("Erro ao carregar a chave salva: " .. tostring(err))
        end
    end
end

loadSavedKey()

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Key System",
    SubTitle = "HAXSTORE",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 340),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    KeySys = Window:AddTab({
        Title = "Key System",
        Icon = "key",
    }),
}

local Entkey = Tabs.KeySys:AddInput("Input", {
    Title = "Enter Key",
    Description = "Enter Key Here",
    Default = key,
    Placeholder = "Enter key…",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        local isValidKey = KeyGuardLibrary.Check(Value)
        if isValidKey then
            saveKey(Value)
            local script = loadstring(game:HttpGet("https://raw.githubusercontent.com/jhowmodderxxxx/haxstore/refs/heads/main/SCRIPTFISCH"))()
            script:Dispose() -- Add the destroy function here
        else
            warn("Chave inválida.")
        end
    end
})

local SaveKeyButton = Tabs.KeySys:AddButton({
    Title = "Save Key",
    Description = "Save the entered key",
    Callback = function()
        saveKeyCheckbox = not saveKeyCheckbox
        print("Save Key: " .. tostring(saveKeyCheckbox))
    end
})
