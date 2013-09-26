ENT.Type = "anim"
ENT.Base = "durgz_base"
ENT.PrintName = "Alcohol"
ENT.Nicknames = {"booze", "beer", "alcohol", "Bud Light"}
ENT.OverdosePhrase = {"drank too much", "got poisoned on"}
ENT.Author = "TheBomb"
ENT.Category = "Drugs"
ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Information	 = "Drink your troubles away..." 

ENT.TRANSITION_TIME = 6

if(CLIENT)then
	
	
	killicon.Add("durgz_alcohol","killicons/durgz_alcohol_killicon",Color( 255, 80, 0, 255 ))
	
	local TRANSITION_TIME = ENT.TRANSITION_TIME; --transition effect from sober to high, high to sober, in seconds how long it will take etc.
	local HIGH_INTENSITY = 1; --1 is max, 0 is nothing at all
	
	
	local function DoAlcohol()
		if(!DURGZ_LOST_VIRGINITY)then return; end
		--self:SetNetworkedFloat( "SprintSpeed"
		local pl = LocalPlayer();
		
		
		
		if( pl:GetNetworkedFloat("durgz_alcohol_high_start") && pl:GetNetworkedFloat("durgz_alcohol_high_end") > CurTime() )then
		
			if( pl:GetNetworkedFloat("durgz_alcohol_high_start") + TRANSITION_TIME > CurTime() )then
			
				local s = pl:GetNetworkedFloat("durgz_alcohol_high_start");
				local e = s + TRANSITION_TIME;
				local c = CurTime();
				local pf = (c-s) / (e-s);
				
				DrawMotionBlur( 0.03, pf*HIGH_INTENSITY, 0);
				
			elseif( pl:GetNetworkedFloat("durgz_alcohol_high_end") - TRANSITION_TIME < CurTime() )then
			
				local e = pl:GetNetworkedFloat("durgz_alcohol_high_end");
				local s = e - TRANSITION_TIME;
				local c = CurTime();
				local pf = 1 - (c-s) / (e-s);
				
				DrawMotionBlur( 0.03, pf*HIGH_INTENSITY, 0);
				
			else
				
				DrawMotionBlur( 0.03, HIGH_INTENSITY, 0);
				
			end
			
			
		end
	end
	hook.Add("RenderScreenspaceEffects", "durgz_alcohol_high", DoAlcohol)
	
end