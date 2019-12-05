include("shared.lua")

function ENT:Draw()

    self:DrawModel()

end

net.Receive("doSound", function()

    local var = net.ReadString()
    local player = LocalPlayer()
    sound.Play( var, player:GetPos(), 100, 100, 1 )

end)