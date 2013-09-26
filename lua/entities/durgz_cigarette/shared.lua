ENT.Type = "anim"
ENT.Base = "durgz_base"
ENT.PrintName = "Cigarette"
ENT.Nicknames = {"wimpy cigars", "cigarettes", "ciggies"}
ENT.OverdosePhrase = {"got cancer from"}
ENT.Author = "cheesylard (inspired by ninjers)"
ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Information	 = "This stuff makes you look badass." 

ENT.TRANSITION_TIME = 0

--function for high visuals

if(CLIENT)then

	
	local function DoCigarette()
		local pl = LocalPlayer();
		
		
		
		if( pl:GetNetworkedFloat("durgz_cigarette_high_start") && pl:GetNetworkedFloat("durgz_cigarette_high_end") > CurTime() )then
		
			local say = "You smoke. Therefore you are cool."
			draw.DrawText(say, "ScoreboardHead", ScrW() / 2+1 , ScrH()*0.6+1, Color(255,255,255,255),TEXT_ALIGN_CENTER) 
			draw.DrawText(say, "ScoreboardHead", ScrW() / 2-1 , ScrH()*0.6-1, Color(255,255,255,255),TEXT_ALIGN_CENTER) 
			draw.DrawText(say, "ScoreboardHead", ScrW() / 2-1 , ScrH()*0.6+1, Color(255,255,255,255),TEXT_ALIGN_CENTER) 
			draw.DrawText(say, "ScoreboardHead", ScrW() / 2+1 , ScrH()*0.6-1, Color(255,255,255,255),TEXT_ALIGN_CENTER) 
			draw.DrawText(say, "ScoreboardHead", ScrW() / 2 , ScrH()*0.6, Color(255,9,9,255),TEXT_ALIGN_CENTER) 
		end
	end
	hook.Add("HUDPaint", "durgz_cigarette_high", DoCigarette)
end