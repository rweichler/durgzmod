ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Essence of drugs"
ENT.Nicknames = {"the essence of drugs"}
ENT.OverdosePhrase = {"took"}
ENT.Author = "cheesylard"
ENT.Category = "Drugs"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Information	 = "" 

ENT.TRANSITION_TIME = 0

if(CLIENT)then
	function ENT:Initialize()
	end


	function ENT:Draw()
		self:DrawModel()
	end

end
