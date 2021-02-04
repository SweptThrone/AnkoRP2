--[[---------------------------------------------------------------------------
Ammo types
---------------------------------------------------------------------------
Ammo boxes that can be purchased in the F4 menu.

Add your custom ammo types in this file. Here's the syntax:
DarkRP.createAmmoType("ammoType", {
    name = "Ammo name",
    model = "Model",
    price = 1234,
    amountGiven = 5678,
    customCheck = function(ply) return ply:IsAdmin()
})

ammoType: The name of the ammo that Garry's mod recognizes
	If you open your SWEP's shared.lua, you can find the ammo name next to
	SWEP.Primary.Ammo = "AMMO NAME HERE"
	or
	SWEP.Secondary.Ammo = "AMMO NAME HERE"

name: The name you want to give to the ammo. This can be anything.

model: The model you want the ammo to have in the F4 menu

price: the price of your ammo in dollars

amountGiven: How much bullets of this ammo is given every time the player buys it

customCheck: (Optional! Advanced!) a Lua function that describes who can buy the ammo.
	Similar to the custom check function for jobs and shipments
	Parameters:
		ply: the player who is trying to buy the ammo


Add new ammo types under the next line!
---------------------------------------------------------------------------]]

DarkRP.createAmmoType(".44-40 Winchester", {
    name = "30x .44-40 Winchester",
    model = "models/Items/BoxMRounds.mdl",
    price = 80,
    amountGiven = 30,
})

DarkRP.createAmmoType("5.56x45mm", {
    name = "90x 5.56x45mm",
    model = "models/Items/BoxMRounds.mdl",
    price = 180,
    amountGiven = 90,
})

DarkRP.createAmmoType("7.62x39mm", {
    name = "90x 7.62x39mm",
    model = "models/Items/BoxMRounds.mdl",
    price = 200,
    amountGiven = 90,
})

DarkRP.createAmmoType("5.45x39mm", {
    name = "90x 5.45x39mm",
    model = "models/Items/BoxMRounds.mdl",
    price = 160,
    amountGiven = 90,
})

DarkRP.createAmmoType("9x39mm", {
    name = "90x 9x39mm",
    model = "models/Items/BoxMRounds.mdl",
    price = 140,
    amountGiven = 90,
})

DarkRP.createAmmoType("7.62x51mm", {
    name = "90x 7.62x51mm",
    model = "models/Items/BoxMRounds.mdl",
    price = 240,
    amountGiven = 90,
})

DarkRP.createAmmoType(".50 AE", {
    name = "35x .50 AE",
    model = "models/Items/BoxMRounds.mdl",
    price = 60,
    amountGiven = 35,
})

DarkRP.createAmmoType(".338 Lapua Magnum", {
    name = "30x .338 Lapua Magnum",
    model = "models/Items/BoxMRounds.mdl",
    price = 100,
    amountGiven = 30,
})

DarkRP.createAmmoType("9x19mm", {
    name = "90x 9x19mm",
    model = "models/Items/BoxMRounds.mdl",
    price = 120,
    amountGiven = 90,
})

DarkRP.createAmmoType("12 Gauge", {
    name = "20x 12 Gauge",
    model = "models/Items/BoxMRounds.mdl",
    price = 60,
    amountGiven = 20,
})

DarkRP.createAmmoType(".45 ACP", {
    name = "90x .45 ACP",
    model = "models/Items/BoxMRounds.mdl",
    price = 160,
    amountGiven = 90,
})

DarkRP.createAmmoType(".40 S&W", {
    name = "90x .40 S&W",
    model = "models/Items/BoxMRounds.mdl",
    price = 140,
    amountGiven = 90,
})

DarkRP.createAmmoType("7.92x57mm Mauser", {
    name = "80x 7.92x57mm Mauser",
    model = "models/Items/BoxMRounds.mdl",
    price = 180,
    amountGiven = 80,
})

DarkRP.createAmmoType(".30-06 Springfield", {
    name = "80x .30-06 Springfield",
    model = "models/Items/BoxMRounds.mdl",
    price = 180,
    amountGiven = 80,
})

DarkRP.createAmmoType(".44 Magnum", {
    name = "20x .30-06 Springfield",
    model = "models/Items/BoxMRounds.mdl",
    price = 60,
    amountGiven = 20,
})

DarkRP.createAmmoType(".357 Magnum", {
    name = "20x .357 Magnum",
    model = "models/Items/BoxMRounds.mdl",
    price = 40,
    amountGiven = 20,
})

DarkRP.createAmmoType(".31 Percussion", {
    name = "24x .31 Percussion",
    model = "models/Items/BoxMRounds.mdl",
    price = 24,
    amountGiven = 24,
})

DarkRP.createAmmoType(".500 S&W Magnum", {
    name = "20x .500 S&W Magnum",
    model = "models/Items/BoxMRounds.mdl",
    price = 40,
    amountGiven = 20,
})

DarkRP.createAmmoType(".50 BMG", {
    name = "40x .50 BMG",
    model = "models/Items/BoxMRounds.mdl",
    price = 160,
    amountGiven = 40,
})

DarkRP.createAmmoType("7.62x54mmR", {
    name = "90x 7.62x54mmR",
    model = "models/Items/BoxMRounds.mdl",
    price = 220,
    amountGiven = 90,
})

DarkRP.createAmmoType(".300 AAC Blackout", {
    name = "90x .300 AAC Blackout",
    model = "models/Items/BoxMRounds.mdl",
    price = 100,
    amountGiven = 90,
})

DarkRP.createAmmoType("9x18mm Makarov", {
    name = "90x 9x18mm Makarov",
    model = "models/Items/BoxMRounds.mdl",
    price = 160,
    amountGiven = 90,
})

DarkRP.createAmmoType("4.6x30mm", {
    name = "80x 4.6x30mm",
    model = "models/Items/BoxMRounds.mdl",
    price = 240,
    amountGiven = 80,
})

DarkRP.createAmmoType("5.7x28mm", {
    name = "100x 5.7x28mm",
    model = "models/Items/BoxMRounds.mdl",
    price = 300,
    amountGiven = 100,
})

DarkRP.createAmmoType(".408 Cheyenne Tactical", {
    name = "28x .408 Cheyenne Tactical",
    model = "models/Items/BoxMRounds.mdl",
    price = 68,
    amountGiven = 28,
})

DarkRP.createAmmoType(".44 Russian", {
    name = "24x .44 Russian",
    model = "models/Items/BoxMRounds.mdl",
    price = 48,
    amountGiven = 24,
})

DarkRP.createAmmoType(".376 Steyr", {
    name = "30x .376 Steyr",
    model = "models/Items/BoxMRounds.mdl",
    price = 80,
    amountGiven = 30,
})