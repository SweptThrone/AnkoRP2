--[[
    Some global functions used for convenience.
]]--

function GetFinalParent( wep )
    if CSO_WEAPONS_TREE[ wep ].parent == "nil" then
        return wep
    end

    local finalParent = wep
    for _ = CSO_WEAPONS_TREE[ wep ].deep, 2, -1 do
        finalParent = CSO_WEAPONS_TREE[ finalParent ].parent
    end

    return finalParent
end

function GetCombatants()
    local combat = {}
    for k,v in pairs( player.GetAll() ) do
        if v:getJobTable().category != "Citizens" and v:getJobTable().category != "Monsters" then
            table.insert( combat, v )
        end
    end
    return combat
end

function GetActiveTeams()
    local active = {}
    for k,v in pairs( player.GetAll() ) do
        if v:getJobTable().category != "Citizens" and v:getJobTable().category != "Monsters" and !table.HasValue( active, v:getJobTable().category ) then
            table.insert( active, v:getJobTable().category )
        end
    end
    return active
end

local plyMeta = FindMetaTable( "Player" )

function plyMeta:IsCombatant()
    return self:getJobTable().category != "Citizens" and self:getJobTable().category != "Monsters"
end