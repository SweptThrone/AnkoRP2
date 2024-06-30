hook.Add( "DarkRPFinishedLoading", "SetUpDoorOwnerships", function()
	timer.Simple( 10, function()
		local ownableDoors = {}
			
		for k,v in pairs( ANKORP_PROPERTIES ) do
			for l,w in pairs( v ) do
				ownableDoors[ w ] = true
			end
		end

		for k,v in pairs( ents.GetAll() ) do
			if v:isDoor() and !ownableDoors[ v:MapCreationID() ] then
				v:setKeysNonOwnable( true )
			end
		end
		
		ents.GetMapCreatedEntity( 3684 ):setKeysTitle( "East VIP Room - $10,000" )
		ents.GetMapCreatedEntity( 3689 ):setKeysTitle( "West VIP Room - $10,000" )
	end )
end )