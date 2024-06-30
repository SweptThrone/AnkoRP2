-- i don't want to comment these right now
-- i have a headache

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "Artist's Workbench"
ENT.Author= "Throneco"
ENT.Contact= "http://discord.gg/Tg8SUDv"
ENT.Purpose= ""
ENT.Instructions= ""
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Category = "AnkoRP Entities"
ENT.RenderGroup = RENDERGROUP_BOTH

local function FormatTime( num )
    return string.FormattedTime( math.ceil( num ) ).m .. ":" .. 
        ( string.FormattedTime( math.ceil( num ) ).s < 10 and "0" or "" ) .. string.FormattedTime( math.ceil( num ) ).s
end

if CLIENT then
    function ENT:Initialize()
        self.spraycan = ClientsideModel( "models/sweptthrone/spray_can.mdl" )
        self.spraycan:SetPos( self:GetPos() + self:GetUp() * 34 - self:GetForward() * 10 + self:GetRight() * 30 )
        --self.spraycan:SetModelScale( 0.3333 )
        self.spraycan:Spawn()

        self.wrench = ClientsideModel( "models/props_c17/tools_wrench01a.mdl" )
        self.wrench:SetPos( self:GetPos() + self:GetUp() * 35 + self:GetForward() * 15 - self:GetRight() * 30 )
        self.wrench:Spawn()
    end

    function ENT:OnRemove()
        self.spraycan:Remove()
        self.wrench:Remove()
    end

    function ENT:Draw()
        self:DrawModel()
    end

    function ENT:DrawTranslucent()

        local Pos = self:GetPos()
        local Ang = self:GetAngles()

        if not IsValid( self.spraycan ) then
            self.spraycan = ClientsideModel( "models/sweptthrone/spray_can.mdl" )
        end

        if not IsValid( self.wrench ) then
            self.wrench = ClientsideModel( "models/props_c17/tools_wrench01a.mdl" )
        end

        local propAng = self:GetAngles()
        propAng:RotateAroundAxis( propAng:Up(), -225 )
        self.spraycan:SetPos( self:GetPos() + self:GetUp() * 34 - self:GetForward() * 10 + self:GetRight() * 30 )
        self.spraycan:SetAngles( propAng )
        self.wrench:SetPos( self:GetPos() + self:GetUp() * 35 + self:GetForward() * 15 - self:GetRight() * 30 )
        self.wrench:SetAngles( propAng )

        Ang:RotateAroundAxis(Ang:Forward(), 90)
        Ang:RotateAroundAxis(Ang:Right(),-90)
        
        local txt = ( self:CPPIGetOwner() and self:CPPIGetOwner():Name() .. "'s " or "" ) .. "Artist's Workbench"
        local txt2
        --print(  self:GetNWString( "WorkWeapon" ) )
        if weapons.Get( self:GetNWString( "WorkWeapon" ) ) != nil then
            txt2 = weapons.Get( self:GetNWString( "WorkWeapon" ) ).PrintName
        else
            txt2 = "No Weapon"
        end
        local txt3
        if self:GetNWString( "WorkSkin" ) == "" then
            txt3 = "No Skin"
        else
            txt3 = TFA.Attachments.Atts[ self:GetNWString( "WorkSkin" ) ].Name
        end
        local txt4
        if self:GetNWInt( "WorkTime", math.huge ) == math.huge then
            if self:GetNWString( "WorkSkin" ) != "" then
                txt4 = "READY"
            else
                txt4 = FormatTime( 0 )
            end
        else
            txt4 = FormatTime( self:GetNWInt( "WorkTime", math.huge ) - CurTime() )
        end
        
        surface.SetFont("UPGMed")
        local TextWidth = surface.GetTextSize(txt)
        local TextWidth2 = surface.GetTextSize(txt2)
        local TextWidth3 = surface.GetTextSize(txt3)
        local TextWidth4 = surface.GetTextSize(txt4)
        
        cam.Start3D2D(Pos + Ang:Up() * -20 - Ang:Right() * 5, Ang, 0.16)
            draw.WordBox(4, -TextWidth*0.5, -380, txt, "UPGMed", Color(50, 22, 49, 255), Color(255,255,255,255))
            draw.WordBox(4, -TextWidth2*0.5, -340, txt2, "UPGMed", Color(50, 22, 49, 255), Color(255,255,255,255))
            draw.WordBox(4, -TextWidth3*0.5, -300, txt3, "UPGMed", Color(50, 22, 49, 255), Color(255,255,255,255))
            draw.WordBox(4, -TextWidth4*0.5, -260, txt4, "UPGMed", Color(50, 22, 49, 255), Color(255,255,255,255))
        cam.End3D2D()
    end

    net.Receive( "ST_OpenArtistMenu", function()
    
        local this = net.ReadEntity()
        local wep = net.ReadEntity()

        local UpgradeWindow = vgui.Create( "DFrame" )
        UpgradeWindow:SetPos( 5, 5 )
        UpgradeWindow:SetSize( 800, 500 )
        UpgradeWindow:SetTitle( "" )
        UpgradeWindow:SetVisible( true )
        UpgradeWindow:SetDraggable( false )
        UpgradeWindow:ShowCloseButton( false )
        UpgradeWindow:MakePopup()
        UpgradeWindow:Center()
        UpgradeWindow.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 22, 49, 255 ) )
            draw.SimpleText( "ARTIST'S WORKBENCH", "UPGMed", 5, 2 )
        end

        local CloseButton = vgui.Create( "DButton", UpgradeWindow )
        CloseButton:SetPos( 760, 0 )
        CloseButton:SetSize( 40, 20 )
        CloseButton:SetText( "X" )
        CloseButton:SetTextColor(Color(255,255,255))
        CloseButton.DoClick = function( self )
            UpgradeWindow:Close()
            surface.PlaySound("ui/buttonclick.wav")
        end
        CloseButton.Paint = function( self, w, h )
            if CloseButton:IsHovered() then
                draw.RoundedBox( 0, 0, 0, w, h, Color( 128, 0, 0, 255 ) )
            else
                draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 0, 0, 255 ) )
            end
            surface.SetDrawColor( color_black )
        end

        local WeaponLabel = vgui.Create( "DLabel", UpgradeWindow )
        WeaponLabel:SetPos( 0, 80 )
        WeaponLabel:SetFont( "UPGSmall" )
        local wepUpgrades = wep.Attachments
        
        if wepUpgrades == {} or wepUpgrades == nil or table.IsEmpty( wepUpgrades ) then
            WeaponLabel:SetText( "You cannot apply any skins to your " .. language.GetPhrase( wep:GetPrintName() ) .. "." )
            WeaponLabel:SizeToContents()
            WeaponLabel:CenterHorizontal()
        else
            WeaponLabel:SetText( "Select a skin for your " .. wep:GetPrintName() .. ":" )
            WeaponLabel:SizeToContents()
            WeaponLabel:CenterHorizontal()

            local HintLabel = vgui.Create( "DLabel", UpgradeWindow )
            HintLabel:SetPos( 0, 480 )
            HintLabel:SetFont( "UPGMini" )
            HintLabel:SetText( "Hit C while holding your weapon to view skins and their effects." )
            HintLabel:SizeToContents()
            HintLabel:CenterHorizontal()
            -- fuckin tfa attachment structure
            -- attachment slot (v)
            --      attachments in that slot (w)
            --          number of the attachment (m)
            --              class name of the attachment (x)
            for k,v in pairs( wepUpgrades ) do
                for l,w in pairs( v ) do
                    if l != "sel" then
                        for m,x in pairs( w ) do

                            local skinPrice, paintTime = 0, 0
                            if TFA.Attachments.Atts[ x ].WeaponTable.MaterialTable != {} or TFA.Attachments.Atts[ x ].WeaponTable.MaterialTable_W != {} then
                                skinPrice = skinPrice + 500
                                paintTime = paintTime + 30
                            end
                            if TFA.Attachments.Atts[ x ].WeaponTable.Primary then
                                if TFA.Attachments.Atts[ x ].WeaponTable.Primary.Damage then
                                    skinPrice = skinPrice + ( ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.Damage( LocalPlayer():GetActiveWeapon(), LocalPlayer():GetActiveWeapon().Primary.Damage ) / LocalPlayer():GetActiveWeapon().Primary.Damage ) ) * CSO_WEAPONS_TREE[ GetFinalParent( LocalPlayer():GetActiveWeapon():GetClass() ) ].price * 5 )
                                    paintTime = paintTime + 30 + ( ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.Damage( LocalPlayer():GetActiveWeapon(), LocalPlayer():GetActiveWeapon().Primary.Damage ) / LocalPlayer():GetActiveWeapon().Primary.Damage ) - 1 ) * 90 )
                                end
                                if TFA.Attachments.Atts[ x ].WeaponTable.Primary.ClipSize then
                                    skinPrice = skinPrice + ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.ClipSize( LocalPlayer():GetActiveWeapon(), LocalPlayer():GetActiveWeapon().Primary.ClipSize ) - LocalPlayer():GetActiveWeapon().Primary.ClipSize ) * ( CSO_WEAPONS_TREE[ LocalPlayer():GetActiveWeapon():GetClass() ].price * 1 ) )
                                    paintTime = paintTime + 30 + ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.ClipSize( LocalPlayer():GetActiveWeapon(), LocalPlayer():GetActiveWeapon().Primary.ClipSize ) - LocalPlayer():GetActiveWeapon().Primary.ClipSize ) * 9 )
                                end
                                if TFA.Attachments.Atts[ x ].WeaponTable.Primary.Spread then
                                    skinPrice = skinPrice + ( ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.Spread( LocalPlayer():GetActiveWeapon(), LocalPlayer():GetActiveWeapon().Primary.Spread ) / LocalPlayer():GetActiveWeapon().Primary.Spread ) ) * ( CSO_WEAPONS_TREE[ LocalPlayer():GetActiveWeapon():GetClass() ].price * 2.5 ) )
                                    paintTime = paintTime + 30 + ( ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.Spread( LocalPlayer():GetActiveWeapon(), LocalPlayer():GetActiveWeapon().Primary.Spread ) / LocalPlayer():GetActiveWeapon().Primary.Spread ) - 1 ) * 45 )
                                end
                                if TFA.Attachments.Atts[ x ].WeaponTable.Primary.RPM then
                                    skinPrice = skinPrice + ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.RPM( LocalPlayer():GetActiveWeapon(), LocalPlayer():GetActiveWeapon().Primary.RPM ) - LocalPlayer():GetActiveWeapon().Primary.RPM ) * ( CSO_WEAPONS_TREE[ LocalPlayer():GetActiveWeapon():GetClass() ].price * 0.1 ) )
                                    paintTime = paintTime + 30 + ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.RPM( LocalPlayer():GetActiveWeapon(), LocalPlayer():GetActiveWeapon().Primary.RPM ) - LocalPlayer():GetActiveWeapon().Primary.RPM ) * 6 )
                                end
                            end

                            paintTime = paintTime / SKIN_SPEED_MULTIPLIER

                            local SkinnedWeapon = vgui.Create( "DButton", UpgradeWindow )
                            SkinnedWeapon:SetPos( 100, 50 + (m+k)*35 )
                            SkinnedWeapon:SetSize( 600, 30 )
                            --SkinnedWeapon:SetText( LocalPlayer():GetActiveWeapon():GetPrintName() .. " | " .. TFA.Attachments.Atts[ x ].Name .. " - " .. "$97" )
                            SkinnedWeapon:SetText( LocalPlayer():GetActiveWeapon():GetPrintName() .. " | " .. TFA.Attachments.Atts[ x ].Name .. " - " .. "$" .. string.Comma( math.floor( skinPrice ) ) .. " | " .. FormatTime( paintTime ) )
                            SkinnedWeapon:SetFont( "UPGSmall" )
                            SkinnedWeapon:SetTextColor( LocalPlayer().attInvTable[ x ] and Color( 128, 128, 128 ) or Color( 255, 255, 255 ) )
                            SkinnedWeapon:SetEnabled( !LocalPlayer().attInvTable[ x ] )
                            SkinnedWeapon.class = x
                            function SkinnedWeapon:Paint( w, h )
                                if self:IsHovered() or LocalPlayer().attInvTable[ x ] then
                                    surface.SetDrawColor( Color( 128, 128, 128 ) )
                                else
                                    surface.SetDrawColor( Color( 255, 255, 255 ) )
                                end
                                surface.DrawOutlinedRect( 0, 0, w, h)
                            end
                            function SkinnedWeapon:DoClick()
                                net.Start( "ST_SkinWeapon" )
                                    net.WriteString( self.class )
                                    net.WriteEntity( this )
                                    net.WriteEntity( wep )
                                    --net.WriteInt( math.floor( skinPrice ), 32 )
                                    --net.WriteInt( paintTime, 32 )
                                    --net.WriteString( LocalPlayer():GetActiveWeapon():GetClass() )
                                net.SendToServer()
                                UpgradeWindow:Close()
                            end
                        end
                    end
                end
            end
        end

    end )

end

if SERVER then
    function ENT:Initialize()
    
        self:SetModel( "models/props/CS_militia/table_kitchen.mdl" )
        self:PhysicsInit( SOLID_VPHYSICS )
        self:SetMoveType( MOVETYPE_VPHYSICS )
        self:SetSolid( SOLID_VPHYSICS )
    
        self.Ready = false

        local phys = self:GetPhysicsObject()
        if (phys:IsValid()) then phys:Wake() end
        self:SetUseType(SIMPLE_USE)

        -- ############## up is not up for all weapons ##################
        -- use the OBB's second smallest edge and orient it based on that
        -- but how
        self.weapon = ents.Create( "prop_dynamic" )
        self.weapon:SetModel( "models/weapons/w_rif_m4a1.mdl" )
        self.weapon:SetPos( self:GetPos() + self:GetUp() * 36 + self:GetForward() * 4 + self:GetRight() * 7 )
        self.weapon:SetAngles( self:GetAngles() - Angle( 0, 115, 270 ) )
        self.weapon:SetParent(self)
        self.weapon:SetMaterial( "models/wireframe" )
        self:DeleteOnRemove( self.weapon )
        self.weapon:Spawn()

    end

    function ENT:Think()
        if CurTime() >= self:GetNWInt( "WorkTime", math.huge ) and self:GetNWString( "WorkSkin" ) != "" then
            self.Ready = true
            self:SetNWInt( "WorkTime", math.huge )
            if TFA.Attachments.Atts[ self:GetNWString( "WorkSkin" ) ].WeaponTable.MaterialTable then
                self.weapon:SetMaterial( TFA.Attachments.Atts[ self:GetNWString( "WorkSkin" ) ].WeaponTable.MaterialTable[ 1 ] )
            elseif TFA.Attachments.Atts[ self:GetNWString( "WorkSkin" ) ].WeaponTable.MaterialTable_W then
                self.weapon:SetMaterial( TFA.Attachments.Atts[ self:GetNWString( "WorkSkin" ) ].WeaponTable.MaterialTable_W[ 1 ] )
            end
            self:EmitSound( "player/sprayer.wav" )
        end
    end
    
    function table.GetLosingKey( tab )
        local lowest = math.huge
        local loser = nil

        for k,v in pairs( tab ) do
            if ( v < lowest ) then
                loser = k
                lowest = v
            end
        end

        return loser
    end

    function ENT:Use( act, ply )
        if self:GetNWInt( "WorkTime", math.huge ) == math.huge then
            if self.Ready then
                if ply:getJobTable().category ~= "Monsters" then
                    ply:Give( self:GetNWString( "WorkWeapon" ) )
                end
                DarkRP.notify( ply, 0, 4, "You got the " .. weapons.Get( self:GetNWString( "WorkWeapon" ) ).PrintName .. " | " .. TFA.Attachments.Atts[ self:GetNWString( "WorkSkin" ) ].Name .. "." )
                ply:AddAttachmentToTable( self:GetNWString( "WorkSkin" ) )
                self.weapon:SetModel( "models/weapons/w_rif_m4a1.mdl" )
                self.weapon:SetAngles( self:GetAngles() - Angle( 0, 115, 270 ) )
                self.weapon:SetMaterial( "models/wireframe" )
                self:SetNWInt( "WorkTime", math.huge )
                self:SetNWString( "WorkSkin", "" )
                self:SetNWString( "WorkWeapon", "" )
                self.Ready = false
            else
                net.Start( "ST_OpenArtistMenu" )
                    net.WriteEntity( self )
                    net.WriteEntity( ply:GetActiveWeapon() )
                net.Send( ply )
            end
        else
            DarkRP.notify( ply, 1, 4, "This workbench is busy." )
        end
            
    end

    net.Receive( "ST_SkinWeapon", function( _, ply )
        local att = net.ReadString()
        local this = net.ReadEntity()
        local wep = net.ReadEntity()
        --local price = net.ReadInt( 32 )
        --local time = net.ReadInt( 32 )
        --local actWep = net.ReadString()
        local skinPrice, paintTime = 0, 0

        if wep ~= ply:GetActiveWeapon() then
            DarkRP.notify( ply, 1, 4, "Paint failed, you are not holding the right weapon." )
        return end

        local wepUpgrades = ply:GetActiveWeapon().Attachments

        for k,v in pairs( wepUpgrades ) do
            for l,w in pairs( v ) do
                if l != "sel" then
                    for m,x in pairs( w ) do

                        skinPrice, paintTime = 0, 0

                        if TFA.Attachments.Atts[ x ].WeaponTable.MaterialTable != {} or TFA.Attachments.Atts[ x ].WeaponTable.MaterialTable_W != {} then
                            skinPrice = skinPrice + 500
                            paintTime = paintTime + 30
                        end
                        if TFA.Attachments.Atts[ x ].WeaponTable.Primary then
                            if TFA.Attachments.Atts[ x ].WeaponTable.Primary.Damage then
                                skinPrice = skinPrice + ( ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.Damage( wep, wep.Primary.Damage ) / wep.Primary.Damage ) ) * CSO_WEAPONS_TREE[ GetFinalParent( wep:GetClass() ) ].price * 5 )
                                paintTime = paintTime + 30 + ( ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.Damage( wep, wep.Primary.Damage ) / wep.Primary.Damage ) - 1 ) * 90 )
                            end
                            if TFA.Attachments.Atts[ x ].WeaponTable.Primary.ClipSize then
                                skinPrice = skinPrice + ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.ClipSize( wep, wep.Primary.ClipSize ) - wep.Primary.ClipSize ) * ( CSO_WEAPONS_TREE[ wep:GetClass() ].price * 1 ) )
                                paintTime = paintTime + 30 + ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.ClipSize( wep, wep.Primary.ClipSize ) - wep.Primary.ClipSize ) * 9 )
                            end
                            if TFA.Attachments.Atts[ x ].WeaponTable.Primary.Spread then
                                skinPrice = skinPrice + ( ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.Spread( wep, wep.Primary.Spread ) / wep.Primary.Spread ) ) * ( CSO_WEAPONS_TREE[ wep:GetClass() ].price * 2.5 ) )
                                paintTime = paintTime + 30 + ( ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.Spread( wep, wep.Primary.Spread ) / wep.Primary.Spread ) - 1 ) * 45 )
                            end
                            if TFA.Attachments.Atts[ x ].WeaponTable.Primary.RPM then
                                skinPrice = skinPrice + ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.RPM( wep, wep.Primary.RPM ) - wep.Primary.RPM ) * ( CSO_WEAPONS_TREE[ wep:GetClass() ].price * 0.1 ) )
                                paintTime = paintTime + 30 + ( ( TFA.Attachments.Atts[ x ].WeaponTable.Primary.RPM( wep, wep.Primary.RPM ) - wep.Primary.RPM ) * 6 )
                            end
                        end

                        paintTime = paintTime / SKIN_SPEED_MULTIPLIER
                    end
                end
            end
        end


        if !ply:canAfford( skinPrice ) then
            DarkRP.notify( ply, 1, 4, "Paint failed, you don't have enough money." )
        return end
        this:EmitSound( "npc/dog/dog_servo12.wav" )
        DarkRP.notify( ply, 0, 4, "Paint started! Come back in " .. FormatTime( paintTime ) .. " to get your " .. ply:GetActiveWeapon():GetPrintName() .. " | " .. TFA.Attachments.Atts[ att ].Name .. "." )
        ply:addMoney( -skinPrice )
        this:SetNWString( "WorkWeapon", wep:GetClass() )
        this:SetNWString( "WorkSkin", att )
        this:SetNWInt( "WorkTime", CurTime() + paintTime )
        this.weapon:SetModel( ply:GetActiveWeapon().WorldModel )
        local diffs = {
            ["x"] = Vector( Vector( this.weapon:OBBMaxs().x, this.weapon:OBBMins().y, this.weapon:OBBMins().z ) - this.weapon:OBBMins() ).x,
            ["y"] = Vector( Vector( this.weapon:OBBMins().x, this.weapon:OBBMaxs().y, this.weapon:OBBMins().z ) - this.weapon:OBBMins() ).y,
            ["z"] = Vector( Vector( this.weapon:OBBMins().x, this.weapon:OBBMins().y, this.weapon:OBBMaxs().z ) - this.weapon:OBBMins() ).z,
        }
        local func = {
            ["x"] = this.weapon:GetForward() * 64,
            ["y"] = this.weapon:GetRight() * 64,
            ["z"] = this.weapon:GetUp() * 64,
        }
        local angs = {
            ["x"] = Angle( 90, 0, 0 ),
            ["y"] = Angle( 0, 0, 0 ),
            ["z"] = Angle( 0, 225, 90 )
        }
        this.weapon:SetAngles( this:GetAngles() - Angle( 0, 115, 270 ) - angs[ table.GetLosingKey( diffs ) ] )
        this.weapon:SetMaterial( "" )
		
        ply:StripWeapon( ply:GetActiveWeapon():GetClass() )

    end )

end
