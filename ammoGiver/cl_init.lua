include("shared.lua")

surface.CreateFont( "Font", {
    font = "Verdana", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    size = 100,
    weight = 500,

} )

function ENT:Draw()

    self:DrawModel()
    local ang = self:GetAngles()
    ang:RotateAroundAxis(self:GetAngles():Right(), 90)
    ang:RotateAroundAxis(self:GetAngles():Forward(), 90)

    cam.Start3D2D(self:GetPos(), ang, 0.1)
    draw.SimpleText( "Ammo", "Font", 0,-400, color_white, 1,1 )

    cam.End3D2D()

end
