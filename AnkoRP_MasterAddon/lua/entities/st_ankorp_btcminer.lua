AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "Bitcoin Miner"
ENT.Author= "Throneco"
ENT.Contact= "http://discord.gg/Tg8SUDv"
ENT.Purpose= ""
ENT.Instructions= ""
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "AnkoRP Entities"
ENT.EntHealth = 500

if CLIENT then
    function ENT:Draw()
        self:DrawModel()

        local Pos = self:GetPos()
        local Ang = self:GetAngles()
        local Pos2 = Vector(Pos.x, Pos.y + 4, Pos.z+17)
            
        txt0 = ( self:CPPIGetOwner() and self:CPPIGetOwner():Name() .. "'s " or "Unknown" )
        txt1 = "BitMiner"
        txt2 = tostring( math.Round( self:GetNWFloat( "CurrBTC", 0 ), 5 ) ) .. " BTC"
        
        surface.SetFont("UPGSmall")
        local TextWidth0 = surface.GetTextSize( txt0 )
        local TextWidth = surface.GetTextSize( txt1 )
        local TextWidth2 = surface.GetTextSize( txt2 )
        
        --Ang:RotateAroundAxis(Ang:Forward(), 90)
        --Ang:RotateAroundAxis(Ang:Right(), 270)
        Ang:RotateAroundAxis(Ang:Up(), 90)
            
        cam.Start3D2D(Pos + Ang:Up() * 11 - Ang:Right() * 1, Ang, 0.16)
            draw.WordBox(2, -TextWidth0*0.5, -40, txt0, "UPGSmall", Color(49, 50, 21, 255), Color(255,255,255,255))
            draw.WordBox(2, -TextWidth*0.5, -10, txt1, "UPGSmall", Color(49, 50, 21, 255), Color(255,255,255,255))
            draw.WordBox(2, -TextWidth2*0.5, 20, txt2, "UPGSmall", Color(49, 50, 21, 255), Color(255,255,255,255))
        cam.End3D2D()
    end
end

if SERVER then
    function ENT:Initialize()
    
        self:SetModel( "models/props_c17/consolebox01a.mdl" )
        --models/props/cs_assault/MoneyPallet02.mdl - some full
        --models/props/cs_assault/MoneyPallet.mdl - fully full
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
    
        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then phys:Wake() end
        self:SetUseType(SIMPLE_USE)

        timer.Create( "AnkoRPBTCMine" .. self:EntIndex(), 5, 0, function()
            if !IsValid( self ) then return end
            self:SetNWFloat( "CurrBTC", self:GetNWFloat( "CurrBTC", 0 ) + math.Rand( 0.0002, 0.0003 ) * ( GLOBAL_MONEY_MULTIPLIER * BITCOIN_MONEY_MULTIPLIER ) )
            self:EmitSound( "ankorp/bitcoin_mine.wav", 60 )
            self.EntHealth = math.Clamp( self.EntHealth + 5, 0, 500 )
            self:SetColor( Color( 255, ( ( self.EntHealth / 500 ) * 255 ), ( ( self.EntHealth / 500 ) * 255 ) ) )
        end )

    end
    
    function ENT:Use( act, ply )
        if self:GetNWFloat( "CurrBTC", 0 ) > 0 then
            ply:addMoney( self:GetNWFloat( "CurrBTC", 0 ) * STBTC2_PRICE )
            DarkRP.notify( ply, 0, 4, "Got $" .. math.floor( self:GetNWFloat( "CurrBTC", 0 ) * STBTC2_PRICE ) .. " from a Bitcoin miner." )
            self:SetNWFloat( "CurrBTC", 0 )
        end
    end

    function ENT:OnTakeDamage( dmg )
        self.EntHealth = self.EntHealth - dmg:GetDamage()
        self:SetColor( Color( 255, ( ( self.EntHealth / 500 ) * 255 ), ( ( self.EntHealth / 500 ) * 255 ) ) )
        if self.EntHealth <= 0 then 
            self:EmitSound( "physics/metal/metal_box_break" .. math.random( 1, 2 ) .. ".wav" ) 
            local explode = ents.Create( "env_explosion" ) //creates the explosion
            explode:SetPos( self:GetPos() )
            explode:Spawn()
            --explode:EmitSound( "weapons/railgun-expl.wav" )
            --explode:SetKeyValue( "spawnflags", bit.bor( 16, 64, 2048, 128, 256, 512 ) )
            explode:SetKeyValue( "iMagnitude", 75 )
            explode:Fire( "Explode", 0, 0 )
            self:Remove() 
        end
    end

end