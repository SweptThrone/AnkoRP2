AddCSLuaFile()

ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Nurse"
ENT.Author = "SweptThrone"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "AnkoRP NPCs"

ENT.AutomaticFrameAdvance = true
ENT.NextHealUse = 0

function ENT:SetAutomaticFrameAdvance( enable )
	self.AutomaticFrameAdvance = enable
end 

if SERVER then

	function ENT:Initialize()
		self:SetModel( table.Random( { "models/Humans/Group02/Female_02.mdl", "models/Humans/Group02/Female_04.mdl", "models/Humans/Group02/Female_07.mdl" } ) )
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
		self:ResetSequence( "idle_subtle" )
	end

	function ENT:AcceptInput(name, activator, caller)
		if name == "Use" and caller:IsPlayer() and CurTime() >= self.NextHealUse then
			self.NextHealUse = CurTime() + 1.5

			if caller:Health() >= caller:GetMaxHealth() or timer.Exists( "NurseHeal" .. caller:EntIndex() ) then
				self:EmitSound( "vo/npc/female01/sorry0" .. math.random( 1, 3 ) .. ".wav" )
				if caller:Health() >= caller:GetMaxHealth() then
					caller:STNPCMessage( self, "Sorry, you're already at full health!" )
				else
					caller:STNPCMessage( self, "Sorry, you're already under the effects of a medkit!" )
				end
			else
				self:EmitSound( "vo/npc/female01/health0" .. math.random( 1, 4 ) .. ".wav" )
				caller:STNPCMessage( self, "Here, use this medkit to heal yourself up." )
				timer.Simple( 1, function()
					caller:EmitSound( "items/smallmedkit1.wav" )
					caller:SetNWBool( "MedkitRegen", true )
					timer.Create( "NurseHeal" .. caller:EntIndex(), 0.25, caller:GetMaxHealth() - caller:Health(), function()
						if IsValid( caller ) and caller:Health() < caller:GetMaxHealth() then caller:SetHealth( caller:Health() + 1 ) end
						if timer.RepsLeft( "NurseHeal" .. caller:EntIndex() ) == 0 then caller:SetNWBool( "MedkitRegen", false ) end
					end )
				end )
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
		
		local txt = " Nurse "
		
		surface.SetFont("UPGMed")
		local TextWidth = surface.GetTextSize(txt)
		
		cam.Start3D2D(Pos - Ang:Right() * 50 + Ang:Up(), Ang, 0.16)
			draw.WordBox(4, -TextWidth*0.5 - 5, -200, txt, "UPGMed", Color(0, 0, 0, 255), Color(255,255,255,255))
		cam.End3D2D()

	end
end