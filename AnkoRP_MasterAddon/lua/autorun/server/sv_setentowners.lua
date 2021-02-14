hook.Add( "playerBoughtCustomEntity", "SetCPPIOwnerOnEntBuy", function( ply, tbl, ent, price )
	ent:CPPISetOwner( ply )
end )