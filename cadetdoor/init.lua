AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
local dbounce = false
util.AddNetworkString("doSound")

function ENT:Initialize()

    self:SetModel(doormodel)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

end

function ENT:StartTouch( entity ) 

    if entity:IsPlayer() and not dbounce then
        dbounce = true
        for _,v in ipairs(blacklistedjobs) do

            if entity:getDarkRPVar("job") != v then

                self:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )
                timer.Simple(1, function() self:SetCollisionGroup( COLLISION_GROUP_NONE ) end)
                net.Start("doSound")
                net.WriteString(successSound)
                net.Send( entity )
            
            else
                net.Start("doSound")
                net.WriteString(errorSound)
                net.Send( entity )
                dbounce = true
                entity:ChatPrint("You are not allowed in here")
            end
        end
        timer.Simple(2, function() dbounce = false end)
    end
end