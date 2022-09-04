hook.Add( "TFA_GetStat", "FixGoldG11", function( wep, stat, value )
    if wep:GetClass() == "tfa_cso_g11g" and stat == "Primary.IronAccuracy" then
        return value / 10
    end
end )
