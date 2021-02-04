--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua#L111

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]
DarkRP.createEntity( "Shipment Box", {
	ent = "better_shipment",
	model = "models/Items/item_item_crate.mdl",
	price = 0,
	max = 8,
	cmd = "buyshipbox",
	allowed = { TEAM_GUN, TEAM_SPECGUN }
} )

DarkRP.createEntity( "Bitcoin Miner", {
	ent = "st_ankorp_btcminer",
	model = "models/props_c17/consolebox01a.mdl",
	price = 1000,
	max = 4,
	cmd = "buybtcminer",
	allowed = { TEAM_MINER }
} )

DarkRP.createEntity( "Artist's Workbench", {
	ent = "st_artist_table",
	model = "models/props_wasteland/controlroom_desk001b.mdl",
	price = 8000,
	max = 1,
	cmd = "buyarttable"
} )