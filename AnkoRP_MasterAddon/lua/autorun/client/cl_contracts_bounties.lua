--[[
    Show the player the offered contract,
    show the player the offered bounty.
]]--

local currentWindow = currentWindow or nil
local currentWindow2 = currentWindow2 or nil
local slotRewards = { 2500, 1500, 500, 250, 100 }

net.Receive( "ST_OfferAnkoContract", function( len )
    local slot = net.ReadInt( 4 )
    local kills = net.ReadInt( 6 )

    if IsValid( currentWindow ) then
        currentWindow:Remove()
    end

    surface.PlaySound( "ui/hint.wav" )

    local ContractPanel = vgui.Create( "DFrame" )
    ContractPanel:SetSize( 300, 200 )
    ContractPanel:SetPos( ScrW(), ScrH() / 2 - 100 )
    ContractPanel:SetTitle( "" )
    ContractPanel:SetDraggable( false )
    ContractPanel:ShowCloseButton( false )
    ContractPanel:MoveTo( ScrW() - 300, ScrH() / 2 - 100, 1, 0, 0.25, function( anim, panel )
        currentWindow = ContractPanel
        timer.Create( "CloseCurrentContract", 30, 1, function()
            if IsValid( currentWindow ) then
                currentWindow:MoveTo( ScrW(), ScrH() / 2 - 100, 1, 0, 0.25, function( anim2, panel2 )
                    currentWindow:Close()
                    currentWindow = nil
                end )
            end
        end )
    end )
    ContractPanel.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 81, 133, 78, 255 ) )
        surface.SetFont( "UPGSmall" )
        draw.SimpleText( "CONTRACT OFFER", "UPGSmall", 150 - surface.GetTextSize( "CONTRACT OFFER" ) / 2, 2, color_black )
        surface.SetFont( "UPGMini" )
        draw.SimpleText( "Get " .. kills .. " kills with", "UPGMini", 150 - surface.GetTextSize( "Get " .. kills .. " kills with" ) / 2, 40, color_black )
        draw.SimpleText( "Slot " .. slot .. " weapons", "UPGMini", 150 - surface.GetTextSize( "Slot " .. slot .. " weapons" ) / 2, 60, color_black )
        draw.SimpleText( "during next round.", "UPGMini", 150 - surface.GetTextSize( "during this round." ) / 2, 80, color_black )
        draw.SimpleText( "Reward: $" .. string.Comma( kills * slotRewards[ slot ] ), "UPGMini", 150 - surface.GetTextSize( "Reward: $" .. string.Comma( kills * slotRewards[ slot ] ) ) / 2, 110, color_black )
        if timer.Exists( "CloseCurrentContract" ) then
            draw.SimpleText( "Offer expires in " .. math.ceil( timer.TimeLeft( "CloseCurrentContract" ) ), "UPGMini", 150 - surface.GetTextSize( "Offer expires in " .. math.ceil( timer.TimeLeft( "CloseCurrentContract" ) ) ) / 2, 180, Color( 0, 0, 0, 156 ) )
        end
    end

    local AcceptButton = vgui.Create( "DButton", ContractPanel )
    AcceptButton:SetSize( 120, 30 )
    AcceptButton:SetPos( 20, 145 )
    AcceptButton:SetFont( "UPGMini" )
    AcceptButton:SetText( "ACCEPT" )
    AcceptButton:SetTextColor( color_black )
    AcceptButton.Paint = function( self, w, h )
        if self:IsHovered() then
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 196, 0, 255 ) )
        else
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 255, 0, 255 ) )
        end
    end
    AcceptButton.DoClick = function( self )
        surface.PlaySound( "buttons/button9.wav" )
        notification.AddLegacy( "You have accepted this contract.  It will become active next round.", NOTIFY_GENERIC, 4 )
        currentWindow:MoveTo( ScrW(), ScrH() / 2 - 100, 1, 0, 0.25, function( anim2, panel2 )
            net.Start( "ST_TakeContract" )
            net.SendToServer()
            currentWindow:Close()
            currentWindow = nil
            timer.Remove( "CloseCurrentContract" )
            ConstructContractStatus()
        end )
    end

    local DenyButton = vgui.Create( "DButton", ContractPanel )
    DenyButton:SetSize( 120, 30 )
    DenyButton:SetPos( 170, 145 )
    DenyButton:SetFont( "UPGMini" )
    DenyButton:SetText( "DENY" )
    DenyButton:SetTextColor( color_black )
    DenyButton.Paint = function( self, w, h )
        if self:IsHovered() then
            draw.RoundedBox( 0, 0, 0, w, h, Color( 196, 0, 0, 255 ) )
        else
            draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 0, 0, 255 ) )
        end
    end
    DenyButton.DoClick = function( self )
        currentWindow:MoveTo( ScrW(), ScrH() / 2 - 100, 1, 0, 0.25, function( anim2, panel2 )
            currentWindow:Close()
            currentWindow = nil
            timer.Remove( "CloseCurrentContract" )
        end )
    end

end )

function ConstructContractStatus()
    local ActiveContractPanel = vgui.Create( "DFrame" )
    ActiveContractPanel:SetSize( 300, 100 )
    ActiveContractPanel:SetPos( ScrW(), ScrH() / 2 - 50 )
    ActiveContractPanel:SetTitle( "" )
    ActiveContractPanel:SetDraggable( false )
    ActiveContractPanel:ShowCloseButton( false )
    ActiveContractPanel.Think = function( self )
        if LocalPlayer():GetNWInt( "Contract_KillsDone" ) >= LocalPlayer():GetNWInt( "Contract_KillsReq" ) then
            self:Remove()
        end
    end
    ActiveContractPanel:MoveTo( ScrW() - 300, ScrH() / 2 - 50, 1, 0, 0.25, function( anim, panel )
        currentWindow = ActiveContractPanel
        ActiveContractPanel.Hidden = false
    end )
    ActiveContractPanel.Paint = function( self, w, h )
        local timeLeft = math.max( game.GetWorld():GetNWInt( "AnkoNextRound" ) - CurTime(), 0 )
        local timeLeftStr = string.FormattedTime( math.ceil( timeLeft ) ).m .. ":" .. 
            ( string.FormattedTime( math.ceil( timeLeft ) ).s < 10 and "0" or "" ) .. string.FormattedTime( math.ceil( timeLeft ) ).s

        draw.RoundedBox( 0, 0, 0, w, h, Color( 81, 133, 78, 255 ) )
        surface.SetFont( "UPGSmall" )
        draw.SimpleText( "CONTRACT STATUS", "UPGSmall", 150 - surface.GetTextSize( "CONTRACT STATUS" ) / 2, 2, color_black )
        surface.SetFont( "UPGMini" )
        draw.SimpleText( "Get " .. LocalPlayer():GetNWInt( "Contract_KillsReq" ) .. " kills - Slot " .. LocalPlayer():GetNWInt( "Contract_SlotReq" ) .. " (" .. LocalPlayer():GetNWInt( "Contract_KillsDone" ) .. "/" .. LocalPlayer():GetNWInt( "Contract_KillsReq" ) .. ")", "UPGMini", 150 - surface.GetTextSize( "Get " .. LocalPlayer():GetNWInt( "Contract_KillsReq" ) .. " kills - Slot " .. LocalPlayer():GetNWInt( "Contract_SlotReq" ) .. " (" .. LocalPlayer():GetNWInt( "Contract_KillsDone" ) .. "/" .. LocalPlayer():GetNWInt( "Contract_KillsReq" ) .. ")" ) / 2, 30, color_black )
        if LocalPlayer():GetNWInt( "Contract_IsActive", 1 ) == 1 then
            draw.SimpleText( "Contract is inactive until next round.", "UPGMini", 150 - surface.GetTextSize( "Contract is inactive until next round." ) / 2, 80, Color( 196, 0, 0, 196 ) )
        else
            draw.SimpleText( "Contract expires in " .. timeLeftStr, "UPGMini", 150 - surface.GetTextSize( "Contract expires in " .. timeLeftStr ) / 2, 80, Color( 0, 0, 0, 156 ) )
        end

        if self.Hidden then
            draw.RoundedBox( 0, 0, 20, 20, 80, Color( 64, 0, 0, 255 ) )
            draw.RoundedBox( 0, 0, 100 - LocalPlayer():GetNWInt( "Contract_KillsDone" ) / LocalPlayer():GetNWInt( "Contract_KillsReq" ) * 80, 20, LocalPlayer():GetNWInt( "Contract_KillsDone" ) / LocalPlayer():GetNWInt( "Contract_KillsReq" ) * 80, Color( 0, 196, 0 ) )
        else
            draw.RoundedBox( 0, 20, 55, 260, 15, Color( 64, 0, 0, 255 ) )
            draw.RoundedBox( 0, 20, 55, LocalPlayer():GetNWInt( "Contract_KillsDone" ) / LocalPlayer():GetNWInt( "Contract_KillsReq" ) * 260, 15, Color( 0, 196, 0, 255 ) )
        end
    end

    local HideButton = vgui.Create( "DButton", ActiveContractPanel )
    HideButton:SetSize( 20, 20 )
    HideButton:SetPos( 0, 0 )
    HideButton:SetFont( "UPGMini" )
    HideButton:SetText( ">" )
    HideButton:SetTextColor( color_black )
    HideButton.Paint = function( self, w, h )
        if self:IsHovered() then
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 64, 128, 255 ) )
        else
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 128, 255, 255 ) )
        end
    end
    HideButton.DoClick = function( self )
        if ActiveContractPanel.Hidden then
            ActiveContractPanel:MoveTo( ScrW() - 300, ScrH() / 2 - 50, 1, 0, 0.25, function( anim2, panel2 )
                ActiveContractPanel.Hidden = false
                self:SetText( ">" )
            end )
        else
            ActiveContractPanel:MoveTo( ScrW() - 20, ScrH() / 2 - 50, 1, 0, 0.25, function( anim2, panel2 )
                 ActiveContractPanel.Hidden = true
                self:SetText( "<" )
            end )
        end
    end
end

net.Receive( "ST_OfferAnkoBounty", function( len )
    local target = net.ReadEntity()
    local payout = net.ReadInt( 32 )

    print( target )

    if IsValid( currentWindow2 ) then
        currentWindow2:Remove()
    end

    surface.PlaySound( "ui/hint.wav" )

    local BountyPanel = vgui.Create( "DFrame" )
    BountyPanel:SetSize( 300, 150 )
    BountyPanel:SetPos( -300, ScrH() / 2 - 75 )
    BountyPanel:SetTitle( "" )
    BountyPanel:SetDraggable( false )
    BountyPanel:ShowCloseButton( false )
    BountyPanel:MoveTo( 0, ScrH() / 2 - 75, 1, 0, 0.25, function( anim, panel )
        currentWindow2 = BountyPanel
        timer.Create( "CloseCurrentBounty", 30, 1, function()
            if IsValid( currentWindow2 ) then
                currentWindow2:MoveTo( -300, ScrH() / 2 - 75, 1, 0, 0.25, function( anim2, panel2 )
                    currentWindow2:Close()
                    currentWindow2 = nil
                end )
            end
        end )
    end )
    BountyPanel.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 133, 81, 78, 255 ) )
        surface.SetFont( "UPGSmall" )
        draw.SimpleText( "BOUNTY OFFER", "UPGSmall", 150 - surface.GetTextSize( "BOUNTY OFFER" ) / 2, 2, color_black )
        surface.SetFont( "UPGMini" )
        draw.SimpleText( "Kill " .. target:Name(), "UPGMini", 150 - surface.GetTextSize( "Kill " .. target:Name() ) / 2, 40, color_black )
        --draw.SimpleText( "Slot " .. slot .. " weapons", "UPGMini", 150 - surface.GetTextSize( "Slot " .. slot .. " weapons" ) / 2, 60, color_black )
        --draw.SimpleText( "during next round.", "UPGMini", 150 - surface.GetTextSize( "during this round." ) / 2, 80, color_black )
        draw.SimpleText( "Reward: $" .. string.Comma( payout ), "UPGMini", 150 - surface.GetTextSize( "Reward: $" .. string.Comma( payout ) ) / 2, 60, color_black )
        if timer.Exists( "CloseCurrentBounty" ) then
            draw.SimpleText( "Offer expires in " .. math.ceil( timer.TimeLeft( "CloseCurrentBounty" ) ), "UPGMini", 150 - surface.GetTextSize( "Offer expires in " .. math.ceil( timer.TimeLeft( "CloseCurrentBounty" ) ) ) / 2, 130, Color( 0, 0, 0, 156 ) )
        end
    end

    local BAcceptButton = vgui.Create( "DButton", BountyPanel )
    BAcceptButton:SetSize( 120, 30 )
    BAcceptButton:SetPos( 20, 90 )
    BAcceptButton:SetFont( "UPGMini" )
    BAcceptButton:SetText( "ACCEPT" )
    BAcceptButton:SetTextColor( color_black )
    BAcceptButton.Paint = function( self, w, h )
        if self:IsHovered() then
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 196, 0, 255 ) )
        else
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 255, 0, 255 ) )
        end
    end
    BAcceptButton.DoClick = function( self )
        surface.PlaySound( "buttons/button9.wav" )
        notification.AddLegacy( "You have accepted this bounty.  Hunt down your target.", NOTIFY_GENERIC, 4 )
        currentWindow2:MoveTo( -300, ScrH() / 2 - 75, 1, 0, 0.25, function( anim2, panel2 )
            net.Start( "ST_TakeBounty" )
                net.WriteBool( true )
            net.SendToServer()
            currentWindow2:Close()
            currentWindow2 = nil
            timer.Remove( "CloseCurrentBounty" )
            ConstructBountyStatus()
        end )
    end

    local BDenyButton = vgui.Create( "DButton", BountyPanel )
    BDenyButton:SetSize( 120, 30 )
    BDenyButton:SetPos( 170, 90 )
    BDenyButton:SetFont( "UPGMini" )
    BDenyButton:SetText( "DENY" )
    BDenyButton:SetTextColor( color_black )
    BDenyButton.Paint = function( self, w, h )
        if self:IsHovered() then
            draw.RoundedBox( 0, 0, 0, w, h, Color( 196, 0, 0, 255 ) )
        else
            draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 0, 0, 255 ) )
        end
    end
    BDenyButton.DoClick = function( self )
        currentWindow2:MoveTo( 0, ScrH() / 2 - 75, 1, 0, 0.25, function( anim2, panel2 )
            currentWindow2:Close()
            currentWindow2 = nil
            timer.Remove( "CloseCurrentBounty" )
        end )
    end

end )

function ConstructBountyStatus()
    local ActiveBountyPanel = vgui.Create( "DFrame" )
    ActiveBountyPanel:SetSize( 300, 100 )
    ActiveBountyPanel:SetPos( -300, ScrH() / 2 - 50 )
    ActiveBountyPanel:SetTitle( "" )
    ActiveBountyPanel:SetDraggable( false )
    ActiveBountyPanel:ShowCloseButton( false )
    ActiveBountyPanel.Think = function( self )
        if !IsValid( LocalPlayer():GetNWEntity( "Bounty_Target" ) ) then
            self:Remove()
        end
    end
    ActiveBountyPanel:MoveTo( 0, ScrH() / 2 - 50, 1, 0, 0.25, function( anim, panel )
        currentWindow2 = ActiveBountyPanel
        ActiveBountyPanel.Hidden = false
    end )
    ActiveBountyPanel.Paint = function( self, w, h )
        local timeLeft = math.max( game.GetWorld():GetNWInt( "AnkoNextRound" ) - CurTime(), 0 )
        local timeLeftStr = string.FormattedTime( math.ceil( timeLeft ) ).m .. ":" .. 
            ( string.FormattedTime( math.ceil( timeLeft ) ).s < 10 and "0" or "" ) .. string.FormattedTime( math.ceil( timeLeft ) ).s

        draw.RoundedBox( 0, 0, 0, w, h, Color( 133, 81, 78, 255 ) )
        surface.SetFont( "UPGSmall" )
        draw.SimpleText( "BOUNTY STATUS", "UPGSmall", 150 - surface.GetTextSize( "BOUNTY STATUS" ) / 2, 2, color_black )
        surface.SetFont( "UPGMini" )
        draw.SimpleText( "Kill " .. LocalPlayer():GetNWInt( "Bounty_Target" ):Name() .. ".", "UPGMini", 150 - surface.GetTextSize( "Kill " .. LocalPlayer():GetNWInt( "Bounty_Target" ):Name() .. "." ) / 2, 30, color_black )
    end

    local HideButton = vgui.Create( "DButton", ActiveBountyPanel )
    HideButton:SetSize( 20, 20 )
    HideButton:SetPos( 280, 0 )
    HideButton:SetFont( "UPGMini" )
    HideButton:SetText( "<" )
    HideButton:SetTextColor( color_black )
    HideButton.Paint = function( self, w, h )
        if self:IsHovered() then
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 64, 128, 255 ) )
        else
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 128, 255, 255 ) )
        end
    end
    HideButton.DoClick = function( self )
        if ActiveBountyPanel.Hidden then
            ActiveBountyPanel:MoveTo( 0, ScrH() / 2 - 50, 1, 0, 0.25, function( anim2, panel2 )
                ActiveBountyPanel.Hidden = false
                self:SetText( "<" )
            end )
        else
            ActiveBountyPanel:MoveTo( -280, ScrH() / 2 - 50, 1, 0, 0.25, function( anim2, panel2 )
                 ActiveBountyPanel.Hidden = true
                self:SetText( ">" )
            end )
        end
    end

    local CancelButton = vgui.Create( "DButton", ActiveBountyPanel )
    CancelButton:SetSize( 120, 30 )
    CancelButton:SetPos( 90, 60 )
    CancelButton:SetFont( "UPGMini" )
    CancelButton:SetText( "CANCEL" )
    CancelButton:SetTextColor( color_black )
    CancelButton.Paint = function( self, w, h )
        if self:IsHovered() then
            draw.RoundedBox( 0, 0, 0, w, h, Color( 196, 0, 0, 255 ) )
        else
            draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 0, 0, 255 ) )
        end
    end
    CancelButton.DoClick = function( self )
        net.Start( "ST_TakeBounty" )
            net.WriteBool( false )
        net.SendToServer()
        currentWindow2:MoveTo( -300, ScrH() / 2 - 50, 1, 0, 0.25, function( anim2, panel2 )
            currentWindow2:Close()
            currentWindow2 = nil
        end )
    end
end