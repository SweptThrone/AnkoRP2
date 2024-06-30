AddCSLuaFile()

ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Crime Boss"
ENT.Author = "SweptThrone"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "AnkoRP NPCs"
ENT.HasJob = {}
ENT.Jobs = {}
ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( enable )
	self.AutomaticFrameAdvance = enable
end 

if SERVER then

	function ENT:Initialize()
		self:SetModel("models/player/gman_high.mdl")
		self:SetHullType(HULL_HUMAN)
		self:SetHullSizeNormal()
		self:SetNPCState(NPC_STATE_IDLE)
		self:SetSolid(SOLID_BBOX)
		self:SetUseType(SIMPLE_USE)
		self:SetBloodColor(BLOOD_COLOR_RED)

		timer.Create( "GenerateBountyJob", 30, 0, function()
			if math.random( 1, 10 ) == 10 and #GetCombatants() > 2 and #GetActiveTeams() >= 2 then
				for k,v in pairs( GetCombatants() ) do
					self.HasJob[ v ] = true
				end
			end
		end )
	end

	function ENT:Use( ent, ply )

	end

	function ENT:OnRemove()
		
	end

	function ENT:Think()
		self:ResetSequence( "idle_all_01" )
	end

	function ENT:AcceptInput(name, activator, caller)
		if name == "Use" and caller:IsPlayer() then
			if self.HasJob[ caller ] == nil then
				self.HasJob[ caller ] = false
			end

			local speechLUT = {
				[ "Citizens" ] = {
					[ true ] = "I don't have any business with you, get out of my office.",
					[ false ] = "I don't have any business with you, get out of my office."
				},
				[ "Counter-Terrorists" ] = {
					[ true ] = "Ah, a corrupt cop looking for some extra money, eh? Don’t worry, I gotcha covered.",
					[ false ] = "Nah I ain’t got nothin’, officer. Back to your day job for now."
				},
				[ "Terrorists" ] = {
					[ true ] = "What’s the deal? Random killings not giving enough money? I got something for you.",
					[ false ] = "Got nothin’ for ya right now, wouldn’t doubt it’s because you’ve killed ‘em all."
				},
				[ "Resistance" ] = {
					[ true ] = "You lookin’ to kill someone? I got a job, but I don’t know if you’re up for it.",
					[ false ] = "No jobs right now, kid. Come back later and maybe I’ll find something small enough."
				},
				[ "Combine" ] = {
					[ true ] = "I don’t usually care for your type but if you’re willing to do my work, I’ll pay ya.",
					[ false ] = "I got nothin’ you’d be interested in. Now go, you’re creepin’ me out."
				},
				[ "Monsters" ] = {
					[ true ] = "I’m not trusting no frail monster to take out my targets. Scram!",
					[ false ] = "I’m not trusting no frail monster to take out my targets. Scram!"
				},
				[ "???" ] = {
					[ true ] = "What the hell???",
					[ false ] = "What the hell???"
				}
			}

			if self.HasJob[ caller ] and #GetCombatants() > 2 and #GetActiveTeams() >= 2 and caller:IsCombatant() and !caller:GetNWBool( "Bounty_IsActive", false ) then
				caller:STNPCMessage( self, speechLUT[ caller:getJobTable().category ][ true ] )
				if IsValid( self.Jobs[ caller ] ) then
					caller:OfferBounty( self.Jobs[ caller ] )
				else
					local targets = GetCombatants()
					table.remove( targets, caller )
					for k,v in pairs( targets ) do
						if v:getJobTable().category == caller:getJobTable().category then
							table.remove( targets, v )
						end
					end
					local target = table.Random( targets )
					self.Jobs[ caller ] = target
					caller:OfferBounty( self.Jobs[ caller ] )
				end
			else
				caller:STNPCMessage( self, speechLUT[ caller:getJobTable().category ][ false ] )
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
		
		local txt = " Crime Boss "
		
		surface.SetFont("UPGMed")
		local TextWidth = surface.GetTextSize(txt)
		
		cam.Start3D2D(Pos - Ang:Right() * 50 + Ang:Up(), Ang, 0.16)
			draw.WordBox(4, -TextWidth*0.5 - 5, -200, txt, "UPGMed", Color(0, 0, 0, 255), Color(255,255,255,255))
		cam.End3D2D()

	end
end
