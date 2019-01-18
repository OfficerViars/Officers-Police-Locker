--[[---------------------------------------------------------------------------
	Local File Stuff.
---------------------------------------------------------------------------]]
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
resource.AddSingleFile( "resource/fonts/borg.ttf" )
--[[---------------------------------------------------------------------------
	Networking.
---------------------------------------------------------------------------]]
util.AddNetworkString( "PoliceArmory" )
util.AddNetworkString( "GivePolicePrimaryWeapon" )
util.AddNetworkString( "GivePoliceSecondaryWeapon" )
util.AddNetworkString( "GivePoliceArmor" )
util.AddNetworkString( "GivePoliceHealth" )
util.AddNetworkString( "GivePoliceAmmo" )
util.AddNetworkString( "GivePolicePlayerModel" )
util.AddNetworkString( "buyAmmoandWeapon" )
util.AddNetworkString( "buyhealthandarmor" )

util.AddNetworkString("PoliceLocker_Messages")

--[[---------------------------------------------------------------------------
	Initialise.
---------------------------------------------------------------------------]]
function ENT:Initialize()
	self:SetModel( PoliceLocker.Config.Base.LockerModel )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
end

--[[---------------------------------------------------------------------------
	Use.
---------------------------------------------------------------------------]]
function ENT:Use(pl)


	if ( !self.Opened ) then -- If we are not "opened"
		self:ResetSequence( "p_open" ) -- Play the open sequence
		self:SetSequence( "p_open" )
		self.Opened = true -- We are now opened
	else
		self:ResetSequence( "p_close" ) -- Play the close sequence
		self:SetSequence( "p_close" )
		self.Opened = false -- We are now closed
	end

	if pl:isCP() then

		net.Start( "PoliceArmory" )
		net.Send(pl)

	else

		net.Start( "PoliceLocker_Messages" )
			net.WriteString(PoliceLocker.Config.Language.NoAccessToLocker)
		net.Send(pl)

	end

end
--[[---------------------------------------------------------------------------
	buyMessageAmmoandWeapon.
---------------------------------------------------------------------------]]
function buyMessageAmmoandWeapon(ply, item, price, bool)

	net.Start("buyAmmoandWeapon")
		net.WriteString(tostring(item))
		net.WriteString(tostring(price))
		net.WriteBool(bool)
	net.Send(ply)

end

--[[---------------------------------------------------------------------------
	buyhealthandarmor.
---------------------------------------------------------------------------]]
function buyhealthandarmor(ply, item, price, bool)

	net.Start("buyhealthandarmor")
		net.WriteString(tostring(item))
		net.WriteString(tostring(price))
		net.WriteBool(bool)
	net.Send(ply)

end

--[[---------------------------------------------------------------------------
	GivePolicePrimaryWeapon.
---------------------------------------------------------------------------]]
net.Receive("GivePolicePrimaryWeapon", function(len, pl)

	local weapon = net.ReadString()

	if PrimaryWeaponList[weapon] then
		local wepclass = PrimaryWeaponList[weapon].class
		local price = PrimaryWeaponList[weapon].price
		local money = pl:getDarkRPVar("money")

		if IsValid(pl) and pl:isCP() and money > price then

			if pl.hasBoughtWeapon == false or pl.hasBoughtWeapon == nil or CurTime() > pl.hasBoughtWeapon then
						
			if PoliceLocker.Config.Buyable == true 
				then
				pl:addMoney(-price)
				end
				pl:Give(wepclass)
				pl:EmitSound("items/ammo_pickup.wav")
				pl.hasBoughtWeapon = true
				buyMessageAmmoandWeapon(pl, wepclass, price, true)
				pl.hasBoughtWeapon = CurTime() + PoliceLocker.Config.RecentlyBoughtPrimary

			else

				local timeLeft = string.sub(math.floor(CurTime() - pl.hasBoughtWeapon),2)
			
				net.Start( "PoliceLocker_Messages" )
					net.WriteString( string.format( PoliceLocker.Config.Language.WeaponPurchaseCooldown, timeLeft ) )
				net.Send(pl)

			end

		end

	end

end)

--[[---------------------------------------------------------------------------
	GivePoliceSecondaryWeapon.
---------------------------------------------------------------------------]]
net.Receive("GivePoliceSecondaryWeapon", function(len, pl)

	local weapon = net.ReadString()

	if SecondaryWeaponList[weapon] then

		local wepclass = SecondaryWeaponList[weapon].class
		local price = SecondaryWeaponList[weapon].price
		local money = pl:getDarkRPVar("money")

		if IsValid(pl) and pl:isCP() and money > price then

			if pl.hasBoughtWeapon == false or pl.hasBoughtWeapon == nil or CurTime() > pl.hasBoughtWeapon then
				
				if PoliceLocker.Config.Buyable == true 
				then
				pl:addMoney(-price)
				end
				pl:Give(wepclass)
				pl:EmitSound("items/ammo_pickup.wav")
				pl.hasBoughtWeapon = true
				buyMessageAmmoandWeapon(pl, wepclass, price, true)
				pl.hasBoughtWeapon = CurTime() + PoliceLocker.Config.RecentlyBoughtSecondary
			
			else
				
				local timeLeft = string.sub(math.floor(CurTime() - pl.hasBoughtWeapon),2)

				net.Start( "PoliceLocker_Messages" )
					net.WriteString( string.format( PoliceLocker.Config.Language.WeaponPurchaseCooldown, timeLeft ) )
				net.Send(pl)
			
			end

		end

	end

end)

--[[---------------------------------------------------------------------------
	GivePoliceArmor.
---------------------------------------------------------------------------]]
net.Receive("GivePoliceArmor", function(len, pl)

	local armor = net.ReadString()

	if ArmorList[armor] then

		local armorAmount = ArmorList[armor].amount
		local price = ArmorList[armor].price
		local money = pl:getDarkRPVar("money")

		if IsValid(pl) and pl:isCP() and money > price then

			if pl.boughtArmorRecently == nil or CurTime() > pl.boughtArmorRecently then

				local addArmor = pl:Armor() + armorAmount
				pl:SetArmor(addArmor)
			if PoliceLocker.Config.Buyable == true 
			then
				pl:addMoney(-price)
			end
				pl:EmitSound("items/battery_pickup.wav")
				buyhealthandarmor(pl, armor, price, false)
				pl.boughtArmorRecently = CurTime() + PoliceLocker.Config.RecentlyBoughtArmor
			
			else
				
				local timeLeft = string.sub(math.floor(CurTime() - pl.boughtArmorRecently),2)
			
				net.Start( "PoliceLocker_Messages" )
					net.WriteString( string.format( PoliceLocker.Config.Language.ArmorPurchaseCooldown, timeLeft ) )
				net.Send(pl)
			end
		elseif( pl:Armor() >= PoliceLocker.Config.MaxArmor ) then
			pl:ChatPrint(PoliceLocker.Config.Language.MaxArmor)
		if PoliceLocker.Config.Buyable == true then
		elseif( price > money ) then
			pl:ChatPrint(PoliceLocker.Config.Language.CannotAfford)
		end
		else
			pl:ChatPrint("You are not valid" )
		end
	end
end)

--[[---------------------------------------------------------------------------
	GivePoliceHealth.
---------------------------------------------------------------------------]]
net.Receive("GivePoliceHealth", function(len, pl)
	local health = net.ReadString()
	if HealthList[health] then
		local healthAmount = HealthList[health].amount
		local price = HealthList[health].price
		local money = pl:getDarkRPVar("money")
		if IsValid(pl) and pl:isCP() and money > price and pl:Health() < PoliceLocker.Config.MaxHealth then
			if pl.boughtHealthRegenRecently == nil or CurTime() > pl.boughtHealthRegenRecently then
				local addHealth = pl:Health() + healthAmount
				pl:SetHealth(addHealth)
			if PoliceLocker.Config.Buyable == true 
			then
				pl:addMoney(-price)
			end
				pl:EmitSound("items/battery_pickup.wav")
				buyhealthandarmor(pl, health, price, true)
				pl.boughtHealthRegenRecently = CurTime() + PoliceLocker.Config.RecentlyBoughtHealth
			else
				
				local timeLeft = string.sub(math.floor(CurTime() - pl.boughtHealthRegenRecently),2)
			
				net.Start( "PoliceLocker_Messages" )
					net.WriteString( string.format( PoliceLocker.Config.Language.HealthPurchaseCooldown, timeLeft ) )
				net.Send(pl)
			end
		elseif( pl:Health() >= PoliceLocker.Config.MaxHealth ) then
			pl:ChatPrint(PoliceLocker.Config.Language.MaxHealth)
		if PoliceLocker.Config.Buyable == true then
		elseif( price > money ) then
			pl:ChatPrint(PoliceLocker.Config.Language.CannotAfford)
		end
		else
			pl:ChatPrint("You are not valid" )
		end
	end
end)

--[[---------------------------------------------------------------------------
	GivePoliceAmmo.
---------------------------------------------------------------------------]]
net.Receive("GivePoliceAmmo", function(len, pl)

	local ammo = net.ReadString()
	
	if AmmoList[ammo] then
		
		local AmmoAmount = AmmoList[ammo].amount
		local ammoclass = AmmoList[ammo].class
		local price = AmmoList[ammo].price
		local money = pl:getDarkRPVar("money")
		
		if IsValid(pl) and pl:isCP() and money > price then
			
			if pl.boughtAmmoRecently == nil or CurTime() > pl.boughtAmmoRecently then
				
			if PoliceLocker.Config.Buyable == true 
			then
				pl:addMoney(-price)
			end
				pl:GiveAmmo( AmmoAmount, ammoclass )
				pl:EmitSound("items/ammo_pickup.wav")
				buyMessageAmmoandWeapon(pl, ammoclass, price, false)
				pl.boughtAmmoRecently = CurTime() + PoliceLocker.Config.RecentlyBoughtAmmo
			
			else
				
				local timeLeft = string.sub(math.floor(CurTime() - pl.boughtAmmoRecently),2)

				net.Start( "PoliceLocker_Messages" )
					net.WriteString( string.format( PoliceLocker.Config.Language.AmmoPurchaseCooldown, timeLeft ) )
				net.Send(pl)
			
			end

		end

	end

end)

--[[---------------------------------------------------------------------------
	GivePolicePlayerModel.
---------------------------------------------------------------------------]]
net.Receive("GivePolicePlayerModel", function(len, pl)

	local playermodel = net.ReadString()

	if Playermodellist[playermodel] then
		
		local playermodelclass = Playermodellist[playermodel].model
		local price = Playermodellist[playermodel].price
		local money = pl:getDarkRPVar("money")
		
		if IsValid(pl) and pl:isCP() and money > price then
			
			if pl.hasBoughtModel == false or pl.hasBoughtModel == nil or CurTime() > pl.hasBoughtModel then
			if PoliceLocker.Config.Buyable == true 
			then
				pl:addMoney(-price)
			end
				pl:SetModel(playermodelclass)
				pl:EmitSound("items/ammo_pickup.wav")
				pl.hasBoughtModel = true
				buyMessageAmmoandWeapon(pl, playermodelclass, price, true)
				pl.hasBoughtModel = CurTime() + PoliceLocker.Config.RecentlyBoughtPlayermodel
			
			else
				
				local timeLeft = string.sub(math.floor(CurTime() - pl.hasBoughtModel),2)

				net.Start( "PoliceLocker_Messages" )
					net.WriteString( string.format( PoliceLocker.Config.Language.UniformPurchaseCooldown, timeLeft ) )
				net.Send(pl)
			
			end
		end

	end

end)