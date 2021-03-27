--[[
    Print random tips on death,
    and play some sounds when certain jobs die.
]]--
local ANKORP_TIPS = {
    "Switching to another weapon is typically faster than reloading!",
    "You can carry more than one weapon per slot!",
    "Babygod lasts for ten seconds unless you shoot!",
    "Higher killstreaks award you with more money per kill!",
    "Killing players with more kills awards you with more money!",
    "Smaller weapons award you with more money!",
    "Monsters gain full health when they kill someone!",
    "Use console command st_ping_loc to call out locations to your team!",
    "The Vs over players' heads are your teammates!",
    "These tips only show up 25% of the time!",
	"Visit the Crime Boss at the Club to pick up a Bounty!",
	"Hold shift to run up stairs without flying off!",
	"Check the Utilities menu in the spawnmenu for extra options!",
	"Hit F1 to view the map!"
}

hook.Add( "PlayerDeath", "DifferentKillSounds", function( vic, inf, atk )
    if math.random( 1, 4 ) == 1 then
        DarkRP.notify( vic, 0, 10, "Tip: " .. table.Random( ANKORP_TIPS ) )
    end

    -- Custom death sounds based on which job you were.
    if vic:getJobTable().category == "Monsters" then
        vic:EmitSound( "npc/zombie/zombie_pain" .. math.random( 1, 6 ) .. ".wav" )
    end
    
    if vic:Team() == TEAM_SOLDIER or vic:Team() == TEAM_ELITE or vic:Team() == TEAM_GUARD then
        vic:EmitSound( "npc/combine_soldier/die" .. math.random( 1, 3 ) .. ".wav" )
    end
    
    if vic:Team() == TEAM_POLICE then
        vic:EmitSound( "npc/metropolice/die" .. math.random( 1, 4 ) .. ".wav" )
    end
    
    if vic:Team() == TEAM_ALYX then
        vic:EmitSound( "vo/npc/alyx/uggh0" .. math.random( 1, 2 ) .. ".wav" )
    end
    
    if vic:Team() == TEAM_BARNEY then
        vic:EmitSound( "vo/npc/barney/ba_pain0" .. math.random( 1, 9 ) .. ".wav" )
    end
    
    if vic:Team() == TEAM_GRIGORI then
        vic:EmitSound( "vo/ravenholm/monk_pain0" .. math.random( 1, 9 ) .. ".wav" )
    end
end )