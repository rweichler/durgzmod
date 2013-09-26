AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.MODEL = "models/marioragdoll/Super Mario Galaxy/star/star.mdl"


ENT.LASTINGEFFECT = 20; --how long the high lasts in seconds

--called when you use it (after it sets the high visual values and removes itself already)
function ENT:High(activator,caller)
		
	local sayings = {
		"HELLO. MY NAME IS JARED AND I LIKE FOOTBALL.",
		"MY ARMS ARE LIKE FUCKING CANNONS",
		"FOOTBALLLL",
		"REEEED! MENOS TRES"
	}
	self:Say(activator, ""..sayings[math.random(1,#sayings)])
		
end



function ENT:SpawnFunction( ply, tr ) 
   
 	if ( !tr.Hit ) then return end 
 	 
 	local SpawnPos = tr.HitPos + tr.HitNormal * 16 
 	 
 	local ent = ents.Create("durgz_pcp") 
 		ent:SetPos( SpawnPos ) 
 	ent:Spawn() 
 	ent:Activate() 
 	 
 	return ent 
 	 
 end



