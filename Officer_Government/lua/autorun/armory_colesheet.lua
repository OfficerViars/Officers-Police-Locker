surface.CreateFont("ButtonFont", { font = "Trebuchet", size = 20 } )
local PANEL = {}

AccessorFunc( PANEL, "ActiveButton", "ActiveButton" )

function PANEL:Init()

    self.Navigation = vgui.Create( "DScrollPanel", self )
    self.Navigation:Dock( LEFT )
    self.Navigation:SetWidth( 140 )
    self.Navigation:DockMargin( 0, 0, 0, 0 )

    self.Content = vgui.Create( "Panel", self )
    self.Content:Dock( FILL )

    self.Items = {}
    
end

function PANEL:UseButtonOnlyStyle()
    self.ButtonOnly = true
end

function PANEL:AddSheet( label, panel, material )

    if ( !IsValid( panel ) ) then return end

    local Sheet = {}

    if ( self.ButtonOnly ) then
        Sheet.Button = vgui.Create( "DImageButton", self.Navigation )
    else
        Sheet.Button = vgui.Create( "DButton", self.Navigation )
    end

    Sheet.Button:SetImage( material )
    Sheet.Button.Target = panel
    Sheet.Button:Dock( TOP )
    Sheet.Button:SetText("")
    Sheet.Button:DockMargin( 5, 7, 0, 5 )
    Sheet.Button:SetHeight( 35 )
	    Sheet.Button.Paint = function(self, w, h)
        surface.SetDrawColor(40,40,40,55)
        surface.DrawRect( 0, 0, w, h )
        --surface.SetDrawColor(0,0,0,255)
        surface.DrawOutlinedRect( 0, 0, w, h )
        if(self:IsHovered()) then
            draw.SimpleText(label,"ButtonFont",w/1.75,h/2, Color(255,255,255,155),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        elseif(self:IsDown() or self.m_bSelected) then
            draw.SimpleText(label,"ButtonFont",w/1.75,h/2, Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        else
            draw.SimpleText(label,"ButtonFont",w/1.75,h/2, Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end   
	end

    Sheet.Button.DoClick = function()
        self:SetActiveButton( Sheet.Button )
    end

    Sheet.Panel = panel
    Sheet.Panel:SetParent( self.Content )
    Sheet.Panel:SetVisible( false )

    if ( self.ButtonOnly ) then
        Sheet.Button:SizeToContents()
        --Sheet.Button:SetColor( Color( 150, 150, 150, 100 ) )
    end

    table.insert( self.Items, Sheet )

    if ( !IsValid( self.ActiveButton ) ) then
        self:SetActiveButton( Sheet.Button )
    end

end

function PANEL:SetActiveButton( active )

    if ( self.ActiveButton == active ) then return end

    if ( self.ActiveButton && self.ActiveButton.Target ) then
        self.ActiveButton.Target:SetVisible( false )
        self.ActiveButton:SetSelected( false )
        self.ActiveButton:SetToggle( false )
        --self.ActiveButton:SetColor( Color( 150, 150, 150, 100 ) )
    end

    self.ActiveButton = active
    active.Target:SetVisible( true )
    active:SetSelected( true )
    active:SetToggle( true )
    --active:SetColor( Color( 255, 255, 255, 255 ) )

    self.Content:InvalidateLayout()

end

derma.DefineControl( "armorycolesheet", "", PANEL, "Panel" )