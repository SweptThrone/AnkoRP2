--[[
	Prevent friendly fire,
	attempt to prevent babygod exploits,
	and play custom footstep sound effects.
]]--

hook.Add( "ScalePlayerDamage", "FriendlyFire/CitizenFie", function( vic, _, dmg )

	-- friendly fire and civilian shots deal zero damage
    if vic:getJobTable() and dmg:GetAttacker():IsPlayer() then

        if dmg:GetAttacker():getJobTable() and vic:getJobTable().category == dmg:GetAttacker():getJobTable().category then
            dmg:ScaleDamage( 0 )
            dmg:GetAttacker():PrintMessage( HUD_PRINTCENTER, "Watch your fire!  You hit a teammate!" )
			if SERVER then return true end
        end

        if vic:getJobTable().category == "Citizens" then
            dmg:ScaleDamage( 0 )
            dmg:GetAttacker():PrintMessage( HUD_PRINTCENTER, "Watch your fire!  Civilians are not combatants!" )
			if SERVER then return true end
        end
		
		if dmg:GetAttacker():getJobTable().category == "Citizens" then
			dmg:ScaleDamage( 0 )
            dmg:GetAttacker():PrintMessage( HUD_PRINTCENTER, "Do not attack people as a civilian!" )
			if SERVER then return true end
		end
		
		if dmg:GetAttacker().Babygod then
            dmg:GetAttacker().Babygod = nil
			dmg:GetAttacker():SetRenderMode( RENDERMODE_NORMAL )
			dmg:GetAttacker():GodDisable()
		end
		
		if vic.Babygod then
			dmg:ScaleDamage( 0 )
            dmg:GetAttacker():PrintMessage( HUD_PRINTCENTER, "Slow down!  They are still spawning!" )
			if SERVER then return true end
		end

		-- this never actually worked
		-- its intention is obvious
		if dmg:GetAttacker().Babygod then
			dmg:ScaleDamage( 0.5 )
			dmg:GetAttacker():PrintMessage( HUD_PRINTCENTER, "Baby-god pop!  50% damage!" )
			if SERVER then return true end
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

end )

hook.Add( "PlayerFootstep", "NoStepWhenWalkAndCrouch", function( ply, pos, foot, sound, vol, rf )

	-- stealth

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