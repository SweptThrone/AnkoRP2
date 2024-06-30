EXISTING_CSO_WEPS = {} 
CSO_WEAPONS_TREE = {}

-- these weapons have c_hands-enabled versions but still exist without c_hands
local ignoreWeapons = {
    [ "tfa_cso_p228_nochands" ] = true,
    [ "tfa_cso_mac10_nochands" ] = true,
    [ "tfa_cso_famas_nochands" ] = true,
    [ "tfa_cso_fiveseven_nochands" ] = true,
    [ "tfa_cso_g3sg1_nochands" ] = true,
    [ "tfa_cso_sg552_nochands" ] = true,
    [ "tfa_cso_ump45_nochands" ] = true,
    [ "tfa_cso_aug_nochands" ] = true
}

http.Fetch( "https://raw.githubusercontent.com/SweptThrone/AnkoRP2/main/cso_weapons_with_prices.json", function( body, size, headers, code )
    if code == 200 then
        CSO_WEAPONS_TREE = util.JSONToTable( body )

        for k,v in pairs( weapons.GetList() ) do
            if v.Category and string.Left( v.Category, 9 ) == "TFA CS:O " then
                EXISTING_CSO_WEPS[ v.ClassName ] = true
            end
        end
        
        print( "=====[ NEW WEAPONS ]=====" )
        for k,v in pairs( EXISTING_CSO_WEPS ) do
            if !CSO_WEAPONS_TREE[ k ] and !ignoreWeapons[ k ] then
                print( k .. ":\t\t" .. weapons.Get( k ).PrintName )
            end
        end
        
        print( "=====[ REPLACED WEAPONS ]=====" )
        for k,v in pairs( CSO_WEAPONS_TREE ) do
            if !EXISTING_CSO_WEPS[ k ] and !ignoreWeapons[ k ] then
                print( k .. ":\t\t" .. CSO_WEAPONS_TREE[ k ].name )
            end
        end
    else
        error( "HTTP fetch error " .. code )
    end
end, function( err )
    error( err )
end )


