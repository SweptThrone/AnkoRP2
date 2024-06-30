--[[
    Drop any items a player is carrying,
    penalize improper killings,
    handle contract payouts,
    handle bounty payouts,
    reward players for killing.
]]--

hook.Add( "PlayerDeath", "GiveMoneyForKills", function( vic, inf, atk )

	if game.GetWorld():GetNWString( "EventLoc", "" ) == "eggs" and vic:IsCombatant() then
		local egg = ents.Create( "st_golden_egg" )
		egg:SetPos( vic:GetPos() + Vector( 0, 0, 32 ) )
		egg:Spawn()
		egg:GetPhysicsObject():SetVelocity( VectorRand( -100, 100 ) )
		for i = 1, vic:GetNWInt( "NumEggs", 0 ) do
			local egg = ents.Create( "st_golden_egg" )
			egg:SetPos( vic:GetPos() + Vector( 0, 0, 32 ) )
			egg:Spawn()
			egg:GetPhysicsObject():SetVelocity( VectorRand( -100, 100 ) )
		end
		vic:SetNWInt( "NumEggs", 0 )
	end

    if vic:GetNWBool( "HasGold", false ) then
        local gold = ents.Create( "st_ankorp_gold" )
        gold:SetPos( vic:GetPos() + Vector( 0, 0, 64 ) )
        gold:SetAngles( vic:GetAngles() )
        gold:Spawn()
        vic:SetNWBool( "HasGold", false )
    end
    if vic:GetNWBool( "HasSmallGems", false ) then
        local gold = ents.Create( "st_ankorp_smgems" )
        gold:SetPos( vic:GetPos() + Vector( 0, 0, 64 ) )
        gold:SetAngles( vic:GetAngles() )
        gold:Spawn()
        vic:SetNWBool( "HasSmallGems", false )
    end
    if vic:GetNWBool( "HasLargeGems", false ) then
        local gold = ents.Create( "st_ankorp_lggems" )
        gold:SetPos( vic:GetPos() + Vector( 0, 0, 64 ) )
        gold:SetAngles( vic:GetAngles() )
        gold:Spawn()
        vic:SetNWBool( "HasLargeGems", false )
    end
    -- penalize players for improper killing
    -- it's really hard but never impossible
    if atk:IsPlayer() and atk != vic then
        
        if vic:getJobTable().category == "Citizens" then
            if atk:getJobTable().category == "Terrorists" or atk:getJobTable().category == "Combine" then
                atk:PrintMessage( HUD_PRINTCENTER, "There are targets more important than civilians!" )
                atk:PrintMessage( HUD_PRINTCONSOLE, "Penalized 1 frag for unnecessary killing." )
                atk:AddFrags( -2 )
            else
                atk:PrintMessage( HUD_PRINTCENTER, "Do not kill civilians!" )
                atk:PrintMessage( HUD_PRINTCONSOLE, "Penalized $5,000 and 1 frag for wrongful killing." )
                atk:AddFrags( -2 )
                atk:addMoney( -5000 )
            end
        elseif vic:getJobTable().category == atk:getJobTable().category then
            atk:PrintMessage( HUD_PRINTCENTER, "Do not kill your teammates!" )
            atk:PrintMessage( HUD_PRINTCONSOLE, "Penalized $2,500 and 1 frag for teamkill." )
            atk:AddFrags( -2 )
            atk:addMoney( -2500 )
        elseif atk:getJobTable().category == "Citizens" then
            atk:PrintMessage( HUD_PRINTCENTER, "Do not kill as a citizen!" )
            atk:PrintMessage( HUD_PRINTCONSOLE, "Penalized $10,000 for wrongful killing." )
            atk:addMoney( -10000 )
        else
            -- contracts
            if atk:GetNWInt( "Contract_IsActive", 0 ) == 2 and atk:GetActiveWeapon().Slot + 1 == atk:GetNWInt( "Contract_SlotReq" ) then
                atk:SetNWInt( "Contract_KillsDone", atk:GetNWInt( "Contract_KillsDone", 0 ) + 1 )
                if atk:GetNWInt( "Contract_KillsDone", 0 ) >= atk:GetNWInt( "Contract_KillsReq", 0 ) then
                    atk:TerminateContract( true )
                end
            end

            --bounties
            if atk:GetNWBool( "Bounty_IsActive", false ) and IsValid( atk:GetNWEntity( "Bounty_Target", NULL ) ) and vic == atk:GetNWEntity( "Bounty_Target" ) then
                atk:TerminateBounty( true )
            end
            for k,v in pairs( player.GetAll() ) do
                if IsValid( v:GetNWEntity( "Bounty_Target", NULL ) ) and v:GetNWEntity( "Bounty_Target" ) == vic and v != atk then
                    v:TerminateBounty( false )
                    DarkRP.notify( v, 1, 4, "Your target was killed by someone else." )
                end
            end

            -- monsters siphon health because they're so weak and worthless
			if atk:getJobTable().category == "Monsters" then
				atk:SetHealth( 150 )
			end
		
            -- money based on weapon class, target's kills, and killstreak
			local wep = atk:GetActiveWeapon()
			local slot
            local randMon
            if IsValid( wep ) then slot = ( wep.Slot and wep.Slot + 1 or 1 ) end
            if slot == 1 then
                randMon = math.random( 1500, 2500 )
                atk:addMoney( ( ( randMon + math.max( 0, vic:Frags() ) * 500 ) * ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) ) * ( GLOBAL_MONEY_MULTIPLIER * KILL_MONEY_MULTIPLIER ) )
                if atk:GetInfoNum( "cl_anko_killrewardbreakdown", 0 ) == 1 then
                    atk:PrintMessage( HUD_PRINTCONSOLE, "/ Kill reward breakdown" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|================================" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| +$" .. randMon .. " for Slot 1 kill" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| +$" .. math.max( 0, vic:Frags() ) * 500 .. " for killing a player with " .. vic:Frags() .. " frags ($500 each)" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) .. " for your current " .. atk:GetNWInt( "CurrKillStreak", 0 ) .. " killstreak" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. GLOBAL_MONEY_MULTIPLIER .. " global money multiplier" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. KILL_MONEY_MULTIPLIER .. " kill reward multiplier" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|================================" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| =$" .. ( ( randMon + math.max( 0, vic:Frags() ) * 500 ) * ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) ) * ( GLOBAL_MONEY_MULTIPLIER * KILL_MONEY_MULTIPLIER ) )
                end
            elseif slot == 2 then
                randMon = math.random( 1000, 1500 )
                atk:addMoney( ( ( randMon + math.max( 0, vic:Frags() ) * 300 ) * ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) ) * ( GLOBAL_MONEY_MULTIPLIER * KILL_MONEY_MULTIPLIER ) )
                atk:GiveAmmo( wep:GetMaxClip1(), wep:GetPrimaryAmmoType() )
                if atk:GetInfoNum( "cl_anko_killrewardbreakdown", 0 ) == 1 then
                    atk:PrintMessage( HUD_PRINTCONSOLE, "/ Kill reward breakdown" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|================================" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| +$" .. randMon .. " for Slot 2 kill" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| +$" .. math.max( 0, vic:Frags() ) * 300 .. " for killing a player with " .. vic:Frags() .. " frags ($300 each)" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) .. " for your current " .. atk:GetNWInt( "CurrKillStreak", 0 ) .. " killstreak" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. GLOBAL_MONEY_MULTIPLIER .. " global money multiplier" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. KILL_MONEY_MULTIPLIER .. " kill reward multiplier" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|================================" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| =$" .. ( ( randMon + math.max( 0, vic:Frags() ) * 300 ) * ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) ) * ( GLOBAL_MONEY_MULTIPLIER * KILL_MONEY_MULTIPLIER ) )
                end
            elseif slot == 3 then
                randMon = math.random( 250, 500 )
                atk:addMoney( ( ( randMon + math.max( 0, vic:Frags() ) * 100  ) * ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) ) * ( GLOBAL_MONEY_MULTIPLIER * KILL_MONEY_MULTIPLIER ) )
                atk:GiveAmmo( wep:GetMaxClip1(), wep:GetPrimaryAmmoType() )
                if atk:GetInfoNum( "cl_anko_killrewardbreakdown", 0 ) == 1 then
                    atk:PrintMessage( HUD_PRINTCONSOLE, "/ Kill reward breakdown" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|================================" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| +$" .. randMon .. " for Slot 3 kill" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| +$" .. math.max( 0, vic:Frags() ) * 100 .. " for killing a player with " .. vic:Frags() .. " frags ($100 each)" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) .. " for your current " .. atk:GetNWInt( "CurrKillStreak", 0 ) .. " killstreak" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. GLOBAL_MONEY_MULTIPLIER .. " global money multiplier" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. KILL_MONEY_MULTIPLIER .. " kill reward multiplier" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|================================" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| =$" .. ( ( randMon + math.max( 0, vic:Frags() ) * 100 ) * ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) ) * ( GLOBAL_MONEY_MULTIPLIER * KILL_MONEY_MULTIPLIER ) )
                end
            elseif slot == 4 then
                randMon = math.random( 150, 250 )
                atk:addMoney( ( ( randMon + math.max( 0, vic:Frags() ) * 50  ) * ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) ) * ( GLOBAL_MONEY_MULTIPLIER * KILL_MONEY_MULTIPLIER ) )
                atk:GiveAmmo( wep:GetMaxClip1() / 2, wep:GetPrimaryAmmoType() )
                if atk:GetInfoNum( "cl_anko_killrewardbreakdown", 0 ) == 1 then
                    atk:PrintMessage( HUD_PRINTCONSOLE, "/ Kill reward breakdown" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|================================" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| +$" .. randMon .. " for Slot 4 kill" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| +$" .. math.max( 0, vic:Frags() ) * 50 .. " for killing a player with " .. vic:Frags() .. " frags ($50 each)" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) .. " for your current " .. atk:GetNWInt( "CurrKillStreak", 0 ) .. " killstreak" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. GLOBAL_MONEY_MULTIPLIER .. " global money multiplier" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. KILL_MONEY_MULTIPLIER .. " kill reward multiplier" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|================================" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| =$" .. ( ( randMon + math.max( 0, vic:Frags() ) * 50 ) * ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) ) * ( GLOBAL_MONEY_MULTIPLIER * KILL_MONEY_MULTIPLIER ) )
                end
            elseif slot == 5 then
                randMon = math.random( 50, 100 )
                atk:addMoney( ( ( randMon + math.max( 0, vic:Frags() ) * 25  ) * ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) ) * ( GLOBAL_MONEY_MULTIPLIER * KILL_MONEY_MULTIPLIER ) )
                atk:GiveAmmo( wep:GetMaxClip1() / 2, wep:GetPrimaryAmmoType() )
                if atk:GetInfoNum( "cl_anko_killrewardbreakdown", 0 ) == 1 then
                    atk:PrintMessage( HUD_PRINTCONSOLE, "/ Kill reward breakdown" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|================================" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| +$" .. randMon .. " for Slot 5 kill" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| +$" .. math.max( 0, vic:Frags() ) * 25 .. " for killing a player with " .. vic:Frags() .. " frags ($25 each)" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) .. " for your current " .. atk:GetNWInt( "CurrKillStreak", 0 ) .. " killstreak" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. GLOBAL_MONEY_MULTIPLIER .. " global money multiplier" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. KILL_MONEY_MULTIPLIER .. " kill reward multiplier" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|================================" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| =$" .. ( ( randMon + math.max( 0, vic:Frags() ) * 25 ) * ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) ) * ( GLOBAL_MONEY_MULTIPLIER * KILL_MONEY_MULTIPLIER ) )
                end
            else
                randMon = math.random( 500, 1000 )
                atk:addMoney( ( ( randMon + math.max( 0, vic:Frags() ) * 250  ) * ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) ) * ( GLOBAL_MONEY_MULTIPLIER * KILL_MONEY_MULTIPLIER ) )
                if atk:GetInfoNum( "cl_anko_killrewardbreakdown", 0 ) == 1 then
                    atk:PrintMessage( HUD_PRINTCONSOLE, "/ Kill reward breakdown" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|================================" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| +$" .. randMon .. " for miscellaneous kill" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| +$" .. math.max( 0, vic:Frags() ) * 250 .. " for killing a player with " .. vic:Frags() .. " frags ($250 each)" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) .. " for your current " .. atk:GetNWInt( "CurrKillStreak", 0 ) .. " killstreak" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. GLOBAL_MONEY_MULTIPLIER .. " global money multiplier" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|  x" .. KILL_MONEY_MULTIPLIER .. " kill reward multiplier" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "|================================" )
                    atk:PrintMessage( HUD_PRINTCONSOLE, "| =$" .. ( ( randMon + math.max( 0, vic:Frags() ) * 250 ) * ( 1 + atk:GetNWInt( "CurrKillStreak", 0 ) / 10 ) ) * ( GLOBAL_MONEY_MULTIPLIER * KILL_MONEY_MULTIPLIER ) )
                end
            end
        end
        
    end

end )

hook.Add( "PostPlayerDeath", "RemoveNurseTimers", function( ply ) 
    if timer.Exists( "NurseHeal" .. ply:EntIndex() ) then
        timer.Remove( "NurseHeal" .. ply:EntIndex() )
    end
    ply:SetNWBool( "MedkitRegen", false )
end )