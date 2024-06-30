--[[
	All of this simply draws a V over your teammates' heads.
]]--

hook.Add( "PostDrawOpaqueRenderables", "GetChevronOverPlayers", function()

    LocalPlayer().teammateChevrons = {}
    for k,v in pairs( player.GetAll() ) do
        if v:getJobTable() != nil and 
            v:getJobTable() != {} and 
            v:getJobTable().category == LocalPlayer():getJobTable().category and
            v:getJobTable().category != "Citizens" and 
            LocalPlayer():getJobTable().category != "Citizens" then
            LocalPlayer().teammateChevrons[ v:EntIndex() ] = ( v:GetPos() + Vector( 0, 0, 72 ) ):ToScreen()
        end
    end

end )

hook.Add( "HUDPaint", "DrawChevronsOverTeammates", function()

    for k,v in pairs( LocalPlayer().teammateChevrons ) do
		if Entity( k ):Alive() and !Entity( k ):IsDormant() then
			surface.SetFont( "STChevronText" )
			surface.SetTextColor( Entity( k ):GetPlayerColor():ToColor() )
			surface.SetTextPos( v.x - 8, v.y )
			surface.DrawText( "V" )
		end
    end

end )