local CurrentCops = 0
local count = 0

local function requestModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
end

local function requestParticle(asset)
    if not HasNamedPtfxAssetLoaded(asset) then
        RequestNamedPtfxAsset(asset)
    end
    while not HasNamedPtfxAssetLoaded(asset) do
        Wait(0)
    end
    SetPtfxAssetNextCall(asset)
end

local function runRegisterChecks(k)
    count = count + 1
    if GlobalState.StoreRobberyRegisters[k].robbed then
        return false
    end
    if CurrentCops < Config.MinimumStoreRobberyPolice then
        return false
    end
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.metadata['isdead'] or PlayerData.metadata['inlaststand'] then
        return false
    end
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        return false
    end
    return true
end

local function runSafeChecks(k)
    if GlobalState.StoreRobberySafes[k].robbed then
        return false
    end
    if CurrentCops < Config.MinimumStoreRobberyPolice then
        return false
    end
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.metadata['isdead'] or PlayerData.metadata['inlaststand'] then
        return false
    end
    if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        return false
    end
    return true
end

local function checkLockpicks()
    if QBCore.Functions.HasItem('lockpick') then
        return true
    elseif QBCore.Functions.HasItem('advancedlockpick') then
        return true
    else
        return false
    end
end

local function alarm()
    CreateThread(function()
        local alarmCount = 10
        repeat
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 30.0, 'security-alarm', 0.5)
            Wait(3000)
            alarmCount = alarmCount - 1
        until alarmCount == 0
    end)
end

local function failRegister()
    local lockPickChance = math.random(1, 100)
    if lockPickChance <= 20 then
        TriggerServerEvent('qb-storerobbery:server:removeAdvancedLockpick')
    end
    local alarms = math.random(1, 100)
    if alarms <= 20 then
        alarm()
    end
end

local function initRegisters()
    for k, v in pairs(GlobalState.StoreRobberyRegisters ) do
        exports['qb-target']:AddBoxZone('register_' .. k, v.loc, 0.4, 0.6, {
            name = 'register_' .. k,
            heading = 0,
            debugPoly = false,
            minZ = v.loc.z - 1,
            maxZ = v.loc.z + 1,
        }, {
            options = {
                {
                    type = 'client',
                    icon = 'fas fa-hand-holding-usd',
                    label = 'Rob Register',
                    action = function()
                        if not checkLockpicks() then
                            QBCore.Functions.Notify(Lang:t('error.no_lockpick'), 'error')
                            return false
                        end
                        local pass = exports['qb-minigames']:Lockpick(1)
                        if not pass then
                            failRegister()
                            return
                        end
                        QBCore.Functions.Progressbar('rob_register', Lang:t('text.rob_register'), 4500, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "mp_arresting",
                            anim = 'a_uncuff',
                            flags = 16,
                        }, {}, {}, function()
                            TriggerServerEvent('qb-storerobbery:server:robRegister', k)
                        end, function()
                            QBCore.Functions.Notify(Lang:t('error.process_canceled'), 'error')
                        end)
                    end,
                    canInteract = function()
                        return runRegisterChecks(k)
                    end
                }
            },
            distance = 2.5,
        })
    end
    for k, v in pairs (GlobalState.StoreRobberySafes) do
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
                    icon = 'fas fa-dungeon',
                    label = 'Unlock Safe',
                    action = function()
                        local input = exports['qb-input']:ShowInput({
                            header = 'Safe Combination',
                            submitText = 'Submit',
                            inputs = {
                                {
                                    type = 'number',
                                    isRequired = true,
                                    name = 'combination',
                                    text = 'Combination'
                                }
                            }
                        })
                        if type(input) ~= 'table' then return end
                        TriggerServerEvent('qb-storerobbery:server:openSafe', k, tonumber(input.combination))
                    end,
                    canInteract = function()
                        return runSafeChecks(k)
                    end
                },
                {
                    icon = 'fas fa-eye',
                    label = 'Blow Up Safe',
                    item = 'thermite',
                    action = function()
                        if not QBCore.Functions.HasItem('thermite') then
                            return
                        end
                        local canThermite = QBCore.Functions.TriggerCallback('qb-storerobbery:server:canThermite', k)
                        if not canThermite then
                            return
                        end
                        local finished = false
                        requestModel('hei_prop_heist_thermite', 2000)
                        requestParticle('scr_ornate_heist')
                        local thermite = CreateObject('hei_prop_heist_thermite', vector3(v.loc.x, v.loc.y, v.loc.z), true, false, false)
                        FreezeEntityPosition(thermite, true)
                        SetEntityRotation(thermite, v.rotation.x, v.rotation.y, v.rotation.z, 3, true )
                        QBCore.Functions.LookAtEntity(thermite, 1000, -1)
                        QBCore.Functions.Progressbar('plant_thermite', Lang:t('text.plant_thermite'), 5000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                            anim = "machinic_loop_mechandplayer",
                        }, {}, {}, function()
                            finished = true
                        end)
                        repeat
                            Wait(10)
                        until finished or finished == nil
                        if not finished then
                            DeleteEntity(thermite)
                            return
                        end
                        finished = false
                        Wait(1000)
                        local therm = StartParticleFxLoopedOnEntity('scr_heist_ornate_thermal_burn', thermite, 0.0, 1.4, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
                        Wait(math.random(10000, 20000))
                        StopParticleFxLooped(therm, true)
                        DeleteEntity(thermite)
                        TriggerServerEvent('qb-storerobbery:server:thermiteSafe', k)
                    end,
                    canInteract = function()
                        if GlobalState.StoreRobberySafes[k].robbed then
                            return false
                        end
                        if GlobalState.StoreRobberySafes[k].thermited then
                            return false
                        end
                        return runSafeChecks(k)
                    end
                },
                {
                    icon = 'fas fa-sticky-note',
                    label = 'Collect From Safe',
                    action = function()
                        TriggerServerEvent('qb-storerobbery:server:collectFromSafe', k)
                    end,
                    canInteract = function()
                        if GlobalState.StoreRobberySafes[k].robbed then
                            return false
                        end
                        if not GlobalState.StoreRobberySafes[k].thermited then
                            return false
                        end
                        return true
                    end
                }
            },
            distance = 2.5,
        })
    end

end

initRegisters()
