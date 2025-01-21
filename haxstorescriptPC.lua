local KeyGuardLibrary = loadstring(game:HttpGet("https://cdn.keyguardian.org/library/v1.0.0.lua"))()
local trueData = "3b3a486187d94877a0b19cb729b4e4f8"
local falseData = "e980d435d0594895811af42243ce90b1"

KeyGuardLibrary.Set({
  publicToken = "28be885d7e124572bc1980f892becb6d",
  privateToken = "0a7a15979ac74b4cbea133ccdbbd81ff",
  trueData = trueData,
  falseData = falseData,
})

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local key = ""

-- Função para salvar a chave
local function saveKey(newKey)
    key = newKey
    -- Aqui você poderia salvar a chave em um arquivo ou outra forma de persistência, se desejado
end

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
    KeySys = Window:AddTab({ Title = "Key System", Icon = "key" }),
}

local Entkey = Tabs.KeySys:AddInput("Input", {
    Title = "Enter Key",
    Description = "Enter Key Here",
    Default = key, -- Preenche com a chave salva
    Placeholder = "Enter key…",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        saveKey(Value)  -- Salva a chave ao digitar
    end
})

local Checkkey = Tabs.KeySys:AddButton({
    Title = "Check Key",
    Description = "Enter Key before pressing this button",
    Callback = function()
        local response = KeyGuardLibrary.validateDefaultKey(key)
        if response == trueData then
           print("Key is valid")

           -- Tenta carregar o script adicional
           local success, err = pcall(function()
               loadstring(game:HttpGet("https://raw.githubusercontent.com/jhowmodderxxxx/haxstore/refs/heads/main/SCRIPTFISCH"))()
           end)

           if success then
               print("Novo script carregado com sucesso!")
               for _, child in pairs(Window:GetChildren()) do
                   child:Destroy()  -- Remove todos os elementos da janela do sistema de chaves
               end
               Window:Destroy()  -- Remove a janela do sistema de chaves
           else
               warn("Falha ao carregar o novo script: ".. tostring(err))
           end
        else
           print("Key is invalid")
        end
    end
})

local Getkey = Tabs.KeySys:AddButton({
    Title = "Get Key",
    Description = "Get Key here",
    Callback = function()
       setclipboard(KeyGuardLibrary.getLink())
    end
})

Window:SelectTab(1)
