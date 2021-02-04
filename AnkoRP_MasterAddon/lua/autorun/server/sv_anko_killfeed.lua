--[[
    Send kill information to print the killfeed.
]]--

hook.Add( "DoPlayerDeath", "CustomKillFeedMaybe", function( vic, atk, dmg )
    if atk:IsPlayer() and IsValid( dmg:GetInflictor() ) and CSO_WEAPONS_TREE[ dmg:GetInflictor():GetClass() ] then
        --print( "is player, valid inf, in tree" )
        net.Start( "STCustomKillfeed" )
            net.WriteEntity( vic )
            net.WriteEntity( dmg:GetInflictor() )
            net.WriteEntity( atk )
            net.WriteBool( true )
        net.Broadcast()
    else --atk:IsPlayer() and IsValid( dmg:GetInflictor() ) then
        --print( "not player or not valid inf or not in tree" )
        net.Start( "STCustomKillfeed" )
            net.WriteEntity( vic )
            net.WriteEntity( dmg:GetInflictor() )
            net.WriteEntity( atk )
            net.WriteBool( false )
        net.Broadcast()
    end
end )