-- Constants
local velocidadefarm = 700
--By MrJhowTeamRX

-- Função para salvar o login em um arquivo
function saveLogin(login, password)
    local file = io.open("/sdcard/loginsalvo.txt", "w") -- Caminho do arquivo
    if file then
        file:write(login .. "\n") -- Salva o login
        file:write(password)      -- Salva a senha
        file:close()
        gg.toast("Login salvo com sucesso!")
    else
        gg.toast("Erro ao salvar o login!")
    end
end

-- Função para carregar o login de um arquivo
function loadLogin()
    local file = io.open("/sdcard/loginsalvo.txt", "r") -- Caminho do arquivo
    if file then
        local login = file:read("*line") -- Lê a primeira linha (login)
        local password = file:read("*line") -- Lê a segunda linha (senha)
        file:close()
        return login, password
    else
        return nil, nil
    end
end

-- Carregar o login salvo, se existir
local savedLogin, savedPassword = loadLogin()

-- Solicitar login, senha e opção de salvar login
local loginInfo = gg.prompt(
    {"Digite seu login:", "Digite sua senha:", "Salvar login"}, -- Campos
    {savedLogin or "", savedPassword or "", false}, -- Valores padrão
    {"text", "text", "checkbox"} -- Tipos de entrada
)


if loginInfo then
    local login = loginInfo[1]
    local password = loginInfo[2]
    local saveLoginOption = loginInfo[3] -- true se o checkbox estiver marcado


 
if loginInfo and loginInfo[1] == "chines" and loginInfo[2] == "cria13" then
    expirationYear = 2026
    expirationMonth = 9
    expirationDay = 21
    expirationHour = 21
    expirationMinute = 20
    usuario = loginInfo[1]



elseif loginInfo and loginInfo[1] == "jhow" and loginInfo[2] == "modder" then
    expirationYear = 2026
    expirationMonth = 5
    expirationDay = 28
    expirationHour = 8
    expirationMinute = 10
    usuario = loginInfo[1]

elseif loginInfo and loginInfo[1] == "lucas" and loginInfo[2] == "112113" then
    expirationYear = 2025
    expirationMonth = 4
    expirationDay = 6
    expirationHour = 8
    expirationMinute = 10
    usuario = loginInfo[1]


elseif loginInfo and loginInfo[1] == "MATEUS" and loginInfo[2] == "mods" then
    expirationYear = 2025
    expirationMonth = 4
    expirationDay = 2
    expirationHour = 8
    expirationMinute = 10
    usuario = loginInfo[1]

elseif loginInfo and loginInfo[1] == "Igorzin" and loginInfo[2] == "igor123" then
    expirationYear = 2025
    expirationMonth = 4
    expirationDay = 2
    expirationHour = 8
    expirationMinute = 10
    usuario = loginInfo[1]


elseif loginInfo and loginInfo[1] == "Detroid" and loginInfo[2] == "9108" then
    expirationYear = 2026
    expirationMonth = 5
    expirationDay = 28
    expirationHour = 8
    expirationMinute = 10
    usuario = loginInfo[1]

elseif loginInfo and loginInfo[1] == "Gabriel" and loginInfo[2] == "122113145" then
    expirationYear = 2026
    expirationMonth = 5
    expirationDay = 28
    expirationHour = 8
    expirationMinute = 10
    usuario = loginInfo[1]
   
else
    gg.alert("Usuário ou senha incorretos!")
    os.exit()
end

if saveLoginOption then
    saveLogin(login, password)
end
 

gg.alert("Bem-vindo, " .. usuario .. "!")
else
    gg.alert("Nenhum login fornecido!")
    os.exit()
end


gg.alert("VERSAO V1 \n\nSCRIPT DE PUXAR ARMAS, COLETE E VIDA By RodrigoGTyx")


versao = "SCRIPT SOWxTEAM V1 PREMIUM"





local ENABLED = "✔️ "

local DISABLED = "❌ "

local BASE_ADDRESS = nil -- Should be defined elsewhere



-- API Request Function

function makeRequest(url, headers, body)

    local response = gg.makeRequest(url, headers, body)

    if not response then

        gg.alert("Houve um erro. Por favor contate o desenvolvedor.")

        os.exit()

    end

    return response

end



-- Update Function
-- Weapon Functions

function toggleWeapon(weaponName, weaponId, ammoCount, slotsCount, addressOffset, statusVar)

    if statusVar == ENABLED then

        addWeaponItems(weaponName, 0, 0, 0, addressOffset)

        return DISABLED

    else

        addWeaponItems(weaponName, weaponId, ammoCount, slotsCount, addressOffset)

        return ENABLED

    end

end



function addWeaponItems(weaponName, idValue, firesValue, slotsValue, baseOffset)

    gg.addListItems({

        {

            address = BASE_ADDRESS + baseOffset,

            flags = gg.TYPE_DWORD,

            value = tostring(idValue),

            name = weaponName .. " ID",

            freeze = true,

            freezetype = gg.FREEZE_NORMAL

        },

        {

            address = BASE_ADDRESS + baseOffset + 8,

            flags = gg.TYPE_DWORD,

            value = tostring(firesValue),

            name = weaponName .. " FIRES COUNT",

            freeze = true,

            freezetype = gg.FREEZE_NORMAL

        },

        {

            address = BASE_ADDRESS + baseOffset + 12,

            flags = gg.TYPE_DWORD,

            value = tostring(slotsValue),

            name = weaponName .. " SLOTS COUNT",

            freeze = true,

            freezetype = gg.FREEZE_NORMAL

        }

    })

    gg.setVisible(false)

end



-- Health Functions

function setHealth(value)
    gg.setValues({
        {
            address = BASE_ADDRESS,
            flags = gg.TYPE_FLOAT,
            value = tostring(value)
        }
    })
end



function setArmor(value)
    gg.setValues({
        {
            address = BASE_ADDRESS + 8,
            flags = gg.TYPE_FLOAT,
            value = tostring(value)
        }
    })
end



function resetHealthAndArmor()
    setHealth(200.0)
    setArmor(100.0)
end



function healthMenu()
    local choice = gg.choice({
        "REGENERAR VIDA🤎",
        "SETAR 200 VIDA🤎",
        "SETAR 150 VIDA🤎",
        "SETAR 100 VIDA🤎",
        "SETAR 20 VIDA🤎",
        "SETAR 0 VIDA🤎"
    })


    if choice == 1 then
        resetHealthAndArmor()
    elseif choice == 2 then
        setHealth(200.0)
    elseif choice == 3 then
        setHealth(150.0)
    elseif choice == 4 then
        setHealth(100.0)
    elseif choice == 5 then
        setHealth(20.0)
    elseif choice == 6 then
        setHealth(0.0)

    end

end



function armorMenu()

    local choice = gg.choice({

        "150 COLETE 🛡",

        "100 COLETE 🛡",

        "0 COLETE 🛡"

    }, nil, "Selecione uma opção:")

    

    if choice == 1 then

        setArmor(150.0)

    elseif choice == 2 then

        setArmor(100.0)

    elseif choice == 3 then

        setArmor(0.0)

    end

end


-- Weapons Menu

local weaponStatus = {

    desert = DISABLED,

    shotgun = DISABLED,

    mp5 = DISABLED,

    ak47 = DISABLED,

    m4 = DISABLED,

    bazooka = DISABLED

}



function weaponsMenu()

    local choice = gg.choice({

        weaponStatus.desert .. "🔫DESERT🔫",
        weaponStatus.shotgun .. "🔫SHOTGUN🔫",
        weaponStatus.m4 .. "🔫M4🔫",

    }, nil, "Selecione uma arma:")

    

    if not choice then return end

    

    if choice == 1 then

        weaponStatus.desert = toggleWeapon("desert", 24, 7, 35, 196, weaponStatus.desert)

    elseif choice == 2 then

        weaponStatus.shotgun = toggleWeapon("shotgun", 25, 1, 30, 228, weaponStatus.shotgun)
        
        weaponStatus.m4 = DISABLED

    elseif choice == 3 then

        weaponStatus.m4 = toggleWeapon("m4", 31, 30, 90, 292, weaponStatus.m4)

        weaponStatus.ak47 = DISABLED

    end

end


-- Main Menu

function mainMenu()
local titulo = string.format(
        "🎇SCRIPT SOWxTEAM V1 🎇\n\n 👤 Usuário: %s\n\n 🔓 Expiração: %02d/%02d/%d",
        usuario, expirationDay, expirationMonth, expirationYear
    )

    menu = gg.choice({
        "SOWxTEAM - FUNCTION ▶",
    }, nil, titulo)
    
    local choice = gg.choice({

        "SOWxTEAM SETAR VIDA 🤎",

        "SOWxTEAM SETAR COLETE🛡",

        "SOWxTEAM SETAR ARMAS🔫",

    }, nil, "Selecione uma opção:")

    

    if choice == 1 then

        healthMenu()

    elseif choice == 2 then

        armorMenu()

    elseif choice == 3 then

        weaponsMenu()

    end

end


----- teleports farm


    -- Find base address

    gg.searchNumber("7.5F;0.10000000149", gg.TYPE_FLOAT)

    local results = gg.getResults(1)

    if #results > 0 then

        BASE_ADDRESS = results[1].address - 32

        gg.clearResults()

        mainMenu()

    else

        gg.alert("Failed to find base address!")
        os.exit()
    end

-- Initialization

function init()

    gg.setVisible(false)
    while true do
        if gg.isVisible() then
            gg.setVisible(false)
            mainMenu()
        end
        gg.sleep(50)
    end
end





-- Start the script

init()
