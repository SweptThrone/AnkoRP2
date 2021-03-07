--[[
    Offer players contracts when they spawn,
    offer players bounties when requested.
]]--

local plyMeta = FindMetaTable( "Player" )
local slotRewards = { 2500, 1500, 500, 250, 100 }

function plyMeta:OfferContract( slot )

    slot = slot or math.random( 1, 5 )
    local succ = self:GetNWInt( "ContractSuccess", 0 )
    local fail = self:GetNWInt( "ContractFail", 0 )

    local rate
    if succ == 0 and fail == 0 then
        rate = 50
    else
        rate = succ / ( succ + fail ) * 100
    end
    local needKills = math.floor( 0.3 * rate )
    needKills = math.Clamp( needKills + math.random( -2, 2 ), 1, 30 )

    self:SetNWInt( "Contract_KillsReq", needKills )
    self:SetNWInt( "Contract_KillsDone", 0 )
    self:SetNWInt( "Contract_SlotReq", slot )
    self:SetNWInt( "Contract_IsActive", 0 )
    self:SetNWInt( "Contract_Payout", needKills * slotRewards[ slot ]  )

    net.Start( "ST_OfferAnkoContract" )
        net.WriteInt( slot, 4 )
        net.WriteInt( needKills, 6 )
    net.Send( self )

end

function plyMeta:TerminateContract( succeeded )
    if self:GetNWInt( "Contract_IsActive", 0 ) == 0 then
        ErrorNoHalt( "Attempt to terminate contract that isn't active!" )
    return end

    if succeeded then
        DarkRP.notify( self, 0, 4, "You successfully completed your contract and have been compensated!" )
        self:addMoney( self:GetNWInt( "Contract_Payout" ) * GLOBAL_MONEY_MULTIPLIER * CONTRACT_MONEY_MULTIPLIER )
        self:SetNWInt( "ContractSuccess", self:GetNWInt( "ContractSuccess" ) + 1 )
    else
        DarkRP.notify( self, 1, 4, "You failed to complete your active contract on time." )
        self:SetNWInt( "ContractFail", self:GetNWInt( "ContractFail" ) + 1 )
    end
    self:SetNWInt( "Contract_IsActive", 0 )
    self:SetNWInt( "Contract_KillsReq", 0 )
    self:SetNWInt( "Contract_KillsDone", 0 )
    self:SetNWInt( "Contract_SlotReq", 0 )
    self:SetNWInt( "Contract_Payout", 0 )
    sql.Query( "UPDATE AnkoRP_Rep SET ContractSuccess = " .. self:GetNWInt( "ContractSuccess" ) .. ", ContractFail = " .. self:GetNWInt( "ContractFail" ) .. " WHERE SteamID = '" .. self:SteamID64() .. "'" )
end

function plyMeta:OfferBounty( target ) 
    local mySucc = self:GetNWInt( "BountySuccess", 0 )
    local myFail = self:GetNWInt( "BountyFail", 0 )
    local tgtSucc = target:GetNWInt( "BountySuccess", 0 )
    local tgtFail = target:GetNWInt( "BountyFail", 0 )

    local myRate
    if mySucc == 0 and myFail == 0 then
        myRate = 50
    else
        myRate = mySucc / ( mySucc + myFail ) * 100
    end

    local tgtRate
    if tgtSucc == 0 and tgtFail == 0 then
        tgtRate = 50
    else
        tgtRate = tgtSucc / ( tgtSucc + tgtFail ) * 100
    end

    local bounty = math.max( 1000, tgtRate - myRate * 1000 ) * myRate / 10

    self:SetNWEntity( "Bounty_Target", target )
    self:SetNWInt( "Bounty_Payout", bounty )
    self:SetNWBool( "Bounty_IsActive", false )

    net.Start( "ST_OfferAnkoBounty" )
        net.WriteEntity( target )
        net.WriteInt( bounty, 32 )
    net.Send( self )
end

function plyMeta:TerminateBounty( succeeded )
    if !self:GetNWBool( "Bounty_IsActive", false ) then
        ErrorNoHalt( "Attempt to terminate bounty that isn't active!" )
    return end

    if succeeded then
        DarkRP.notify( self, 0, 4, "You successfully completed your bounty and have been rewarded!" )
        self:addMoney( self:GetNWInt( "Bounty_Payout" ) * GLOBAL_MONEY_MULTIPLIER * BOUNTY_MONEY_MULTIPLIER )
        self:SetNWInt( "BountySuccess", self:GetNWInt( "BountySuccess" ) + 1 )
    else
        DarkRP.notify( self, 1, 4, "You failed to complete your bounty assignment." )
        self:SetNWInt( "BountyFail", self:GetNWInt( "BountyFail" ) + 1 )
    end

    self:SetNWEntity( "Bounty_Target", NULL )
    self:SetNWBool( "Bounty_IsActive", true )
    self:SetNWInt( "Bounty_Payout", 0 )
    sql.Query( "UPDATE AnkoRP_Rep SET BountySuccess = " .. self:GetNWInt( "BountySuccess" ) .. ", BountyFail = " .. self:GetNWInt( "BountyFail" ) .. " WHERE SteamID = '" .. self:SteamID64() .. "'" )
end

hook.Add( "PlayerLoadout", "OfferPlayerContract", function( ply )

    local succ = ply:GetNWInt( "ContractSuccess" )
    local fail = ply:GetNWInt( "ContractFail" )
    local chance, rate
    if succ + fail == 0 then
        rate = 50
    else
        rate = succ / ( succ + fail ) * 100
    end
    
    chance = math.Clamp( rate, 20, 80 )

    local randChance = math.random( 1, 100 )
	if #GetCombatants() > 1 and #GetActiveTeams() >= 2 then
		if randChance < chance and ply:GetNWInt( "Contract_IsActive", 0 ) == 0 and ply:IsCombatant() then
			ply:OfferContract()
		end
	else
		PrintMessage( HUD_PRINTCONSOLE, "Need 2 combatants and 2 teams for a contract, have " .. #GetCombatants() .. " combatants and " .. #GetActiveTeams() .. " teams." )
	end

end )

net.Receive( "ST_TakeContract", function( len, ply )

    ply:SetNWInt( "Contract_IsActive", 1 )

end )

net.Receive( "ST_TakeBounty", function( len, ply )

    local op = net.ReadBool()

    if op then --took the bounty
        ply:SetNWBool( "Bounty_IsActive", true )
    else --cancelled the bounty
        ply:TerminateBounty( false )
    end

end )
