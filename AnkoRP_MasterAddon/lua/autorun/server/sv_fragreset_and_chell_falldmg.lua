--[[
    Retain frags if the player's team is the same,
    and remove fall damage from Chell.
]]--

hook.Add("PlayerChangedTeam", "SaveKillsInSameTeam", function( ply, old, new )

    if !RPExtraTeams then return end
    if old == 0 or old == 1001 or new == 0 or new == 1001 then return end

    local oldTeam = -1
    local newTeam = -1
    
    for k,v in pairs( RPExtraTeams ) do
        if v.team == old then
            oldTeam = v
        end
        if v.team == new then
            newTeam = v
        end
    end
    if newTeam.category != oldTeam.category then
        ply:SetFrags( 0 )
    end

    if ply:getJobTable().category == "Citizens" then
        for k,v in pairs( player.GetAll() ) do
            if v:GetNWEntity( "Bounty_Target", NULL ) == ply then
                v:SetNWEntity( "Bounty_Target", NULL )
                v:SetNWBool( "Bounty_IsActive", true )
                v:SetNWInt( "Bounty_Payout", 0 )
                DarkRP.notify( v, 1, 4, "Your bounty is no longer a combatant and therefore was cancelled." )
                DarkRP.notify( v, 1, 4, "You suffered no penalty." )
            end
        end

        for k,v in pairs( ents.FindByClass( "st_crime_boss" ) ) do
            for a,b in pairs( v.Jobs ) do
                if b == ply then
                    v.Jobs[ a ] = NULL
                    v.HasJob[ a ] = false
                end
            end
        end
    end

    if CURRENT_ANKORP_EVENT and #GetCombatants() <= 2 and #GetActiveTeams() <= 1 then
        DarkRP.notify( player.GetAll(), 1, 4, "There are no longer enough combatants for the current Money Event.  It has been cancelled." )
        for k,v in pairs( player.GetAll() ) do
            v:SetNWBool( "HasGold", false )
            v:SetNWBool( "HasSmallGems", false )
            v:SetNWBool( "HasLargeGems", false )
        end
        for k,v in pairs( ents.FindByClass( "st_ankorp_gold" ) ) do
            v:Remove()
        end
        for k,v in pairs( ents.FindByClass( "st_ankorp_lggems" ) ) do
            v:Remove()
        end
        for k,v in pairs( ents.FindByClass( "st_ankorp_money" ) ) do
            v:Remove()
        end
        for k,v in pairs( ents.FindByClass( "st_ankorp_smgems" ) ) do
            v:Remove()
        end
        for k,v in pairs( ents.FindByClass( "st_weapon_box" ) ) do
            v:Remove()
        end
        for k,v in pairs( ents.GetAll() ) do
            if v.REMOVEONEVENT then
                v:Remove()
            end
        end
        CURRENT_ANKORP_EVENT = false
        game.GetWorld():SetNWString( "EventLoc", "" )
        game.GetWorld():SetNWString( "EventEnt", "" )
    end

end )

hook.Add( "GetFallDamage", "NoChellFDamage", function( ply, _ )
    if ply:Team() == TEAM_CHELL or ply:Team() == TEAM_FZOMBIE then return 0 end
end )
