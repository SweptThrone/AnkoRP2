local function SetTeamSpawnPos(ply, args)
    local pos = ply:GetPos()
    local t

    for k, v in pairs(RPExtraTeams) do
        if args == v.category then
            t = k
            DarkRP.notify(ply, 0, 4, DarkRP.getPhrase("updated_spawnpos", v.name))
        end
    end

    if t then
        for a,b in pairs( RPExtraTeams ) do
            if b.category == RPExtraTeams[ t ].category then
                DarkRP.storeTeamSpawnPos(a, {pos.x, pos.y, pos.z})
            end
        end
    else
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("could_not_find", tostring(args)))
    end
end
DarkRP.definePrivilegedChatCommand("settspawn", "DarkRP_AdminCommands", SetTeamSpawnPos)
DarkRP.declareChatCommand{
    command = "settspawn",
    description = "Set a category spawn.",
    delay = 0.5
}

local function AddTeamSpawnPos(ply, args)
    local pos = ply:GetPos()
    local t

    for k, v in pairs(RPExtraTeams) do
        if args == v.category then
            t = k
            DarkRP.notify(ply, 0, 4, DarkRP.getPhrase("created_spawnpos", v.name))
        end
    end

    if t then
        for a,b in pairs( RPExtraTeams ) do
            if b.category == RPExtraTeams[ t ].category then
                DarkRP.addTeamSpawnPos(a, {pos.x, pos.y, pos.z})
            end
        end
    else
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("could_not_find", tostring(args)))
    end
end
DarkRP.definePrivilegedChatCommand("addtspawn", "DarkRP_AdminCommands", AddTeamSpawnPos)
DarkRP.declareChatCommand{
    command = "addtspawn",
    description = "Add a category spawn.",
    delay = 0.5
}

local function RemoveTeamSpawnPos(ply, args)
    local t

    for k, v in pairs(RPExtraTeams) do
        if args == v.category then
            t = k
            DarkRP.notify(ply, 0, 4, DarkRP.getPhrase("remove_spawnpos", v.name))
        end
    end

    if t then
        for a,b in pairs( RPExtraTeams ) do
            if b.category == RPExtraTeams[ t ].category then
                DarkRP.removeTeamSpawnPos(a)
            end
        end
    else
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("could_not_find", tostring(args)))
    end
end
DarkRP.definePrivilegedChatCommand("removetspawn", "DarkRP_AdminCommands", RemoveTeamSpawnPos)
DarkRP.declareChatCommand{
    command = "removetspawn",
    description = "Remove a category spawn.",
    delay = 0.5
}
