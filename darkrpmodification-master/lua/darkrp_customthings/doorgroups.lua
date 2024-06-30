--[[---------------------------------------------------------------------------
Door groups
---------------------------------------------------------------------------
The server owner can set certain doors as owned by a group of people, identified by their jobs.


HOW TO MAKE A DOOR GROUP:
AddDoorGroup("NAME OF THE GROUP HERE, you will see this when looking at a door", Team1, Team2, team3, team4, etc.)
---------------------------------------------------------------------------]]


-- Example: AddDoorGroup("Cops and Mayor only", TEAM_CHIEF, TEAM_POLICE, TEAM_MAYOR)
-- Example: AddDoorGroup("Gundealer only", TEAM_GUN)
AddDoorGroup( "Counter-Terrorists", TEAM_SAS, TEAM_GSG, TEAM_GIGN, TEAM_ST6, TEAM_WW2AMER )
AddDoorGroup( "Terrorists", TEAM_ARC, TEAM_WAR, TEAM_LEET, TEAM_PHOE, TEAM_NAZI )
AddDoorGroup( "Resistance", TEAM_ALYX, TEAM_BARNEY, TEAM_ELI, TEAM_KLEINER, TEAM_MAGNUSSON, TEAM_GRIGORI, TEAM_ODESSA, TEAM_MOSSMAN, TEAM_RESIST, TEAM_MEDIC )
AddDoorGroup( "Combine", TEAM_BREEN, TEAM_SOLDIER, TEAM_ELITE, TEAM_GUARD, TEAM_POLICE, TEAM_STRIPPED )
AddDoorGroup( "Gun Dealers", TEAM_GUN, TEAM_SPECGUN )