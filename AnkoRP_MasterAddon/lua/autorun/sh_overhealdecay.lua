hook.Add( "PlayerTick", "OverhealthDecay", function( ply )
    ply.NextOverHealDecayTime = ply.NextOverHealDecayTime or 0
    if ply:Health() > ply:GetMaxHealth() and CurTime() >= ply.NextOverHealDecayTime then
        ply:SetHealth( ply:Health() - 1 )
        local dec = -0.01 * ply:Health() + 2
        ply.NextOverHealDecayTime = CurTime() + dec / 2
    end
end )