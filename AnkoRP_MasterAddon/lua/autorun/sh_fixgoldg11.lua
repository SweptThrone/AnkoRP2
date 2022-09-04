hook.Add( "TFA_GetStat", "FixGoldG11", function(wepom,stat,value)
    if wepom:GetClass() == "tfa_cso_g11g" and stat == "Primary.IronAccuracy" then
        return value / 10
    end
end )