--[[
    Initialize a client-side ConVar for reward breakdown spam.
]]--

hook.Add( "Initialize", "SetUpDebugSpamConvar", function()
    CreateClientConVar( "cl_anko_killrewardbreakdown", "0", true, true, "Fill console with nine lines per kill, explaining your cash breakdown?", 0, 1 )
end )