AddCSLuaFile()

ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Pawn Broker"
ENT.Author = "SweptThrone"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "AnkoRP NPCs"

ENT.NextTalkUse = 0

ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( enable )
	self.AutomaticFrameAdvance = enable
end 

if SERVER then

	function ENT:Initialize()
		self:SetModel("models/vortigaunt.mdl")
		self:SetHullType(HULL_HUMAN)
		self:SetHullSizeNormal()
		self:SetNPCState(NPC_STATE_IDLE)
		self:SetSolid(SOLID_BBOX)
		self:SetUseType(SIMPLE_USE)
		self:SetBloodColor(BLOOD_COLOR_RED)
	end

	function ENT:Use( ent, ply )

	end

	function ENT:OnRemove()
		
	end

	function ENT:Think()
		self:ResetSequence( "idle01" )
	end

	function ENT:AcceptInput(name, activator, caller)
		if name == "Use" and caller:IsPlayer() and CurTime() >= self.NextTalkUse then
			self.NextTalkUse = CurTime() + 2

			local plysHaveGems, plysHaveGold = false, false
			for k,v in pairs( player.GetAll() ) do
				if v != caller then 
					if v:GetNWBool( "HasGold" ) then
						plysHaveGold = true
					end
					if v:GetNWBool( "HasSmallGems" ) or v:GetNWBool( "HasLargeGems" ) then
						plysHaveGems = true
					end
				end
			end

			if caller:GetNWBool( "HasGold", false ) then
				self:EmitSound( "vo/npc/vortigaunt/here.wav" )
				caller:SetNWBool( "HasGold", false )
				caller:addMoney( 100000 * GLOBAL_MONEY_MULTIPLIER )
            	DarkRP.notify( caller, 0, 4, "You got $" .. string.Comma( 100000 * GLOBAL_MONEY_MULTIPLIER ) .. " for turning in Gold!" )
				caller:STNPCMessage( self, "We appreciate the gold..." )
				if #ents.FindByClass( "st_ankorp_gold" ) == 0 and !plysHaveGold then
					for k,v in pairs( ents.GetAll() ) do
						if v.REMOVEONEVENT then
							v:Remove()
						end
					end		
					CURRENT_ANKORP_EVENT = false
					game.GetWorld():SetNWString( "EventLoc", "" )
					game.GetWorld():SetNWString( "EventEnt", "" )
					DarkRP.notify( player.GetAll(), 0, 4, "All Gold has been turned in and therefore the Money Event has ended!" )
				end
			elseif caller:GetNWBool( "HasSmallGems", false ) then
				self:EmitSound( "vo/npc/vortigaunt/here.wav" )
				caller:SetNWBool( "HasSmallGems", false )
				caller:addMoney( 50000 * GLOBAL_MONEY_MULTIPLIER )
            	DarkRP.notify( caller, 0, 4, "You got $" .. string.Comma( 50000 * GLOBAL_MONEY_MULTIPLIER ) .. " for turning in a small bag of Diamonds!" )
				caller:STNPCMessage( self, "This small bag of gems will go a long way..." )
				if #ents.FindByClass( "st_ankorp_smgems" ) == 0 and !plysHaveGems then		
					CURRENT_ANKORP_EVENT = false
					game.GetWorld():SetNWString( "EventLoc", "" )
					game.GetWorld():SetNWString( "EventEnt", "" )
					DarkRP.notify( player.GetAll(), 0, 4, "All Gems have been turned in and therefore the Money Event has ended!" )
				end
			elseif caller:GetNWBool( "HasLargeGems", false ) then
				self:EmitSound( "vo/npc/vortigaunt/here.wav" )
				caller:SetNWBool( "HasLargeGems", false )
				caller:addMoney( 125000 * GLOBAL_MONEY_MULTIPLIER )
            	DarkRP.notify( caller, 0, 4, "You got $" .. string.Comma( 125000 * GLOBAL_MONEY_MULTIPLIER ) .. " for turning in a large bag of Diamonds!" )
				caller:STNPCMessage( self, "We pay well for this fine mound of gems..." )
				if #ents.FindByClass( "st_ankorp_lggems" ) == 0 and !plysHaveGems then
					CURRENT_ANKORP_EVENT = false
					game.GetWorld():SetNWString( "EventLoc", "" )
					game.GetWorld():SetNWString( "EventEnt", "" )
					DarkRP.notify( player.GetAll(), 0, 4, "All Gems have been turned in and therefore the Money Event has ended!" )
				end
			else
				self:EmitSound( "vo/npc/vortigaunt/reasondelay.wav" )
				caller:STNPCMessage( self, "You don't have anything we need...come back later..." )
			end
		end
	end

	function ENT:OnTakeDamage( dmg )
		return 0
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		
		local Pos = self:GetPos()
		local Ang = self:GetAngles()
		
		Ang:RotateAroundAxis(Ang:Forward(), 90)
		Ang:RotateAroundAxis(Ang:Right(), 270)
		
		local txt = " Pawn Broker "
		
		surface.SetFont("UPGMed")
		local TextWidth = surface.GetTextSize(txt)
		
		cam.Start3D2D(Pos - Ang:Right() * 50 + Ang:Up(), Ang, 0.16)
			draw.WordBox(4, -TextWidth*0.5 - 5, -200, txt, "UPGMed", Color(0, 0, 0, 255), Color(255,255,255,255))
		cam.End3D2D()

	end
end