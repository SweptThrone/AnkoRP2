--[[
    Initialize the gamemode and define some globals.
]]--

CSO_WEAPONS_TREE = util.JSONToTable( file.Read( "cso_weapons_with_prices.json" ) )
CSO_BASIC_WEAPONS = {}
for k,v in pairs( CSO_WEAPONS_TREE ) do
    if v.basic then
        table.insert( CSO_BASIC_WEAPONS, k )
    end
end

ROUND_TIME = 600
CURRENT_ANKORP_EVENT = false

-- starting scores
FINAL_SCORES = {
    ["CT"] = 0,
    ["TR"] = 0,
    ["CM"] = 0,
    ["RE"] = 0
}

hook.Add( "Initialize", "SetupTDMRPDir", function()

    if !sql.TableExists( "AnkoRP_Weapons" ) then
        sql.Query( "CREATE TABLE AnkoRP_Weapons( SteamID TEXT )" )
        sql.Query( "CREATE TABLE AnkoRP_Atts( SteamID TEXT )" )
        sql.Query( "CREATE TABLE AnkoRP_Rep( SteamID TEXT, ContractSuccess INT, ContractFail INT, BountySuccess INT, BountyFail INT )" )
    end

    -- disallow dropping expensive and high-tier weapons
    GAMEMODE.Config.DisallowDrop = GAMEMODE.Config.DisallowDrop or {}

    for k,v in pairs( CSO_WEAPONS_TREE ) do
        if v.deep > 1 or v.price > 99999 then
            GAMEMODE.Config.DisallowDrop[ k ] = true
        end
    end

    game.GetWorld():SetNWInt( "AnkoNextRound", CurTime() + ROUND_TIME )
	
end )

hook.Add( "InitPostEntity", "FreezeMultiplayerProps", function()
	for k,v in pairs( ents.FindByClass( "prop_physics_multiplayer" ) ) do
		v:GetPhysicsObject():EnableMotion( false )
	end
end )

hook.Add( "PlayerInitialSpawn", "AssignOrSetupInventory", function( ply )

    if sql.Query( "SELECT * FROM AnkoRP_Weapons WHERE SteamID = '" .. ply:SteamID64() .. "'" ) == nil then
        sql.Query( "INSERT INTO AnkoRP_Weapons( SteamID ) VALUES( '" .. ply:SteamID64() .. "' )" )
        sql.Query( "INSERT INTO AnkoRP_Atts( SteamID ) VALUES( '" .. ply:SteamID64() .. "' )" )
        sql.Query( "INSERT INTO AnkoRP_Rep( SteamID, ContractSuccess, ContractFail, BountySuccess, BountyFail ) VALUES( '" .. ply:SteamID64() .. "', 0, 0, 0, 0 )" )
    end

    if file.Exists( "ankorp/" .. ply:SteamID64() .. ".txt", "DATA" ) then
        ankoWepTable = util.JSONToTable( file.Read( "ankorp/" .. ply:SteamID64() .. ".txt" ) )
        for k,v in pairs( ankoWepTable ) do
            if v != "nil" then
                ply:AddWeaponToTable( v )
            end
        end
        file.Delete( "ankorp/" .. ply:SteamID64() .. ".txt" )
    end

    local ankoRepTable = sql.Query( "SELECT SteamID, ContractSuccess, ContractFail, BountySuccess, BountyFail FROM AnkoRP_Rep WHERE SteamID = '" .. ply:SteamID64() .. "'" )[ 1 ]
    ply:SetNWInt( "ContractSuccess", tonumber( ankoRepTable[ "ContractSuccess" ] ) )
    ply:SetNWInt( "ContractFail", tonumber( ankoRepTable[ "ContractFail" ] ) )
    ply:SetNWInt( "BountySuccess", tonumber( ankoRepTable[ "BountySuccess" ] ) )
    ply:SetNWInt( "BountyFail", tonumber( ankoRepTable[ "BountyFail" ] ) )

end )

hook.Add( "playerGetSalary", "OverrideSalMsg", function( ply, amt )
	return false, "Thanks for playing! +" .. DarkRP.formatMoney( amt )
end )

local plyMeta = FindMetaTable( "Player" )

function plyMeta:GetWeaponTable()
    local tab = sql.Query( "SELECT * FROM AnkoRP_Weapons WHERE SteamID = '" .. self:SteamID64() .. "'" )[ 1 ]
    tab[ "SteamID" ] = nil
    return tab
end

function plyMeta:AddWeaponToTable( wep )
    sql.Query( [[ALTER TABLE AnkoRP_Weapons
    ADD ]] .. GetFinalParent( wep ) .. [[ TEXT
    ]] )
    sql.Query( "UPDATE AnkoRP_Weapons SET " .. GetFinalParent( wep ) .. " = '" .. wep .. "' WHERE SteamID = '" .. self:SteamID64() .. "'" )
end

function plyMeta:RemoveWeaponFromTable( wep )
    sql.Query( "UPDATE AnkoRP_Weapons SET " .. GetFinalParent( wep ) .. " = NULL WHERE SteamID = '" .. self:SteamID64() .. "'" )
end

function plyMeta:GetAttachmentTable()
    local tab = sql.Query( "SELECT * FROM AnkoRP_Atts WHERE SteamID = '" .. self:SteamID64() .. "'" )[ 1 ]
    tab[ "SteamID" ] = nil
    return tab
end

function plyMeta:AddAttachmentToTable( att )
    sql.Query( [[ALTER TABLE AnkoRP_Atts
    ADD ]] .. att .. [[ BOOL
    END
    ]] )
    sql.Query( "UPDATE AnkoRP_Atts SET " .. att .. " = 1 WHERE SteamID = '" .. self:SteamID64() .. "'" )
    net.Start( "SendPlyTheirAttTable" )
        net.WriteData( util.Compress( util.TableToJSON( self:GetAttachmentTable() ) ), #util.Compress( util.TableToJSON( self:GetAttachmentTable() ) ) )
    net.Send( self )
end

function plyMeta:STNPCMessage( ent, msg )
    net.Start( "ST_NPCMessage" )
        net.WriteString( ent.PrintName )
        net.WriteString( msg )
    net.Send( self )
end

function plyMeta:GetInventoryValue( str )
	local val = 0

	for k,v in pairs( self:GetWeaponTable() ) do
		--val = val + CSO_WEAPONS_TREE[ v ].price
		local curr = v
		for i = CSO_WEAPONS_TREE[ v ].deep, 1, -1 do
			--print( "Added " .. curr )
			val = val + CSO_WEAPONS_TREE[ curr ].price
			curr = CSO_WEAPONS_TREE[ curr ].parent
		end
	end
	
	return str and "$" .. string.Comma( val ) or val
end

function plyMeta:GetWorth( str )
	return str and "$" .. string.Comma( self:GetInventoryValue() + self:getDarkRPVar( "money" ) ) or self:GetInventoryValue() + self:getDarkRPVar( "money" )
end

net.Receive( "AskForCSOTree", function( len, ply )
    local CSO_WEAPONS_TREE = file.Read( "cso_weapons_with_prices.json" )
    net.Start( "AllowTreeToBeSeen" )
        net.WriteData( util.Compress( CSO_WEAPONS_TREE ), #util.Compress( CSO_WEAPONS_TREE ) )
    net.Send( ply )
    net.Start( "SendAnkoScores" )
        net.WriteData( util.Compress( util.TableToJSON( FINAL_SCORES ) ), #util.Compress( util.TableToJSON( FINAL_SCORES ) ) )
    net.Broadcast()
    net.Start( "SendPlyTheirAttTable" )
        net.WriteData( util.Compress( util.TableToJSON( ply:GetAttachmentTable() ) ), #util.Compress( util.TableToJSON( ply:GetAttachmentTable() ) ) )
    net.Send( ply )
end )
