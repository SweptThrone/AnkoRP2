AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "Golden Egg"
ENT.Author= "Throneco"
ENT.Contact= "http://discord.gg/Tg8SUDv"
ENT.Purpose= ""
ENT.Instructions= ""
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "AnkoRP Pickups"

if CLIENT then
    local glowSprite = Material( "sprites/glow04_noz" )

    function ENT:Draw()
        self:DrawModel()
        local Ang = self:GetAngles()
        local Rot = self:GetAngles()
        Rot:RotateAroundAxis( Ang:Forward(), 180 )
        Rot:RotateAroundAxis( Ang:Up(), 180 )

        render.SetMaterial( glowSprite )
        render.DrawSprite( self:LocalToWorld( self:OBBCenter() ), 32, 32, Color( 255, 192, 0 ) )

    end
end

if SERVER then
    function ENT:Initialize()
    
        self:SetModel( "models/props_phx/misc/egg.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
		self:SetCollisionGroup( COLLISION_GROUP_WORLD )
        self:SetMaterial( "okxapack/models/gold_player" )
    
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then phys:Wake() phys:EnableGravity( false ) end
        self:SetUseType( SIMPLE_USE )

        util.SpriteTrail( self, 0, Color( 255, 192, 0 ), false, 30, 1, 1.5, 1 / ( 15 + 1 ) * 0.5, "trails/laser" )

    end
    
    function ENT:Use( ply )
        self:EmitSound( "npc/combine_gunship/gunship_ping_search.wav", 75, 133 )
		ply:SetNWInt( "NumEggs", ply:GetNWInt( "NumEggs", 0 ) + 1 )
        self:Remove()
    end

end