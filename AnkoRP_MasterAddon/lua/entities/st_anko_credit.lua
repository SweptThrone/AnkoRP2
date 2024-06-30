AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "Credit"
ENT.Author= "Throneco"
ENT.Contact= "http://discord.gg/Tg8SUDv"
ENT.Purpose= ""
ENT.Instructions= ""
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "AnkoRP Pickups"
ENT.Credits = 1

if CLIENT then
    local creditIcon = Material( "icon16/rosette.png", "smooth" )
    local glowSprite = Material( "sprites/glow04_noz" )

    function ENT:Draw()
        --self:DrawModel()
        local Ang = self:GetAngles()
        local Rot = self:GetAngles()
        Rot:RotateAroundAxis( Ang:Forward(), 180 )
        Rot:RotateAroundAxis( Ang:Up(), 180 )

        render.SetMaterial( glowSprite )
        render.DrawSprite( self:GetPos(), 32, 32, Color( 255, 0, 0 ) )

        cam.Start3D2D( self:GetPos(), Ang, 0.5 )
            --SLOT 1
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.SetMaterial( creditIcon )
            surface.DrawTexturedRect( -12, -12, 24, 24 )
	    cam.End3D2D()

        cam.Start3D2D( self:GetPos(), Rot, 0.5 )
            --SLOT 1
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.SetMaterial( creditIcon )
            surface.DrawTexturedRect( -12, -12, 24, 24 )
	    cam.End3D2D()

    end
end

if SERVER then
    function ENT:Initialize()
    
        self:SetModel( "models/hunter/plates/plate025x025.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
        --self:SetMaterial( "" )
    
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then phys:Wake() phys:EnableGravity( false ) end
        self:SetUseType( SIMPLE_USE )

        util.SpriteTrail( self, 0, Color( 255, 0, 0 ), false, 30, 1, 1.5, 1 / ( 15 + 1 ) * 0.5, "trails/laser" )

    end
    
    function ENT:Use( ply )
        self:EmitSound( "npc/combine_gunship/gunship_ping_search.wav", 75, 133 )
        ply:AddCredits( self.Credits )
		ply:ChatPrint( "Picked up " .. self.Credits .. ( self.Credits == 1 and " Credit" or " Credits" ) .. "!" )
        self:Remove()
    end

end