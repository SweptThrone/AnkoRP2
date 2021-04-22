--[[
    Add 20 network strings to be used in the gamemode.
]]--

util.AddNetworkString( "ST_OpenLoadoutMenu" ) -- sv->cl open loadout menu
util.AddNetworkString( "ST_SetLoadout" ) -- cl->sv set loadout

util.AddNetworkString( "ST_OpenInventoryMenu" ) -- sv->cl open inventory menu
util.AddNetworkString( "ST_InventoryTransaction" ) -- cl->sv scrap or equip a weapon

util.AddNetworkString( "ST_OpenUpgradeMenu" ) -- sv->cl open upgrade menu
util.AddNetworkString( "ST_UpgradeWeapon" ) -- cl->sv upgrade and store weapon

util.AddNetworkString( "ST_OpenDowngradeMenu" ) -- sv->cl open downgrade menu
util.AddNetworkString( "ST_DowngradeWeapon" ) -- cl->sv downgrade and store weapon

util.AddNetworkString( "AskForCSOTree" ) -- cl->sv dirty workaround
util.AddNetworkString( "AllowTreeToBeSeen" ) -- sv->cl send the cso weapon data tree
util.AddNetworkString( "SendPlyTheirAttTable" ) -- sv->cl send the player's att table

util.AddNetworkString( "ST_OpenArtistMenu" ) -- sv->cl open artist's workbench menu
util.AddNetworkString( "ST_SkinWeapon" ) -- cl->sv unlock and store a skin

util.AddNetworkString( "ST_NPCMessage" ) -- sv->cl print a chat-like npc message

util.AddNetworkString( "ST_EventStarted" ) -- sv->cl do stuff about an event
util.AddNetworkString( "SendAnkoScores" ) -- sv->cl send the current scores

util.AddNetworkString( "ST_OfferAnkoContract" ) -- sv->cl offer the player a contract
util.AddNetworkString( "ST_TakeContract" ) -- cl->sv accept or deny the contract 

util.AddNetworkString( "ST_OfferAnkoBounty" ) -- sv->cl offer the player a bounty
util.AddNetworkString( "ST_TakeBounty" ) -- cl->sv accept or deny the bounty

util.AddNetworkString( "STCustomKillfeed" ) -- sv->cl send info for killfeed

util.AddNetworkString( "ST_SendCredits" ) -- sv->cl send number of credits