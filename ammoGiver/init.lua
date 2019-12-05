AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local nextOccurance = 0

function ENT:Initialize()

    self:SetModel(dispensermodel)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

end

function ENT:Use( activator )
	local timeLeft = nextOccurance - CurTime()
    if timeLeft < 0 then -- If the time has passed the nextOccurance time
        if activator:IsPlayer() then
                if activator:GetActiveWeapon():GetClass() != "keys" and activator:GetActiveWeapon():GetClass() != "weapon_physgun" and activator:GetActiveWeapon():GetClass() != "gmod_tool" then
                    if activator:getDarkRPVar("money") > price then
                        activator:addMoney(-price)
                        local ammotype = activator:GetActiveWeapon():GetPrimaryAmmoType()
                        activator:GiveAmmo( amountgiven, ammotype, false )
                    end
                end
        end
		nextOccurance = CurTime() + delay
	end
end