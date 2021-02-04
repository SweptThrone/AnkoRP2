--[[
    Define a function to start an event.
]]--

local lootEntLUT = {
    [ "money" ] = "st_ankorp_money",
    [ "gold" ] = "st_ankorp_gold",
    [ "weapons" ] = "st_weapon_box",
}

function StartEvent( location, loot )
    game.GetWorld():SetNWString( "EventLoc", location )
    game.GetWorld():SetNWString( "EventEnt", loot )
    CURRENT_ANKORP_EVENT = true

    for k,v in pairs( LOOT_SPAWNS ) do
        if location == v.loc and location != "richman" then
            if lootEntLUT[ loot ] == v.ent then
                local lootEnt = ents.Create( v.ent )
                lootEnt:SetPos( v.pos )
                lootEnt:SetAngles( v.ang )
                lootEnt:Spawn()
                lootEnt:GetPhysicsObject():EnableMotion( false )
            end
        end
        if location == "richman" and location == v.loc then
            local lootEnt = ents.Create( v.ent )
            lootEnt:SetPos( v.pos )
            lootEnt:SetAngles( v.ang )
            lootEnt:Spawn()
            lootEnt:GetPhysicsObject():EnableMotion( false )
        end
    end
    if location == "worldcorp" then
        local worldCorpTable = ents.Create( "prop_physics" )
        worldCorpTable:SetPos( Vector( -637.683960, 5089.089355, 1780.333130 ) )
        worldCorpTable:SetAngles( Angle( 0, -90, 0 ) )
        worldCorpTable:SetModel( "models/props_wasteland/kitchen_counter001b.mdl" )
        worldCorpTable:Spawn()
        worldCorpTable.REMOVEONEVENT = true
        worldCorpTable:GetPhysicsObject():EnableMotion( false )
    end

    net.Start( "ST_EventStarted" )
    net.Broadcast()
end