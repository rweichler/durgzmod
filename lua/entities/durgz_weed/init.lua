AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.MODEL = "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl"


ENT.LASTINGEFFECT = 60; --how long the high lasts in seconds

--called when you use it (after it sets the high visual values and removes itself already)
function ENT:High(activator,caller)
	local smoke = EffectData();
	smoke:SetOrigin(activator:EyePos());
	util.Effect("durgz_weed_smoke", smoke);
	--enhance sound (not really like it but close enough as far as computers go)
	activator:SetDSP(6);
	--increase health
	if( math.random(0,10) == 0 )then
		activator:Ignite(5,0)
		activator:ConCommand("say FFFFFFUUUUUUUUUUUUUUUUUU")
	else
		local health = activator:Health()
		if( health * 3/2 < 500 )then
			activator:SetHealth( math.floor(health * 3/2) )
		else
			activator:SetHealth( health + 50 )
		end
		
		
		local sayings = {
			"hey gise. what if like the universe was just an videogame!!??!1 holy craaaap that would be awesomeeeeee",
			"does any1 hav goldfish!?1 i want goldfish plz thx",
			"duuuuuuuuuuudeeeeeeee",
			"hi how do i type in chat i cant figure it out"
		}
		activator:ConCommand("say "..sayings[math.random(1,#sayings)])
		
	end
end

function ENT:AfterHigh(activator, caller)
	activator:SetGravity(0.2);
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


local function ResetGrav()

	for id,pl in pairs( player.GetAll() )do

		if( pl:GetNetworkedFloat("durgz_weed_high_end") - 0.5 < CurTime() && pl:GetNetworkedFloat("durgz_weed_high_end") > CurTime() )then
			pl:SetGravity(1)
		end
		
	end
	
end
hook.Add("Think", "durgz_weed_resetgrav", ResetGrav)


