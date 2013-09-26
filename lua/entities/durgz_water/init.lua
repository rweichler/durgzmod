AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.MODEL = "models/props/cs_office/Water_bottle.mdl"

ENT.HASHIGH = false

ENT.LASTINGEFFECT = 0;

--called when you use it (after it sets the high visual values and removes itself already)
function ENT:High(activator,caller)
	self:Soberize(activator)
end


function ENT:SpawnFunction( plr, tr )

	if not tr.Hit then return end
	
	local ent = ents.Create( self.Classname )
	ent:SetPos( tr.HitPos + tr.HitNormal * self.MULTIPLY )
	ent:Spawn()
	ent:Activate()	
	
	return ent

end
