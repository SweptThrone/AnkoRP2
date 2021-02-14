--[[
    Print the custom killfeed.
    This is hell.
]]--

local stckfdeaths = {}

--[[
local DEEP_COLORS = {
    Color( 255, 255, 255 ),
    Color( 146, 95, 72 ), --copper
    Color( 199, 155, 92 ), --bronze
    Color( 192, 192, 192 ), --silver
    Color( 219, 170, 16 ), --gold
    Color( 177, 1, 215 ), --mystic
    Color( 255, 215, 0 ) --transcendent
}
]]
local DEEP_COLORS = {
    Color( 255, 255, 255 ),
    Color( 141, 141, 141 ), --grey
    Color( 197, 121, 101 ), --pale
    Color( 228, 144, 255 ), --pink
    Color( 46, 246, 255 ), --aqua
    Color( 255, 183, 0 ), --gold
    Color( 255, 0, 0 ) --red
}

net.Receive( "STCustomKillfeed", function()
    local vic = net.ReadEntity()
    local wep = net.ReadEntity()
    local atk = net.ReadEntity()
    local isCSOWep = net.ReadBool()

    --print( vic )
    --print( wep )
    --print( atk )
    --print( isCSOWep )


    local attackerName, attackerColor
    if atk:GetClass() == "worldspawn" then
        attackerName = "WORLD"
        attackerColor = Color( 255, 0, 0 )
    elseif atk:IsPlayer() then
        attackerName = atk:Name()
        attackerColor = atk:getJobTable().color
    else
        if atk.PrintName == nil then
            attackerName = atk:GetClass()
        else
            attackerName = atk.PrintName
        end
        attackerColor = Color( 255, 0, 0 )
    end
    local wepName
    if !IsValid( wep ) then
        wepName = "???"
    else
        if wep:IsWeapon() then
            wepName = wep:GetPrintName()
        elseif wep:IsPlayer() then
            wepName = wep:Name()
        else
            if wep.PrintName == nil then
                wepName = wep:GetClass()
            else
                wepName = wep.PrintName
            end
        end
    end

    if !isCSOWep then
        --print( "NOT CSO WEP" )
        table.insert( stckfdeaths, { 
            ["atk"] = attackerName, 
            ["atk_col"] = attackerColor, 
            ["wep"] = wepName, 
            ["vic"] = vic:Name(), 
            ["vic_col"] = vic:getJobTable().color, 
            ["time"] = CurTime() + 6 } )
    else
        if !IsValid( wep ) or !IsValid( atk ) then
            --print( "WEP OR ATK NOT VALID" )
            table.insert( stckfdeaths, { ["atk"] = vic:Name(), ["atk_col"] = vic:getJobTable().color, ["wep"] = "???", ["vic"] = vic:Name(), ["vic_col"] = vic:getJobTable().color, ["time"] = CurTime() + 6 } )
        else
            if wep.Attachments != {} and wep.Attachments[ 1 ] != nil and wep.Attachments[ 1 ].sel != nil then
                --print( "HAS ATTACHMENT 1" )
                if wep.Attachments != {} and wep.Attachments[ 2 ] != nil and wep.Attachments[ 2 ].sel != nil then
                    --print( "AND 2" )
                    table.insert( stckfdeaths, { ["atk"] = atk:Name(), ["atk_col"] = atk:getJobTable().color, ["wep"] = wep:GetPrintName() .. " | " .. TFA.Attachments.Atts[ wep.Attachments[ 1 ].atts[ wep.Attachments[ 1 ].sel ] ].Name .. ", " .. TFA.Attachments.Atts[ wep.Attachments[ 2 ].atts[ wep.Attachments[ 2 ].sel ] ].Name, ["vic"] = vic:Name(), ["vic_col"] = vic:getJobTable().color, ["time"] = CurTime() + 6, ["class"] = wep:GetClass() } )
                else
                    --print( "AND NOT 2" )
                    table.insert( stckfdeaths, { ["atk"] = atk:Name(), ["atk_col"] = atk:getJobTable().color, ["wep"] = wep:GetPrintName() .. " | " .. TFA.Attachments.Atts[ wep.Attachments[ 1 ].atts[ wep.Attachments[ 1 ].sel ] ].Name, ["vic"] = vic:Name(), ["vic_col"] = vic:getJobTable().color, ["time"] = CurTime() + 6, ["class"] = wep:GetClass() } )
                end
            elseif wep.Attachments != {} and wep.Attachments[ 2 ] != nil and wep.Attachments[ 2 ].sel != nil then
                --print( "HAS ATTACHMENT 2" )
                if wep.Attachments != {} and wep.Attachments[ 1 ] != nil and wep.Attachments[ 1 ].sel != nil then
                    --print( "AND 1" )
                    table.insert( stckfdeaths, { ["atk"] = atk:Name(), ["atk_col"] = atk:getJobTable().color, ["wep"] = wep:GetPrintName() .. " | " .. TFA.Attachments.Atts[ wep.Attachments[ 1 ].atts[ wep.Attachments[ 1 ].sel ] ].Name .. ", " .. TFA.Attachments.Atts[ wep.Attachments[ 2 ].atts[ wep.Attachments[ 2 ].sel ] ].Name, ["vic"] = vic:Name(), ["vic_col"] = vic:getJobTable().color, ["time"] = CurTime() + 6, ["class"] = wep:GetClass() } )
                else
                    --print( "AND NOT 1" )
                    table.insert( stckfdeaths, { ["atk"] = atk:Name(), ["atk_col"] = atk:getJobTable().color, ["wep"] = wep:GetPrintName() .. " | " .. TFA.Attachments.Atts[ wep.Attachments[ 2 ].atts[ wep.Attachments[ 2 ].sel ] ].Name, ["vic"] = vic:Name(), ["vic_col"] = vic:getJobTable().color, ["time"] = CurTime() + 6, ["class"] = wep:GetClass() } )
                end
            else
                --print( "HAS NO ATTACHMENTS" )
                table.insert( stckfdeaths, { ["atk"] = atk:Name(), ["atk_col"] = atk:getJobTable().color, ["wep"] = wep:GetPrintName(), ["vic"] = vic:Name(), ["vic_col"] = vic:getJobTable().color, ["time"] = CurTime() + 6, ["class"] = wep:GetClass() } )
            end
        end
    end
    --[[atk:ChatPrint( "You killed someone" )
    vic:ChatPrint( "You were killed" )]]
    

end )

--[[
hook.Add( "Initialize", "Disappear, Killfeed!", function()
    function GAMEMODE:DrawDeathNotice( x, y ) x = 150 y = 150 end
end )
]]

hook.Add( "DrawDeathNotice", "Disapeajrohe", function( x, y ) 
    return false
end )

hook.Add( "HUDPaint", "DrawCustomKillFeed", function()

        surface.SetFont( "KillFeedFont" )

        --ERROR LINE 37: ATTEMPT TO USE A NULL ENTITY IF YOU GET KILLED BY A NON-WEAPON AFTER KILLING SOMEONE

        for k,v in pairs( stckfdeaths ) do
            --local pname = ( IsValid( v.wep ) and v.wep:GetPrintName() or "???" )
            --print( v.class )

            draw.SimpleText( v.atk .. "  ", "KillFeedFont", ScrW() - 10 - surface.GetTextSize( v.atk .. "  " .. v.wep .. "  " .. v.vic ), 10 + ( k - 1 ) * 30, v.atk_col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
            if v.class != nil then
                draw.SimpleTextOutlined( v.wep, "KillFeedFont", ScrW() - 10 - surface.GetTextSize( v.wep .. "  " .. v.vic ), 10 + ( k - 1 ) * 30, DEEP_COLORS[ CSO_WEAPONS_TREE[ v.class ].deep ], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, color_black )
            else
                draw.SimpleTextOutlined( v.wep, "KillFeedFont", ScrW() - 10 - surface.GetTextSize( v.wep .. "  " .. v.vic ), 10 + ( k - 1 ) * 30, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, color_black )
            end    
            draw.SimpleText( "  " .. v.vic, "KillFeedFont", ScrW() - 10 - surface.GetTextSize( "  " .. v.vic ), 10 + ( k - 1 ) * 30, v.vic_col, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
            if CurTime() >= v.time then
                table.remove( stckfdeaths, k )
            end
        end
        

    end )