AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.MODEL = "models/jaanus/aspbtl.mdl"

ENT.HASHIGH = false

ENT.LASTINGEFFECT = 0;

--called when you use it (after it sets the high visual values and removes itself already)
function ENT:High(activator,caller)
	
	local drugs = {
		"weed",
		"cocaine",
		"cigarette",
		"alcohol",
		"mushroom",
		"heroine"
	}
	local wat = false;
	local say = activator:Nick().."got rid of their headache";
	for k,v in pairs(drugs)do
		if( activator:GetNetworkedFloat("durgz_"..v.."_high_end" > CurTime() && !wat)then
			activator:Kill();
			wat = true;
			say = say.." but died in the process";
		end
	end
	for id,pl in pairs(player.GetAll())do
		pl:PrintMessage(HUD_PRINTTALK, say..".");
	end
end


function ENT:SpawnFunction( ply, tr ) 
   
 	if ( !tr.Hit ) then return end 
 	 
 	local SpawnPos = tr.HitPos + tr.HitNormal * 16 
 	 
 	local ent = ents.Create( self.Classname ) 
 		ent:SetPos( SpawnPos ) 
 	ent:Spawn() 
 	ent:Activate() 
 	 
 	return ent 
 	 
 end 