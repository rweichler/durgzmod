local function AddSIcon(materials)
	for k,v in pairs(materials)do
		resource.AddFile("materials/vgui/entities/"..v..".vmt";
		resource.AddFile("materials/vgui/entities/"..v..".vtf";
	end
end

local function r(materials, models)
	if(materials)then
		for k,v in pairs(materials)do
			resource.AddFile("materials/"..v);
		end
	end
	if(models)then
		for k,v in pairs(models)do
			resource.AddFile("models/"..v);
		end
	end
end

local function syringeMats(mats, ins)
	local gh = "in";
	if(!ins)then
		gh = "out";
	end
	for k,v in pairs(mats)do
		resource.AddFile("materials/katharsmodels/syringe_"..gh.."/syringe_"..v);
	end
end

syringeMats(
	{
		"body.vmt",
		"grip.vmt",
		"liquid.vmt",
		"lowerstopper.vmt",
		"needle.vmt",
		"stopper.vmt",
		"tip.vmt"
	},
	true
)

syringeMats(
	{
		"body.vmt",
		"grip.vmt",
		"liquid.vmt",
		"lowerstopper.vmt",
		"needle.vmt",
		"stopper.vmt",
		"tip.vmt"
		
		"body.vtf",
		"body_mask.vtf",
		"grip.vtf",
		"liquid.vtf",
		"lowerstopper.vtf",
		"needle.vtf",
		"stopper.vtf",
		"tip.vtf"
	},
	false
)

r(
	{
		"katharsmodels/contraband/contraband_normal.vtf",
		"katharsmodels/contraband/contraband_one.vmt",
		"katharsmodels/contraband/contraband_one.vtf",
		"katharsmodels/contraband/contraband_two.vmt",
		"ipha/mushd.vmt",
		"ipha/mushd.vtf",
		"models/drug/drug.vmt",
		"models/drug/drug.vtf",
		"models/druggg_mod/PopCan01a.vmt",
		"models/druggg_mod/PopCan01a.vtf",
		"jaanus/aspbtl_a.vmt",
		"jaanus/aspbtl_a.vtf",
		"jaanus/aspirin_.vtf",
		"jaanus/aspirin_.vmt"
	},
	
	{
		"cocn.mdl",
		"ipha/mushroom_small.mdl",
		"drug_mod/alcohol_can.mdl",
		"weed/zak_wiet.mdl",
		"katharsmodels/contraband/zak_wiet/zak_wiet.mdl",
		"katharsmodels/syringe_in/syringe_in.mdl",
		"katharsmodels/syringe_out/syringe_out.mdl",
		"models/jaanus/aspbtl.mdl"



)

local function addShib(mat, modl)
	for k,v in pairs(mat)do
		resource.AddFile("materials/models/shibboro/"..v..".vmt"
		resource.AddFile("materials/models/shibboro/"..v..".vtf"
	end
	
	for k,v in pairs(modl)do
		resource.AddFile("models/"..modl..".mdl";
	end

end

addShib(
	{
		"cigsshib",
		"closedboxshib",
		"emptyboxshib",
		"opennoshib",
		"openyesshib"
	},
	
	{
		"boxopencigshib",
		"emptyboxshib",
		"oldcigshib",
		"closedboxshib",
		"phycignew",
		"phycigold",
		"pissedmeoff",
		"phycignew",
		"phycignew"
	}
);