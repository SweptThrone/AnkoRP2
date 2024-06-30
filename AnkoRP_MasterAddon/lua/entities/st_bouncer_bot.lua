AddCSLuaFile()

ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Bouncer Bot"
ENT.Author = "SweptThrone"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "AnkoRP NPCs"

ENT.AutomaticFrameAdvance = true
ENT.NextTalkUse = 0

function ENT:SetAutomaticFrameAdvance( enable )
	self.AutomaticFrameAdvance = enable
end 

if SERVER then

	function ENT:Initialize()
		self:SetModel( "models/Combine_Scanner.mdl" )
		self:SetHullType(HULL_HUMAN)
		self:SetHullSizeNormal()
		self:SetNPCState(NPC_STATE_IDLE)
		self:SetSolid(SOLID_BBOX)
		self:SetUseType(SIMPLE_USE)
		self:SetBloodColor(BLOOD_COLOR_MECH)
	end

	function ENT:Use( ent, ply )

	end

	function ENT:OnRemove()
		
	end

	function ENT:Think()
		self:ResetSequence( "idle" )
	end

	function ENT:AcceptInput(name, activator, caller)
		if name == "Use" and caller:IsPlayer() and CurTime() >= self.NextTalkUse then
			caller:STNPCMessage( self, "<## KEEP YOUR BUSINESS OUT OF THE CLUB ##>" )
			self:EmitSound( "npc/scanner/scanner_scan5.wav", 75, 150 )
			self.NextTalkUse = CurTime() + 1
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
		
		local txt = " Bouncer Bot "
		
		surface.SetFont("UPGMed")
		local TextWidth = surface.GetTextSize(txt)
		
		cam.Start3D2D(Pos - Ang:Right() * 50 + Ang:Up(), Ang, 0.16)
			draw.WordBox(4, -TextWidth*0.5 - 5, 100, txt, "UPGMed", Color(0, 0, 0, 255), Color(255,255,255,255))
		cam.End3D2D()

	end
end