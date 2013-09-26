ENT.Type = "anim"
ENT.Base = "durgz_base"
ENT.PrintName = "Mushrooms"
ENT.Nicknames = {"shrooms", "magic mushrooms", "mushrooms"}
ENT.OverdosePhrase = {"ate too many", "consumed a lot of"}
ENT.Author = "cheesylard (inspired by ninjers)"
ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Information	 = "*Insert mario reference here*" 

ENT.TRANSITION_TIME = 6

--function for high visuals

if(CLIENT)then

	local TRANSITION_TIME = ENT.TRANSITION_TIME; --transition effect from sober to high, high to sober, in seconds how long it will take etc.
	local HIGH_INTENSITY = 0.77; --1 is max, 0 is nothing at all
	
	
	local function DoMushrooms()
		--self:SetNetworkedFloat( "SprintSpeed"
		local pl = LocalPlayer();
		
		
		local tab = {}
		tab[ "$pp_colour_addr" ] = 0
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		//tab[ "$pp_colour_brightness" ] = 0
		//tab[ "$pp_colour_contrast" ] = 1
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0
		
		
		if( pl:GetNetworkedFloat("durgz_mushroom_high_start") && pl:GetNetworkedFloat("durgz_mushroom_high_end") > CurTime() )then
		
			if( pl:GetNetworkedFloat("durgz_mushroom_high_start") + TRANSITION_TIME > CurTime() )then
			
				local s = pl:GetNetworkedFloat("durgz_mushroom_high_start");
				local e = s + TRANSITION_TIME;
				local c = CurTime();
				local pf = (c-s) / (e-s);
				
				tab[ "$pp_colour_colour" ] =   1 - pf*0.37
				tab[ "$pp_colour_brightness" ] = -pf*0.21
				tab[ "$pp_colour_contrast" ] = 1 + pf*1.57
				DrawMotionBlur( 1 - 0.18*pf, 1, 0);
				DrawColorModify( tab ) 
				DrawSharpen( 8.32,1.03*pf )
				
			elseif( pl:GetNetworkedFloat("durgz_mushroom_high_end") - TRANSITION_TIME < CurTime() )then
			
				local e = pl:GetNetworkedFloat("durgz_mushroom_high_end");
				local s = e - TRANSITION_TIME;
				local c = CurTime();
				local pf = 1 - (c-s) / (e-s);
				
				pl:SetDSP(1)
				
				tab[ "$pp_colour_colour" ] = 1 - pf*0.37
				tab[ "$pp_colour_brightness" ] = -pf*0.21
				tab[ "$pp_colour_contrast" ] = 1 + pf*1.57
				DrawMotionBlur( 1 - 0.18*pf, 1, 0);
				DrawColorModify( tab ) 
				DrawSharpen( 8.32,1.03*pf )
				
			else
				
				tab[ "$pp_colour_colour" ] = 0.63//5*HIGH_INTENSITY
				tab[ "$pp_colour_brightness" ] = -0.21
				tab[ "$pp_colour_contrast" ] = 2.57
				DrawMotionBlur( 0.82, 1, 0);
				DrawColorModify( tab ) 
				DrawSharpen( 8.32,1.03 )
				
			end
			
			
		end
	end
	hook.Add("RenderScreenspaceEffects", "durgz_mushroom_high", DoMushrooms)
end




/*




Motion Blur
	add: 0.82 (default 1)
	draw: 1
	delay: 0
Color Mod
	bright: -0.21
	contrast: 2.57
	color mul: 0.37
Sharpen
	distance: 1.03 (default 0)
	contrast: 8.32




*/




