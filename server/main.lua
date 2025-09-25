local cashA = 250 --<<how much minimum you can get from a robbery
local cashB = 450 --<< how much maximum you can get from a robbery
local safeCombos = {}
local thermitingSafes = {}
local Registers = {
    {  loc = vector3(-47.24, -1757.65, 29.53),   robbed = false,  safeKey = 1,  camId = 4 },
    {  loc = vector3(-48.58, -1759.21, 29.59),   robbed = false,  safeKey = 1,  camId = 4 },
    {  loc = vector3(-1486.26, -378.0, 40.16),   robbed = false,  safeKey = 2,  camId = 5 },
    {  loc = vector3(-1222.03, -908.32, 12.32),  robbed = false,  safeKey = 3,  camId = 6 },
    {  loc = vector3(-706.08, -915.42, 19.21),   robbed = false,  safeKey = 4,  camId = 7 },
    {  loc = vector3(-706.16, -913.5, 19.21),    robbed = false,  safeKey = 4,  camId = 7 },
    {  loc = vector3(24.47, -1344.99, 29.49),    robbed = false,  safeKey = 5,  camId = 8 },
    {  loc = vector3(24.45, -1347.37, 29.49),    robbed = false,  safeKey = 5,  camId = 8 },
    {  loc = vector3(1134.15, -982.53, 46.41),   robbed = false,  safeKey = 6,  camId = 9 },
    {  loc = vector3(1165.05, -324.49, 69.2),    robbed = false,  safeKey = 7,  camId = 10 },
    {  loc = vector3(1164.7, -322.58, 69.2),     robbed = false,  safeKey = 7,  camId = 10 },
    {  loc = vector3(373.14, 328.62, 103.56),    robbed = false,  safeKey = 8,  camId = 11 },
    {  loc = vector3(372.57, 326.42, 103.56),    robbed = false,  safeKey = 8,  camId = 11 },
    {  loc = vector3(-1818.9, 792.9, 138.08),    robbed = false,  safeKey = 9,  camId = 12 },
    {  loc = vector3(-1820.17, 794.28, 138.08),  robbed = false,  safeKey = 9,  camId = 12 },
    {  loc = vector3(-2966.46, 390.89, 15.04),   robbed = false,  safeKey = 10, camId = 13 },
    {  loc = vector3(-3041.14, 583.87, 7.9),     robbed = false,  safeKey = 11, camId = 14 },
    {  loc = vector3(-3038.92, 584.5, 7.9),      robbed = false,  safeKey = 11, camId = 14 },
    {  loc = vector3(-3244.56, 1000.14, 12.83),  robbed = false,  safeKey = 12, camId = 15 },
    {  loc = vector3(-3242.24, 999.98, 12.83),   robbed = false,  safeKey = 12, camId = 15 },
    {  loc = vector3(549.42, 2669.06, 42.15),    robbed = false,  safeKey = 13, camId = 16 },
    {  loc = vector3(549.05, 2671.39, 42.15),    robbed = false,  safeKey = 13, camId = 16 },
    {  loc = vector3(1165.9, 2710.81, 38.15),    robbed = false,  safeKey = 14, camId = 17 },
    {  loc = vector3(2676.02, 3280.52, 55.24),   robbed = false,  safeKey = 15, camId = 18 },
    {  loc = vector3(2678.07, 3279.39, 55.24),   robbed = false,  safeKey = 15, camId = 18 },
    {  loc = vector3(1958.96, 3741.98, 32.34),   robbed = false,  safeKey = 16, camId = 19 },
    {  loc = vector3(1960.13, 3740.0, 32.34),    robbed = false,  safeKey = 16, camId = 19 },
    {  loc = vector3(1728.86, 6417.26, 35.03),   robbed = false,  safeKey = 17, camId = 20 },
    {  loc = vector3(1727.85, 6415.14, 35.03),   robbed = false,  safeKey = 17, camId = 20 },
    {  loc = vector3(-161.07, 6321.23, 31.5),    robbed = false,  safeKey = 18, camId = 27 },
    {  loc = vector3(160.52, 6641.74, 31.6),     robbed = false,  safeKey = 19, camId = 28 },
    {  loc = vector3(162.16, 6643.22, 31.6),     robbed = false,  safeKey = 19, camId = 29 },
}

GlobalState.StoreRobberyRegisters = Registers

local Safes = {
    {  loc = vector3(-43.77, -1748.3, 29.09),            rotation = vector3(100.0,50.0,0.0),    thermited = false, robbed = false, camId = 4 },
    {  loc = vector4(-1478.94, -375.5, 39.16, 229.5),    rotation = vector3(-100.0,-50.0,0.0),  thermited = false, robbed = false, camId = 5 },
    {  loc = vector4(-1220.85, -916.05, 11.32, 229.5),   rotation = vector3(30,100,0.0),        thermited = false, robbed = false, camId = 6 },
    {  loc = vector3(-710.03, -904.33, 18.88),           rotation = vector3(90.0,90.0,0.0),     thermited = false, robbed = false, camId = 7 },
    {  loc = vector3(27.99, -1338.88, 29.2),            rotation = vector3(90.0,0.0,0.0),       thermited = false, robbed = false, camId = 8 },
    {  loc = vector3(1126.77, -980.1, 45.41),            rotation = vector3(90.0,0.0,0.0),      thermited = false, robbed = false, camId = 9 },
    {  loc = vector3(1159.24, -314.27, 68.84),            rotation = vector3(90.0,90.0,0.0),    thermited = false, robbed = false, camId = 10 },
    {  loc = vector3(378.05, 333.73, 103.19),            rotation = vector3(90.0,0.0,0.0),      thermited = false, robbed = false, camId = 11 },
    {  loc = vector3(-1829.28, 798.4, 137.87),          rotation = vector3(90.0,120.0,0.0),     thermited = false, robbed = false, camId = 12 },
    {  loc = vector3(-2959.64, 387.08, 14.04),           rotation = vector3(90.0,180.0,0.0),    thermited = false, robbed = false, camId = 13 },
    {  loc = vector3(-3048.08, 585.33, 7.55),             rotation = vector3(90.0,90.0,0.0),    thermited = false, robbed = false, camId = 14 },
    {  loc = vector3(-3250.36, 1004.23, 12.44),          rotation = vector3(90.0,90.0,0.0),     thermited = false, robbed = false, camId = 15 },
    {  loc = vector3(546.67, 2662.52, 41.78),            rotation = vector3(90.0,180.0,0.0),    thermited = false, robbed = false, camId = 16 },
    {  loc = vector3(1169.31, 2717.79, 37.15),           rotation = vector3(90.0,-90.0,0.0),    thermited = false, robbed = false, camId = 17 },
    {  loc = vector3(2672.38, 3286.57, 54.81),           rotation = vector3(90.0,40.0,0.0),     thermited = false, robbed = false, camId = 18 },
    {  loc = vector3(1958.93, 3749.08, 31.96),           rotation = vector3(90.0,20.0,0.0),     thermited = false, robbed = false, camId = 19 },
    {  loc = vector3(1734.77, 6421.21, 34.65),           rotation = vector3(90.0,-20.0,0.0),    thermited = false, robbed = false, camId = 20 },
    {  loc = vector3(-168.40, 6318.80, 30.58),           rotation = vector3(90.0,180.0,0.0),    thermited = false, robbed = false, camId = 27 }, -- addon maps needed for paleto
    {  loc = vector3(168.95, 6644.74, 31.70),            rotation = vector3(90.0,180.0,0.0),    thermited = false, robbed = false, camId = 30 }, -- addon maps needed for paleto
}

GlobalState.StoreRobberySafes = Safes

local function createCombo(type, index)
    if safeCombos[index] then
        return safeCombos[index]
    end
    if type == 'keypad' then
        safeCombos[index] = math.random(1000, 9999)
    else
        safeCombos[index] = { math.random(1, 149), math.random(500.0, 600.0), math.random(360.0, 400), math.random(600.0, 900.0) }
    end
    CreateThread(function()
        Wait(15 * 60 * 1000)
        safeCombos[index] = nil
    end)
    return safeCombos[index]
end

local function robbedRegister(index)
    if not Registers[index] then
        return false
    end

    if Registers[index].robbed then
        return false
    end

    Registers[index].robbed = true
    GlobalState.StoreRobberyRegisters = Registers

    CreateThread(function()
        Wait(Config.resetTime)
        Registers[index].robbed = false
        GlobalState.StoreRobberyRegisters = Registers
    end)
    return true
end

RegisterNetEvent('qb-storerobbery:server:robRegister', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    if not Registers[index] then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.demolish_vehicle'), 'error')
        return
    end

    local dist = #(GetEntityCoords(GetPlayerPed(src)) - Registers[index].loc)
    if dist > 3.0 then
        return
    end

    if not robbedRegister(index) then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.demolish_vehicle'), 'error')
        return
    end
    if 1 <= math.random(1, 100) then
        local combo = createCombo(Safes[Registers[index].safeKey].type, Registers[index].safeKey)
        Player.Functions.AddItem('stickynote', 1, false, { Combo = combo })
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['stickynote'], "add")
    end
    local cash = math.random(cashA, cashB)
    Player.Functions.AddMoney('cash', cash, "store-robbery")
end)

RegisterNetEvent('qb-storerobbery:server:openSafe', function(index, combo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not Safes[index] then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.demolish_vehicle'), 'error')
        return
    end
    local dist = #(GetEntityCoords(GetPlayerPed(src)) - vector3(Safes[index].loc.x, Safes[index].loc.y, Safes[index].loc.z))
    if dist > 3.0 then
        return
    end
    if Safes[index].robbed then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.demolish_vehicle'), 'error')
        return
    end
    if safeCombos[index] ~= combo then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.wrong_code'), 'error')
        return
    end
    Safes[index].robbed = true
    GlobalState.StoreRobberySafes = Safes
    CreateThread(function()
        Wait(Config.resetTime)
        Safes[index].robbed = false
        GlobalState.StoreRobberySafes = Safes
    end)
    local cash = math.random(1000, 2500)
    Player.Functions.AddMoney('cash', cash, "store-robbery")
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:canThermite', function(source, cb, index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Safes[index] then
        return
    end
    if Safes[index].robbed then
        return
    end
    local dist = #(GetEntityCoords(GetPlayerPed(src)) - vector3(Safes[index].loc.x, Safes[index].loc.y, Safes[index].loc.z))
    if dist > 3.0 then
        return
    end
    if Player.Functions.RemoveItem('thermite', 1, false) then
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['thermite'], "remove")
        thermitingSafes[Player.PlayerData.citizenid] = {safe = index}
        cb(true)
        return
    end
    cb(false)
end)

RegisterNetEvent('qb-storerobbery:server:thermiteSafe', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Safes[index] then
        return
    end
    if Safes[index].robbed then
        return
    end
    if not thermitingSafes[Player.PlayerData.citizenid] or thermitingSafes[Player.PlayerData.citizenid].safe ~= index then
        return
    end
    thermitingSafes[Player.PlayerData.citizenid] = nil
    Safes[index].thermited = true
    GlobalState.StoreRobberySafes = Safes
    CreateThread(function()
        Wait(Config.resetTime)
        Safes[index].thermited = false
        GlobalState.StoreRobberySafes = Safes
    end)
end)

RegisterNetEvent('qb-storerobbery:server:collectFromSafe', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not Safes[index] then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.demolish_vehicle'), 'error')
        return
    end
    local dist = #(GetEntityCoords(GetPlayerPed(src)) - vector3(Safes[index].loc.x, Safes[index].loc.y, Safes[index].loc.z))
    if dist > 3.0 then
        return
    end
    if Safes[index].robbed then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.demolish_vehicle'), 'error')
        return
    end
    if not Safes[index].thermited then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.demolish_vehicle'), 'error')
        return
    end
    local cash = math.random(2000, 5000)
    Player.Functions.AddMoney('cash', cash, "store-robbery")
    Safes[index].thermited = false
    Safes[index].robbed = true
    GlobalState.StoreRobberySafes = Safes
    CreateThread(function()
        Wait(Config.resetTime)
        Safes[index].robbed = false
        GlobalState.StoreRobberySafes = Safes
    end)
end)