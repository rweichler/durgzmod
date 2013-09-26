AddCSLuaFile("shared.lua")
include("shared.lua")


ENT.MODEL = "models/drug_mod/alcohol_can.mdl"


ENT.LASTINGEFFECT = 45; --how long the high lasts in seconds


/*

    pl:ConCommand("pp_motionblur 1")  
    pl:ConCommand("pp_motionblur_addalpha 0.05")  
    pl:ConCommand("pp_motionblur_delay 0.035")  
    pl:ConCommand("pp_motionblur_drawalpha 1.00")  
    pl:ConCommand("pp_dof 1")  
    pl:ConCommand("pp_dof_initlength 9")  
    pl:ConCommand("pp_dof_spacing 8") 
    pl:ConCommand("say waitt, wait. guysss. i need to tells u abuot micrsfoft excel!11!") 
	

    local IDSteam = string.gsub(pl:SteamID(), ":", "")

    timer.Create(IDSteam, 30, 1, UnDrugPlayer, pl)

*/



function ENT:High(activator,caller)
	self:Say(activator,"waitt, wait. guysss. i need to tells u abuot micrsfoft excel!11!")
	
	--does random stuff while higH!
	local commands = {"left", "right", "moveleft", "moveright", "attack"}
	local thing = math.random(1,3)
	
	local TRANSITION_TIME = self.TRANSITION_TIME;
	
	for i = 1,thing do
		timer.Simple(math.Rand(5,10), function()
			if( activator && activator:GetNetworkedFloat("durgz_alcohol_high_end") - TRANSITION_TIME > CurTime() )then
				local cmd = commands[math.random(1, #commands)]
				activator:ConCommand("+"..cmd)
				timer.Simple(1, function()
					activator:ConCommand("-"..cmd)
				end)
			end
		end)
	end
	
	--takes out the pistol and then shoots randomly
	local oldwep = activator:GetActiveWeapon()
	
	if( !oldwep )then return; end
	for id,wep in pairs(activator:GetWeapons())do
		if( wep:GetClass() == "weapon_pistol" )then
			activator:SelectWeapon("weapon_pistol")
			timer.Simple(0.3, function()
				if( !activator:GetActiveWeapon() || activator:GetNetworkedFloat("durgz_alcohol_high_end") < CurTime())then return end
				activator:ConCommand("+attack")
				timer.Simple(0.1, function()
					activator:ConCommand("-attack")
					if(oldwep == NULL || !oldwep || !activator:Alive())then return; end
						activator:SelectWeapon(oldwep:GetClass()) --Timer Error: entities/durgz_alcohol/init.lua:65: Tried to use a NULL entity!

				end)
			end)
		end
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
