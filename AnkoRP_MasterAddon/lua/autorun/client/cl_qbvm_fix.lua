--[[
	Fix the missing texture hands on the Battle QBB-95.
]]--

hook.Add( "PostDrawViewModel", "SetHandsOnBattle", function( vm, ply, wep )

	if IsValid( wep ) and wep:GetClass() == "tfa_cso_bqbb95" then
		ply:GetViewModel():SetSubMaterial( 1, "models/weapons/tfa_cso/bqbb95/#256252hand" )
	end

end )
