--I know the folder "heroine" isn't right but I wanted the files to overwrite instead of having two files, heroine and heroin. So I just kept it as-is.

AddCSLuaFile("shared.lua")
include("shared.lua")


ENT.MODEL = "models/katharsmodels/syringe_out/syringe_out.mdl"


ENT.LASTINGEFFECT = 20; --how long the high lasts in seconds, short because it's heroine.


function ENT:High(activator,caller)
	--make you invincible
	if( !self:Realistic() )then
		activator:GodEnable()
		activator:SetHealth(1)
	end
	self:Say(activator, "It's my arm man! My fuckin' arm!")
	
end

--heroine is bad, so you die when your high is over (you have to take more to NOT die, kind of like an "addiction")
local function HeroinDeath()
	for id,pl in pairs(player.GetAll())do
	
		if pl:GetNetworkedFloat("durgz_heroine_high_end") < CurTime() && pl:GetNetworkedFloat("durgz_heroine_high_end") + 0.5 > CurTime() && pl:GetNetworkedFloat("durgz_heroine_high_start") != 0 then
			pl.DURGZ_MOD_DEATH = "durgz_heroine"
			pl.DURGZ_MOD_OVERRIDE = pl:Nick().." died because of their Heroin dependence.";
			pl:Kill()
			pl:GodDisable()
			pl:SetNetworkedFloat("durgz_heroine_high_start", 0)
			pl:SetNetworkedFloat("durgz_heroine_high_end", 0)
		end
		
	end
end
hook.Add("Think", "durgz_heroine_die", HeroinDeath)

	


function ENT:SpawnFunction( ply, tr ) 
   
 	if ( !tr.Hit ) then return end 
 	 
 	local SpawnPos = tr.HitPos + tr.HitNormal * 16 
 	 
 	local ent = ents.Create( self.Classname ) 
 		ent:SetPos( SpawnPos ) 
 	ent:Spawn() 
 	ent:Activate() 
 	 
 	return ent 
 	 
 end 
