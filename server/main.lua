local safeCombos, thermiteWait, exploit = {}, {}, {} -- dont touch

local function coolDown(type, index, time)
    if type == 'combo' then
       CreateThread(function()
            Wait(time)
            safeCombos[index] = nil
        end)
    end
    if type == 'robRegister' then
        CreateThread(function()
            Wait(time)
            Registers[index].robbed = false
            GlobalState.StoreRobberyRegisters = Registers
        end)
    end
    if type == 'robSafe' then
        CreateThread(function()
            Wait(time)
            Safes[index].robbed = false
            GlobalState.StoreRobberySafes = Safes
        end)
    end
    if type == 'thermiteCooldown' then
        if thermiteWait[index] then
            return false
        end
        thermiteWait[index] = true
        CreateThread(function()
            Wait(time - 1000)
            thermiteWait[index] = nil
        end)
    end
    if type == 'resetThermite' then
        CreateThread(function()
            Wait(time)
            if not Safes[index].thermited then
                Safes[index].thermited = false
                GlobalState.StoreRobberySafes = Safes
            end
        end)
    end
end

local function checkDistance(src, location, distance)
    local ped = GetPlayerPed(src)
    local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(location.x, location.y, location.z))
    if dist <= distance then
        return true
    else
        exploit[src] = (exploit[src] and exploit[src] + 1 or 1)
        if exploit[src] >= 5 then
            DropPlayer(src, Lang:t('error.cheatingDetectedDrop'))
            print(src .. Lang:t('error.cheatingDetectedPrint'))
        end
        return false
    end
end

local function createCombo(index)
    if safeCombos[index] then
        return safeCombos[index]
    end
    safeCombos[index] = math.random(1000, 9999)
    coolDown('combo', index, RegisterConfig.comboResetTime)
    return safeCombos[index]
end

RegisterNetEvent('qb-storerobbery:server:robRegister', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if PoliceCount <= Config.MinimumStoreRobberyPolice then
        return
    end
    if not Registers[index] then
        print(Lang:t('error.invalidRegister') .. tostring(index))
        return
    end

    if not checkDistance(src, Registers[index].loc, 3.0) then
        return
    end

    if Registers[index].robbed then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.alreadyRobbed'), 'error')
        return
    end

    if RegisterConfig.comboChance <= math.random(1, 100) then
        local combo = createCombo(Registers[index].safeKey)
        Player.Functions.AddItem('stickynote', 1, false, { Combo = combo })
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['stickynote'], "add")
    end

    Player.Functions.AddMoney('cash',  math.random(RegisterConfig.cashMin, RegisterConfig.cashMax), "store-robbery")

    Registers[index].robbed = true
    GlobalState.StoreRobberyRegisters = Registers
    coolDown('robRegister', index, RegisterConfig.registerResetTime)
end)

RegisterNetEvent('qb-storerobbery:server:openSafe', function(index, combo)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if PoliceCount <= Config.MinimumStoreRobberyPolice then
        return
    end
    if not Safes[index] then
        print(Lang:t('error.invalidSafe') .. tostring(index))
        return
    end

    if not checkDistance(src, Safes[index].loc, 3.0) then
        return
    end

    if Safes[index].robbed then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.safeRobbed'), 'error')
        return
    end

    if safeCombos[index] ~= combo then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.wrongCode'), 'error')
        return
    end

    local completed = QBCore.Functions.TriggerClientCallback('qb-storerobbery:client:openSafe', src)
    if not completed then
        return
    end

    Safes[index].robbed = true
    safeCombos[index] = nil
    GlobalState.StoreRobberySafes = Safes

    Player.Functions.AddMoney('cash', math.random(SafeConfig.cashMin, SafeConfig.cashMax), "store-robbery")
    coolDown('robSafe', index, SafeConfig.safeResetTime)
end)


local hitSafes = {}
QBCore.Functions.CreateCallback('qb-storerobbery:server:canThermite', function(source, cb, index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if PoliceCount <= Config.MinimumStoreRobberyPolice then
        return false
    end
    if not Safes[index] then
        print(Lang:t('error.invalidSafe') .. tostring(index))
        return
    end

    if Safes[index].robbed then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.safeRobbed'), 'error')
        return
    end

    if not checkDistance(src, Safes[index].loc, 3.0) then
        return
    end

    if Player.Functions.RemoveItem('thermite', 1, false) then
        TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items['thermite'], "remove")
        local thermiteTime = math.random(SafeConfig.thermiteCooldownTime.min * 1000, SafeConfig.thermiteCooldownTime.max * 1000)
        hitSafes[index] = true
        coolDown('thermiteCooldown', index, thermiteTime)
        cb({bool = true, thermiteTime = thermiteTime})
        return
    end

    cb({bool = false, thermiteTime = 10000000000000})
end)

RegisterNetEvent('qb-storerobbery:server:thermiteSafe', function(index)
    local src = source
    if PoliceCount <= Config.MinimumStoreRobberyPolice then
        return
    end
    if not checkDistance(src, Safes[index].loc, 3.0) then
        return
    end
    if not Safes[index] then
        print(Lang:t('error.invalidSafe') .. tostring(index))
        return
    end

    if Safes[index].robbed then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.safeRobbed'), 'error')
        return
    end

    if thermiteWait[index] then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.thermiteCooldown'), 'error')
        return
    end

    if not hitSafes[index] then
        print(Lang:t('error.notThermited') .. tostring(src))
        return
    end

    hitSafes[index] = nil

    Safes[index].thermited = true
    GlobalState.StoreRobberySafes = Safes
    coolDown('resetThermite', index, SafeConfig.resetThermite)
end)

RegisterNetEvent('qb-storerobbery:server:collectFromSafe', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if PoliceCount <= Config.MinimumStoreRobberyPolice then
        return
    end
    if not Safes[index] then
        print(Lang:t('error.invalidSafe') .. tostring(index))
        return
    end

    if not checkDistance(src, Safes[index].loc, 3.0) then
        return
    end

    if Safes[index].robbed then
        TriggerClientEvent('QBCore:Notify', src, Lang:t('error.safeRobbed'), 'error')
        return
    end

    if not Safes[index].thermited then
        print(Lang:t('error.notThermited') .. tostring(src))
        return
    end

    local cash = math.random(SafeConfig.cashMin, SafeConfig.cashMax)
    Player.Functions.AddMoney('cash', cash, "store-robbery")

    Safes[index].thermited = false
    Safes[index].robbed = true
    GlobalState.StoreRobberySafes = Safes
    coolDown('robSafe', index, SafeConfig.safeResetTime)
end)

RegisterNetEvent('qb-storerobbery:server:alertPolice', function()
    local src = source

    if PoliceCount <= Config.MinimumStoreRobberyPolice then
        return
    end

    local coords = GetEntityCoords(GetPlayerPed(src))
    TriggerClientEvent('qb-storerobbery:client:alertPolice', -1, coords)
end)

RegisterNetEvent('qb-storerobbery:server:busyRegister', function(index)
    if not Registers[index] then
        return
    end
    Registers[index].busy = not Registers[index].busy
    GlobalState.StoreRobberyRegisters = Registers
end)

RegisterNetEvent('qb-storerobbery:server:busySafe', function(index)
    if not Safes[index] then
        return
    end
    Safes[index].busy = not Safes[index].busy
    GlobalState.StoreRobberySafes = Safes
end)

RegisterNetEvent('qb-storerobbery:server:removeLockpick', function(register)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not checkDistance(src, Registers[register].loc, 5.0) then
        local itemCount = Player.Functions.GetItemByName('lockpick')
        local adv = Player.Functions.GetItemByName('advancedlockpick')
        if itemCount and itemCount.amount > 0 then
            Player.Functions.RemoveItem('lockpick', itemCount.amount)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lockpick'], "remove")
        end
        if adv and adv.count > 0 then
            Player.Functions.RemoveItem('advancedlockpick', adv.count)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['advancedlockpick'], "remove")
        end
    end
    if Player.Functions.RemoveItem('lockpick', 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['lockpick'], "remove")
        return
    end
    if Player.Functions.RemoveItem('advancedlockpick', 1) then
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['advancedlockpick'], "remove")
        return
    end
end)

QBCore.Functions.CreateCallback('qb-storerobbery:server:getPoliceCount', function(source, cb)
    local policeCount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player then
            local PlayerJob = Player.PlayerData.job
            if (PlayerJob.name == 'police' or PlayerJob.type == 'leo') and PlayerJob.onduty then
                policeCount = policeCount + 1
            end
        end
    end
    PoliceCount = policeCount
    cb(policeCount)
end)