AddCSLuaFile("shared.lua")
include("shared.lua")


ENT.MODEL = "models/katharsmodels/syringe_out/syringe_out.mdl"


ENT.LASTINGEFFECT = 20; --how long the high lasts in seconds, short because it's heroine.


function ENT:High(activator,caller)
	--make you invincible
	activator:GodEnable()
	activator:SetHealth(1)
	activator:ConCommand("say My fuckin arm man!")
	
end

--heroine is bad, so you die when your high is over (you have to take more to NOT die, kind of like an "addiction")
local function HeroineDeath()
	for id,pl in pairs(player.GetAll())do
	
		if pl:GetNetworkedFloat("durgz_heroine_high_end") < CurTime() && pl:GetNetworkedFloat("durgz_heroine_high_end") + 0.5 > CurTime() && pl:GetNetworkedFloat("durgz_heroine_high_start") != 0 then
			for id2, pl2 in pairs(player.GetAll())do
				pl2:PrintMessage(HUD_PRINTTALK, pl:Nick().." died because of their Heroine dependence.")
			end
			pl:Kill()
			pl:GodDisable()
			pl:SetNetworkedFloat("durgz_heroine_high_start", 0)
			pl:SetNetworkedFloat("durgz_heroine_high_end", 0)
		end
		
	end
end
hook.Add("Think", "durgz_heroine_die", HeroineDeath)

	


function ENT:SpawnFunction( ply, tr ) 
   
 	if ( !tr.Hit ) then return end 
 	 
 	local SpawnPos = tr.HitPos + tr.HitNormal * 16 
 	 
 	local ent = ents.Create( self.Classname ) 
 		ent:SetPos( SpawnPos ) 
 	ent:Spawn() 
 	ent:Activate() 
 	 
 	return ent 
 	 
 end 
