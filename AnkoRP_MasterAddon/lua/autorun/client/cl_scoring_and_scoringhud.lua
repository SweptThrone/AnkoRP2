--[[
	HUD to draw current scores, current time,
	and information about current events.
]]--

local DISPLAY_SCORES = {
    { tem = "CT", score = 0 },
    { tem = "TR", score = 0 },
    { tem = "CM", score = 0 },
    { tem = "RE", score = 0 }
}

local scores = {
	["CT"] = 0,
	["TR"] = 0,
	["CM"] = 0,
	["RE"] = 0,
}

net.Receive( "SendAnkoScores", function( len )

	local dat = net.ReadData( len )

	scores = util.JSONToTable( util.Decompress( dat ) )

end )

local lootColLUT = {
	gems = Color( 166, 222, 255 ),
	money = Color( 158, 217, 173 ),
	gold = Color( 255, 240, 160 ),
	weapons = Color( 217, 160, 160 ),
	eggs = Color( 255, 200, 110 )
}
local locLUT = {
	[ "worldcorp" ] = "World Corp",
	[ "bank" ] = "Union Bank",
	[ "barge" ] = "The Barge",
	[ "remote" ] = "Remote",
	[ "richman" ] = "Richman",
	[ "eggs" ] = LocalPlayer():GetNWInt( "NumEggs", 0 ) .. " Eggs"
}
local locPos = {
	[ "worldcorp" ] = Vector( "-1216.555664 4793.572266 32.209515" ),
	[ "bank" ] = Vector( "-1536.038086 2169.774170 21.320343" ),
	[ "barge" ] = Vector( "12637.647461 -12563.388672 251.119675" ),
	[ "remote" ] = Vector( "-12982.264648 -9695.625977 -144.829605" ),
	[ "richman" ] = Vector( "-167.647278 255.750748 9.278425" )
}
local lootLUT = {
	[ "gold" ] = "GOLD",
	[ "money" ] = "CASH",
	[ "gems" ] = "GEMS",
	[ "weapons" ] = "GUNS"
}

hook.Add( "HUDPaint", "STShowTimer", function()

	--time left
	local timeLeft = math.max( game.GetWorld():GetNWInt( "AnkoNextRound" ) - CurTime(), 0 )
    local txt = string.FormattedTime( math.ceil( timeLeft ) ).m .. ":" .. 
        ( string.FormattedTime( math.ceil( timeLeft ) ).s < 10 and "0" or "" ) .. string.FormattedTime( math.ceil( timeLeft ) ).s

	surface.SetDrawColor( color_black )
	draw.NoTexture()

	if game.GetWorld():GetNWString( "EventLoc" ) != "" then
		surface.DrawPoly( {
			{ x = ScrW() / 2 - 93, y = 35 }, --upper left
			{ x = ScrW() / 2 - 49, y = 35 }, --upper right
			{ x = ScrW() / 2 - 40, y = 50 }, --lower right
			{ x = ScrW() / 2 - 85, y = 50 } --lower left
		} )

		surface.DrawPoly( {
			{ x = ScrW() / 2 + 49, y = 35 },
			{ x = ScrW() / 2 + 93, y = 35 },
			{ x = ScrW() / 2 + 85, y = 50 }, --lower right
			{ x = ScrW() / 2 + 40, y = 50 }
		} )

		surface.DrawPoly( {
			{ x = ScrW() / 2 - 85, y = 50 },
			{ x = ScrW() / 2 + 85, y = 50 },
			{ x = ScrW() / 2 + 65, y = 85 },
			{ x = ScrW() / 2 - 65, y = 85 }
		} )

		surface.SetDrawColor( lootColLUT[ game.GetWorld():GetNWString( "EventEnt" ) ] )
		draw.NoTexture()

		surface.DrawPoly( {
			{ x = ScrW() / 2 - 86, y = 37 }, --upper left
			{ x = ScrW() / 2 + 86, y = 37 }, --upper right
			{ x = ScrW() / 2 + 60, y = 80 }, --lower right
			{ x = ScrW() / 2 - 60, y = 80 } --lower left
		} )

		surface.SetFont( "UPGSmall" )
		surface.SetTextColor( color_black )
		surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( game.GetWorld():GetNWString( "EventLoc" ) == "eggs" and LocalPlayer():GetNWInt( "NumEggs", 0 ) .. " Eggs" or locLUT[ game.GetWorld():GetNWString( "EventLoc" ) ] ) / 2 ), 52 )
		surface.DrawText( game.GetWorld():GetNWString( "EventLoc" ) == "eggs" and LocalPlayer():GetNWInt( "NumEggs", 0 ) .. " Eggs" or locLUT[ game.GetWorld():GetNWString( "EventLoc" ) ] )

		if game.GetWorld():GetNWString( "EventLoc" ) != "eggs" then
			surface.SetFont( "STChevronText" )
			surface.SetTextColor( Color( 255, TimedSin( 1, 127, 255, 0 ), TimedSin( 1, 127, 255, 0 ), 64 ) )
			surface.SetTextPos( locPos[ game.GetWorld():GetNWString( "EventLoc" ) ]:ToScreen().x - surface.GetTextSize( "!" )/2, locPos[ game.GetWorld():GetNWString( "EventLoc" ) ]:ToScreen().y )
			surface.DrawText( "!" )
			surface.SetFont( "UPGMini" )
			surface.SetTextColor( Color( 255, TimedSin( 1, 127, 255, 0 ), TimedSin( 1, 127, 255, 0 ), 64 ) )
			surface.SetTextPos( locPos[ game.GetWorld():GetNWString( "EventLoc" ) ]:ToScreen().x - surface.GetTextSize( lootLUT[ game.GetWorld():GetNWString( "EventEnt" ) ] )/2, locPos[ game.GetWorld():GetNWString( "EventLoc" ) ]:ToScreen().y - 20 )
			surface.DrawText( lootLUT[ game.GetWorld():GetNWString( "EventEnt" ) ] )
		end
	end
	
	if LocalPlayer():GetNWBool( "HasGold" ) or LocalPlayer():GetNWBool( "HasSmallGems" ) or LocalPlayer():GetNWBool( "HasLargeGems" ) then
		surface.SetFont( "STChevronText" )
		surface.SetTextColor( Color( TimedCos( 1, 127, 255, 0 ), 255, TimedCos( 1, 127, 255, 0 ), 64 ) )
		surface.SetTextPos( Vector( 4016.228027, 8673.984375, 241.311050 ):ToScreen().x - surface.GetTextSize( "!" )/2, Vector( 4016.228027, 8673.984375, 241.311050 ):ToScreen().y )
		surface.DrawText( "!" )
		surface.SetFont( "UPGMini" )
		surface.SetTextColor( Color( TimedCos( 1, 127, 255, 0 ), 255, TimedCos( 1, 127, 255, 0 ), 64 ) )
		surface.SetTextPos( Vector( 4016.228027, 8673.984375, 241.311050 ):ToScreen().x - surface.GetTextSize( "PAWN" )/2, Vector( 4016.228027, 8673.984375, 241.311050 ):ToScreen().y - 20 )
		surface.DrawText( "PAWN" )
	end

	surface.SetDrawColor( color_black )
	draw.NoTexture()

	--small trapezoid under the Time
	surface.DrawPoly( {
		{ x = ScrW() / 2 - 70, y = 0 },
		{ x = ScrW() / 2 + 70, y = 0 },
		{ x = ScrW() / 2 + 40, y = 50 },
		{ x = ScrW() / 2 - 40, y = 50 }
	} )

	--main big background trapezoid
	surface.DrawPoly( {
		{ x = ScrW() / 2 - 160, y = 0 },
		{ x = ScrW() / 2 + 160, y = 0 },
		{ x = ScrW() / 2 + 140, y = 35 },
		{ x = ScrW() / 2 - 140, y = 35 }
	} )

	--CT
	surface.SetDrawColor( 84, 109, 126, 255 )
	draw.NoTexture()
	surface.DrawPoly( {
		{ x = ScrW() / 2 - 155, y = 0 },
		{ x = ScrW() / 2 - 116, y = 0 },
		{ x = ScrW() / 2 - 97, y = 30 },
		{ x = ScrW() / 2 - 136, y = 30 }
	} )

	--TR
	surface.SetDrawColor( 125, 61, 64, 255 )
	draw.NoTexture()
	surface.DrawPoly( {
		{ x = ScrW() / 2 - 111, y = 0 },
		{ x = ScrW() / 2 - 72, y = 0 },
		{ x = ScrW() / 2 - 53, y = 30 },
		{ x = ScrW() / 2 - 92, y = 30 }
	} )

	--CM
	surface.SetDrawColor( 63, 92, 205, 255 )
	draw.NoTexture()
	surface.DrawPoly( {
		{ x = ScrW() / 2 + 116, y = 0 },
		{ x = ScrW() / 2 + 155, y = 0 },
		{ x = ScrW() / 2 + 138, y = 30 },
		{ x = ScrW() / 2 + 96, y = 30 }
	} )

	--RE
	surface.SetDrawColor( 243, 207, 47, 255 )
	draw.NoTexture()
	surface.DrawPoly( {
		{ x = ScrW() / 2 + 72, y = 0 },
		{ x = ScrW() / 2 + 111, y = 0 },
		{ x = ScrW() / 2 + 92, y = 30 },
		{ x = ScrW() / 2 + 53, y = 30 }
	} )

	--Time display
	surface.SetFont( "UPGMed" )
	surface.SetTextColor( color_white )
	surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( txt ) / 2 ), 5 )
	surface.DrawText( txt )

	--CT scores
	surface.SetFont( "UPGSmall" )
	surface.SetTextColor( color_black )
	surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( scores[ "CT" ] ) / 2 ) - 127, 5 )
	surface.DrawText( scores[ "CT" ] )
	--[[surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "00" ) / 2 ) - 120, 25 )
	surface.DrawText( "00" )]]

	--TR scores
	surface.SetTextColor( color_black )
	surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( scores[ "TR" ] ) / 2 ) - 83, 5 )
	surface.DrawText( scores[ "TR" ] )
	--[[surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "00" ) / 2 ) - 80, 25 )
	surface.DrawText( "00" )]]

	--RE scores
	surface.SetTextColor( color_black )
	surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( scores[ "RE" ] ) / 2 ) + 80, 5 )
	surface.DrawText( scores[ "RE" ] )
	--[[surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "00" ) / 2 ) + 80, 25 )
	surface.DrawText( "00" )]]

	--CM scores
	surface.SetTextColor( color_black )
	surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( scores[ "CM" ] ) / 2 ) + 125, 5 )
	surface.DrawText( scores[ "CM" ] )
	--[[surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "00" ) / 2 ) + 120, 25 )
	surface.DrawText( "00" )]]	
end )