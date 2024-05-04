systemChat "Init";

//[player] spawn FABHH_fnc_infAmmoVeh_AttachEHUnit;

FABHH_mmv_Sides = [];
FABHH_mmv_StartUpUnits = [];
FABHH_mmv_AllowedVehicleClasses = [];

/*
Driveable Vehicle/Emplacement types (isKindOf):

Static Emplacements:
	EdSubCat_Turrets

Vehicular:
	Land:
		EdSubCat_Artillery
		EdSubCat_AAs
		EdSubCat_Tanks
		EdSubCat_APCs
		EdSubCat_Cars
	Air:
		EdSubCat_Helicopters
		EdSubCat_Planes
	Sea:
		EdSubCat_Submersibles
		EdSubCat_Boats
	Drones:
		EdSubCat_Drones
		
Notes:

The script(s) on the settings runs every respective change and at mission start and LOAD.

Possible improments: Replace Side with Faction.

*/

[
    "FABHH_mmv_ApplyNewUnits",
    "CHECKBOX",
    ["Apply to new units", "Apply to units created after mission start (Scripts, Zeus), recommended ON."],
    "Magic Mag - Vehicles",
    [true],
    true,
	{}
] call CBA_fnc_addSetting;

//
// APPLY TO
//

[
    "FABHH_mmv_Players",
    "CHECKBOX",
    ["Players", "Has immediate effect."],
    ["Magic Mag - Vehicles", "Apply to"],
    [true],
    true,
	{
	
		params["_value"];
		
		private _allPlayers = call BIS_fnc_listPlayers;
		if (_value) then {
			{
				[_x] call FABHH_fnc_infAmmoVeh_AttachEHUnit;
			} forEach (_allPlayers);
		} else {
			{
				[_x] call FABHH_fnc_infAmmoVeh_DetachEHUnit;
			} forEach (_allPlayers);
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_BLUFORAI",
    "CHECKBOX",
    ["BLUFOR AI", "Effects units on mission start and new AI units if Apply New Groups is enabled"],
    ["Magic Mag - Vehicles", "Apply to"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_Sides append ["WEST"];
			{
				[_x] call FABHH_fnc_infAmmoVeh_AttachEHUnit;
			} forEach (units west - (call BIS_fnc_listPlayers));
		} else {
			FABHH_mmv_Sides = FABHH_mmv_Sides - ["WEST"];
			{
				[_x] call FABHH_fnc_infAmmoVeh_DetachEHUnit;
			} forEach (units west - (call BIS_fnc_listPlayers));
		};
		
	} // Refresh list of sides
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_OPFORAI",
    "CHECKBOX",
    ["OPFOR AI", "Effects units on mission start and new AI units if Apply New Groups is enabled"],
    ["Magic Mag - Vehicles", "Apply to"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_Sides append ["EAST"];
			{
				[_x] call FABHH_fnc_infAmmoVeh_AttachEHUnit;
			} forEach (units east - (call BIS_fnc_listPlayers));
		} else {
			FABHH_mmv_Sides = FABHH_mmv_Sides - ["EAST"];
			{
				[_x] call FABHH_fnc_infAmmoVeh_DetachEHUnit;
			} forEach (units east - (call BIS_fnc_listPlayers));
		};
		
	} // Refresh list of sides
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_INDFORAI",
    "CHECKBOX",
    ["INDFOR AI", "Effects units on mission start and new AI units if Apply New Groups is enabled"],
    ["Magic Mag - Vehicles", "Apply to"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_Sides append ["GUER"];
			{
				[_x] call FABHH_fnc_infAmmoVeh_AttachEHUnit;
			} forEach (units independent - (call BIS_fnc_listPlayers));
		} else {
			FABHH_mmv_Sides = FABHH_mmv_Sides - ["GUER"];
			{
				[_x] call FABHH_fnc_infAmmoVeh_DetachEHUnit;
			} forEach (units independent - (call BIS_fnc_listPlayers));
		};
		
	} // Refresh list of sides
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_CIVAI",
    "CHECKBOX",
    ["CIV AI", "Civilians with unlimited ammo?!"],
    ["Magic Mag - Vehicles", "Apply to"],
    [false],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_Sides append ["CIV"];
			{
				[_x] call FABHH_fnc_infAmmoVeh_AttachEHUnit;
			} forEach (units civilian - (call BIS_fnc_listPlayers));
		} else {
			FABHH_mmv_Sides = FABHH_mmv_Sides - ["CIV"];
			{
				[_x] call FABHH_fnc_infAmmoVeh_DetachEHUnit;
			} forEach (units civilian - (call BIS_fnc_listPlayers));
		};
		
	} // Refresh list of sides
] call CBA_fnc_addSetting;

//
// Vehicle categories
//

[
    "FABHH_mmv_land_Cars",
    "CHECKBOX",
    ["Land - Cars", "Includes unarmed and armed cars, trucks, MRAPS."],
    ["Magic Mag - Vehicles", "Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["Car"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["Car"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_land_APCs",
    "CHECKBOX",
    ["Land - APCs", "Includes tracked and unarmed APCs and IFVs, be those tracked or wheeled."],
    ["Magic Mag - Vehicles", "Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["APC"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["APC"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_land_Tanks",
    "CHECKBOX",
    ["Land - Tanks", "Includes Wheeled or tracked tanks."],
    ["Magic Mag - Vehicles", "Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["Tank"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["Tank"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_land_Artillery",
    "CHECKBOX",
    ["Land - Artillery", "Includes artillery, self propelled: 120mm, MLRS, and everything inbetween."],
    ["Magic Mag - Vehicles", "Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["Artillery"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["Artillery"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_land_AAs",
    "CHECKBOX",
    ["Land - Anti-Air", "Includes mobile anti-air artillery"],
    ["Magic Mag - Vehicles", "Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["AA"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["AA"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_air_Helicopters",
    "CHECKBOX",
    ["Air - Helicopters", "Includes helicopters in general. VTOLs are not helicopters!"],
    ["Magic Mag - Vehicles", "Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["Helicopter"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["Helicopter"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_air_Planes",
    "CHECKBOX",
    ["Air - Planes", "Includes planes such as jet fighters and VTOLs, even if they look like helicopters..."],
    ["Magic Mag - Vehicles", "Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["Plane"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["Plane"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_sea_Boats",
    "CHECKBOX",
    ["Sea - Boats", "Includes fast attack craft by default. Static ships with turrets NOT affected!"],
    ["Magic Mag - Vehicles", "Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["Boat"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["Boat"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_sea_Submersibles",
    "CHECKBOX",
    ["Sea - Submersibles", "Includes submersibles, such as the SDV."],
    ["Magic Mag - Vehicles", "Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["Submersible"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["Submersible"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_misc_Turrets",
    "CHECKBOX",
    ["Misc - Turrets", "Includes deployable and static turrets suchs as GMGs, HMGs, Mortars. Also included: Radars, Anti Air Batteries, etc"],
    ["Magic Mag - Vehicles", "Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["Turret"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["Turret"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_misc_Drones",
    "CHECKBOX",
    ["Misc - Drones", "Includes drones of all kinds, from the smallest to the biggest."],
    ["Magic Mag - Vehicles", "Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["Drone"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["Drone"];
		};
		
	}
] call CBA_fnc_addSetting;

//
// Dynamic Loadouts - Cooldown Multipliers
//

[
    "FABHH_mmv_DLReloadMultiplier",
    "SLIDER",
    ["Weapon Reload Multiplier", "Multiplies the 'reloadTime' CfgWeapon value by this number. use this to stop weapons from reloading instantly on Dynamic Loadout Vehicles."],
    ["Magic Mag - Vehicles", "Dynamic Loadouts - Cooldowns"],
    [1, 1000, 100, 0],
    true
] call CBA_fnc_addSetting;

//
// MISC
//

[
    "FABHH_mmv_debugMessages",
    "CHECKBOX",
    ["Debug Messages", "Enable this if you're filling a bug report."],
    ["Magic Mag - Vehicles", "Misc"],
    [false]
] call CBA_fnc_addSetting;

