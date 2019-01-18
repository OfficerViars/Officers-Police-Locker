/*---------------------------------------------------------
	Local file stuff.
---------------------------------------------------------*/
if SERVER then
	resource.AddFile("icons/armour.png")
	resource.AddFile("icons/heart.png")
	resource.AddFile("icons/primary.png")
	resource.AddFile("icons/secondary.png")
	resource.AddFile("icons/uniform.png")
	resource.AddFile("icons/ammo.png")
	
end

include("shared.lua")



/*---------------------------------------------------------
	Fonts.
---------------------------------------------------------*/
surface.CreateFont( "maintext", {
	font = "borg", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 180,
	weight = 200,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


surface.CreateFont( "policearmory", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


surface.CreateFont( "buytext", {
	font = "borg", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "title", {
	font = "borg", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 65,
	weight = 200,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont("PoliceLocker_UIFont", { font = "Trebuchet", size = 25 } )
surface.CreateFont("PoliceLocker_CategoryFontName", { font = "Trebuchet", size = 40, } )
surface.CreateFont("PoliceLocker_CategoryFont", { font = "Arial", size = 24, weight = 40 } )

local gradientu = Material( 'vgui/gradient_up' )
local gradientd = Material( 'vgui/gradient_down' )

/*---------------------------------------------------------
	Networking.
---------------------------------------------------------*/
		
if PoliceLocker.Config.Buyable == true 
then
net.Receive("buyAmmoandWeapon", function(len)
	local item = net.ReadString()
	local price = net.ReadString()
	local i = net.ReadBool()
	if i then
		chat.AddText( Color( 20, 20, 255 ),"[Police Armory] ", Color( 225, 225, 225 ), "You have purchased a " .. item .. " for $" .. price)
	else
		chat.AddText( Color( 20, 20, 255 ),"[Police Armory] ", Color( 225, 225, 225 ), "You have purchased " .. item .. " armor for $" .. price)
	end
end)
else
net.Receive("buyAmmoandWeapon", function(len)
	local item = net.ReadString()
	local price = net.ReadString()
	local i = net.ReadBool()
	if i then
		chat.AddText( Color( 20, 20, 255 ),"[Police Armory] ", Color( 225, 225, 225 ), "You have purchased a " .. item)
	else
		chat.AddText( Color( 20, 20, 255 ),"[Police Armory] ", Color( 225, 225, 225 ), "You have purchased " .. item)
		end
	end)
end
if PoliceLocker.Config.Buyable == true 
then
net.Receive("buyhealthandarmor", function(len)
	local item = net.ReadString()
	local price = net.ReadString()
	local i = net.ReadBool()
	if i then
		chat.AddText( Color( 20, 20, 255 ),"[Police Armory] ", Color( 225, 225, 225 ), "You have purchased " .. item .. " for $" .. price)
	else
		chat.AddText( Color( 20, 20, 255 ),"[Police Armory] ", Color( 225, 225, 225 ), "You have purchased " .. item .. " for $" .. price)
	end
end)
else
net.Receive("buyhealthandarmor", function(len)
	local item = net.ReadString()
	local price = net.ReadString()
	local i = net.ReadBool()
	if i then
		chat.AddText( Color( 20, 20, 255 ),"[Police Armory] ", Color( 225, 225, 225 ), "You have purchased " .. item)
	else
		chat.AddText( Color( 20, 20, 255 ),"[Police Armory] ", Color( 225, 225, 225 ), "You have purchased " .. item)
		end
	end)
end

net.Receive( "PoliceLocker_Messages", function()
	chat.AddText( PoliceLocker.Config.PoliceLockerTextColor, PoliceLocker.Config.Language.PoliceLockerText, PoliceLocker.Config.PoliceLockerTextColor1, net.ReadString() )
end )

/*---------------------------------------------------------
	Draw.
---------------------------------------------------------*/
function ENT:Draw()

	self.Entity:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Up(), 90)

	cam.Start3D2D(Pos + Ang:Up() * 95 - Ang:Right() * 30 + Ang:Forward() * -0.1, Ang + Angle( 0, 90, 90 ), 0.067)
		draw.SimpleText( "Police Locker", "maintext", 0, 46, Color(255,255,255,150), 1, 0 )
	cam.End3D2D()

end

/*---------------------------------------------------------
	ArmoryPoliceMenu.
---------------------------------------------------------*/
function ArmoryPoliceMenu()

	/*---------------------------------------------------------
		Frame.
	---------------------------------------------------------*/
	-- Don't draw the frame if it already exists.
	if IsValid(PoliceLocker_Frame) then return end

	-- The frame itself.
	PoliceLocker_Frame = vgui.Create( "DFrame" )
	PoliceLocker_Frame:SetSize( 700, 500 )
	PoliceLocker_Frame:SetTitle( "" )
	PoliceLocker_Frame:MakePopup()
	PoliceLocker_Frame:SetDraggable( false )
	PoliceLocker_Frame:SetVisible( true )
	PoliceLocker_Frame:Center()
	PoliceLocker_Frame:ShowCloseButton( false )
	-- Cache the icon here if it exists.
	local gradRight = Material("vgui/gradient-r")
	PoliceLocker_Frame.Paint = function( self, w, h )

		-- Background.
		draw.RoundedBox( 0, 0, 0, w, h-360, Color( 0,0,0,230 ) ) -- TOP BG

		draw.RoundedBox( 4, 0, 140, w, 360, Color( 40,40,40,255 ) )

		-- Tab.      
		draw.RoundedBox( 4, 0, 0, w, 50, Color( 40,40,40,255 ) )

		-- Underline.
		surface.SetDrawColor(Color( 255,255,255,230 ))
		--surface.DrawRect(0, 50, w, 2)

		--[[
		surface.SetMaterial( gradRight )
		surface.SetDrawColor( Color(18,53,151) )
		surface.DrawTexturedRect( 0, 0, w, 50 )
		]]--

		-- Title.
		draw.SimpleText("Police Locker", "PoliceLocker_UIFont", 10, 25, Color( 255,255,255,255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		
	end

	/*---------------------------------------------------------
		Close Button.
	---------------------------------------------------------*/	
	local idclose = vgui.Create( "DButton", PoliceLocker_Frame )
	idclose:SetPos( PoliceLocker_Frame:GetWide()-50, 0 )
	idclose:SetSize( 50, 50 )
	idclose:SetText( "" )
	idclose.Paint = function(self, w, h)
	    if self:IsHovered() then
			draw.RoundedBox( 4, 0, 0, w, 50, Color(215,25,25,230) )	    	
	    end
		draw.SimpleText( 'X', "PoliceLocker_UIFont", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	idclose.DoClick = function()
	    if IsValid(PoliceLocker_Frame) then
	        PoliceLocker_Frame:Close()
	    end
	end

	/*---------------------------------------------------------
		Player Panel.
	---------------------------------------------------------*/	
	local PlayerPanel = vgui.Create( "DPanel", PoliceLocker_Frame )
	PlayerPanel:SetPos( 3, 55 )
	PlayerPanel:SetSize( 250, 80 )
	PlayerPanel:SetText( "" )
	PlayerPanel.Paint = function(self, w, h)
	    surface.SetDrawColor( Color(55,55,55,220) )
	    --surface.DrawRect(0,0,w,h) UNDER AVATAR

	    surface.SetDrawColor( Color(255,255,255,220) )
	    --surface.DrawOutlinedRect(0,0,w,h)
	end

	local Avatar = vgui.Create( "AvatarImage", PlayerPanel )
	Avatar:SetSize( 64, 64 )
	Avatar:SetPos( -60,8 )
	Avatar:MoveTo( 4, 8, 0.1, 0, -1)
	Avatar:SetPlayer( LocalPlayer(), 64 )
	Avatar:SetCursor("hand")
	Avatar:SetMouseInputEnabled(true)
	Avatar.OnMousePressed = function(s, keycode)
	    if(keycode != MOUSE_LEFT) then return end
		-- Open the players profile.
	    LocalPlayer():ShowProfile()
	end

	local PlayerName = vgui.Create( "DLabel", PlayerPanel )
	PlayerName:SetPos( -60, 8 )
	PlayerName:MoveTo( 80, 8, 0.1, 0, -1)
	PlayerName:SetSize( PlayerPanel:GetWide(), 40 )
	PlayerName:SetFont( "PoliceLocker_CategoryFontName" )
	PlayerName:SetText( LocalPlayer():Nick() )
	PlayerName.Paint = function(self, w, h) end

	local money  = DarkRP.formatMoney( LocalPlayer():getDarkRPVar("money") )
	local PlayerMoney = vgui.Create( "DLabel", PlayerPanel )
	PlayerMoney:SetPos( -60, 40 )
	PlayerMoney:MoveTo( 80, 40, 0.1, 0, -1)
	PlayerMoney:SetSize( PlayerPanel:GetWide(), 40 )
	PlayerMoney:SetFont( "PoliceLocker_CategoryFont" )
	PlayerMoney:SetText( "Cash: "..money )
	PlayerMoney.Paint = function(self, w, h) end

	local pagesback = vgui.Create( "DPanel", PoliceLocker_Frame)
	pagesback:SetPos(3, 140)
	pagesback:SetSize( 695, 355)
	pagesback.Paint = function (self, w, h)
		surface.SetDrawColor( 0,0,0,100)
		--surface.DrawRect( 0, 0, w, h ) -- LEFT BAR BG
		surface.SetDrawColor( 255,255,255, 255)
		--surface.DrawOutlinedRect( 0, 0, w, h )
	end

	local pages = vgui.Create( "armorycolesheet", pagesback )
	pages:Dock( FILL )
	
	local primaryarea = vgui.Create( "DScrollPanel", pages) -- MAIN PAGE
	primaryarea:Dock( FILL )
	primaryarea.Paint = function (self, w, h)
		surface.SetDrawColor( 0,0,0,150)
		surface.DrawRect( 0, 0, w, h )
		surface.SetDrawColor( 255,255,255, 255)
		--surface.DrawOutlinedRect( 0, 0, w, h )
	end

	local sbar = primaryarea:GetVBar() --SCROLLBAR
	function sbar:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
	end
	function sbar.btnUp:Paint( w, h )
		surface.SetMaterial( gradientd )
		surface.SetDrawColor( 80, 80, 80, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( gradientu )
		surface.SetDrawColor( 50, 50, 50, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	function sbar.btnDown:Paint( w, h )
		surface.SetMaterial( gradientu )
		surface.SetDrawColor( 50, 50, 50, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( gradientd )
		surface.SetDrawColor( 80, 80, 80, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50 ) )
	end

	
	pages:AddSheet( "Primaries", primaryarea, "icons/primary.png" )

	for k,v in pairs(PrimaryWeaponList) do
	
	
		local primariesback = vgui.Create( "DPanel", primaryarea)
		primariesback:Dock( TOP )
		primariesback:SetSize( 0, 100 )
		primariesback:DockMargin( 5, 5, 5, 5)
		primariesback.Paint = function (self, w, h )
			surface.SetDrawColor( 75,75,75,50)
			surface.DrawRect(0,0,w,h)
		
		end
		local primariesnames = vgui.Create( "DLabel", primariesback)
		primariesnames:SetText(k)
		primariesnames:Dock( FILL )
		primariesnames:DockMargin( 30, -23, 0, 0 )
		primariesnames:SetFont( "title" )
		primariesnames:SetTextColor( Color(200,200,200,200) ) -- NAMES
		primariesnames:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	
		local primariesmodels = vgui.Create( "DModelPanel", primariesback)
		primariesmodels:Dock( FILL )
		primariesmodels:SetCamPos( Vector( 10, 180, 0 ) )
		primariesmodels:SetLookAng( Angle( 180, 90, 180 ) )
		primariesmodels:SetModel(v.model)
		
	if PoliceLocker.Config.Buyable == true 
	then
		local primariesprice = vgui.Create( "DLabel", primariesback)
		primariesprice:SetText("Price: ".. DarkRP.formatMoney(v.price))
		primariesprice:Dock( FILL )
		primariesprice:DockMargin( 30, 60, 0, 0 )
		primariesprice:SetFont( "policearmory" )
		primariesprice:SetTextColor( Color(200,200,200,200) )
		primariesprice:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	end
		
		
		local primariesbutton = vgui.Create( "DButton", primariesback)
		primariesbutton:Dock( FILL )
		primariesbutton:DockMargin( 350, 30, 0, 0 )
		primariesbutton:SetFont( "policearmory" )
		primariesbutton:SetTextColor( Color(200,200,200,200) )
		primariesbutton:SetExpensiveShadow( 2, Color(0,0,0, 200) )
		primariesbutton:SetText( "" )
		primariesbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0,self:GetWide(),self:GetTall(),Color(40,40,40,0))
		draw.SimpleText( PoliceLocker.Config.Language.PurchaseButton, "buytext", 30, 2, Color( 200, 200, 200, 200 ) )
		end
		function primariesbutton:DoClick()
		net.Start("GivePolicePrimaryWeapon")
		net.WriteString( k )
		net.SendToServer()
		end
	end
	
		local secondaryarea = vgui.Create( "DScrollPanel", pages)
		secondaryarea:Dock( FILL )
		secondaryarea.Paint = function (self, w, h)
			surface.SetDrawColor( 0,0,0,150)
			surface.DrawRect( 0, 0, w, h )
			--surface.SetDrawColor( 255,255,255, 255)
			--surface.DrawOutlinedRect( 0, 0, w, h )
		end

		local sbar = secondaryarea:GetVBar() --SCROLLBAR
		function sbar:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
		end
	function sbar.btnUp:Paint( w, h )
		surface.SetMaterial( gradientd )
		surface.SetDrawColor( 80, 80, 80, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( gradientu )
		surface.SetDrawColor( 50, 50, 50, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	function sbar.btnDown:Paint( w, h )
		surface.SetMaterial( gradientu )
		surface.SetDrawColor( 50, 50, 50, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( gradientd )
		surface.SetDrawColor( 80, 80, 80, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50 ) )
	end

		pages:AddSheet( "Secondary", secondaryarea, "icons/secondary.png" )
		
	for k,v in pairs(SecondaryWeaponList) do
	
	
		local secondaryback = vgui.Create( "DPanel", secondaryarea)
		secondaryback:Dock( TOP )
		secondaryback:SetSize( 0, 100 )
		secondaryback:DockMargin( 5, 5, 5, 5)
		secondaryback.Paint = function (self, w, h )
			surface.SetDrawColor( 75,75,75,50) --BG LINE
			surface.DrawRect(0,0,w,h)
		
		end


		local secondarynames = vgui.Create( "DLabel", secondaryback)
		secondarynames:SetText(k)
		secondarynames:Dock( FILL )
		secondarynames:DockMargin( 30, -23, 0, 0 )
		secondarynames:SetFont( "title" )
		secondarynames:SetTextColor( Color(200,200,200,200) )
		secondarynames:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	
		local secondarymodels = vgui.Create( "DModelPanel", secondaryback)
		secondarymodels:Dock( FILL )
		secondarymodels:SetCamPos( Vector( 0, 150, 0 ) )
		secondarymodels:SetLookAng( Angle( 180, 90, 180 ) )
		secondarymodels:SetModel(v.model)
				
	if PoliceLocker.Config.Buyable == true 
	then
		local secondaryprice = vgui.Create( "DLabel", secondaryback)
		secondaryprice:SetText("Price: ".. DarkRP.formatMoney(v.price))
		secondaryprice:Dock( FILL )
		secondaryprice:DockMargin( 30, 60, 0, 0 )
		secondaryprice:SetFont( "policearmory" )
		secondaryprice:SetTextColor( Color(200,200,200,200) )
		secondaryprice:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	end
		local secondarybutton = vgui.Create( "DButton", secondaryback)
		secondarybutton:Dock( FILL )
		secondarybutton:DockMargin( 350, 30, 0, 0 )
		secondarybutton:SetFont( "policearmory" )
		secondarybutton:SetTextColor( Color(200,200,200,200) )
		secondarybutton:SetExpensiveShadow( 2, Color(0,0,0, 200) )
		secondarybutton:SetText( "" )
		secondarybutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0,self:GetWide(),self:GetTall(),Color(40,40,40,0))
		draw.SimpleText( PoliceLocker.Config.Language.PurchaseButton, "buytext", 30, 2, Color( 200, 200, 200, 200 ) )
		end
		function secondarybutton:DoClick()
		net.Start("GivePoliceSecondaryWeapon")
		net.WriteString( k )
		net.SendToServer()
		end
	end
	
		local armorarea = vgui.Create( "DScrollPanel", pages)
		armorarea:Dock( FILL )
		armorarea.Paint = function (self, w, h)
			surface.SetDrawColor( 0,0,0,150)
			surface.DrawRect( 0, 0, w, h )
			--surface.SetDrawColor( 255,255,255, 255)
			--surface.DrawOutlinedRect( 0, 0, w, h )
		end
	
		local sbar = armorarea:GetVBar() --SCROLLBAR
		function sbar:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
		end
	function sbar.btnUp:Paint( w, h )
		surface.SetMaterial( gradientd )
		surface.SetDrawColor( 80, 80, 80, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( gradientu )
		surface.SetDrawColor( 50, 50, 50, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	function sbar.btnDown:Paint( w, h )
		surface.SetMaterial( gradientu )
		surface.SetDrawColor( 50, 50, 50, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( gradientd )
		surface.SetDrawColor( 80, 80, 80, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50 ) )
	end

		pages:AddSheet( "Armor", armorarea, "icons/armour.png" )
		
	for k,v in pairs(ArmorList) do
	
	
		local armorback = vgui.Create( "DPanel", armorarea)
		armorback:Dock( TOP )
		armorback:SetSize( 0, 100 )
		armorback:DockMargin( 5, 5, 5, 5)
		armorback.Paint = function (self, w, h )
			surface.SetDrawColor( 75,75,75,50)
			surface.DrawRect(0,0,w,h)
		
		end
		local armornames = vgui.Create( "DLabel", armorback)
		armornames:SetText(k)
		armornames:Dock( FILL )
		armornames:DockMargin( 30, -23, 0, 0 )
		armornames:SetFont( "title" )
		armornames:SetTextColor( Color(200,200,200,200) )
		armornames:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	
		local armormodels = vgui.Create( "DModelPanel", armorback)
		armormodels:Dock( FILL )
		armormodels:SetCamPos( Vector( 0, 100, 0 ) )
		armormodels:SetLookAng( Angle( 180, 90, 180 ) )
		armormodels:SetModel("models/Items/combine_rifle_cartridge01.mdl")
				
	if PoliceLocker.Config.Buyable == true 
	then
		local armorprice = vgui.Create( "DLabel", armorback)
		armorprice:SetText("Price: ".. DarkRP.formatMoney(v.price))
		armorprice:Dock( FILL )
		armorprice:DockMargin( 30, 60, 0, 0 )
		armorprice:SetFont( "policearmory" )
		armorprice:SetTextColor( Color(200,200,200,200) )
		armorprice:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	end
		
		local armorbutton = vgui.Create( "DButton", armorback)
		armorbutton:Dock( FILL )
		armorbutton:DockMargin( 350, 30, 0, 0 )
		armorbutton:SetFont( "policearmory" )
		armorbutton:SetTextColor( Color(200,200,200,200) )
		armorbutton:SetExpensiveShadow( 2, Color(0,0,0, 200) )
		armorbutton:SetText( "" )
		armorbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0,self:GetWide(),self:GetTall(),Color(40,40,40,0))
		draw.SimpleText( PoliceLocker.Config.Language.PurchaseButton, "buytext", 30, 2, Color( 200, 200, 200, 200 ) )
		end
		function armorbutton:DoClick()
		net.Start("GivePoliceArmor")
		net.WriteString( k )
		net.SendToServer()
		end
	end
	
		local healtharea = vgui.Create( "DScrollPanel", pages)
		healtharea:Dock( FILL )
		healtharea.Paint = function (self, w, h)
			surface.SetDrawColor( 0,0,0,150)
			surface.DrawRect( 0, 0, w, h )
			--surface.SetDrawColor( 255,255,255, 255)
			--surface.DrawOutlinedRect( 0, 0, w, h )
		end
	
		local sbar = healtharea:GetVBar() --SCROLLBAR
		function sbar:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
		end
	function sbar.btnUp:Paint( w, h )
		surface.SetMaterial( gradientd )
		surface.SetDrawColor( 80, 80, 80, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( gradientu )
		surface.SetDrawColor( 50, 50, 50, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	function sbar.btnDown:Paint( w, h )
		surface.SetMaterial( gradientu )
		surface.SetDrawColor( 50, 50, 50, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( gradientd )
		surface.SetDrawColor( 80, 80, 80, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50 ) )
	end

		pages:AddSheet( "Health", healtharea, "icons/heart.png" )

	for k,v in pairs(HealthList) do
	
	
		local healthback = vgui.Create( "DPanel", healtharea)
		healthback:Dock( TOP )
		healthback:SetSize( 0, 100 )
		healthback:DockMargin( 5, 5, 5, 5)
		healthback.Paint = function (self, w, h )
			surface.SetDrawColor( 75,75,75,50)
			surface.DrawRect(0,0,w,h)
		
		end
		local healthnames = vgui.Create( "DLabel", healthback)
		healthnames:SetText(k)
		healthnames:Dock( FILL )
		healthnames:DockMargin( 30, -23, 0, 0 )
		healthnames:SetFont( "title" )
		healthnames:SetTextColor( Color(200,200,200,200) )
		healthnames:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	
		local healthmodels = vgui.Create( "DModelPanel", healthback)
		healthmodels:Dock( FILL )
		healthmodels:SetCamPos( Vector( 0, 100, 0 ) )
		healthmodels:SetLookAng( Angle( 180, 90, 180 ) )
		healthmodels:SetModel("models/Items/HealthKit.mdl")
				
	if PoliceLocker.Config.Buyable == true 
	then
		local healthprice = vgui.Create( "DLabel", healthback)
		healthprice:SetText("Price: ".. DarkRP.formatMoney(v.price))
		healthprice:Dock( FILL )
		healthprice:DockMargin( 30, 60, 0, 0 )
		healthprice:SetFont( "policearmory" )
		healthprice:SetTextColor( Color(200,200,200,200) )
		healthprice:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	end
		
		local healthbutton = vgui.Create( "DButton", healthback)
		healthbutton:Dock( FILL )
		healthbutton:DockMargin( 350, 30, 0, 0 )
		healthbutton:SetFont( "policearmory" )
		healthbutton:SetTextColor( Color(200,200,200,200) )
		healthbutton:SetExpensiveShadow( 2, Color(0,0,0, 200) )
		healthbutton:SetText( "" )
		healthbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0,self:GetWide(),self:GetTall(),Color(40,40,40,0))
		draw.SimpleText( PoliceLocker.Config.Language.PurchaseButton, "buytext", 30, 2, Color( 200, 200, 200, 200 ) )
		end
		function healthbutton:DoClick()
		net.Start("GivePoliceHealth")
		net.WriteString( k )
		net.SendToServer()
		end
	end
	
		local ammoarea = vgui.Create( "DScrollPanel", pages)
		ammoarea:Dock( FILL )
		ammoarea.Paint = function (self, w, h)
			surface.SetDrawColor( 0,0,0,150)
			surface.DrawRect( 0, 0, w, h )
			--surface.SetDrawColor( 255,255,255, 255)
			--surface.DrawOutlinedRect( 0, 0, w, h )
		end
		
		local sbar = ammoarea:GetVBar() --SCROLLBAR
		function sbar:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
		end
	function sbar.btnUp:Paint( w, h )
		surface.SetMaterial( gradientd )
		surface.SetDrawColor( 80, 80, 80, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( gradientu )
		surface.SetDrawColor( 50, 50, 50, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	function sbar.btnDown:Paint( w, h )
		surface.SetMaterial( gradientu )
		surface.SetDrawColor( 50, 50, 50, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( gradientd )
		surface.SetDrawColor( 80, 80, 80, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50 ) )
	end

		pages:AddSheet( "Ammo", ammoarea, "icons/ammo.png" )	
		
			for k,v in pairs(AmmoList) do
	
	
		local ammoback = vgui.Create( "DPanel", ammoarea)
		ammoback:Dock( TOP )
		ammoback:SetSize( 0, 100 )
		ammoback:DockMargin( 5, 5, 5, 5)
		ammoback.Paint = function (self, w, h )
			surface.SetDrawColor( 75,75,75,50)
			surface.DrawRect(0,0,w,h)
		
		end
		local ammonames = vgui.Create( "DLabel", ammoback)
		ammonames:SetText(k)
		ammonames:Dock( FILL )
		ammonames:DockMargin( 30, -23, 0, 0 )
		ammonames:SetFont( "title" )
		ammonames:SetTextColor( Color(200,200,200,200) )
		ammonames:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	
		local ammomodels = vgui.Create( "DModelPanel", ammoback)
		ammomodels:Dock( FILL )
		ammomodels:SetCamPos( Vector( 30, 170, 0 ) )
		ammomodels:SetLookAng( Angle( 180, 90, 180 ) )
		ammomodels:SetModel(v.model)
				
	if PoliceLocker.Config.Buyable == true 
	then
		local ammoprice = vgui.Create( "DLabel", ammoback)
		ammoprice:SetText("Price: ".. DarkRP.formatMoney(v.price))
		ammoprice:Dock( FILL )
		ammoprice:DockMargin( 30, 60, 0, 0 )
		ammoprice:SetFont( "policearmory" )
		ammoprice:SetTextColor( Color(200,200,200,200) )
		ammoprice:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	end
		local ammobutton = vgui.Create( "DButton", ammoback)
		ammobutton:Dock( FILL )
		ammobutton:DockMargin( 350, 30, 0, 0 )
		ammobutton:SetFont( "policearmory" )
		ammobutton:SetTextColor( Color(200,200,200,200) )
		ammobutton:SetExpensiveShadow( 2, Color(0,0,0, 200) )
		ammobutton:SetText( "" )
		ammobutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0,self:GetWide(),self:GetTall(),Color(40,40,40,0))
		draw.SimpleText( PoliceLocker.Config.Language.PurchaseButton, "buytext", 30, 2, Color( 200, 200, 200, 200 ) )
		end
		function ammobutton:DoClick()
		net.Start("GivePoliceAmmo")
		net.WriteString( k )
		net.SendToServer()
		end
	end
	if PoliceLocker.Config.PlayermodelsTab == true then
		
			local playermodelarea = vgui.Create( "DScrollPanel", pages)
			playermodelarea:Dock( FILL )
			playermodelarea.Paint = function (self, w, h)
			surface.SetDrawColor( 0,0,0,150)
			surface.DrawRect( 0, 0, w, h )
			--surface.SetDrawColor( 255,255,255, 255)
			--surface.DrawOutlinedRect( 0, 0, w, h )
			end
	
			local sbar = playermodelarea:GetVBar() --SCROLLBAR
			function sbar:Paint( w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 100 ) )
			end
	function sbar.btnUp:Paint( w, h )
		surface.SetMaterial( gradientd )
		surface.SetDrawColor( 80, 80, 80, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( gradientu )
		surface.SetDrawColor( 50, 50, 50, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	function sbar.btnDown:Paint( w, h )
		surface.SetMaterial( gradientu )
		surface.SetDrawColor( 50, 50, 50, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
		surface.SetMaterial( gradientd )
		surface.SetDrawColor( 80, 80, 80, 255 ) -- solid white, 0,0,0 is black
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	function sbar.btnGrip:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50 ) )
	end

		pages:AddSheet( "Uniforms", playermodelarea, "icons/uniform.png" )
		
		for k,v in pairs(Playermodellist) do
	
	
		local playermodelback = vgui.Create( "DPanel", playermodelarea)
		playermodelback:Dock( TOP )
		playermodelback:SetSize( 0, 200 )
		playermodelback:DockMargin( 5, 5, 5, 5)
		playermodelback.Paint = function (self, w, h )
			surface.SetDrawColor( 75,75,75,50)
			surface.DrawRect(0,0,w,h)
		
		end
		local playermodelnames = vgui.Create( "DLabel", playermodelback)
		playermodelnames:SetText(k)
		playermodelnames:Dock( FILL )
		playermodelnames:DockMargin( 30, -23, 0, 0 )
		playermodelnames:SetFont( "title" )
		playermodelnames:SetTextColor( Color(200,200,200,200) )
		playermodelnames:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	
		local playermodelmodels = vgui.Create( "DModelPanel", playermodelback)
		playermodelmodels:Dock( FILL )
		playermodelmodels:SetCamPos( Vector( 100, 300, 30 ) )
		playermodelmodels:SetLookAng( Angle( 180, 90, 180 ) )
		playermodelmodels:SetModel(v.model)
				
	if PoliceLocker.Config.Buyable == true 
	then
		local playermodelprice = vgui.Create( "DLabel", playermodelback)
		playermodelprice:SetText("Price: ".. DarkRP.formatMoney(v.price))
		playermodelprice:Dock( FILL )
		playermodelprice:DockMargin( 30, 60, 0, 0 )
		playermodelprice:SetFont( "policearmory" )
		playermodelprice:SetTextColor( Color(200,200,200,200) )
		playermodelprice:SetExpensiveShadow( 2, Color(0,0,0, 200) )
	end
		
		local playermodelbutton = vgui.Create( "DButton", playermodelback)
		playermodelbutton:Dock( FILL )
		playermodelbutton:DockMargin( 420, 70, 0, 0 )
		playermodelbutton:SetFont( "policearmory" )
		playermodelbutton:SetTextColor( Color(200,200,200,200) )
		playermodelbutton:SetExpensiveShadow( 2, Color(0,0,0, 200) )
		playermodelbutton:SetText( "" )
		playermodelbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0,self:GetWide(),self:GetTall(),Color(40,40,40,0))
		draw.SimpleText( PoliceLocker.Config.Language.PurchaseButton, "buytext", 30, 2, Color( 200, 200, 200, 200 ) )
		end
		function playermodelbutton:DoClick()
		net.Start("GivePolicePlayerModel")
		net.WriteString( k )
		net.SendToServer()
			end
		end
	else

	end
end
net.Receive("PoliceArmory", ArmoryPoliceMenu)