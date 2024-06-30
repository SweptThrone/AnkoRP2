--[[
	Prevent friendly fire,
	attempt to prevent babygod exploits,
	and play custom footstep sound effects.
]]--

hook.Add( "EntityTakeDamage", "FriendlyFire/CitizenFie", function( vic, dmg )

	if !vic:IsPlayer() then return end
	if vic == dmg:GetAttacker() then
		dmg:ScaleDamage( 1 )
	end

	-- friendly fire and civilian shots deal zero damage
    if vic:getJobTable() and dmg:GetAttacker():IsPlayer() then

		if vic:Team() == TEAM_SKELETON then
			dmg:ScaleDamage( 0.75 )
			vic:EmitSound( "weapons/fx/rics/ric" .. math.random( 1, 5 ) .. ".wav" )
		end
		
		if vic:Team() == TEAM_CORPSE and dmg:GetDamage() >= vic:Health() then
			vic:SetHealth( 75 )
			DarkRP.notify( vic, 0, 4, "Your UNDYING trait saved you from death...this time..." )
		end

		if dmg:GetAttacker():Team() == TEAM_CHARPLE and vic:getJobTable().category != "Monsters" and vic:getJobTable().category != "Citizens" and dmg:GetInflictor():IsWeapon() and dmg:GetInflictor().Slot == 0 then
			vic:Ignite( 5 )
		end

		if dmg:GetAttacker():Team() == TEAM_ZOMBIE and vic:getJobTable().category != "Monsters" and vic:getJobTable().category != "Citizens" and dmg:GetInflictor():IsWeapon() and dmg:GetInflictor().Slot == 0 then
			timer.Create( "Bleeding" .. vic:EntIndex(), 0.5, math.random( 12, 18 ), function()
				local cdmg = DamageInfo()
				cdmg:SetDamage( math.random( 2, 4 ) )
				cdmg:SetAttacker( dmg:GetAttacker() )
				cdmg:SetDamageType( DMG_SLASH )
				cdmg:SetInflictor( dmg:GetInflictor() )
				vic:TakeDamageInfo( cdmg )
			end )
		end

        if dmg:GetAttacker():getJobTable() and vic:getJobTable().category == dmg:GetAttacker():getJobTable().category and vic ~= dmg:GetAttacker() then
            dmg:ScaleDamage( 0 )
            dmg:GetAttacker():PrintMessage( HUD_PRINTCENTER, "Watch your fire!  You hit a teammate!" )
        end

        if vic:getJobTable().category == "Citizens" then
            dmg:ScaleDamage( 0 )
            dmg:GetAttacker():PrintMessage( HUD_PRINTCENTER, "Watch your fire!  Civilians are not combatants!" )
        end
		
		if dmg:GetAttacker():getJobTable().category == "Citizens" then
			dmg:ScaleDamage( 0 )
            dmg:GetAttacker():PrintMessage( HUD_PRINTCENTER, "Do not attack people as a civilian!" )
		end
		
		if dmg:GetAttacker().Babygod then
            dmg:GetAttacker().Babygod = nil
			dmg:GetAttacker():SetRenderMode( RENDERMODE_NORMAL )
			dmg:GetAttacker():GodDisable()
		end
		
		if vic.Babygod then
			dmg:ScaleDamage( 0 )
            dmg:GetAttacker():PrintMessage( HUD_PRINTCENTER, "Slow down!  They are still spawning!" )
		end

		-- this never actually worked
		-- its intention is obvious
		if dmg:GetAttacker().Babygod then
			dmg:ScaleDamage( 0.5 )
			dmg:GetAttacker():PrintMessage( HUD_PRINTCENTER, "Baby-god pop!  50% damage!" )
		end
		
		-- monster health siphon
		-- because they're weak and worthless
		if dmg:GetAttacker():getJobTable().category == "Monsters" then
			dmg:GetAttacker():SetHealth( math.Clamp( dmg:GetAttacker():Health() + dmg:GetDamage(), 0, 150 ) )
		end
		
	end

end )

hook.Add( "KeyPress", "KillBabygodWhenFire", function( ply, key )

	if SERVER then
		if ply:Alive() and IsValid( ply:GetActiveWeapon() ) and key == IN_ATTACK and string.sub( ply:GetActiveWeapon():GetClass(), 1, 3 ) == "tfa" and ply:GetActiveWeapon():CanPrimaryAttack() then
			ply.Babygod = nil
			ply:SetRenderMode( RENDERMODE_NORMAL )
			ply:GodDisable()
		end
	end

	if key == IN_ALT1 and ply:Team() == TEAM_FZOMBIE and CurTime() > ply:GetNWInt( "SuperJumpRecharge", 0 ) and ply:Alive() then
		if SERVER then ply:EmitSound( "npc/fast_zombie/leap1.wav" ) end
		ply:SetVelocity( ply:GetAimVector() * 750 )
		ply:SetNWInt( "SuperJumpRecharge", CurTime() + 3 )
	end

	if key == IN_ALT1 and ply:Team() == TEAM_ZOMBINE and !timer.Exists( "ZombineDet" .. ply:EntIndex() ) and !ply:HasGodMode() then
		if SERVER then
			ply:EmitSound( "npc/fast_zombie/fz_scream1.wav" )
			timer.Create( "ZombineDet" .. ply:EntIndex(), 1.5, 1, function()
				if ply:Alive() and !ply:HasGodMode() then
					local explode = ents.Create( "env_explosion" ) //creates the explosion
					explode:SetPos( ply:GetPos() + Vector( 0, 0, 32 ) )
					explode:Spawn()
					explode:SetKeyValue( "iMagnitude", 0 )
					--explode:SetOwner( ply )
					explode:Fire( "Explode", 0, 0 )

					util.BlastDamage( explode, ply, ply:GetPos() + Vector( 0, 0, 32 ), 200, 200 )
				end
			end )
		end
	end

end )

hook.Add( "PlayerFootstep", "NoStepWhenWalkAndCrouch", function( ply, pos, foot, sound, vol, rf )

	-- stealth
	if !ply:getJobTable() then return end
	
	if IsValid( ply ) and ( ply:Crouching() or ply:GetMaxSpeed() < 150 ) and ply:getJobTable() then
		return true
	else
		if ply:Team() == TEAM_SOLDIER or ply:Team() == TEAM_ELITE or ply:Team() == TEAM_GUARD or ply:Team() == TEAM_STRIPPED then
			if SERVER then ply:EmitSound( "npc/combine_soldier/gear" .. math.random( 1, 6 ) .. ".wav", 75, 100, 0.5 ) end
			return true
		end
		if ply:Team() == TEAM_POLICE then
			if SERVER then ply:EmitSound( "npc/metropolice/gear" .. math.random( 1, 6 ) .. ".wav", 75, 100, 0.5 ) end
			return true
		end
		if ply:getJobTable().category == "Monsters" then
			if SERVER then ply:EmitSound( "npc/zombie/foot" .. math.random( 1, 3 ) .. ".wav", 75, 100, 0.5 ) end
			return true
		end
	end

end )
