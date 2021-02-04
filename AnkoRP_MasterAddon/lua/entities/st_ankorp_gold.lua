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
            self:SetUser( nil )
			self:SetProgress( -1 )
            return
        end
        if ply:getJobTable().category == "Citizens" then
            DarkRP.notify( ply, 1, 4, "You cannot participate in Money Events as a Citizen!" )
            self:SetUser( nil )
			self:SetProgress( -1 )
            return
        end
        if ply:getJobTable().category == "Counter-Terrorists" then
            DarkRP.notify( ply, 1, 4, "Defend this gold from anyone trying to steal it!" )
            self:SetUser( nil )
			self:SetProgress( -1 )
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