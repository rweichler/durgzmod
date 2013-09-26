AddCSLuaFile("shared.lua")
include("shared.lua")


ENT.MODEL = "models/cocn.mdl"

ENT.MASS = 2; --the model is too heavy so we have to override it with THIS

ENT.LASTINGEFFECT = 45; --how long the high lasts in seconds


function ENT:High(activator,caller)
	--cut health in half and double the speed
	activator:SetHealth(activator:Health()/2)
	if( activator:Health() > 1 )then
		activator:ConCommand("say MYNOSEISDRIBBLINGISANYONEELSESNOSEDRIBBLINGTHATSREALLYWEIRDIHOPEIDONTHAVEACOLD")
	end
	
	self.MakeHigh = false;
	local ss = activator:GetNetworkedFloat("SprintSpeed")
	local ws = activator:GetNetworkedFloat("WalkSpeed")
	if activator:GetNetworkedFloat("durgz_cocaine_high_end") < CurTime() &&  ( !activator:GetNetworkedFloat("durgz_oldSprintSpeed") || activator:GetNetworkedFloat("durgz_oldSprintSpeed") == 0 || activator:GetNetworkedFloat( "durgz_oldSprintSpeed") == ss ) then
		self.MakeHigh = true;
	end
end

function ENT:AfterHigh(activator, caller)
	
	--kill them if they're weak
	if( activator:Health() <=1 )then
		activator:Kill()
		for id,pl in pairs(player.GetAll())do
			pl:PrintMessage(HUD_PRINTTALK, activator:Nick().." died of a heart attack (too much cocaine).")
		end
	return
	end
	
	local ss = activator:GetNetworkedFloat("SprintSpeed")
	local ws = activator:GetNetworkedFloat("WalkSpeed")
	if( self.MakeHigh )then
		activator:SetNetworkedFloat( "durgz_oldSprintSpeed", ss)
		activator:SetNetworkedFloat( "durgz_oldWalkSpeed", ws)
		
		activator:SetRunSpeed(ss*6)
		activator:SetWalkSpeed(ws*6)
	end
end

--set speed back to normal once your high is over 
local function ResetSpeed()
	for id,pl in pairs(player.GetAll())do
	
		if pl:GetNetworkedFloat("durgz_cocaine_high_end") < CurTime() && pl:GetNetworkedFloat("durgz_cocaine_high_end") + 0.5 > CurTime() && ( pl:GetNetworkedFloat( "durgz_oldSprintSpeed" ) && pl:GetNetworkedFloat("durgz_oldSprintSpeed") != 0)then
			pl:SetWalkSpeed(pl:GetNetworkedFloat( "durgz_oldWalkSpeed" ))
			pl:SetRunSpeed(pl:GetNetworkedFloat( "durgz_oldSprintSpeed" ))
		end
		
	end
end
hook.Add("Think", "durgz_cocaine_resetspeed", ResetSpeed)

	



function ENT:SpawnFunction( ply, tr ) 
   
 	if ( !tr.Hit ) then return end 
 	 
 	local SpawnPos = tr.HitPos + tr.HitNormal * 16 
 	 
 	local ent = ents.Create( self.Classname ) 
 		ent:SetPos( SpawnPos ) 
 	ent:Spawn() 
 	ent:Activate() 
 	 
 	return ent 
 	 
 end 
