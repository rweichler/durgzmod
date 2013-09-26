ENT.Type = "anim"
ENT.Base = "durgz_base"
ENT.PrintName = "PCP"
ENT.Nicknames = {"PCP"}
ENT.OverdosePhrase = {"overdosed on"}
ENT.Author = "shit fixed by Metasync, original by cheesylard (inspired by ninjers)"
ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Information	 = "GODLIKE!!!" 
ENT.Category = "Drugs"
ENT.TRANSITION_TIME = 3

--function for high visuals

if(CLIENT)then

	killicon.Add("durgz_pcp","killicons/durgz_pcp_killicon",Color( 255, 80, 0, 255 ))

	local TRANSITION_TIME = ENT.TRANSITION_TIME; --transition effect from sober to high, high to sober, in seconds how long it will take etc.
	local HIGH_INTENSITY = 0.77; --1 is max, 0 is nothing at all
	
	
	local function DoPCP()
		if(!DURGZ_LOST_VIRGINITY)then return; end
		--self:SetNetworkedFloat( "SprintSpeed"
		local pl = LocalPlayer();
		
		
		local tab = {}
		tab[ "$pp_colour_addr" ] = 0
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = 0
		tab[ "$pp_colour_contrast" ] = 1
		tab[ "$pp_colour_colour" ] = 1
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0
		
		
		if( pl:GetNetworkedFloat("durgz_pcp_high_start") && pl:GetNetworkedFloat("durgz_pcp_high_end") > CurTime() )then
		
		      local pf = 1;
		
			if( pl:GetNetworkedFloat("durgz_pcp_high_start") + TRANSITION_TIME > CurTime() )then
			
				local s = pl:GetNetworkedFloat("durgz_pcp_high_start");
				local e = s + TRANSITION_TIME;
				local c = CurTime();
				pf = (c-s) / (e-s);
				
			elseif( pl:GetNetworkedFloat("durgz_pcp_high_end") - TRANSITION_TIME < CurTime() )then
			
				local e = pl:GetNetworkedFloat("durgz_pcp_high_end");
				local s = e - TRANSITION_TIME;
				local c = CurTime();
				pf = 1 - (c-s) / (e-s);
				
			end
				
				tab[ "$pp_colour_addr" ] = pf*math.random(0,1);
			    tab[ "$pp_colour_addg" ] = pf*math.random(0,1);
			    tab[ "$pp_colour_addb" ] = pf*math.random(0,1);
			    DrawColorModify(tab);
		end
	end
	
	
	/*local function DoMsgPCP()
		local pl = LocalPlayer();
		
		
		
		if( pl:GetNetworkedFloat("durgz_pcp_high_start") && pl:GetNetworkedFloat("durgz_pcp_high_end") > CurTime() )then
		
			local say = "main"
			
			if( pl:GetNetworkedFloat("durgz_pcp_high_start") + TRANSITION_TIME > CurTime() )then
			
				say = "trans"
				
			elseif( pl:GetNetworkedFloat("durgz_pcp_high_end") - TRANSITION_TIME < CurTime() )then
			
				say = "trans"
				
			end
			draw.DrawText(say, "ScoreboardHead", ScrW() / 2+1 , ScrH()*0.6+1, Color(255,255,255,255),TEXT_ALIGN_CENTER) 
			draw.DrawText(say, "ScoreboardHead", ScrW() / 2-1 , ScrH()*0.6-1, Color(255,255,255,255),TEXT_ALIGN_CENTER) 
			draw.DrawText(say, "ScoreboardHead", ScrW() / 2-1 , ScrH()*0.6+1, Color(255,255,255,255),TEXT_ALIGN_CENTER) 
			draw.DrawText(say, "ScoreboardHead", ScrW() / 2+1 , ScrH()*0.6-1, Color(255,255,255,255),TEXT_ALIGN_CENTER) 
			draw.DrawText(say, "ScoreboardHead", ScrW() / 2 , ScrH()*0.6, Color(255,9,9,255),TEXT_ALIGN_CENTER) 
		end
	end
	hook.Add("HUDPaint", "durgz_pcp_msg", DoMsgPCP)*/
	
	hook.Add("RenderScreenspaceEffects", "durgz_pcp_high", DoPCP)
end