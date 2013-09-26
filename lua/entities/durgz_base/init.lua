AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.MODEL = "oijsdfjisd.mdl"
ENT.LASTINGEFFECT = 30;
ENT.HASHIGH = true
ENT.MULTIPLY = 1


function ENT:SpawnFunction( ply, tr ) 
   
 	if ( !tr.Hit ) then return end 
 	 
 	local SpawnPos = tr.HitPos + tr.HitNormal * 16 
 	 
 	local ent = ents.Create( self.Classname ) 
 		ent:SetPos( SpawnPos ) 
 	ent:Spawn() 
 	ent:Activate() 
 	 
 	return ent 
 	 
 end 

function ENT:Initialize()	

	self:SetModel( self.MODEL )
	
	self:PhysicsInit( SOLID_VPHYSICS )

	local phys = self:GetPhysicsObject()  	
	if phys:IsValid() then  		
		phys:Wake()  	
	end
	
	if( self.MASS )then
		self.Entity:GetPhysicsObject():SetMass( self.MASS );
	end
	
end

 function ENT:OnTakeDamage( dmginfo ) 
   
 	self.Entity:TakePhysicsDamage( dmginfo ) 
 	 
 end 

 
 
 --TODO: When your high is ending and you take another one add a nice transition to it as well (kinda like in the soberup function).

function ENT:Use(activator,caller)
	self:High(activator,caller)
	if( self.HASHIGH )then
	
		--if you're transitioning to the end and you take another, smoothen it out
		if activator:GetNetworkedFloat(self:GetClass().."_high_end") && activator:GetNetworkedFloat(self:GetClass().."_high_end") > CurTime() && activator:GetNetworkedFloat(self:GetClass().."_high_end") - self.TRANSITION_TIME < CurTime() then
			--set the high start in such a way to where it doesn't snap to the start time, goes smoooothly.
			local set = CurTime() - ( activator:GetNetworkedFloat(self:GetClass().."_high_end") - CurTime() )
			activator:SetNetworkedFloat(self:GetClass().."_high_start", set)
			
		--if you're not high at all
		elseif( !activator:GetNetworkedFloat(self:GetClass().."_high_start") || activator:GetNetworkedFloat(self:GetClass().."_high_end") < CurTime() )then
			activator:SetNetworkedFloat(self:GetClass().."_high_start", CurTime())
		end
		
		--high is done
		local ctime;
		if( !activator:GetNetworkedFloat(self:GetClass().."_high_end") || activator:GetNetworkedFloat(self:GetClass().."_high_end") < CurTime() )then
			ctime = CurTime();
		--you're already high on the drug,  add more highness
		else
			ctime = activator:GetNetworkedFloat(self:GetClass().."_high_end") - self.LASTINGEFFECT/3;
		end
		activator:SetNetworkedFloat(self:GetClass().."_high_end", ctime + self.LASTINGEFFECT)
		
		if( activator:GetNetworkedFloat(self:GetClass().."_high_end") && activator:GetNetworkedFloat(self:GetClass().."_high_end") - self.LASTINGEFFECT*5 > CurTime() )then
			activator:Kill()
			for id,pl in pairs(player.GetAll())do
				pl:PrintMessage(HUD_PRINTTALK, activator:Nick().." "..self.OverdosePhrase[math.random(1, #self.OverdosePhrase)].." "..self.Nicknames[math.random(1, #self.Nicknames)].." and died.")
			end
		end
	end
	self:AfterHigh(activator, caller)
    self.Entity:Remove()
end

function ENT:High(activator, caller)

end

function ENT:AfterHigh(activator, caller)

end



	local function SoberUp(pl, x, y, z, ndeath, didntdie)
		--make a smooth transition and not a instant soberization
		local drugs = {
			"weed",
			"cocaine",
			"cigarette",
			"alcohol",
			"mushroom",
			"lsd"
		}
		
		local ttime = {
			6,
			5,
			4,
			6,
			6,
			6
		}
		
		--you can't get out of the heroine high because you die when the high ends
		if( !didntdie )then
			table.insert(ttime, 5)
			table.insert(drugs, "heroine")
		end
		
		for i = 1, #drugs do
			local tend = 0
			if( pl:GetNetworkedFloat("durgz_"..drugs[i].."_high_start") + ttime[i] > CurTime() )then
				tend = ( CurTime() - pl:GetNetworkedFloat("durgz_"..drugs[i].."_high_start") ) + CurTime()
			elseif !( pl:GetNetworkedFloat("durgz_"..drugs[i].."_high_end") - ttime[i] < CurTime() )then	
				tend = CurTime() + ttime[i]
			elseif( pl:GetNetworkedFloat("durgz_"..drugs[i].."_high_end") > CurTime() )then
				tend = pl:GetNetworkedFloat("durgz_"..drugs[i].."_high_end")
			end
		
			pl:SetNetworkedFloat("durgz_"..drugs[i].."_high_start", 0)
			pl:SetNetworkedFloat("durgz_"..drugs[i].."_high_end", tend)
		end
		
		--remove cigarette if there is one
		
		/*if( pl.DurgzModCigarette && pl.DurgzModCigarette:IsValid() )then
			pl.DurgzModCigarette:Remove()
			pl.DurgzModCigarette = nil
		end*/
		
		--set speed back to normal
		
		if( pl:GetNetworkedFloat( "durgz_oldSprintSpeed" ) && pl:GetNetworkedFloat("durgz_oldSprintSpeed") != 0)then
			pl:SetWalkSpeed(pl:GetNetworkedFloat( "durgz_oldWalkSpeed" ))
			pl:SetRunSpeed(pl:GetNetworkedFloat( "durgz_oldSprintSpeed" ))
		else
			local ss = pl:GetNetworkedFloat("SprintSpeed")
			local ws = pl:GetNetworkedFloat("WalkSpeed")
			pl:SetNetworkedFloat( "durgz_oldSprintSpeed", ss)
			pl:SetNetworkedFloat( "durgz_oldWalkSpeed", ws)
		end
		
		--set sound to normal
		pl:SetDSP(1, false)
		--no more floating
		pl:SetGravity(1)
		
		if( ndeath )then
			pl:EmitSound(Sound("vo/npc/male01/moan0"..math.random(4,5)..".wav"))
		end
	end
	hook.Add("DoPlayerDeath", "durgz_sober_up_cmd", SoberUp)

	function ENT:Soberize(pl)
		SoberUp(pl, true, true, true, true, true);
	end


