AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "long_use_base"
 
ENT.PrintName= "Gold Stack ($100k)"
ENT.Author= "Throneco"
ENT.Contact= "http://discord.gg/Tg8SUDv"
ENT.Purpose= ""
ENT.Instructions= ""
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "AnkoRP Pickups"
ENT.TimeToUse = 10

--[[
ENT.PartialUses = {
	{ prog = 1, func = function( ent ) ent:EmitSound( "buttons/blip1.wav", 75, 38 ) end },
	{ prog = 20, func = function( ent ) ent:EmitSound( "buttons/blip1.wav", 75, 50 ) end },
	{ prog = 40, func = function( ent ) ent:EmitSound( "buttons/blip1.wav", 75, 63 ) end },
	{ prog = 60, func = function( ent ) ent:EmitSound( "buttons/blip1.wav", 75, 75 ) end },
	{ prog = 80, func = function( ent ) ent:EmitSound( "buttons/blip1.wav", 75, 88 ) end },
	{ prog = 99, func = function( ent ) ent:EmitSound( "buttons/blip1.wav", 75, 100 ) end }
}
]]

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end

if SERVER then
    function ENT:Initialize()
    
        self:SetModel( "models/okxapack/valuables/valuable_bar_small_stack_double.mdl" )
        --models/props/cs_assault/MoneyPallet02.mdl - some full
        --models/props/cs_assault/MoneyPallet.mdl - fully full
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
    
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then phys:Wake() end
        self:SetUseType( CONTINUOUS_USE )

        self:SetDrawKeyPrompt( false )

    end
    
    function ENT:OnUseStart( ply )
        if ply:GetNWBool( "HasGold", false ) or ply:GetNWBool( "HasSmallGems", false ) or ply:GetNWBool( "HasLargeGems", false ) then
            DarkRP.notify( ply, 1, 4, "You are already carrying something!" )
            self:CancelUse()
            return
        end
        if ply:getJobTable().category == "Citizens" then
            DarkRP.notify( ply, 1, 4, "You cannot participate in Money Events as a Citizen!" )
            self:CancelUse()
            return
        end
        if ply:getJobTable().category == "Counter-Terrorists" then
            DarkRP.notify( ply, 1, 4, "Defend this gold from anyone trying to steal it!" )
            self:CancelUse()
            return
        end
        self:EmitSound( "items/ammopickup.wav" )
    end

    function ENT:OnUseFinish( ply )
        self:EmitSound( "items/gift_pickup.wav" )
        ply:SetNWBool( "HasGold", true )
        self:Remove()
    end

    function ENT:OnUseCancel( ply )
    end

end