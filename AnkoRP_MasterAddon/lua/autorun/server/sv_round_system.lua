--[[
    Handle round progression,
    store and update scores,
    and start and end events,
]]--

-- convenience
local KEY_TO_CATEGORY = {
    ["CT"] = "Counter-Terrorists",
    ["TR"] = "Terrorists",
    ["CM"] = "Combine",
    ["RE"] = "Resistance"
}

hook.Add( "Tick", "CheckFoRoundOver", function()

    if CurTime() >= game.GetWorld():GetNWInt( "AnkoNextRound" ) then
        for k,v in pairs( player.GetAll() ) do
            if v:GetNWInt( "Contract_IsActive", 0 ) == 2 then
                v:TerminateContract( false )
            end
            if v:GetNWInt( "Contract_IsActive", 0 ) == 1 then
                v:SetNWInt( "Contract_IsActive", 2 )
                DarkRP.notify( v, 0, 4, "Your contract is now active!" )
            end
        end

        if CURRENT_ANKORP_EVENT then
            DarkRP.notify( player.GetAll(), 1, 4, "The previous Money Event has ended and all related items have been removed." )
            for k,v in pairs( player.GetAll() ) do
                v:SetNWBool( "HasGold", false )
                v:SetNWBool( "HasSmallGems", false )
                v:SetNWBool( "HasLargeGems", false )
            end
            -- gold cleanup
            if #ents.FindByClass( "st_ankorp_gold" ) > 0 then
                for _,ply in pairs( player.GetAll() ) do
                    if ply:getJobTable().category == "Counter-Terrorists" then
                        ply:addMoney( ( 50000 * #ents.FindByClass( "st_ankorp_gold" ) ) * GLOBAL_MONEY_MULTIPLIER )
                        DarkRP.notify( ply, 0, 4, "Earned $" .. string.Comma( ( 50000 * #ents.FindByClass( "st_ankorp_gold" ) ) * GLOBAL_MONEY_MULTIPLIER ) .. " for defending the Gold." )
                    end
                end
            end
            for k,v in pairs( ents.FindByClass( "st_ankorp_gold" ) ) do
                v:Remove()
            end
            -- large gems cleanup
            if #ents.FindByClass( "st_ankorp_lggems" ) > 0 then
                for _,ply in pairs( player.GetAll() ) do
                    if ply:getJobTable().category == "Counter-Terrorists" then
                        ply:addMoney( ( 75000 * #ents.FindByClass( "st_ankorp_lggems" ) ) * GLOBAL_MONEY_MULTIPLIER )
                        DarkRP.notify( ply, 0, 4, "Earned $" .. string.Comma( ( 75000 * #ents.FindByClass( "st_ankorp_lggems" ) ) * GLOBAL_MONEY_MULTIPLIER ) .. " for defending the Large Diamond Bags." )
                    end
                end
            end
            for k,v in pairs( ents.FindByClass( "st_ankorp_lggems" ) ) do
                v:Remove()
            end
            -- money cleanup
            if #ents.FindByClass( "st_ankorp_money" ) > 0 then
                for _,ply in pairs( player.GetAll() ) do
                    if ply:getJobTable().category == "Counter-Terrorists" then
                        ply:addMoney( ( 12500 * #ents.FindByClass( "st_ankorp_money" ) ) * GLOBAL_MONEY_MULTIPLIER )
                        DarkRP.notify( ply, 0, 4, "Earned $" .. string.Comma( ( 12500 * #ents.FindByClass( "st_ankorp_money" ) ) * GLOBAL_MONEY_MULTIPLIER ) .. " for defending the Money." )
                    end
                end
            end
            for k,v in pairs( ents.FindByClass( "st_ankorp_money" ) ) do
                v:Remove()
            end
            -- small gems cleanup
            if #ents.FindByClass( "st_ankorp_smgems" ) > 0 then
                for _,ply in pairs( player.GetAll() ) do
                    if ply:getJobTable().category == "Counter-Terrorists" then
                        ply:addMoney( ( 25000 * #ents.FindByClass( "st_ankorp_smgems" ) ) * GLOBAL_MONEY_MULTIPLIER )
                        DarkRP.notify( ply, 0, 4, "Earned $" .. string.Comma( ( 25000 * #ents.FindByClass( "st_ankorp_smgems" ) ) * GLOBAL_MONEY_MULTIPLIER ) .. " for defending the Small Diamond Bags." )
                    end
                end
            end
            for k,v in pairs( ents.FindByClass( "st_ankorp_smgems" ) ) do
                v:Remove()
            end
            for k,v in pairs( ents.FindByClass( "st_weapon_box" ) ) do
                v:Remove()
            end
            for k,v in pairs( ents.GetAll() ) do
                if v.REMOVEONEVENT then
                    v:Remove()
                end
            end
            CURRENT_ANKORP_EVENT = false
            game.GetWorld():SetNWString( "EventLoc", "" )
            game.GetWorld():SetNWString( "EventEnt", "" )
        end

        game.GetWorld():SetNWInt( "AnkoNextRound", CurTime() + ROUND_TIME )

        if #GetCombatants() > 2 and #GetActiveTeams() > 1 then
            local eventChance = math.random( 1, 4 )
            local locChance = math.random( 1, 100 )
            local lootChance = math.random( 1, 20 )
            local location, loot
            if eventChance == 4 then
                if locChance < 27 then
                    location = "remote"
                    loot = "weapons"
                elseif locChance < 54 then
                    location = "barge"
                    if lootChance < 14 then
                        loot = "money"
                    else
                        loot = "gold"
                    end
                elseif locChance < 81 then
                    location = "worldcorp"
                    if lootChance < 14 then
                        loot = "money"
                    else
                        loot = "gold"
                    end
                elseif locChance < 93 then
                    location = "bank"
                    if lootChance < 14 then
                        loot = "money"
                    else
                        loot = "gold"
                    end
                else
                    location = "richman"
                    loot = "gems"
                end
                StartEvent( location, loot )
            end
        end

        local SCORE_CT, SCORE_TR, SCORE_CM, SCORE_RE = 0, 0, 0, 0

		local numTeammates = {
            ["CT"] = 0,
            ["TR"] = 0,
            ["CM"] = 0,
            ["RE"] = 0
		}
		
        -- depending on which team a player is on, add to the number
        for k,v in pairs( player.GetAll() ) do
            if v:getJobTable().category == "Counter-Terrorists" then
				numTeammates[ "CT" ] = numTeammates[ "CT" ] + 1
                SCORE_CT = SCORE_CT + v:Frags()
            elseif v:getJobTable().category == "Terrorists" then
				numTeammates[ "TR" ] = numTeammates[ "TR" ] + 1
                SCORE_TR = SCORE_TR + v:Frags()
            elseif v:getJobTable().category == "Combine" then
				numTeammates[ "CM" ] = numTeammates[ "CM" ] + 1
                SCORE_CM = SCORE_CM + v:Frags()
            elseif v:getJobTable().category == "Resistance" then
				numTeammates[ "RE" ] = numTeammates[ "RE" ] + 1
                SCORE_RE = SCORE_RE + v:Frags()
            end
        end

        local scores = { 
            ["CT"] = SCORE_CT,
            ["TR"] = SCORE_TR,
            ["CM"] = SCORE_CM,
            ["RE"] = SCORE_RE
        }
		
		local round_winners = {}
        local win_message = ""

        local winningScore = math.max( scores[ "CT" ], scores[ "TR" ], scores[ "RE" ], scores[ "CM" ] )
        for k,v in pairs( scores ) do
            if v == winningScore then
                table.insert( round_winners, k )
            end
        end
        if #round_winners == 4 then
            round_winners = {}
            win_message = "Tie round!"
        end
        for k,v in pairs( round_winners ) do
            FINAL_SCORES[ v ] = FINAL_SCORES[ v ] + 1
            win_message = win_message .. KEY_TO_CATEGORY[ v ] .. ( k == #round_winners and " win the round!" or ( k == #round_winners - 1  and ( #round_winners == 2 and " and " or ", and " ) or ", " ) .. "" )
        end
        PrintMessage( HUD_PRINTCENTER, win_message )
        PrintMessage( HUD_PRINTCONSOLE, win_message )
		
        -- Add money to winning players for winning a "round"
        -- 12,500 base plus 2,500 per teammate, all of that times the percentage of kills YOU contributed
        -- example:
        -- if you have 2 teammates, one with 5 kills and one with 3, and you have 2,
        -- you would get 12,500 + ( 2,500 * 2 ) * ( 2 / 10 ) so 13,500 total
		for k,v in pairs( player.GetAll() ) do
			for a,b in pairs( round_winners ) do
				if v:getJobTable().category == KEY_TO_CATEGORY[ b ] then
					v:addMoney( ( 12500 + ( 2500 * ( numTeammates[ b ] - 1 ) ) * ( v:Frags() / ( scores[ b ] == 0 and 1 or scores[ b ] ) ) ) * GLOBAL_MONEY_MULTIPLIER )
                    v:PrintMessage( HUD_PRINTCONSOLE, "Earned $" .. string.Comma( ( 12500 + ( 2500 * ( numTeammates[ b ] - 1 ) ) * ( v:Frags() / scores[ b ] ) ) * GLOBAL_MONEY_MULTIPLIER ) .. " for winning the round." )
				end
			end
			v:SetFrags( 0 )
		end

        net.Start( "SendAnkoScores" )
            net.WriteData( util.Compress( util.TableToJSON( FINAL_SCORES ) ), #util.Compress( util.TableToJSON( FINAL_SCORES ) ) )
        net.Broadcast()
    end

end )