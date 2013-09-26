ENT.Type = "anim"
ENT.Base = "durgz_base"
ENT.PrintName = "Heroine"
ENT.Nicknames = {"heroine"}
ENT.OverdosePhrase = {"overdosed on", "injected too much", "took too much"}
ENT.Author = "cheesylard (inspired by ninjers)"
ENT.Category = "Drugs"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Information	 = "Put this stuff in your arm." 

--function for high visuals

ENT.TRANSITION_TIME = 5


if(CLIENT)then
	local cdw, cdw2, cdw3
	cdw2 = -1
	local TRANSITION_TIME = ENT.TRANSITION_TIME; --transition effect from sober to high, high to sober, in seconds how long it will take etc.
	local HIGH_INTENSITY = 0.8; --1 is max, 0 is nothing at all
	local STROBE_PACE_TOTAL = 1
	
	
	local function DoHeroine()
		--self:SetNetworkedFloat( "SprintSpeed"
		local pl = LocalPlayer();
		local pf;
		
		local STROBE_PACE = STROBE_PACE_TOTAL
		
		local tab = {}
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = 0
		tab[ "$pp_colour_contrast" ] = 1
		tab[ "$pp_colour_colour" ] = 1
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0
		tab[ "$pp_colour_mulr" ] = 0
		
		
		if( pl:GetNetworkedFloat("durgz_heroine_high_start") && pl:GetNetworkedFloat("durgz_heroine_high_end") > CurTime() )then
			
			
			
			
			if( pl:GetNetworkedFloat("durgz_heroine_high_start") + TRANSITION_TIME > CurTime() )then
			
				local s = pl:GetNetworkedFloat("durgz_heroine_high_start");
				local e = s + TRANSITION_TIME;
				local c = CurTime();
				pf = (c-s) / (e-s);
				
				pf = pf*HIGH_INTENSITY
				
				
				
			elseif( pl:GetNetworkedFloat("durgz_heroine_high_end") - TRANSITION_TIME < CurTime() )then
			
				local e = pl:GetNetworkedFloat("durgz_heroine_high_end");
				local s = e - TRANSITION_TIME;
				local c = CurTime();
				
				STROBE_PACE = 0.5
				
				pf = 1 - (c-s) / (e-s);
				
				pf = pf*HIGH_INTENSITY
				
				
				
				
			else
			
				pf = HIGH_INTENSITY;
				
			end
			
			
				
			if( !cdw || cdw < CurTime() )then
				cdw = CurTime() + STROBE_PACE
				cdw2 = cdw2*-1
			end
			if( cdw2 == -1 )then
				cdw3 = 2
			else
				cdw3 = 0
			end
			local ich = (cdw2*((cdw - CurTime())*(2/STROBE_PACE)))+cdw3 - 1
			
			
			
			
			local gah = pf*(ich+1)
			tab[ "$pp_colour_addr" ] = gah	
			
			DrawMaterialOverlay("models/shadertest/shader3",  pf*ich*0.05	)
			DrawColorModify(tab)
			
		end
	end
	hook.Add("RenderScreenspaceEffects", "durgz_heroine_high", DoHeroine)
end