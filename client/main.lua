
local function isDead()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.metadata['isdead'] or PlayerData.metadata['inlaststand'] then
        return true
    end
    return false
end

local function isGovernment()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        return true
    end
    return false
end

local function runRegisterChecks(k)
    if not getPoliceCount() then
        QBCore.Functions.Notify(Lang:t('error.not_enough_police') .. Config.MinimumStoreRobberyPolice, 'error')
        return false
    end
    local state = GlobalState.StoreRobberyRegisters[k]
    if state.robbed or state.busy then
        return false
    end

    if isDead() then
        return false
    end

    if isGovernment() then
        return false
    end
    return true
end

local function runSafeChecks(k)
    if not getPoliceCount() then
        QBCore.Functions.Notify(Lang:t('error.not_enough_police') .. Config.MinimumStoreRobberyPolice, 'error')
        return false
    end
    local state = GlobalState.StoreRobberySafes[k]
    if state.robbed or state.busy or state.thermited then
        return false
    end

    if isDead() then
        return false
    end

    if isGovernment() then
        return false
    end
    return true
end

local function checkLockpicks()
    if QBCore.Functions.HasItem('lockpick') or QBCore.Functions.HasItem('advancedlockpick') then
        return true
    end
    return false
end


local function failRegister()
    local lockPickChance = math.random(1, 100)
    if lockPickChance <= 20 then
        TriggerServerEvent('qb-storerobbery:server:removeAdvancedLockpick')
    end
    AlertPoliceRegister()
end

local function robRegister(Register)
    if not getPoliceCount() then
        QBCore.Functions.Notify(Lang:t('error.not_enough_police') .. Config.MinimumStoreRobberyPolice, 'error')
        return false
    end
    boolBusyRegister(Register)
    if not runRegisterChecks(Register) then
        boolBusyRegister(Register)
        return
    end

    if not checkLockpicks() then
        QBCore.Functions.Notify(Lang:t('error.no_lockpick'), 'error')
        boolBusyRegister(Register)
        return false
    end

    local pass = exports['qb-minigames']:Lockpick(1)
    if not pass then
        boolBusyRegister(Register)
        failRegister()
        return
    end

    QBCore.Functions.Progressbar('rob_register', Lang:t('rob.register'), 4500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_arresting",
        anim = 'a_uncuff',
        flags = 16,
    }, {}, {}, function()
        boolBusyRegister(Register)
        TriggerServerEvent('qb-storerobbery:server:robRegister', Register)
    end, function()
        boolBusyRegister(Register)
        QBCore.Functions.Notify(Lang:t('error.process_canceled'), 'error')
    end)
end

local function insertPassword(Register)
    if not getPoliceCount() then
        QBCore.Functions.Notify(Lang:t('error.not_enough_police') .. Config.MinimumStoreRobberyPolice, 'error')
        return false
    end
    boolBusySafe(Register)
    local input = exports['qb-input']:ShowInput({
        header = Lang:t('inputSafe.header'),
        submitText = Lang:t('inputSafe.submit'),
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'combination',
                text = 'Combination'
            }
        }
    })
    if type(input) ~= 'table' then boolBusySafe(Register) return end
    boolBusySafe(Register)
    TriggerServerEvent('qb-storerobbery:server:openSafe', Register, tonumber(input.combination))
end

local function thermiteSafe(Safe,loc, rot)
    if not getPoliceCount() then
        QBCore.Functions.Notify(Lang:t('error.not_enough_police') .. Config.MinimumStoreRobberyPolice, 'error')
        return false
    end
    boolBusySafe(Safe)
    if not QBCore.Functions.HasItem('thermite') then
        boolBusySafe(Safe)
        return
    end
 
    local canThermite = QBCore.Functions.TriggerCallback('qb-storerobbery:server:canThermite', Safe)
    if not canThermite then
        boolBusySafe(Safe)
        return
    end

    requestModel('hei_prop_heist_thermite', 2000)
    requestParticle('scr_ornate_heist')
    local thermite = CreateObject('hei_prop_heist_thermite', vector3(loc.x, loc.y, loc.z), true, false, false)
    FreezeEntityPosition(thermite, true)
    SetEntityRotation(thermite, rot.x, rot.y, rot.z, 3, true )
    QBCore.Functions.LookAtEntity(thermite, 1000, -1)

    local finished = promise.new()
    QBCore.Functions.Progressbar('plant_thermite', Lang:t('rob.plantThermite'), 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
    }, {}, {}, function()
        finished:resolve(true)
    end, function()
        finished:resolve(false)
        boolBusySafe(Safe)
        QBCore.Functions.Notify(Lang:t('error.process_canceled'), 'error')
    end)

    local progressBarComplete = Citizen.Await(finished)
    finished = nil

    if not progressBarComplete then
        DeleteEntity(thermite)
        return
    end

    Wait(1000)
    dispatch()
    local therm = StartParticleFxLoopedOnEntity('scr_heist_ornate_thermal_burn', thermite, 0.0, 1.4, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
    Wait(canThermite.thermiteTime)
    StopParticleFxLooped(therm, true)
    DeleteEntity(thermite)
    TriggerServerEvent('qb-storerobbery:server:thermiteSafe', Safe)
    boolBusySafe(Safe)
end

local function initRegisters()
    for k, v in pairs(GlobalState.StoreRobberyRegisters) do
        if Config.UseTarget then
            exports['qb-target']:AddBoxZone('register_' .. k, v.loc, v.zones.length, v.zones.width, {
                name = 'register_' .. k,
                heading = 0,
                debugPoly = false,
                minZ = v.loc.z - 1,
                maxZ = v.loc.z + 1,
            }, {
                options = {
                    {
                        type = 'client',
                        icon = Lang:t('targets.robRegisterIcon'),
                        label = Lang:t('targets.robRegister'),
                        action = function()
                            robRegister(k)
                        end,
                        canInteract = function()
                            return runRegisterChecks(k)
                        end
                    }
                },
                distance = 2.5,
            })
        else
            local isInZone = false
            local function regLoop(register)
                CreateThread(function()
                    while isInZone do
                        local state = GlobalState.StoreRobberyRegisters[register]
                        if state.busy or state.robbed then
                            goto continue
                        end
                        if IsControlJustPressed(0, 23) then
                            if not getPoliceCount() then
                                QBCore.Functions.Notify(Lang:t('error.not_enough_police') .. Config.MinimumStoreRobberyPolice, 'error')
                                break
                            end
                            if runRegisterChecks(register) then
                                robRegister(k)
                                isInZone = false
                                break
                            end
                        end
                        ::continue::
                        Wait(1)
                    end
                end)
            end
            local box = BoxZone:Create(v.loc, v.zones.length, v.zones.width, {
                name = 'srReg'..k,
                heading = v.loc.w or 180.0,
                minZ = v.loc.z - 1.0,
                maxZ = v.loc.z + 1,
                debugPoly = false
            })
            box:onPlayerInOut(function(inside)
                if inside then
                    isInZone = true
                    if runRegisterChecks(k) then
                        regLoop(k)
                        exports['qb-core']:DrawText(Lang:t('targets.robRegisterDT'))
                    end
                else
                    isInZone = false
                    exports['qb-core']:HideText()
                end
            end)
        end
    end 
    for k, v in pairs(GlobalState.StoreRobberySafes) do
        if Config.UseTarget then
            exports['qb-target']:AddBoxZone('safe_' .. k, v.loc, 1.0, 1.0, {
                name = 'safe_' .. k,
                heading = 0,
                debugPoly = false,
                minZ = v.loc.z - 1,
                maxZ = v.loc.z + 1,
            }, {
                options = {
                    {
                        type = 'client',
                        icon = Lang:t('targets.robSafeIcon'),
                        label = Lang:t('targets.robSafe'),
                        action = function()
                            insertPassword(k)
                        end,
                        canInteract = function()
                            return runSafeChecks(k)
                        end
                    },
                    {
                        icon = Lang:t('targets.thermiteSafeIcon'),
                        label = Lang:t('targets.thermiteSafe'),
                        item = 'thermite',
                        action = function()
                            thermiteSafe(k, v.loc, v.rotation)
                        end,
                        canInteract = function()
                            local state = GlobalState.StoreRobberySafes[k]
                            if state.robbed or state.busy then
                                return false
                            end
                            return runSafeChecks(k)
                        end
                    },
                    {
                        icon = Lang:t('targets.collectFromSafeIcon'),
                        label = Lang:t('targets.collectFromSafe'),
                        action = function()
                            boolBusySafe(k)
                            TriggerServerEvent('qb-storerobbery:server:collectFromSafe', k)
                            boolBusySafe(k)
                        end,
                        canInteract = function()
                            local state = GlobalState.StoreRobberySafes[k]
                            if state.robbed or state.busy or not state.thermited then
                                return false
                            end
                            return true
                        end
                    }
                },
                distance = 2.5,
            })
        else
            local isActive = false
            local function safeLoop(safe)
                CreateThread(function()
                    while isActive do
                        Wait(1)
                        local state = GlobalState.StoreRobberySafes[safe]
                        if state.busy or state.robbed then
                            goto continue
                        end
                        if IsControlJustPressed(0, 23) then
                            if not getPoliceCount() then
                                QBCore.Functions.Notify(Lang:t('error.not_enough_police') .. Config.MinimumStoreRobberyPolice, 'error')
                                break
                            end
                            if state.thermited then
                                boolBusySafe(safe)
                                TriggerServerEvent('qb-storerobbery:server:collectFromSafe', safe)
                                boolBusySafe(safe)
                                break
                            end
                            if not state.thermited and not state.robbed then
                                insertPassword(safe)
                                break
                            end
                        end
                        if IsControlJustPressed(0,47 ) then
                            if not getPoliceCount() then
                                QBCore.Functions.Notify(Lang:t('error.not_enough_police') .. Config.MinimumStoreRobberyPolice, 'error')
                                break
                            end
                            if not state.thermited and not state.robbed then
                                thermiteSafe(safe, state.loc, state.rotation)
                            end
                        end
                        ::continue::
                    end
                end)
            end
            local box = BoxZone:Create(v.loc, v.zones.length, v.zones.width, {
                name = 'srSafe'..k,
                heading = v.loc.w or 180.0,
                minZ = v.loc.z - 1.0,
                maxZ = v.loc.z + 1,
                debugPoly = false
            })
            box:onPlayerInOut(function(inside)
                local state = GlobalState.StoreRobberySafes[k]
                if inside then
                    isActive = true
                    local txt = ''
                    if (not state.busy) and (not state.robbed) and (not state.thermited) then
                        txt = txt .. Lang:t('targets.robSafeDT')
                        if QBCore.Functions.HasItem('thermite') then
                            txt = txt .. Lang:t('targets.thermiteSafeDT')
                        end
                    end
                    if not state.busy and not state.robbed and state.thermited then
                        txt = txt .. Lang:t('targets.collectFromSafeDT')
                    end
                    safeLoop(k)
                    if txt ~= '' then
                        exports['qb-core']:DrawText(txt)
                    end
                else
                    isActive = false
                    exports['qb-core']:HideText()
                end
            end)
        end
    end
end

initRegisters()

QBCore.Functions.CreateClientCallback('qb-storerobbery:client:openSafe', function(cb)
    local finished = promise.new()
    QBCore.Functions.Progressbar('plant_thermite', Lang:t('text.unlocking'), 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
    }, {}, {}, function()
        finished:resolve(true)
        finished = nil
    end, function()
        finished:resolve(false)
        finished = nil
        QBCore.Functions.Notify(Lang:t('error.process_canceled'), 'error')
    end)
     cb(Citizen.Await(finished))
end)