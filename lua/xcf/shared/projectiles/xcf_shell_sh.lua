


// This is the classname of this type in the shared state.  Make sure the name matches in the client and server files, and is unique.
local classname = "Shell"



if !XCF then error("XCF table not initialized yet!\n") end
XCF.ProjClasses = XCF.ProjClasses or {}
local projcs = XCF.ProjClasses

projcs[classname] = projcs[classname] and projcs[classname].super and projcs[classname] or XCF.inheritsFrom(projcs.Base)
local this = projcs[classname]

local balls = XCF.Ballistics or error("XCF: Ballistics hasn't been loaded yet!")



/**
	Reduce a full bulletinfo table to the minimum data set required to reconstruct that bulletinfo.
	Useful for net transportation, serialization etc
//*/
function this.GetCompact(bullet)
	return
	{
		["Id"] 		= bullet.Id,
		["Type"] 	= bullet.Type,
		["PropLength"]	= bullet.PropLength,
		["ProjLength"]	= bullet.ProjLength,
		["FillerVol"]	= bullet.FillerVol,
		["ConeAng"]		= bullet.ConeAng,
		["Tracer"]		= bullet.Tracer,
		
		["Pos"]			= bullet.Pos,
		["Flight"]		= bullet.Flight,
		
		["ProjClass"]	= "Shell"
	}
end


/*
	
//*/
function this.GetExpanded(bullet)

	local input = {}
	local input2 = bullet
		input["Id"] = 			input2["Id"] or "12.7mmMG"
		input["Type"] = 		input2["Type"] or "AP"
		input["PropLength"] = 	input2["PropLength"] or 0
		input["ProjLength"] = 	input2["ProjLength"] or 0
		input["Data5"] = 		input2["FillerVol"] or 0
		input["Data6"] = 		input2["ConeAng"] or 0
		input["Data7"] = 		0
		input["Data8"] = 		0
		input["Data9"] = 		0
		input["Data10"] = 		input2["Tracer"] or 0
	local conversion = ACF.RoundTypes[input.Type].convert
	
	if not conversion then return nil end
	local ret = conversion( nil, input )
	ret.ProjClass = this
	
	return ret

end
