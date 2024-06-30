--[[
    AnkoRP custom jobs.
    Not much to talk about here.
]]--

TEAM_SAS = DarkRP.createJob("British SAS", {
    color = Color(84, 109, 126, 255),
    model = "models/player/gasmask.mdl",
    description = [[The British SAS.
Founded in World War 2 by David Stirling.
Focused on gathering intel behind enemy lines.
Also specialized in key assassinations.
Fight for the safety of the Citizens.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_sealknife", "tfa_cso_p228_v2", "tfa_cso_scout", "door_ram" },
    command = "sas",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Counter-Terrorists", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 1, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_sealknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_p228_v2" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_famas" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_GSG = DarkRP.createJob("German GSG-9", {
    color = Color(84, 109, 126, 255),
    model = "models/player/riot.mdl",
    description = [[The German GSG-9.
Formed in response to the Munich Massacre.
One of the top-performing counter-terrorism units.
Historically rather peaceful yet effective.
Fight for the safety of the Citizens.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_sealknife", "tfa_cso_automagv", "tfa_cso_xm1014", "door_ram" },
    command = "gsg",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Counter-Terrorists", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 2, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_sealknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_automagv" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_xm1014" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_GIGN = DarkRP.createJob("French GIGN", {
    color = Color(84, 109, 126, 255),
    model = "models/player/swat.mdl",
    description = [[The French GIGN.
Designed to be a fast response team.
Limited in size, but excelling in power.
A force to be reckoned with.
Fight for the safety of the Citizens.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_sealknife", "tfa_cso_infinite_silver", "tfa_cso_famas", "door_ram" },
    command = "gign",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Counter-Terrorists", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 3, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_sealknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_infinite_silver" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_scout" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_ST6 = DarkRP.createJob("American ST6", {
    color = Color(84, 109, 126, 255),
    model = "models/player/urban.mdl",
    description = [[The American SEAL Team 6.
Founded in 1980 under Richard Marchinko.
American counter-terrorism unit with worldwide influence.
One of the most intimidating forces on the planet.
Fight for the safety of the Citizens.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_sealknife", "tfa_cso_fiveseven", "tfa_cso_m4a1", "door_ram" },
    command = "seal",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Counter-Terrorists", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 4, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_sealknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_fiveseven" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_m4a1" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_WW2AMER = DarkRP.createJob("American Soldier", {
    color = Color(84, 109, 126, 255),
    model = "models/player/dod_american.mdl",
    description = [[An American WW2 Soldier.
For some, the war never ended.
A force of dedicated American citizens who have taken up arms.
Join forces with the Counter-Terrorists.
Fight for the safety of the Citizens.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_sealknife", "tfa_cso_m1911a1", "tfa_cso_m1918bar", "door_ram" },
    command = "america",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Counter-Terrorists", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 5, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_sealknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_m1911a1" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_m1918bar" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_ARC = DarkRP.createJob("Arctic Avenger", {
    color = Color(125, 61, 64, 255),
    model = "models/player/arctic.mdl",
    description = [[An Arctic Avenger.
Swedish force founded in 1977.
Branched off from the Brotherhood.
Masters of destruction and hand-to-hand combat.
Fight for whatever you believe is right.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_butterflyknife", "tfa_cso_glock", "tfa_cso_awp", "lockquick" },
    command = "arc",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Terrorists", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 1, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_butterflyknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_glock" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_awp" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_WAR = DarkRP.createJob("Guerilla Warrior", {
    color = Color(125, 61, 64, 255),
    model = "models/player/guerilla.mdl",
    description = [[A Guerilla Warrior.
Established in 1968 as a wing of the Reza Regime.
Ruthless Middle Eastern terrorist faction.
The single largest and best-equipped Terrorist group in the world.
Fight for whatever you believe is right.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_butterflyknife", "tfa_cso_fnp45", "tfa_cso_negev", "lockquick" },
    command = "war",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Terrorists", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 2, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_butterflyknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_fnp45" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_negev" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_LEET = DarkRP.createJob("Elite Crewman", {
    color = Color(125, 61, 64, 255),
    model = "models/player/leet.mdl",
    description = [[An Elite Crewman.
Highly ambitious Middle Eastern organization.
The most show-offish Terrorist faction known.
Their main goal is total world domination.
Fight for whatever you believe is right.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_butterflyknife", "tfa_cso_tacticalknife", "tfa_cso_elite", "lockquick" },
    command = "leet",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Terrorists", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 3, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_butterflyknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_tacticalknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_elite" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_PHOE = DarkRP.createJob("Phoenix Connexion", {
    color = Color(125, 61, 64, 255),
    model = "models/player/phoenix.mdl",
    description = [[A Phoenix Connexion member.
Formed somewhere in Europe nearing the breakup of the USSR.
Notoriously ruthless and vicious in their methods.
Their influence reaches across the globe.
Fight for whatever you believe is right.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_butterflyknife", "tfa_cso_deagle", "tfa_cso_ak47", "lockquick" },
    command = "phoe",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Terrorists", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 4, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_butterflyknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_deagle" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_ak47" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_NAZI = DarkRP.createJob("Nazi Soldier", {
    color = Color(125, 61, 64, 255),
    model = "models/player/dod_german.mdl",
    description = [[A German WW2 soldier.
For some, the war never ended.
A force of dedicated German soldiers who have taken up arms.
Join forces with the Terrorists.
Fight for whatever you believe is right.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_butterflyknife", "tfa_cso_luger", "tfa_cso_mp40", "lockquick" },
    command = "nazi",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Terrorists", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 5, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_butterflyknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_luger" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_mp40" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_ALYX = DarkRP.createJob("Alyx Vance", {
    color = Color(243, 207, 47, 255),
    model = "models/player/alyx.mdl",
    description = [[Alyx Vance.
Raised during an era of Combine occupation.
Talented mechanic of the Resistance force.
Often accompanied Gordon Freeman in his travels.
Fight for the freedom of your oppressed citizens.
    
STATS:
150 HP
25 AP]],
    weapons = {"tfa_cso_crowbar", "tfa_cso_python", "tfa_cso_f2000", "lockquick" },
    command = "alyx",
    max = 1, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Resistance", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 1, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 25 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_crowbar" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_python" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_f2000" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_BARNEY = DarkRP.createJob("Barney Calhoun", {
    color = Color(243, 207, 47, 255),
    model = "models/player/barney.mdl",
    description = [[Barney Calhoun.
Former security guard at Black Mesa.
Key leader of the Resistance against the Combine.
Also happens to be a Civil Protection officer.
Fight for the freedom of your oppressed citizens.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_crowbar", "tfa_cso_python", "tfa_cso_mp5", "lockquick" },
    command = "barney",
    max = 1, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Resistance", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 2, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_crowbar" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_python" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_mp5" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_ELI = DarkRP.createJob("Eli Vance", {
    color = Color(243, 207, 47, 255),
    model = "models/player/eli.mdl",
    description = [[Eli Vance.
Physicist and researcher of the Resistance force.
Father of Alyx Vance and just as good of a mechanic.
Prefers not to fight unless he absolutely has to.
Fight for the freedom of your oppressed citizens.
    
STATS:
150 HP
0 AP]],
    weapons = {"tfa_cso_crowbar", "tfa_cso_python", "lockquick" },
    command = "eli",
    max = 1, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Resistance", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 3, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_crowbar" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_python" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_KLEINER = DarkRP.createJob("Isaac Kleiner", {
    color = Color(243, 207, 47, 255),
    model = "models/player/kleiner.mdl",
    description = [[Isaac Kleiner.
Resistance scientist focused on researching teleportation.
Worked alongside Eli Vance back in Black Mesa.
Assisted the Resistance force over in City 17.
Fight for the freedom of your oppressed citizens.
    
STATS:
150 HP
0 AP]],
    weapons = {"tfa_cso_crowbar", "tfa_cso_python", "tfa_cso_spas12", "lockquick" },
    command = "kleiner",
    max = 1, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Resistance", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 4, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_crowbar" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_python" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_spas12" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_MAGNUSSON = DarkRP.createJob("Arne Magnusson", {
    color = Color(243, 207, 47, 255),
    model = "models/player/magnusson.mdl",
    description = [[Arne Magnusson.
Leader of the White Forest Resistance base.
Harsh, stern, and to-the-point in his presentation.
Still sides with the Resistance regardless.
Fight for the freedom of your oppressed citizens.
    
STATS:
150 HP
0 AP]],
    weapons = {"tfa_cso_crowbar", "tfa_cso_python", "tfa_cso_spas12", "lockquick" },
    command = "magnusson",
    max = 1, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Resistance", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 5, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_crowbar" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_python" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_spas12" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_GRIGORI = DarkRP.createJob("Father Grigori", {
    color = Color(243, 207, 47, 255),
    model = "models/player/monk.mdl",
    description = [[Father Grigori.
Insane hermit from the depths of Ravenholm.
Fights with the Resistance for what the Combine has done.
Specializes in taking out zombies and monsters.
Fight for the freedom of your oppressed citizens.
    
STATS:
150 HP
25 AP]],
    weapons = {"tfa_cso_crowbar", "tfa_cso_python", "tfa_cso_dbarrel", "lockquick" },
    command = "grigori",
    max = 1, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Resistance", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 6, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 25 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_crowbar" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_python" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_dbarrel" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_ODESSA = DarkRP.createJob("Odessa Cubbage", {
    color = Color(243, 207, 47, 255),
    model = "models/player/odessa.mdl",
    description = [[Odessa Cubbage.
Resistance colonel specializing in high explosives.
Former security operator who knows how to fight.
Has a Resistance outpost named after him.
Fight for the freedom of your oppressed citizens.
    
STATS:
150 HP
25 AP]],
    weapons = {"tfa_cso_crowbar", "tfa_cso_python", "tfa_cso_at4", "lockquick" },
    command = "odessa",
    max = 1, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Resistance", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 7, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 25 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_crowbar" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_python" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_at4" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    return false end
})

TEAM_MOSSMAN = DarkRP.createJob("Judith Mossman", {
    color = Color(243, 207, 47, 255),
    model = {"models/player/mossman.mdl",
        "models/player/mossman_arctic.mdl"
    },
    description = [[Judith Mossman.
Former double agent for the Combine.
Turned back to the Resistance full-time.
Has some intel on some ship having to do with teleportation.
Fight for the freedom of your oppressed citizens.
    
STATS:
150 HP
0 AP]],
    weapons = {"tfa_cso_crowbar", "tfa_cso_python", "lockquick" },
    command = "mossman",
    max = 1, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Resistance", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 8, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_crowbar" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_python" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_RESIST = DarkRP.createJob("Resistance Fighter", {
    color = Color(243, 207, 47, 255),
    model = {"models/player/group03/female_01.mdl",
        "models/player/group03/female_02.mdl",
        "models/player/group03/female_03.mdl",
        "models/player/group03/female_04.mdl",
        "models/player/group03/female_05.mdl",
        "models/player/group03/female_06.mdl",
        "models/player/group03/male_01.mdl",
        "models/player/group03/male_02.mdl",
        "models/player/group03/male_03.mdl",
        "models/player/group03/male_04.mdl",
        "models/player/group03/male_05.mdl",
        "models/player/group03/male_06.mdl",
        "models/player/group03/male_07.mdl",
        "models/player/group03/male_08.mdl",
        "models/player/group03/male_09.mdl"
    },
    description = [[A fighter in the resistance.
Formed when the Combine started taking over.
Essentially just Citizens with a little extra firepower.
They decided to not stand idly by and let the Combine rule them.
Fight for the freedom of your oppressed citizens.
    
STATS:
150 HP
50 AP]],
    weapons = {"tfa_cso_crowbar", "tfa_cso_python", "tfa_cso_mp7a1", "lockquick" },
    command = "resist",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Resistance", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 9, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 50 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_crowbar" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_python" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_mp7a1" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_MEDIC = DarkRP.createJob("Resistance Medic", {
    color = Color(243, 207, 47, 255),
    model = {"models/player/group03m/female_01.mdl",
        "models/player/group03m/female_02.mdl",
        "models/player/group03m/female_03.mdl",
        "models/player/group03m/female_04.mdl",
        "models/player/group03m/female_05.mdl",
        "models/player/group03m/female_06.mdl",
        "models/player/group03m/male_01.mdl",
        "models/player/group03m/male_02.mdl",
        "models/player/group03m/male_03.mdl",
        "models/player/group03m/male_04.mdl",
        "models/player/group03m/male_05.mdl",
        "models/player/group03m/male_06.mdl",
        "models/player/group03m/male_07.mdl",
        "models/player/group03m/male_08.mdl",
        "models/player/group03m/male_09.mdl"
    },
    description = [[A medic for the resistance.
Basic Resistance soldiers with some medical know-how.
If it wasn't for these soldiers, the Resistance would've died long ago.
Every good squad has at least one on standby.
Fight for the freedom of your oppressed citizens.
    
STATS:
150 HP
50 AP]],
    weapons = {"tfa_cso_crowbar", "tfa_cso_python", "weapon_medkit", "lockquick" },
    command = "medic",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Resistance", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 10, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 50 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_crowbar" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_python" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_BREEN = DarkRP.createJob("Wallace Breen", {
    color = Color(63, 92, 205, 255),
    model = "models/player/breen.mdl",
    description = [[Wallace Breen.
Former head of the Black Mesa research facility.
Represented all of humanity to the Combine.
Regarded as a traitor to humanity.
Fight to keep a tight grip on your control.
    
STATS:
150 HP
0 AP]],
    weapons = {"tfa_cso_coldsteelblade", "tfa_cso_usp", "door_ram" },
    command = "breen",
    max = 1, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Combine", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 1, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_coldsteelblade" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_usp" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_SOLDIER = DarkRP.createJob("Soldier", {
    color = Color(63, 92, 205, 255),
    model = "models/player/combine_soldier.mdl",
    description = [[A basic foot soldier.
The lowest ranking augmented soldiers for the Combine.
Expendable and disposable, yet oddly effective.
Deployed to areas of known Resistance presence.
Fight to keep a tight grip on your control.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_coldsteelblade", "tfa_cso_usp", "tfa_cso_oicw", "door_ram" },
    command = "cmb",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Combine", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 2, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_coldsteelblade" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_usp" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_oicw" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_ELITE = DarkRP.createJob("Elite", {
    color = Color(63, 92, 205, 255),
    model = "models/player/combine_super_soldier.mdl",
    description = [[A heavy foot soldier.
A Combine soldier with plenty of armor.
Underwent substantial augmentation to become even more durable.
Deployed to key areas where the Resistance lurks.
Fight to keep a tight grip on your control.
    
STATS:
250 HP
150 AP
NO LOADOUT]],
    weapons = {"tfa_cso_coldsteelblade", "tfa_cso_usp", "tfa_cso_mg36", "door_ram" },
    command = "elite",
    max = 2, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Combine", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 3, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 250 ) ply:SetArmor( 150 ) ply:SetMaxHealth( 250 )
    return false end
})

TEAM_GUARD = DarkRP.createJob("Prison Guard", {
    color = Color(63, 92, 205, 255),
    model = "models/player/combine_soldier_prisonguard.mdl",
    description = [[A Combine prison guard.
Used to guard the Nova Prospekt prison facility.
Their skill with crowd control comes in handy.
Counter-Terrorists own the jails, so they're essentially Soldiers with shotguns.
Fight to keep a tight grip on your control.
    
STATS:
150 HP
75 AP]],
    weapons = {"tfa_cso_coldsteelblade", "tfa_cso_usp", "tfa_cso_uts15", "door_ram" },
    command = "guard",
    max = 4, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Combine", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 4, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 75 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_coldsteelblade" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_usp" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_uts15" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_POLICE = DarkRP.createJob("Civil Protection", {
    color = Color(63, 92, 205, 255),
    model = { "models/player/police.mdl",
        "models/player/police_fem.mdl" },
    description = [[A Civil Protection agent.
Lowest ranking members of the Combine.
Citizens who have submitted to the Combine rule.
Receive free rations and special treatment.
Fight to keep a tight grip on your control.
    
STATS:
150 HP
50 AP]],
    weapons = {"tfa_cso_coldsteelblade", "tfa_cso_usp", "tfa_cso_mp7a1", "door_ram" },
    command = "police",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Combine", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 5, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 50 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_coldsteelblade" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_usp" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_mp7a1" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_STRIPPED = DarkRP.createJob("Stripped Soldier", {
    color = Color(63, 92, 205, 255),
    model = "models/player/soldier_stripped.mdl",
    description = [[A stripped soldier.
Hastily deployed before their augmentation has finished.
Not enough armor to fight, so they're used as medics.
Aren't cared for too much by the Combine.
Fight to keep a tight grip on your control.
    
STATS:
150 HP
0 AP]],
    weapons = {"tfa_cso_coldsteelblade", "tfa_cso_usp", "weapon_medkit", "door_ram" },
    command = "stripped",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Combine", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 6, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_coldsteelblade" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot2", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_usp" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot2" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot3", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot3" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot4", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot4" ) )
    end
    if ply:GetNWString( "WepLoadoutSlot5", "nil" ) != "nil" then
        ply:Give( ply:GetNWString( "WepLoadoutSlot5" ) )
    end
    return false end
})

TEAM_CHARPLE = DarkRP.createJob("Charple", {
    color = Color(112, 173, 71, 255),
    model = "models/player/charple.mdl",
    description = [[A burnt corpse.
Some of their fiery fate remains with them after death.
Fight against those who left you to die.
    
STATS:
100 HP
0 AP
MELEE ONLY
FLAMING TOUCH]],
    weapons = {"tfa_cso_combatknife" },
    command = "charple",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Monsters", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 1, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 100 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_combatknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    return false end
})

TEAM_CORPSE = DarkRP.createJob("Corpse", {
    color = Color(112, 173, 71, 255),
    model = "models/player/corpse1.mdl",
    description = [[A corpse that hasn't quite decomposed yet.
Got up just a little too early to be effective.
Fight against those who left you to die.
    
STATS:
100 HP
0 AP
MELEE ONLY
UNDYING]],
    weapons = {"tfa_cso_combatknife" },
    command = "corpse",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Monsters", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 2, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 100 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_combatknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    return false end
})

TEAM_SKELETON = DarkRP.createJob("Skeleton", {
    color = Color(112, 173, 71, 255),
    model = "models/player/skeleton.mdl",
    description = [[A completely clean corpse.
Way overdone, their bone marrow has condensed.
Fight against those who left you to die.
    
STATS:
100 HP
0 AP
MELEE ONLY
DENSE MARROW]],
    weapons = {"tfa_cso_combatknife" },
    command = "skel",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Monsters", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 3, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 100 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_combatknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    return false end
})

TEAM_ZOMBIE = DarkRP.createJob("Zombie", {
    color = Color(112, 173, 71, 255),
    model = "models/player/zombie_classic.mdl",
    description = [[The dead resurrected.
Typical zombies with scarily sharp claws.
Fight against those who left you to die.
    
STATS:
100 HP
0 AP
MELEE ONLY
SERRATED CLAWS]],
    weapons = {"tfa_cso_combatknife" },
    command = "zombie",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Monsters", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 4, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 100 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_combatknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    return false end
})

TEAM_FZOMBIE = DarkRP.createJob("Fast Zombie", {
    color = Color(112, 173, 71, 255),
    model = "models/player/zombie_fast.mdl",
    description = [[The dead resurrected, but fast.
Zombies stripped of extra meat, yielding higher agility.
Fight against those who left you to die.
    
STATS:
100 HP
0 AP
MELEE ONLY
NO FALL DAMAGE
+alt1: FERAL LUNGE]],
    weapons = {"tfa_cso_combatknife" },
    command = "fzombie",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Monsters", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 5, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 100 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_combatknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    DarkRP.notify( ply, 0, 4, "Bind a key to +alt1 to super-jump forward!" )
    return false end
})

TEAM_ZOMBINE = DarkRP.createJob("Zombine", {
    color = Color(112, 173, 71, 255),
    model = "models/player/zombie_soldier.mdl",
    description = [[A dead combine soldier resurrected.
They always have a grenade handy from their previous lives.
Fight against those who left you to die.
    
STATS:
100 HP
50 AP
MELEE ONLY
+alt1 SELF-DETONATION]],
    weapons = {"tfa_cso_combatknife" },
    command = "zombine",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Monsters", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 6, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 100 ) ply:SetArmor( 50 ) ply:SetMaxHealth( 150 )
    if ply:GetNWString( "WepLoadoutSlot1", "nil" ) != "nil" then
        ply:StripWeapon( "tfa_cso_combatknife" )
        ply:Give( ply:GetNWString( "WepLoadoutSlot1" ) )
    end
    DarkRP.notify( ply, 0, 4, "Bind a key to +alt1 to explode!" )
    return false end
})

TEAM_CIVIE = DarkRP.createJob("Civilian", {
    color = Color(0, 176, 80, 255),
    model = {"models/player/group01/female_01.mdl",
            "models/player/group01/female_02.mdl",
            "models/player/group01/female_03.mdl",
            "models/player/group01/female_04.mdl",
            "models/player/group01/female_06.mdl",
            "models/player/group01/male_01.mdl",
            "models/player/group01/male_02.mdl",
            "models/player/group01/male_03.mdl",
            "models/player/group01/male_04.mdl",
            "models/player/group01/male_05.mdl",
            "models/player/group01/male_06.mdl",
            "models/player/group01/male_07.mdl",
            "models/player/group01/male_08.mdl",
            "models/player/group01/male_09.mdl"
    },
    description = [[An average citizen lost in the city.
Dodge bullets or do what you can to survive.
You have no real role, therefore you are free to do whatever you want.
Get creative and roleplay.
    
STATS:
150 HP
0 AP
NO COMBAT]],
    weapons = {},
    command = "civilian",
    max = 0, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 1, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 ) return false end
})

TEAM_GUN = DarkRP.createJob("Gun Dealer", {
    color = Color(0, 176, 80, 255),
    model = {"models/player/hostage/hostage_01.mdl",
            "models/player/hostage/hostage_04.mdl"
    },
    description = [[You sell affordable guns at modest prices.
While the guns you sell are quite cheap, they can be upgraded.
Upgrading weapons makes them better than you could ever imagine.
Set up at your gun shop or somewhere on the streets.
    
STATS:
150 HP
0 AP
NO COMBAT]],
    weapons = {},
    command = "gundealer",
    max = 4, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 2, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 ) return false end
})

TEAM_SPECGUN = DarkRP.createJob("Special Gun Dealer", {
    color = Color(0, 176, 80, 255),
    model = {"models/player/hostage/hostage_02.mdl",
            "models/player/hostage/hostage_03.mdl"
    },
    description = [[You sell special guns at ridiculous prices.
You can rake in some serious money selling the guns you have.
These guns can be upgraded too, often also becoming much better
Set up at your gun shop or somewhere on the streets.
    
STATS:
150 HP
0 AP
NO COMBAT]],
    weapons = {},
    command = "specgundealer",
    max = 2, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 3, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 ) return false end
})

TEAM_MINER = DarkRP.createJob("Bitcoin Miner", {
    color = Color(0, 176, 80, 255),
    model = {"models/player/group02/male_02.mdl",
            "models/player/group02/male_04.mdl",
            "models/player/group02/male_06.mdl",
            "models/player/group02/male_08.mdl"
    },
    description = [[You mine Bitcoin to make money.
Your Bitcoin Miners are fragile, so make sure they're kept safe.
Check up on them every so often to reap your rewards.
It pays the bills.
    
STATS:
150 HP
0 AP
NO COMBAT]],
    weapons = {},
    command = "miner",
    max = 8, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 50,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 4, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 ) return false end
})

TEAM_CHELL = DarkRP.createJob( "Chell", {
	color = Color( 0, 176, 80, 255 ),
	model = "models/player/p2_chell.mdl",
	description = [[You are Chell.
You don't do much other than freerun around.
Your special boots prevent you from getting hurt by falling.
You jump around and figure out how to maneuver around the map.
    
STATS:
150 HP
0 AP
NO COMBAT
NO FALL DAMAGE]],
	weapons = {},
	command = "chell",
	max = 1,
	salary = 50,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Citizens",
	sortOrder = 6,
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 ) return false end
})

TEAM_GMAN = DarkRP.createJob("Crime Boss", {
    color = Color(255, 0, 0, 255),
    model = "models/player/gman_high.mdl",
    description = [[You are the Crime Boss.
You offer bounties to combatants who are interested.
You also run the Union City Club.]],
    weapons = {},
    command = "crimeboss",
    max = 1, -- at most 70% of the players can have this job. Set to a whole number to set an absolute limit.
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "???", -- The name of the category it is in. Note: the category must be created!
    sortOrder = 1, -- The position of this thing in its category. Lower number means higher up.
    PlayerLoadout = function(ply) ply:SetHealth( 150 ) ply:SetArmor( 0 ) ply:SetMaxHealth( 150 ) return false end,
    customCheck = function(ply) return ply:SteamID() == "STEAM_0:1:29801505" end,
    CustomCheckFailMsg = "Only SweptThrone can play as the Crime Boss."
})

--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_CIVIE
--[[---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
}
--[[---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------]]
--DarkRP.addHitmanTeam(TEAM_MOB)