local csoTree = util.JSONToTable( file.Read( "cso_weapons_with_prices.json" ) )
local outputTxt = ""

for k,v in pairs( csoTree ) do
    
    if v.deep == 1 then
        local cat = ""
        if v.slot == 1 then
            cat = "Slot 1 - Melee"
        elseif v.slot == 2 then
            cat = "Slot 2 - Sidearms"
        elseif v.slot == 3 then
            cat = "Slot 3 - Light Weapons"
        elseif v.slot == 4 then
            cat = "Slot 4 - Heavy Weapons"
        else
            cat = "Slot 5 - Explosives"
        end

        outputTxt = outputTxt ..
        "DarkRP.createShipment( \"" .. v.name .. "\", {\n" ..
        "\tmodel = \"" .. v.model .. "\",\n" ..
        "\tentity = \"" .. k .. "\",\n" ..
        "\tprice = " .. ( v.price * 10 ) * 1.1 .. ",\n" ..
        "\tamount = 10,\n" ..
        "\tseparate = true,\n" ..
        "\tpricesep = " .. v.price .. ",\n" ..
        "\tnoship = true,\n" ..
        "\tallowed = { " .. ( v.basic and "TEAM_GUN" or "TEAM_SPECGUN" ) .. " },\n" ..
        "\tcategory = \"" .. cat .. "\"\n" ..
        "})\n\n"

        --[[
        if v.basic then
            outputTxt = outputTxt ..
            "DarkRP.createShipment( \"" .. v.name .. "\", {\n" ..
            "\tmodel = \"" .. v.model .. "\",\n" ..
            "\tentity = \"" .. k .. "\",\n" ..
            "\tprice = " .. ( v.price * 10 ) * 1.1 .. ",\n" ..
            "\tamount = 10,\n" ..
            "\tseparate = true,\n" ..
            "\tpricesep = " .. v.price .. ",\n" ..
            "\tnoship = true,\n" ..
            "\tallowed = {TEAM_GUN},\n" ..
            "\tcategory = \"" .. cat .. "\"\n" ..
            "})\n\n"
        else
            outputTxt = outputTxt ..
            "DarkRP.createShipment( \"" .. v.name .. "\", {\n" ..
            "\tmodel = \"" .. v.model .. "\",\n" ..
            "\tentity = \"" .. k .. "\",\n" ..
            "\tprice = " .. ( v.price * 10 ) * 1.1 .. ",\n" ..
            "\tamount = 10,\n" ..
            "\tseparate = true,\n" ..
            "\tpricesep = " .. v.price .. ",\n" ..
            "\tnoship = true,\n" ..
            "\tallowed = {TEAM_SPECGUN},\n" ..
            "\tcategory = \"" .. cat .. "\"\n" ..
            "})\n\n"
        end
        ]]

    end

end

file.Write( "FUCKYOUSTUPIDFUCKINGSHIT.txt", outputTxt )