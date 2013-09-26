AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.MODEL = "models/jaanus/aspbtl.mdl"

ENT.HASHIGH = false

ENT.LASTINGEFFECT = 0;

local TIME_TO_REMOVE = 15;
local HP_TO_ADD = 50;


--called when you use it (after it sets the high visual values and removes itself already)
function ENT:High(activator,caller)
	activator.durgz_aspirin_used = true
	activator.durgz_aspirin_hp = activator:Health() + HP_TO_ADD
	activator.durgz_aspirin_hp_start = activator:Health()
	activator.durgz_aspirin_lasthealth = activator:Health();
	activator:SetHealth(activator:Health()+HP_TO_ADD);
	activator.durgz_aspirin_start = CurTime();
	
end

local function RemoveHealth() for id,pl in pairs(player.GetAll())do
	local health = pl:Health()
	if( pl.durgz_aspirin_used && health > pl.durgz_aspirin_hp_start && pl.durgz_aspirin_start + TIME_TO_REMOVE > CurTime() )then
		if( health < pl.durgz_aspirin_lasthealth )then
			pl.durgz_aspirin_start = pl.durgz_aspirin_start - ( pl.durgz_aspirin_lasthealth - health ) / HP_TO_ADD * TIME_TO_REMOVE
			pl.durgz_aspirin_hp = pl.durgz_aspirin_hp + ( pl.durgz_aspirin_lasthealth - health )
		end
		
		local pf = ( CurTime() - pl.durgz_aspirin_start ) / ( TIME_TO_REMOVE )
		
		local set = math.floor(pl.durgz_aspirin_hp - HP_TO_ADD*pf)
		
		if( set != health )then
			pl:SetHealth( set )
			pl.durgz_aspirin_lasthealth = set
		end
		
	else
		pl.durgz_aspirin_hp = nil
		pl.durgz_aspirin_start = nil
		pl.durgz_aspirin_lasthealth = nil
		pl.durgz_aspirin_used = false
		
	end


end end
hook.Add("Think", "durgz_aspirin_removehealth", RemoveHealth)
hook.Add("DoPlayerDeath", "durgz_aspirin_removehealth_reset", function(pl)

		pl.durgz_aspirin_hp = nil
		pl.durgz_aspirin_start = nil
		pl.durgz_aspirin_lasthealth = nil
		pl.durgz_aspirin_used = false

end)

function ENT:SpawnFunction( ply, tr ) 
   
 	if ( !tr.Hit ) then return end 
 	 
 	local SpawnPos = tr.HitPos + tr.HitNormal * 16 
 	 
 	local ent = ents.Create( self.Classname ) 
 		ent:SetPos( SpawnPos ) 
 	ent:Spawn() 
 	ent:Activate() 
 	 
 	return ent 
 	 
 end 