local copCount = nil
function requestModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
end

function requestParticle(asset)
    if not HasNamedPtfxAssetLoaded(asset) then
        RequestNamedPtfxAsset(asset)
    end
    while not HasNamedPtfxAssetLoaded(asset) do
        Wait(0)
    end
    SetPtfxAssetNextCall(asset)
end

function dispatch()
    TriggerServerEvent('qb-storerobbery:server:alertPolice')
    CreateThread(function()
        local alarmCount = 5
        repeat
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 30.0, 'security-alarm', 0.5)
            Wait(4000)
            alarmCount = alarmCount - 1
        until alarmCount == 0
    end)
end

function AlertPoliceRegister()
    if Config.AlertPoliceRegister <= math.random(1, 100) then
        dispatch()
    end
end

function AlertPoliceSafe()
    if Config.AlertPoliceSafe <= math.random(1, 100) then
        dispatch()
    end
end

RegisterNetEvent('qb-storerobbery:client:alertPolice', function(coords)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local PlayerJob = PlayerData.job
    if (PlayerJob.name == 'police' or PlayerJob.type == 'leo') and PlayerJob.onduty then
        PlaySound(-1, 'Lose_1st', 'GTAO_FM_Events_Soundset', 0, 0, 1)
        TriggerServerEvent('police:server:policeAlert', Lang:t('police.police_alert'))
        local transG = 250
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 458)
        SetBlipColour(blip, 1)
        SetBlipDisplay(blip, 4)
        SetBlipAlpha(blip, transG)
        SetBlipScale(blip, 1.0)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Lang:t('police.shopRobbery'))
        EndTextCommandSetBlipName(blip)
        while transG ~= 0 do
            Wait(180 * 4)
            transG = transG - 1
            SetBlipAlpha(blip, transG)
            if transG == 0 then
                SetBlipSprite(blip, 2)
                RemoveBlip(blip)
                return
            end
        end
    end
end)

function boolBusyRegister(Register)
    TriggerServerEvent('qb-storerobbery:server:busyRegister', Register)
end

function boolBusySafe(index)
    TriggerServerEvent('qb-storerobbery:server:busySafe', index)
end

function getPoliceCount()
    if copCount then
        return copCount == Config.MinimumStoreRobberyPolice
    end
    copCount = QBCore.Functions.TriggerCallback('qb-storerobbery:server:getPoliceCount')
    CreateThread(function()
        Wait(0.5 * 60 * 1000)
        copCount = nil
    end)
    return copCount == Config.MinimumStoreRobberyPolice
end