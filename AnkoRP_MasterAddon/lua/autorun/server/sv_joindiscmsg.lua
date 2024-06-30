util.AddNetworkString( "print_ply_connect" )
util.AddNetworkString( "print_ply_disconnect" )

hook.Add( "PlayerConnect", "ConnectMessages", function( name, ip )


    net.Start( "print_ply_connect" )
        net.WriteString( name )
    net.Broadcast()

end )

gameevent.Listen( "player_disconnect" )
hook.Add( "player_disconnect", "DisConnectMessages", function( dat )
	if IsValid( Player( dat.userid ) ) then
		http.Fetch( "http://127.0.0.1:3799/test?ply=" .. tostring( math.Clamp( player.GetCount() - 1, 0, 24 ) ),
			function()
				print( "This went well!" )
			end,
			function( err )
				print( "This didn't go well!" )
				print( err )
			end
		)
	end

    net.Start( "print_ply_disconnect" )
        net.WriteString( dat.name )
        net.WriteString( dat.reason )
        net.WriteInt( dat.userid, 32 )
    net.Broadcast()

end )

hook.Add( "Initialize", "ResetPlayerNumChannel", function()
	http.Fetch( "http://127.0.0.1:3799/test?ply=0&map=" .. game.GetMap(),
		function()
			print( "This went well!" )
		end,
		function( err )
			print( "This didn't go well!" )
			print( err )
		end
	)
end )

hook.Add( "PlayerInitialSpawn", "SetPlayerNumChannel", function()
	http.Fetch( "http://127.0.0.1:3799/test?ply=" .. tostring( player.GetCount() ),
		function()
			print( "This went well!" )
		end,
		function( err )
			print( "This didn't go well!" )
			print( err )
		end
	)
end )