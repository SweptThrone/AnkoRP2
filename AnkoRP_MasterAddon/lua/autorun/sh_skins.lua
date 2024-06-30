--[[
	Control players' ability to apply only skins they own.
]]--

hook.Add( "TFA_PreCanAttach", "ControlAttaching", function( wep, att )
	local canAttach
	if SERVER then
		canAttach = wep:GetOwner():GetAttachmentTable()[ att ]
	end
	if CLIENT then
		canAttach = wep:GetOwner().attInvTable[ att ]
	end
	if canAttach == nil then canAttach = false end
	return canAttach
end )