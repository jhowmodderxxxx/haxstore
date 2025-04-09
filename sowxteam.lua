
gg.toast("Carregando Spoofer Rio Rise...")
gg.setVisible(false)

-- Alvos específicos para Rio Rise
local rio_rise_targets = {
  {name = "device_id", label = "📱 ID do Dispositivo"},
  {name = "advertising_id", label = "📢 ID de Publicidade"},
  {name = "android_id", label = "🤖 Android ID"},
  {name = "serial_number", label = "🔢 Número de Série"},
  {name = "build_fingerprint", label = "🖐️ Fingerprint do Sistema"},
  {name = "google_services_id", label = "🔵 Google Services ID"},
  {name = "install_referrer", label = "📥 Referência de Instalação"}
}

-- Gera um ID spoofado no formato correto
function gerarIDSpoofado(tipo)
  local formatos = {
    device_id = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx",
    advertising_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
    android_id = "xxxxxxxxxxxxxxxx",
    serial_number = "XXXXXXXXXXXX",
    build_fingerprint = "google/xxxxxxxxxxxx:xx/xxxxxxx/xxxxxxx:user/release-keys",
    google_services_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    install_referrer = "utm_source=xxxxxxxx&utm_medium=xxxxxxxx"
  }
  
  local id = formatos[tipo] or string.rep("x", 16)
  return id:gsub("[xy]", function(c)
    local v = (c == "x") and math.random(0, 15) or math.random(8, 11)
    return string.format("%x", v)
  end)
end

-- Busca e substitui valores
function spoofValor(nome)
  gg.clearResults()
  gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_C_ALLOC | gg.REGION_C_HEAP | gg.REGION_C_DATA | gg.REGION_JAVA_HEAP)
  
  -- Tenta encontrar como string
  gg.searchNumber(":"..nome..":", gg.TYPE_BYTE)
  local results = gg.getResults(1000)
  
  if #results == 0 then
    -- Tenta encontrar como string UTF-16
    gg.searchNumber(":"..nome..":", gg.TYPE_WORD)
    results = gg.getResults(1000)
  end
  
  if #results == 0 then
    gg.toast("Não encontrado: "..nome)
    return false
  end
  
  local spoofed = gerarIDSpoofado(nome)
  local newVals = {}
  
  -- Prepara valores para substituição
  for i = 1, #spoofed do
    table.insert(newVals, {
      address = results[1].address + (i - 1),
      flags = gg.TYPE_BYTE,
      value = string.byte(spoofed:sub(i, i))
    })
  end
  
  -- Adiciona terminador nulo
  table.insert(newVals, {
    address = results[1].address + #spoofed,
    flags = gg.TYPE_BYTE,
    value = 0
  })
  
  gg.setValues(newVals)
  gg.toast("Spoof realizado: "..nome.." → "..spoofed)
  return true
end

-- Menu interativo
function menuPrincipal()
  local menu = {}
  for _, v in ipairs(rio_rise_targets) do
    table.insert(menu, v.label)
  end
  table.insert(menu, "🔁 Spoof Tudo")
  table.insert(menu, "❌ Sair")

  local choice = gg.choice(menu, nil, "Spoofer Rio Rise - Selecione:")
  
  if not choice then return end
  
  if choice == #menu then
    gg.toast("Spoofer encerrado")
    os.exit()
  elseif choice == #menu - 1 then
    gg.toast("Aplicando spoof em todos...")
    for _, target in ipairs(rio_rise_targets) do
      spoofValor(target.name)
      gg.sleep(500)
    end
    gg.toast("Todos os IDs foram spoofados!")
  else
    spoofValor(rio_rise_targets[choice].name)
  end
end

-- Loop principal
while true do
  if gg.isVisible(true) then
    gg.setVisible(false)
    menuPrincipal()
  end
  gg.sleep(100)
end
