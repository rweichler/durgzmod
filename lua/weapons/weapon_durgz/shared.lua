if (SERVER) then
	AddCSLuaFile( "shared.lua" );
end

if ( CLIENT ) then
	SWEP.PrintName			= "Injector/Lacer";
	SWEP.Author				= "cheesylard";
	SWEP.DrawCrosshair		= false;
	SWEP.SlotPos			= 4;
	SWEP.Slot				= 5;
	SWEP.WepSelectIcon		= surface.GetTextureID( "vgui/entities/weapon_durgz" );
	SWEP.BounceWeaponIcon   = true;
	function SWEP:DrawHUD()
		local rand = math.random(0,2);
		local r,g,b
		r = 0;
		g = 0;
		b = 0;
		if(rand == 0)then
			r =  255;
		elseif(rand == 1)then
			g = 255;
		else
			b = 255;
		end
		surface.SetDrawColor(r,g,b,200)
		surface.DrawLine( ScrW()/2 - 10, ScrH()/2, ScrW()/2 + 10, ScrH()/2 )
		surface.DrawLine( ScrW()/2, ScrH()/2-10, ScrW()/2, ScrH()/2+10 )
		
		draw.DrawText(self:Drug(), "ScoreboardHead", ScrW()-10, 10, Color(255,255,255,255),TEXT_ALIGN_RIGHT) 
	end
end

SWEP.Category				= "Drugs";

SWEP.Spawnable				= true;
SWEP.AdminSpawnable			= true;

SWEP.ViewModel				= "models/weapons/v_models/v_syringegun_medic.mdl";
SWEP.WorldModel				= "models/weapons/w_models/w_syringegun.mdl";

SWEP.AutoSwitchTo			= false;
SWEP.AutoSwitchFrom			= false;

SWEP.Primary.ClipSize		= -1;
SWEP.Primary.DefaultClip	= -1;
SWEP.Primary.Automatic		= true;
SWEP.Primary.Ammo			= "none";
SWEP.Primary.DelayHoldDown	= 0.5;
SWEP.Primary.DelayManual	= 0.01;

SWEP.Secondary.ClipSize		= -1;
SWEP.Secondary.DefaultClip	= -1;
SWEP.Secondary.Automatic	= true;
SWEP.Secondary.Ammo			= "none";
SWEP.Secondary.DelayHoldDown = 1.2;
SWEP.Secondary.DelayManual	= 1.2;

SWEP.Primary.Released = true;
SWEP.Secondary.Released = true;

SWEP.Loaded = "";


local drugs = {};
drugs['durgz_heroine'] = true;
drugs['durgz_cocaine'] = true;
drugs['durgz_weed'] = true;
drugs['durgz_lsd'] = true;
drugs['durgz_mushroom'] = true;
drugs['durgz_cigarette'] = true;
drugs['durgz_water'] = true;
drugs['durgz_alcohol'] = true;
drugs['durgz_aspirin'] = true;
//???
drugs['durgz_pcp'] = true;
drugs['durgz_ecstasy'] = true;
drugs['durgz_meth'] = true;
drugs['durgz_caffeine'] = true;
drugs['durgz_opium'] = true;

function SWEP:Initialize()
	self:SetLastAttack1(0);
	self:SetLastAttack2(0);
	self:SetDrug("");
end




function SWEP:PrimaryAttack()
	if( self.Loaded == "" ) || self:LastAttack1() + self.Primary.DelayManual > CurTime() then return end
	
	local ent = self.Owner:GetEyeTrace().Entity;
	local pos = self.Owner:GetEyeTrace().HitPos;
	
	local shootit = true;
	
	if( self.Owner:EyePos():Distance(pos) < 150 )then
		if( drugs[ent:GetClass()] )then
			shootit = false;
			/*local drug = ents.Create(self.Loaded);
			drug:Spawn();
			drug:SetColor(0,0,0,255);
			drug:SetModel(ent:GetModel());
			constraint.NoCollide( drug, ent, 0, 0 )
			drug:SetPos(ent:GetPos());
			drug:SetAngles(ent:GetAngles());
			drug:SetParent(ent);*/
			table.insert(ent.LACED, self.Loaded);
		elseif( ent:IsPlayer() )then
			shootit = false;
			if( SERVER )then
				local drug = ents.Create(self.Loaded);
				drug:Spawn();
				drug:Use(ent,ent);
				drug:Remove();
			end
			local bullet = {}
				bullet.damage = 0;
				bullet.Num = 1;
				bullet.Src = self.Owner:GetShootPos();
				bullet.Dir = self.Owner:GetAimVector();
				bullet.Spread = Vector( 0, 0, 0 );
				bullet.Tracer = 0;
				bullet.Force = 1;
			self.Owner:FireBullets(bullet)
		end
	end
	
	if( shootit && SERVER )then
		local ent = ents.Create(self.Loaded)
			ent:SetPos (self.Owner:EyePos() + (self.Owner:GetAimVector() * 16));
			ent:SetAngles (self.Owner:EyeAngles());
		ent:Spawn();
			local phys = ent:GetPhysicsObject();
			local shot_length = self.Owner:GetEyeTrace().HitPos:Length();
			local normalized_aim = self.Owner:GetAimVector():GetNormalized();
		phys:ApplyForceCenter (normalized_aim * (shot_length^3) );

	end
	
	self.Weapon:EmitSound("weapons/syringegun_shoot.wav", 100, 100)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK);
	self.Loaded = "";
	self:SetDrug("");
	self:SetLastAttack1(CurTime());
	self:SetLastAttack2(CurTime() + self.Primary.DelayManual - self.Secondary.DelayManual );
	
end

function SWEP:SecondaryAttack()
	if( self:LastAttack2() + self.Secondary.DelayManual > CurTime() )then return end
	
	local doanim = false;
	local ent = self.Owner:GetEyeTrace().Entity;
	local pos = self.Owner:GetEyeTrace().HitPos;
	
	
	if( self.Loaded != "" )then
		if( SERVER )then
			local drug = ents.Create(self.Loaded);
			drug:SetPos( self.Owner:GetPos() + Vector(0,0,20) );
			drug:Spawn();
		end
		self.Loaded = "";
		self:SetDrug("");
		doanim = true;
	elseif( self.Owner:EyePos():Distance(pos) < 150 && ent && drugs[ent:GetClass()] )then
		if(ent:IsPlayer())then return; end
		self.Loaded = ent:GetClass();
		self:SetDrug(ent.PrintName);
		ent:Remove();
		doanim = true;
		
	end
	
	if( doanim )then
		local curtime = CurTime();
		self.Weapon:SendWeaponAnim(ACT_VM_RELOAD);
		self:SetLastAttack2(curtime);
		self:SetLastAttack1(curtime + self.Secondary.DelayManual - self.Primary.DelayManual );
	end
end


function SWEP:LastAttack1()
	return self:GetNetworkedFloat("weapon_durgz_lastattack1");
end
function SWEP:LastAttack2()
	return self:GetNetworkedFloat("weapon_durgz_lastattack2");
end
function SWEP:SetLastAttack1(set)
	self:SetNetworkedFloat("weapon_durgz_lastattack1", set);
end
function SWEP:SetLastAttack2(set)
	self:SetNetworkedFloat("weapon_durgz_lastattack2", set);
end
function SWEP:SetDrug(set)
	self:SetNetworkedString("weapon_durgz_drug", set);
end
function SWEP:Drug(set)
	return self:GetNetworkedString("weapon_durgz_drug");
end
