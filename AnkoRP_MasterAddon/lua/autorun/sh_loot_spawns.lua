--[[
    Define a global table for where Money Event loot spawns.
]]--

LOOT_SPAWNS = {
    -- Richman Jewelers :: Potential Take :: $450,000
    { loc = "richman", ent = "st_ankorp_smgems", pos = Vector( "-329.628174 546.222351 -46.949203" ), ang = Angle() },
    { loc = "richman", ent = "st_ankorp_smgems", pos = Vector( "-437.942657 550.940979 -47.066353" ), ang = Angle() },
    { loc = "richman", ent = "st_ankorp_smgems", pos = Vector( "-333.110687 -36.088142 -47.090851" ), ang = Angle() },
    { loc = "richman", ent = "st_ankorp_smgems", pos = Vector( "-436.373474 -35.947456 -47.058754" ), ang = Angle() },
    { loc = "richman", ent = "st_ankorp_lggems", pos = Vector( "-383.293274 148.717300 -45.533058" ), ang = Angle( 0, 90, 0 ) },
    { loc = "richman", ent = "st_ankorp_lggems", pos = Vector( "-383.148865 364.186066 -45.546097" ), ang = Angle( 0, 90, 0 ) },

    -- World Corp :: Potential Take :: $50,000 - $200,000
    { loc = "worldcorp", ent = "st_ankorp_money", pos = Vector( "-637.767883 5077.960449 1800.920532" ), ang = Angle( 0, -90, 0 ) },
    { loc = "worldcorp", ent = "st_ankorp_money", pos = Vector( "-508.963348 5038.942871 1810.826904" ), ang = Angle( 0, 180, 0 ) },
    { loc = "worldcorp", ent = "st_ankorp_gold", pos = Vector( "-636.554932 5084.806641 1800.731812" ), ang = Angle( 0, -90, 0 ) },
    { loc = "worldcorp", ent = "st_ankorp_gold", pos = Vector( "-510.443970 5039.578125 1810.657593" ), ang = Angle( 0, 180, 0 ) },

    -- Bank of Union :: Potential Take :: $150,000 - $600,000
    { loc = "bank", ent = "st_ankorp_money", pos = Vector( "-1492.669067 3538.825195 -229.273636" ), ang = Angle( 0, -90, 0 ) },
    { loc = "bank", ent = "st_ankorp_money", pos = Vector( "-1601.314941 3539.056152 -229.212082" ), ang = Angle( 0, -90, 0 ) },
    { loc = "bank", ent = "st_ankorp_money", pos = Vector( "-1545.510864 3404.561279 -238.043411" ), ang = Angle( 0, -90, 0 ) },
    { loc = "bank", ent = "st_ankorp_money", pos = Vector( "-1544.171875 2977.538574 -237.916626" ), ang = Angle( 0, 90, 0 ) },
    { loc = "bank", ent = "st_ankorp_money", pos = Vector( "-1488.400879 2845.690186 -229.237061" ), ang = Angle( 0, 90, 0 ) },
    { loc = "bank", ent = "st_ankorp_money", pos = Vector( "-1603.224243 2845.576904 -229.199387" ), ang = Angle( 0, 90, 0 ) },
    { loc = "bank", ent = "st_ankorp_gold", pos = Vector( "-1491.539795 2846.382080 -229.381851" ), ang = Angle( 0, 90, 0 ) },
    { loc = "bank", ent = "st_ankorp_gold", pos = Vector( "-1602.415649 2846.396729 -229.379669" ), ang = Angle( 0, 90, 0 ) },
    { loc = "bank", ent = "st_ankorp_gold", pos = Vector( "-1544.587158 2978.009521 -238.078796" ), ang = Angle( 0, 90, 0 ) },
    { loc = "bank", ent = "st_ankorp_gold", pos = Vector( "-1543.399658 3404.256836 -238.066803" ), ang = Angle( 0, -90, 0 ) },
    { loc = "bank", ent = "st_ankorp_gold", pos = Vector( "-1595.112549 3537.666260 -229.315369" ), ang = Angle( 0, -90, 0 ) },
    { loc = "bank", ent = "st_ankorp_gold", pos = Vector( "-1487.324951 3537.725586 -229.427902" ), ang = Angle( 0, -90, 0 ) },

    -- The Barge :: Potential Take :: $50,000 - $200,000
    { loc = "barge", ent = "st_ankorp_money", pos = Vector( "12835.063477 -12655.091797 -381.227325" ), ang = Angle( 0, 180, 0 ) },
    { loc = "barge", ent = "st_ankorp_money", pos = Vector( "12525.054688 -12649.300781 -381.292297" ), ang = Angle() },
    { loc = "barge", ent = "st_ankorp_gold", pos = Vector( "12526.418945 -12646.142578 -381.373596" ), ang = Angle() },
    { loc = "barge", ent = "st_ankorp_gold", pos = Vector( "12833.666016 -12658.325195 -381.381866" ), ang = Angle( 0, 180, 0 ) },

    -- The Remote Warehouse :: Potential Take :: 11 Basic Weapons
    { loc = "remote", ent = "st_weapon_box", pos = Vector( "-12667.880859 -9537.327148 -226.354004" ), ang = Angle( "-0.000 -90.000 0.000" ) },
    { loc = "remote", ent = "st_weapon_box", pos = Vector( "-12487.013672 -9539.968750 -226.463913" ), ang = Angle( "0.000 -90.000 -0.000" ) },
    { loc = "remote", ent = "st_weapon_box", pos = Vector( "-12303.917969 -9540.078125 -226.408752" ), ang = Angle( "0.000 -90.000 0.000" ) },
    { loc = "remote", ent = "st_weapon_box", pos = Vector( "-12239.857422 -9893.412109 -226.289749" ), ang = Angle( "-0.000 180.000 0.000" ) },
    { loc = "remote", ent = "st_weapon_box", pos = Vector( "-12239.544922 -10072.943359 -226.315857" ), ang = Angle( "0.000 180.000 0.000" ) },
    { loc = "remote", ent = "st_weapon_box", pos = Vector( "-12304.029297 -10427.469727 -226.342896" ), ang = Angle( "0.000 90.000 0.000" ) },
    { loc = "remote", ent = "st_weapon_box", pos = Vector( "-12484.879883 -10428.491211 -226.279358" ), ang = Angle( "-0.000 90.000 -0.000" ) },
    { loc = "remote", ent = "st_weapon_box", pos = Vector( "-12668.077148 -10427.681641 -226.291794" ), ang = Angle( "-0.000 90.000 0.000" ) },
    { loc = "remote", ent = "st_weapon_box", pos = Vector( "-11710.415039 -10166.037109 -226.335632" ), ang = Angle( "-0.000 -180.000 -0.000" ) },
    { loc = "remote", ent = "st_weapon_box", pos = Vector( "-11709.280273 -9984.096680 -226.345474" ), ang = Angle( "0.000 180.000 -0.000" ) },
    { loc = "remote", ent = "st_weapon_box", pos = Vector( "-11709.551758 -9801.556641 -226.394135" ), ang = Angle( "-0.000 -180.000 0.000" ) }

}