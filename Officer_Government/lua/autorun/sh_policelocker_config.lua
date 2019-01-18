--[[---------------------------------------------------------------------------
	Making the tables for the config.
---------------------------------------------------------------------------]]
PoliceLocker = {}
PoliceLocker.Config = {}


--[[---------------------------------------------------------------------------
	Base Config.
---------------------------------------------------------------------------]]
-- DO NOT PUT BELOW 5 SECONDS!
PoliceLocker.Config.RecentlyBoughtPrimary = 10 -- how many seconds until a person can buy a primary weapon again
PoliceLocker.Config.RecentlyBoughtSecondary = 10 -- how many seconds until a person can buy a secondary weapon again
PoliceLocker.Config.RecentlyBoughtArmor = 10 -- how many seconds until a person can buy armor again
PoliceLocker.Config.RecentlyBoughtHealth = 10 -- how many seconds until a person can buy health again
PoliceLocker.Config.RecentlyBoughtAmmo = 10 -- how many seconds until a person can buy Ammo Again
PoliceLocker.Config.RecentlyBoughtPlayermodel = 10 -- how many seconds until a person can buy Ammo Again
PoliceLocker.Config.PlayermodelsTab = true -- if want to enable the uniforms tab set it to true
PoliceLocker.Config.Buyable = true -- if set to true police have to pay for there gear
PoliceLocker.Config.PoliceLockerTextColor = Color(215,25,25) -- Color of the [Police Locker] When they do not have access to the locker
PoliceLocker.Config.PoliceLockerTextColor1 = Color(255,255,255) -- Color of the text after [Police Locker]
PoliceLocker.Config.MaxHealth = 150 -- Max health until someone cannot buy health anymore from the locker!
PoliceLocker.Config.MaxArmor = 150 -- Max armor until someone cannot buy armor anymore from the locker!



PoliceLocker.Config.Base = {
	
	LockerModel = "models/locker/polilocker.mdl",



}

--[[---------------------------------------------------------------------------
	Language Support.
---------------------------------------------------------------------------]]
PoliceLocker.Config.Language = {
	
	NoAccessToLocker = "Sorry This is for the government only!",

	WeaponPurchaseCooldown = "You've purchased a weapon too recently! Please wait another %s second(s).",

	ArmorPurchaseCooldown = "You've purchased armor too recently! Please wait another %s second(s).",

	HealthPurchaseCooldown = "You've purchased health too recently! Please wait another %s second(s).",

	AmmoPurchaseCooldown = "You've purchased ammo too recently! Please wait another %s second(s).",

	UniformPurchaseCooldown = "You've purchased ammo too recently! Please wait another %s second(s).",
	
	PurchaseButton = "Purchase",
	
	PoliceLockerText = "[Police Locker]",
	
	MaxHealth = "You have max health already",
	
	MaxArmor = "You have max armor already",
	
	CannotAfford = "You do not have enough money",
	
	

}
--[[---------------------------------------------------------------------------
	Police Locker Primaries
---------------------------------------------------------------------------]]
PrimaryWeaponList = {

["M42"] = {price = 1000, class = "weapon_m42", model = "models/weapons/w_rif_m4a1.mdl"},
["AK47 CUSTOM"] = {price = 1000, class = "weapon_ak47custom", model = "models/weapons/w_rif_ak47.mdl"},
["AK472"] = {price = 1000, class = "weapon_ak472", model = "models/weapons/w_rif_ak47.mdl"},
["PUMP SHOTGUN"] = {price = 1000, class = "weapon_pumpshotgun2", model = "models/weapons/w_shot_m3super90.mdl"},
["SNIPER"] = {price = 1000, class = "ls_sniper", model = "models/weapons/w_snip_g3sg1.mdl"},

}
--[[---------------------------------------------------------------------------
	Police Locker Secondaries
---------------------------------------------------------------------------]]
SecondaryWeaponList = {

["GLOCK"] = {price = 1000, class = "weapon_glock2", model = "models/weapons/w_pist_glock18.mdl"},
["DEAGLE"] = {price = 1000, class = "weapon_deagle2", model = "models/weapons/w_pist_deagle.mdl"},
["FIVE SEVEN"] = {price = 1000, class = "weapon_fiveseven2", model = "models/weapons/w_pist_fiveseven.mdl"},
["P2282"] = {price = 1000, class = "weapon_p2282", model = "models/weapons/w_pist_p228.mdl"},
["MAC 10"] = {price = 1000, class = "weapon_mac102", model = "models/weapons/w_smg_mac10.mdl"},
["MP5"] = {price = 1000, class = "weapon_mp52", model = "models/weapons/w_smg_mp5.mdl"},

}
--[[---------------------------------------------------------------------------
	Police Locker Armor
---------------------------------------------------------------------------]]
ArmorList = {
["10 Armor"] = {price = 100, amount = 10},
["20 Armor"] = {price = 100, amount = 20},
["30 Armor"] = {price = 100, amount = 30},
["40 Armor"] = {price = 100, amount = 40},

}
--[[---------------------------------------------------------------------------
	Police Locker Health
---------------------------------------------------------------------------]]
HealthList = {
["10 Health"] = {price = 100, amount = 10},
["20 Health"] = {price = 100, amount = 20},
["30 Health"] = {price = 100, amount = 30},
["40 Health"] = {price = 100, amount = 40},



}
--[[---------------------------------------------------------------------------
	Police Locker Ammo
---------------------------------------------------------------------------]]
AmmoList = {
["10 Pistol Ammo"] = {price = 1000, class = "Pistol", amount = 10, model = "models/items/boxsrounds.mdl"},
["10 SMG Ammo"] = {price = 1000, class = "SMG1", amount = 10, model = "models/items/boxsrounds.mdl"},
["10 Shotgun Shells"] = {price = 1000, class = "Buckshot", amount = 10, model = "models/items/boxbuckshot.mdl"},
["10 AR2 Ammo"] = {price = 1000, class = "AR2", amount = 10, model = "models/items/boxmrounds.mdl"},

}
--[[---------------------------------------------------------------------------
	Police Locker Playermodels
---------------------------------------------------------------------------]]
Playermodellist = {
["Police Officer Uniform"] = {price = 100, model = "models/player/combine_soldier_prisonguard.mdl"},


}