--[[
	Miscellaneous net receivers.
]]--

net.Receive( "AllowTreeToBeSeen", function( len, ply )

    local tab = net.ReadData( len )

    CSO_WEAPONS_TREE = util.JSONToTable( util.Decompress( tab ) )

end )

net.Receive( "ST_NPCMessage", function( len )
	local npc = net.ReadString()
	local msg = net.ReadString()

	local npcCols = {
		[ "Nurse" ] = Color( 0, 128, 255 ),
		[ "Pawn Broker" ] = Color( 128, 128, 0 ),
		[ "Crime Boss" ] = Color( 255, 0, 0 ),
		[ "Bouncer Bot" ] = Color( 0, 0, 255 )
	}

	chat.PlaySound()
	chat.AddText( npcCols[ npc ], npc, color_white, ": " .. msg )
end )

net.Receive( "SendPlyTheirAttTable", function( len )
	local tab = net.ReadData( len )

	LocalPlayer().attInvTable = util.JSONToTable( util.Decompress( tab ) )
end )

hook.Add( "InitPostEntity", "SendPlayerTheirStuff", function()

	net.Start( "AskForCSOTree" )
	net.SendToServer()

end )