--[[
	I was asked to recreate a HUD from "KDGaming" I think.
	I didn't think it was terrible, so I used it for AnkoRP.

	This version actually also contains an optimization for the money flash,
	making this whole HUD client-bound (as it should be).
]]--

local smoothHP = 100
local smoothAP = 100
local smoothClip = 100
local smoothCash = 0

local money_last_frame = 0
local timesincelastdrop = 0
local timesincelastmoney = 0

local playerIcon = Material( "icon16/user.png" )
local jobIcon = Material( "icon16/group.png" )
local moneyIcon = Material( "icon16/money.png" )
local salaryIcon = Material( "icon16/rosette.png" )
local propIcon = Material( "icon16/group_link.png" )
local killstreakIcon = Material( "icon16/fire.png" )
local ksStar = Material( "icon16/star.png" )
local moreHealth = Material( "icon16/pill_add.png" )
local goldIcon = Material( "icon16/coins.png" )
local smGemsIcon = Material( "icon16/ruby.png" )
local lgGemsIcon = Material( "icon16/ruby_add.png" )

local ammoTypeLUT = {
	"u", "z", "p", "q", "p357", "w", "s", "x", "t", "v", "o", "12", "13", "r"
}

hook.Add( "HUDPaint", "DrawKDGHUD", function()

	local ply = LocalPlayer()
	local hp = LocalPlayer():Health()
	local ap = LocalPlayer():Armor()
	
	local color_hp = Color( 255, 0, 0 )
	local color_ap = Color( 0, 128, 255 )
	local color_bg = LocalPlayer():GetPlayerColor():ToColor()
	local color_wep = LocalPlayer():GetWeaponColor():ToColor()
	local color_barbg = Color( 86, 85, 86 )
	local color_black = color_black

	local money_this_frame
	if LocalPlayer().getDarkRPVar then
		money_this_frame = LocalPlayer():getDarkRPVar( "money" )
	else
		money_this_frame = 0
	end

	if money_last_frame > money_this_frame then
		timesincelastdrop = CurTime()
	elseif money_last_frame < money_this_frame then
		timesincelastmoney = CurTime()
	end

	smoothHP = Lerp( 15 * FrameTime(), smoothHP, hp )
	smoothAP = Lerp( 15 * FrameTime(), smoothAP, ap )
	if LocalPlayer():getDarkRPVar( "money" ) != nil then
		smoothCash = Lerp( 5 * FrameTime(), smoothCash, LocalPlayer():getDarkRPVar( "money" ) )
	end

	--master bg (playercol)
	surface.SetDrawColor( color_bg )
	draw.NoTexture()
	surface.DrawPoly( {
		{ x = 0, y = ScrH() - 175 },
		{ x = 250, y = ScrH() - 175 },
		{ x = 390	, y = ScrH() - 10 },
		{ x = 0, y = ScrH() - 10 }
	} )

	--master bg (black)
	surface.SetDrawColor( color_black )
	draw.NoTexture()
	surface.DrawPoly( {
		{ x = 0, y = ScrH() - 170 },
		{ x = 245, y = ScrH() - 170 },
		{ x = 380, y = ScrH() - 15 },
		{ x = 0, y = ScrH() - 15 }
	} )
	
	-- hp background dark
	surface.SetDrawColor( color_barbg )
	draw.NoTexture()
	surface.DrawPoly( {
		{ x = 0, y = ScrH() - 105 },
		{ x = 294, y = ScrH() - 105 },
		{ x = 330, y = ScrH() - 65 },
		{ x = 0, y = ScrH() - 65 }
	} )

	-- ap background dark
	surface.SetDrawColor( color_barbg )
	draw.NoTexture()
	surface.DrawPoly( { // - 91
		{ x = 0, y = ScrH() - 60 },
		{ x = 332, y = ScrH() - 60 },
		{ x = 368, y = ScrH() - 20 },
		{ x = 0, y = ScrH() - 20 }
	} )

	-- hp foreground
	surface.SetDrawColor( color_hp )
	draw.NoTexture()
	local hpXOne = smoothHP * ( 330 / LocalPlayer():GetMaxHealth() )
	if hp != 0 then
		surface.DrawPoly( {
			{ x = -36, y = ScrH() - 105 },
			{ x = hpXOne - 36, y = ScrH() - 105 },
			{ x = hpXOne, y = ScrH() - 65 },
			{ x = -36, y = ScrH() - 65 }
		} )
	end

	if LocalPlayer():GetNWBool( "MedkitRegen", false ) then
		surface.SetDrawColor( Color( 255, 255, 255, TimedSin( 1, 127, 255, 0 ) ) )
		surface.SetMaterial( moreHealth )
		surface.DrawTexturedRect( 393, ScrH() - 36, 24, 24 )
	end

	if LocalPlayer():GetNWBool( "HasGold", false ) then
		surface.SetDrawColor( Color( 255, 255, 255, TimedCos( 1, 127, 255, 0 ) ) )
		surface.SetMaterial( goldIcon )
		surface.DrawTexturedRect( LocalPlayer():GetNWBool( "MedkitRegen", false ) and 419 or 393, ScrH() - 36, 24, 24 )
	end

	if LocalPlayer():GetNWBool( "HasSmallGems", false ) then
		surface.SetDrawColor( Color( 255, 255, 255, TimedCos( 1, 127, 255, 0 ) ) )
		surface.SetMaterial( smGemsIcon )
		surface.DrawTexturedRect( LocalPlayer():GetNWBool( "MedkitRegen", false ) and 419 or 393, ScrH() - 36, 24, 24 )
	end

	if LocalPlayer():GetNWBool( "HasLargeGems", false ) then
		surface.SetDrawColor( Color( 255, 255, 255, TimedCos( 1, 127, 255, 0 ) ) )
		surface.SetMaterial( lgGemsIcon )
		surface.DrawTexturedRect( LocalPlayer():GetNWBool( "MedkitRegen", false ) and 419 or 393, ScrH() - 36, 24, 24 )
	end

	-- ap foreground
	if LocalPlayer():Team() == TEAM_FZOMBIE then
		surface.SetDrawColor( Color( 255, 255, 0 ) )
		draw.NoTexture()
		local apXOne = math.Clamp( ( 150 * ( 368 / 150 ) ) - ( ( LocalPlayer():GetNWInt( "SuperJumpRecharge", 0 ) - CurTime() ) / 3 ) * 150 * ( 368 / 150 ), 0, ( 150 * ( 368 / 150 ) ) )
		surface.DrawPoly( {
			{ x = -36, y = ScrH() - 60 },
			{ x = apXOne - 36, y = ScrH() - 60 },
			{ x = apXOne, y = ScrH() - 20 },
			{ x = -36, y = ScrH() - 20 }
		} )
	else
		surface.SetDrawColor( color_ap )
		draw.NoTexture()
		local apXOne = smoothAP * ( 368 / 150 )
		if ap != 0 then
			surface.DrawPoly( {
				{ x = -36, y = ScrH() - 60 },
				{ x = apXOne - 36, y = ScrH() - 60 },
				{ x = apXOne, y = ScrH() - 20 },
				{ x = -36, y = ScrH() - 20 }
			} )
		end
	end

	-- name icon
	surface.SetDrawColor( color_white )
	surface.SetMaterial( playerIcon	)
	surface.DrawTexturedRect( 5, ScrH() - 166, 16, 16 )

	-- job icon
	surface.SetDrawColor( color_white )
	surface.SetMaterial( jobIcon )
	surface.DrawTexturedRect( 5, ScrH() - 146, 16, 16 )

	-- cash icon
	surface.SetDrawColor( color_white )
	surface.SetMaterial( moneyIcon )
	surface.DrawTexturedRect( 5, ScrH() - 126, 16, 16 )

	-- salary icon
	surface.SetDrawColor( color_white )
	surface.SetMaterial( salaryIcon )
	surface.DrawTexturedRect( 190, ScrH() - 126, 16, 16 )

	-- team icon
	surface.SetDrawColor( color_white )
	surface.SetMaterial( propIcon )
	surface.DrawTexturedRect( 190, ScrH() - 146, 16, 16 )
	
	-- fire icon
	surface.SetDrawColor( ( CurTime() < ply:GetNWFloat( "LastKillTime", 0 ) + 4 and 255 or 0 ), ( CurTime() < ply:GetNWFloat( "LastKillTime", 0 ) + 4 and 255 or 0 ), ( CurTime() < ply:GetNWFloat( "LastKillTime", 0 ) + 4 and 255 or 0 ) )
	surface.SetMaterial( killstreakIcon )
	surface.DrawTexturedRect( 0, ScrH() - 210, 32, 32 )
	
	-- stars
	for i = 1, ply:GetNWInt( "CurrKillStreak", 0 ) do
		surface.SetDrawColor( color_white )
		surface.SetMaterial( ksStar )
		surface.DrawTexturedRect( 20 + ( i * 16 ), ScrH() - 202, 16, 16 )
	end
	
	if IsValid( LocalPlayer():GetActiveWeapon() ) then
		-- ammo background (wepcol)
		surface.SetDrawColor( color_wep )
		draw.NoTexture()
		surface.DrawPoly( {
			{ x = ScrW() - 256, y = ScrH() - 64 },
			{ x = ScrW(), y = ScrH() - 64 },
			{ x = ScrW(), y = ScrH() - 10 },
			{ x = ScrW() - 286, y = ScrH() - 10 }
		} )

		-- ammo foreground (black)
		surface.SetDrawColor( color_black )
		draw.NoTexture()
		surface.DrawPoly( {
			{ x = ScrW() - 251, y = ScrH() - 59 },
			{ x = ScrW(), y = ScrH() - 59 },
			{ x = ScrW(), y = ScrH() - 15 },
			{ x = ScrW() - 276, y = ScrH() - 15 }
		} )

		if LocalPlayer():GetActiveWeapon().Secondary and ( LocalPlayer():GetActiveWeapon().Secondary.Ammo != "none" and LocalPlayer():GetActiveWeapon().Secondary.Ammo != nil and LocalPlayer():GetActiveWeapon().Secondary.Ammo != "" ) then
			-- alt background (wepcol)
			surface.SetDrawColor( color_wep )
			draw.NoTexture()
			surface.DrawPoly( {
				{ x = ScrW() - 113, y = ScrH() - 100 },
				{ x = ScrW(), y = ScrH() - 100 },
				{ x = ScrW(), y = ScrH() - 64 },
				{ x = ScrW() - 136, y = ScrH() - 64 }
			} )	

			-- alt background (black)
			surface.SetDrawColor( color_black )
			draw.NoTexture()
			surface.DrawPoly( {
				{ x = ScrW() - 108, y = ScrH() - 95 },
				{ x = ScrW(), y = ScrH() - 95 },
				{ x = ScrW(), y = ScrH() - 64 },
				{ x = ScrW() - 128, y = ScrH() - 64 }
			} )
		end
	end

	--[[ ========= TEXTS START HERE ========= ]]--
	local TEAM_CAT_LUT = {
		[ "Counter-Terrorists" ] = "CT",
		[ "Terrorists" ] = "TR",
		[ "Resistance" ] = "RE",
		[ "Combine" ] = "CM",
		[ "Monsters" ] = "MN",
		[ "Citizens" ] = "CZ"
	}
	
	local TEAM_CAT_COLOR_LUT = {
		[ "Counter-Terrorists" ] = Color( 84, 109, 126 ),
		[ "Terrorists" ] = Color( 125, 61, 64 ),
		[ "Resistance" ] = Color( 243, 207, 47 ),
		[ "Combine" ] = Color( 63, 92, 205 ),
		[ "Monsters" ] = Color( 112, 173, 71 ),
		[ "Citizens" ] = Color( 0, 176, 80 )
	}

	draw.SimpleText( hp .. " HP", "KDGWantedFont", 105, ScrH() - 100, color_black )
	draw.SimpleText( LocalPlayer():Team() == TEAM_FZOMBIE and "+ALT1" or ap .. " AP", "KDGWantedFont", 105, ScrH() - 55, color_black )
	draw.SimpleText( LocalPlayer():Name(), "KDGDisplayFont", 24, ScrH() - 167, color_white )
	draw.SimpleText( LocalPlayer():getDarkRPVar( "job" ), "KDGDisplayFont", 24, ScrH() - 147, color_white )
	draw.SimpleText( DarkRP.formatMoney( math.Round( smoothCash ) ), "KDGDisplayFont", 24, ScrH() - 127, color_white )
	draw.SimpleText( DarkRP.formatMoney( math.Round( smoothCash ) ), "KDGDisplayFont", 24, ScrH() - 127, Color( 255, 0, 0, math.Clamp( 255 - ( CurTime() - timesincelastdrop ) * 500, 0, 255 ) ) )
	draw.SimpleText( DarkRP.formatMoney( math.Round( smoothCash ) ), "KDGDisplayFont", 24, ScrH() - 127, Color( 0, 255, 0, math.Clamp( 255 - ( CurTime() - timesincelastmoney ) * 500, 0, 255 ) ) )
	draw.SimpleText( string.Comma( LocalPlayer():GetNWInt( "STCredits", 0 ) ) .. "cR", "KDGDisplayFont", 210, ScrH() - 127, color_white )
	draw.SimpleText( LocalPlayer():getJobTable() and TEAM_CAT_LUT[ LocalPlayer():getJobTable().category ] or "ERR", "KDGDisplayFont", 210, ScrH() - 147, LocalPlayer():getJobTable() and TEAM_CAT_COLOR_LUT[ LocalPlayer():getJobTable().category ] or color_white )

	if IsValid( LocalPlayer():GetActiveWeapon() ) then
		local amoType = LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()
		local amo1 = LocalPlayer():GetAmmoCount( amoType )
		draw.SimpleText( amoType == -1 and "• • • •" or math.floor( amo1 / 1000 % 10 ) .. " " .. math.floor( amo1 / 100 % 10 ) .. " " .. math.floor( amo1 / 10 % 10 ) .. " " .. amo1 % 10, "BigKDGDisplayFont", ScrW() - 124, ScrH() - 56, color_white )

		draw.SimpleText( "/", "BigKDGDisplayFont", ScrW() - 145, ScrH() - 56, color_white )
		local clipp = LocalPlayer():GetActiveWeapon():Clip1()
		draw.SimpleText( amoType == -1 and "• • •" or math.floor( clipp / 100 % 10 ) .. " " .. math.floor( clipp / 10 % 10 ) .. " " .. clipp % 10, "BigKDGDisplayFont", ScrW() - 242, ScrH() - 56, color_white )
		
		if amoType == 5 then
			surface.SetFont( "Ammo2TypeDisplay" )
			draw.SimpleText( ammoTypeLUT[ amoType ] or "", "Ammo2TypeDisplay", ScrW() - 275 - surface.GetTextSize( ammoTypeLUT[ amoType ] or "" ), ScrH() - 65, color_white )
		else
			surface.SetFont( "AmmoTypeDisplay" )
			draw.SimpleText( ammoTypeLUT[ amoType ] or "", "AmmoTypeDisplay", ScrW() - 275 - surface.GetTextSize( ammoTypeLUT[ amoType ] or "" ), ScrH() - 90, color_white )
		end

		if LocalPlayer():GetActiveWeapon().Secondary and ( LocalPlayer():GetActiveWeapon().Secondary.Ammo != "none" and LocalPlayer():GetActiveWeapon().Secondary.Ammo != nil and LocalPlayer():GetActiveWeapon().Secondary.Ammo != "" ) then
			local amoType2 = LocalPlayer():GetActiveWeapon():GetSecondaryAmmoType()
			local amo2 = LocalPlayer():GetAmmoCount( amoType2 )

			draw.SimpleText( amoType2 == -1 and "•" or math.floor( amo2 / 1000 % 10 ) .. " " .. math.floor( amo2 / 100 % 10 ) .. " " .. math.floor( amo2 / 10 % 10 ) .. " " .. amo2 % 10, "AmmoKDGDisplayFont", ScrW() - 90, ScrH() - 92, color_white )
			draw.SimpleText( ammoTypeLUT[ amoType2 ] or "", "Ammo2TypeDisplay", ScrW() - 180, ScrH() - 110, color_white )
		end
	end

	local multOffsets = 0
	surface.SetFont( "UPGMini" )
	if SKIN_SPEED_MULTIPLIER > 1 then
		draw.SimpleTextOutlined( "Skin Paint Speed: " .. SKIN_SPEED_MULTIPLIER .. "x", "UPGMini", ScrW()/2 - surface.GetTextSize( "Skin Paint Speed: " .. SKIN_SPEED_MULTIPLIER .. "x" )/2, ScrH() - 20 - multOffsets, Color( 255, 255, TimedSin( 1, 127, 255, (multOffsets/20)-1 ) ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black )
		multOffsets = multOffsets + 20
	end
	if BOUNTY_MONEY_MULTIPLIER > 1 then
		draw.SimpleTextOutlined( "Bounty Reward Value: " .. BOUNTY_MONEY_MULTIPLIER .. "x", "UPGMini", ScrW()/2 - surface.GetTextSize( "Bounty Reward Value: " .. BOUNTY_MONEY_MULTIPLIER .. "x" )/2, ScrH() - 20 - multOffsets, Color( 255, 255, TimedSin( 1, 127, 255, (multOffsets/20)-1 ) ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black )
		multOffsets = multOffsets + 20
	end
	if CONTRACT_MONEY_MULTIPLIER > 1 then
		draw.SimpleTextOutlined( "Contract Pay Value: " .. CONTRACT_MONEY_MULTIPLIER .. "x", "UPGMini", ScrW()/2 - surface.GetTextSize( "Contract Pay Value: " .. CONTRACT_MONEY_MULTIPLIER .. "x" )/2, ScrH() - 20 - multOffsets, Color( 255, 255, TimedSin( 1, 127, 255, (multOffsets/20)-1 ) ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black )
		multOffsets = multOffsets + 20
	end
	if BITCOIN_MONEY_MULTIPLIER > 1 then
		draw.SimpleTextOutlined( "Bitcoin Mining Value: " .. BITCOIN_MONEY_MULTIPLIER .. "x", "UPGMini", ScrW()/2 - surface.GetTextSize( "Bitcoin Mining Value: " .. BITCOIN_MONEY_MULTIPLIER .. "x" )/2, ScrH() - 20 - multOffsets, Color( 255, 255, TimedSin( 1, 127, 255, (multOffsets/20)-1 ) ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black )
		multOffsets = multOffsets + 20
	end
	if KILL_MONEY_MULTIPLIER > 1 then
		draw.SimpleTextOutlined( "Kill Reward Value: " .. KILL_MONEY_MULTIPLIER .. "x", "UPGMini", ScrW()/2 - surface.GetTextSize( "Kill Reward Value: " .. KILL_MONEY_MULTIPLIER .. "x" )/2, ScrH() - 20 - multOffsets, Color( 255, 255, TimedSin( 1, 127, 255, (multOffsets/20)-1 ) ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black )
		multOffsets = multOffsets + 20
	end
	if GLOBAL_MONEY_MULTIPLIER > 1 then
		draw.SimpleTextOutlined( "Global Earnings Value: " .. GLOBAL_MONEY_MULTIPLIER .. "x", "UPGMini", ScrW()/2 - surface.GetTextSize( "Global Earnings Value: " .. GLOBAL_MONEY_MULTIPLIER .. "x" )/2, ScrH() - 20 - multOffsets, Color( 255, 255, TimedSin( 1, 127, 255, (multOffsets/20)-1 ) ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black )
		multOffsets = multOffsets + 20
	end
	
	if LocalPlayer():GetActiveWeapon().IsTFAWeapon and LocalPlayer():GetActiveWeapon():GetIronSights() and LocalPlayer():GetActiveWeapon().Scoped then
		surface.SetDrawColor( color_white )
		surface.DrawRect( ScrW() / 2 - 1, ScrH() / 2 - 1, 2, 2 )
	end

	money_last_frame = LocalPlayer():getDarkRPVar( "money" )

end )

local hide = {
	CHudBattery = true,
	CHudHealth = true,
	CHudAmmo = true,
	CHudSecondaryAmmo = true,
	DarkRP_LocalPlayerHUD = true,
	DarkRP_Agenda = true,
	DarkRP_ArrestedHUD = true
}


hook.Add( "HUDShouldDraw", "HideDefaults_KDGHUD", function(n)
	if hide[n] then return false end
end )
