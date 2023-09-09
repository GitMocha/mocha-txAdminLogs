-- Simply Logs txAdmin Menu actions to discord for those that wanted it.

if Shared.txAdminLogger then
    AddEventHandler('txsv:logger:menuEvent', function(source, action, allowed, data)
        if not allowed then return end
        local message
        local src = source

        --SELF menu options
        if action == 'playerModeChanged' then
            if data == 'godmode' then
                message = "enabled god mode"
            elseif data == 'noclip' then
                message = "enabled noclip"
            elseif data == 'superjump' then
                message = "enabled super jump"
            elseif data == 'none' then
                message = "became mortal (standard mode)"
            else
                message = "changed playermode to unknown"
            end
    
        elseif action == 'teleportWaypoint' then
            message = "teleported to a waypoint"
    
        elseif action == 'teleportCoords' then
            if type(data) ~= 'table' then return end
            local x = data.x
            local y = data.y
            local z = data.z
            message = ("teleported to coordinates (x=%.3f, y=%0.3f, z=%0.3f)"):format(x or 0.0, y or 0.0, z or 0.0)
    
        elseif action == 'spawnVehicle' then
            if type(data) ~= 'string' then return end
            message = "spawned a vehicle (model: " .. data .. ")"
    
        elseif action == 'deleteVehicle' then
            message = "deleted a vehicle"
    
        elseif action == 'vehicleRepair' then
            message = "repaired their vehicle"
    
        elseif action == 'vehicleBoost' then
            message = "boosted their vehicle"
    
        elseif action == 'healSelf' then
            message = "healed themself"
    
        elseif action == 'healAll' then
            message = "healed all players!"
    
        elseif action == 'announcement' then
            if type(data) ~= 'string' then return end
            message = "made a server-wide announcement: " .. data
    
        elseif action == 'clearArea' then
            if type(data) ~= 'number' then return end
            message = "cleared an area with ".. data .."m radius"
    
        --INTERACTION modal options
        elseif action == 'spectatePlayer' then
            message = 'started spectating player ' .. GetPlayerName(data)
    
        elseif action == 'freezePlayer' then
            message = 'toggled freeze on player ' .. GetPlayerName(data)
    
        elseif action == 'teleportPlayer' then
            if type(data) ~= 'table' then return end
            local playerName = GetPlayerName(data.target)
            local x = data.x or 0.0
            local y = data.y or 0.0
            local z = data.z or 0.0
            message = ("teleported to player %s (x=%.3f, y=%.3f, z=%.3f)"):format(playerName, x, y, z)
    
        elseif action == 'healPlayer' then
            message = "healed player " .. GetPlayerName(data)
    
        elseif action == 'summonPlayer' then
            message = "summoned player " .. GetPlayerName(data)
    
        --TROLL modal options
        elseif action == 'drunkEffect' then
            message = "triggered drunk effect on " .. GetPlayerName(data)
    
        elseif action == 'setOnFire' then
            message = "set ".. GetPlayerName(data) .." on fire" 
    
        elseif action == 'wildAttack' then
            message = "triggered wild attack on " .. GetPlayerName(data)
    
        elseif action == 'showPlayerIDs' then
            if type(data) ~= 'boolean' then return end
            if data then
                message = "turned show player IDs on"
            else
                message = "turned show player IDs off"
            end
    
        --In case of unknown event
        else
            -- logger(source, 'DebugMessage', "unknown menu event "..action)
            return
        end

        -- logger(source, 'MenuEvent', {
        --     action = action,
        --     message = message
        -- })
        TriggerEvent('qb-log:server:CreateLog', 'mochalogs', 'txAdmin Action Logger', 'red', ('**Source:** %s \n**Action:** %s \n**Message:** %s '):format(GetPlayerName(src), action, message)) 
    end)

end