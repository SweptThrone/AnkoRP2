--[[
    Draw text and play sound when an event starts.
]]--

net.Receive( "ST_EventStarted", function( len )
    hook.Add( "HUDPaint", "DrawEventNotif", function()

        surface.SetFont( "UPGLarge" )
        surface.SetTextColor( Color( 0, 128, 0 ) )
        surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "Money Event" ) / 2 ), ScrH() / 8 )
        surface.DrawText( "Money Event" )

        surface.SetFont( "UPGMed" )
        surface.SetTextColor( Color( 196, 0, 0 ) )

        if game.GetWorld():GetNWString( "EventEnt" ) == "gold" then
            surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "You have one round to pick up and turn in the Gold." ) / 2 ), ScrH() / 8 + 72 )
            surface.DrawText( "You have one round to pick up and turn in the Gold." )
            surface.SetTextColor( Color( 84, 109, 126, 255 ) )
            surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "Counter-Terrorists must defend the Gold." ) / 2 ), ScrH() / 8 + 108 )
            surface.DrawText( "Counter-Terrorists must defend the Gold." )
        elseif game.GetWorld():GetNWString( "EventEnt" ) == "money" then
            surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "You have one round to steal the Money." ) / 2 ), ScrH() / 8 + 72 )
            surface.DrawText( "You have one round to steal the Money." )
            surface.SetTextColor( Color( 84, 109, 126, 255 ) )
            surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "Counter-Terrorists must defend the Money." ) / 2 ), ScrH() / 8 + 108 )
            surface.DrawText( "Counter-Terrorists must defend the Money." )
        elseif game.GetWorld():GetNWString( "EventEnt" ) == "gems" then
            surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "You have one round to pick up and turn in the Diamonds." ) / 2 ), ScrH() / 8 + 72 )
            surface.DrawText( "You have one round to pick up and turn in the Diamonds." )
            surface.SetTextColor( Color( 84, 109, 126, 255 ) )
            surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "Counter-Terrorists must defend the Diamonds." ) / 2 ), ScrH() / 8 + 108 )
            surface.DrawText( "Counter-Terrorists must defend the Diamonds." )
        elseif game.GetWorld():GetNWString( "EventEnt" ) == "weapons" then
            surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "You have one round to break open the crates and take the weapons." ) / 2 ), ScrH() / 8 + 72 )
            surface.DrawText( "You have one round to break open the crates and take the weapons." )
		elseif game.GetWorld():GetNWString( "EventEnt" ) == "eggs" then
			surface.SetTextPos( ScrW() / 2 - ( surface.GetTextSize( "You have one round to kill and collect as many golden eggs as you can." ) / 2 ), ScrH() / 8 + 72 )
            surface.DrawText( "You have one round to kill and collect as many golden eggs as you can." )
        end
        --draw.SimpleText( "A new Money Event has started!", "UPGLarge", ScrW() - 185, ScrH() - 49, color_white )
    end )

    timer.Create( "MoneyEventHUDRemove", 10, 1, function()
        hook.Remove( "HUDPaint", "DrawEventNotif" )
    end )

    surface.PlaySound( "ankorp/event_start.wav" )
end )