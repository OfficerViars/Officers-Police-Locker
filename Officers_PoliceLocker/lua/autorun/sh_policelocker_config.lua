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
PoliceLocker.Config.RecentlyBoughtPlayermodel = 10 -- how many seconds until a person can buy Playermodel Again
PoliceLocker.Config.PlayermodelsTab = true -- if want to enable the uniforms tab set it to true
PoliceLocker.Config.AmmoTab = true -- if want to enable the ammo tab set it to true
PoliceLocker.Config.HealthTab = true -- if want to enable the health tab set it to true
PoliceLocker.Config.ArmorTab = true -- if want to enable the Armor tab set it to true
PoliceLocker.Config.SecondaryTab = true -- if want to enable the Secondaries tab set it to true
PoliceLocker.Config.PrimaryTab = true -- if want to enable the Secondaries tab set it to true
PoliceLocker.Config.Buyable = true -- if set to true police have to pay for there gear
PoliceLocker.Config.Overhead = true -- if set to true then the overhead text on the locker will display
PoliceLocker.Config.PoliceLockerTextColor = Color(215,25,25) -- Color of the [Police Locker] When they do not have access to the locker
PoliceLocker.Config.MaxHealth = 150 -- Max health until someone cannot buy health anymore from the locker!
PoliceLocker.Config.MaxArmor = 150 -- Max armor until someone cannot buy armor anymore from the locker!

PoliceLocker.Config.Base = {
	
	LockerModel = "models/locker/polilocker.mdl", --  model of the locker



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
	
	LockerOverhead = "Police Locker",
	
	

}
--[[---------------------------------------------------------------------------
	Police Locker Primaries
---------------------------------------------------------------------------]]

PrimaryWeaponList = {}
 
PrimaryWeaponList["M42"] = {
    price = 1000, 
    class = "weapon_m42", 
    model = "models/weapons/w_rif_m4a1.mdl"
}
PrimaryWeaponList["AK47 CUSTOM"] = {
    price = 1000, 
    class = "weapon_ak47custom", 
    model = "models/weapons/w_rif_ak47.mdl"
}
--[[---------------------------------------------------------------------------
	Police Locker Secondaries
---------------------------------------------------------------------------]]
SecondaryWeaponList = {}

SecondaryWeaponList["GLOCK"] = {
    price = 1000, 
    class = "weapon_glock2", 
    model = "models/weapons/w_pist_glock18.mdl"
}
SecondaryWeaponList["DEAGLE"] = {
    price = 1000, 
    class = "weapon_deagle2", 
    model = "models/weapons/w_pist_deagle.mdl"
}
--[[---------------------------------------------------------------------------
	Police Locker Armor
---------------------------------------------------------------------------]]
ArmorList = {}

ArmorList["10 Armor"] = {
    price = 1000, 
	amount = 10
}
ArmorList["20 Armor"] = {
    price = 1000, 
	amount = 20
}
--[[---------------------------------------------------------------------------
	Police Locker Health
---------------------------------------------------------------------------]]
HealthList = {}

HealthList["10 Health"] = {
    price = 1000, 
	amount = 10
}
HealthList["20 Health"] = {
    price = 1000, 
	amount = 20
}
--[[---------------------------------------------------------------------------
	Police Locker Ammo
---------------------------------------------------------------------------]]
AmmoList = {}

AmmoList["10 Pistol Ammo"] = {
    price = 1000, 
    class = "Pistol", 
	amount = 10,
    model = "models/items/boxsrounds.mdl"
}
AmmoList["10 SMG Ammo"] = {
    price = 1000, 
    class = "SMG1", 
	amount = 10,
    model = "models/items/boxsrounds.mdl"
}
AmmoList["10 Shotgun Shells"] = {
    price = 1000, 
    class = "Buckshot", 
	amount = 10,
    model = "models/items/boxbuckshot.mdl"
}
AmmoList["10 AR2 Ammo"] = {
    price = 1000, 
    class = "AR2", 
	amount = 10,
    model = "models/items/boxmrounds.mdl"
}
--[[---------------------------------------------------------------------------
	Police Locker Playermodels
---------------------------------------------------------------------------]]
Playermodellist = {}

Playermodellist["Police Officer Uniform"] = {
    price = 1000, 
    model = "models/player/combine_soldier_prisonguard.mdl"
}