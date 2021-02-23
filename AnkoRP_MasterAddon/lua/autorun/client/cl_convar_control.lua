--[[
    Initialize a ConVar for console spam and the old HUD
]]--

hook.Add( "AddToolMenuCategories", "CustomCategory", function()
	spawnmenu.AddToolCategory( "Utilities", "AnkoRP", "AnkoRP" )
end )

hook.Add( "PopulateToolMenu", "CustomMenuSettings", function()
	spawnmenu.AddToolMenuOption( "Utilities", "AnkoRP", "AnkoRP_Convars", "Settings", "", "", function( panel )
		panel:ClearControls()
		panel:CheckBox( "Kill reward breakdown?", "cl_anko_killrewardbreakdown" )
		panel:CheckBox( "Use KDGaming HUD?", "cl_anko_classichud" )
	end )
end )

hook.Add( "Initialize", "SetUpDebugSpamConvar", function()
    CreateClientConVar( "cl_anko_killrewardbreakdown", "0", true, true, "Fill console with nine lines per kill, explaining your cash breakdown?", 0, 1 )
    CreateClientConVar( "cl_anko_classichud", "0", true, true, "Use the classic KDGaming HUD instead of the modern AnkoHUD?", 0, 1 )
end )
