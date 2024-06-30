--[[
    This box just gives you ammo when you hit E on it.
    It's very simple.
]]--

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "Weapon Crate"
ENT.Author= "Throneco"
ENT.Contact= "http://discord.gg/Tg8SUDv"
ENT.Purpose= ""
ENT.Instructions= ""
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "AnkoRP Entities"
ENT.EntHealth = 25

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end

if SERVER then
    function ENT:Initialize()
    
        self:SetModel( "models/props_junk/wood_crate002a.mdl" )
        self:PrecacheGibs()
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
    
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then phys:Wake() end
        self:SetUseType(SIMPLE_USE)

    end
    
    function ENT:OnTakeDamage( dmg )
        if dmg:GetAttacker():IsPlayer() and dmg:GetAttacker():getJobTable().category == "Citizens" then
            dmg:GetAttacker():PrintMessage( HUD_PRINTCENTER, "You cannot break weapon boxes as a Citizen!" )
            return
        end
        self.EntHealth = self.EntHealth - dmg:GetDamage()
        if self.EntHealth <= 0 then 
            self:GibBreakClient( dmg:GetDamageForce() )
            local randWep = table.Random( CSO_BASIC_WEAPONS )
            local gun = ents.Create( randWep ) //creates the explosion
            gun:SetPos( self:GetPos() )
            gun:Spawn()
            if #ents.FindByClass( "st_weapon_box" ) == 1 then
                CURRENT_ANKORP_EVENT = false
                game.GetWorld():SetNWString( "EventLoc", "" )
                game.GetWorld():SetNWString( "EventEnt", "" )
                DarkRP.notify( player.GetAll(), 0, 4, "All Weapon Crates have been smashed and therefore the Money Event has ended!" )
            end
            self:Remove()
        end
    end

end