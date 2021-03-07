AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "long_use_base"
 
ENT.PrintName= "Money Stack ($25k)"
ENT.Author= "Throneco"
ENT.Contact= "http://discord.gg/Tg8SUDv"
ENT.Purpose= ""
ENT.Instructions= ""
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "AnkoRP Pickups"
ENT.TimeToUse = 5

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end

if SERVER then
    function ENT:Initialize()
    
        self:SetModel( "models/player/spike/pile.mdl" )
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
        if ply:getJobTable().category == "Citizens" then
            DarkRP.notify( ply, 1, 4, "You cannot participate in Money Events as a Citizen!" )
            self:SetUser( nil )
			self:SetProgress( -1 )
            return
        end
        if ply:getJobTable().category == "Counter-Terrorists" then
            DarkRP.notify( ply, 1, 4, "Defend this money from anyone trying to steal it!" )
            self:SetUser( nil )
			self:SetProgress( -1 )
            return
        end
        self:EmitSound( "items/ammopickup.wav" )
    end

    function ENT:OnUseFinish( ply )
        self:EmitSound( "items/gift_pickup.wav" )
        ply:addMoney( 25000 * GLOBAL_MONEY_MULTIPLIER )
        DarkRP.notify( ply, 0, 4, "You picked up $" .. string.Comma( 25000 * GLOBAL_MONEY_MULTIPLIER ) .. "!" )
        if #ents.FindByClass( "st_ankorp_money" ) == 1 then
			CURRENT_ANKORP_EVENT = false
			game.GetWorld():SetNWString( "EventLoc", "" )
			game.GetWorld():SetNWString( "EventEnt", "" )
			DarkRP.notify( player.GetAll(), 0, 4, "All money has been stolen and therefore the Money Event has ended!" )
		end
        self:Remove()
    end

    function ENT:OnUseCancel( ply )
    end
	
	function ENT:Think()

		if IsValid( self:GetUser() ) then
            if !IsValid( self:GetUser():GetUseEntity() ) and self:GetUser():GetUseEntity() != self then
                self:SetUser( nil )
                self:SetProgress( -1 )
            end
        end

		if self:GetProgress() == self.LastProg and self:GetProgress() != -1 then
			self:OnUseCancel( self:GetUser() )
            self:SetUser( nil )
            self:SetProgress( -1 )
		end

		self.LastProg = self:GetProgress()

		--[[
			usually you'd just use CurTime() here,
			but on 66-tick servers, it's extremely unreliable.
			sometimes it will cancel using even if you're holding it.
			this is a bit of a fix, but it runs this entity
			at 16-tick i think...
		]]--
		self:NextThink( CurTime() + 0.06 )

		return true

	end

end