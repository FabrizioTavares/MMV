if (!isServer) exitWith {};

FABHH_mmv_Sides = [];
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
    ["Magic Mag - Vehicles", "0. Mod Setting"],
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
    ["Players", "Includes player from all sides."],
    ["Magic Mag - Vehicles", "1. Apply to"],
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
    ["Magic Mag - Vehicles", "1. Apply to"],
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
    ["Magic Mag - Vehicles", "1. Apply to"],
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
    ["Magic Mag - Vehicles", "1. Apply to"],
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
    ["Magic Mag - Vehicles", "1. Apply to"],
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
    ["Magic Mag - Vehicles", "2. Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["car"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["car"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_land_APCs",
    "CHECKBOX",
    ["Land - APCs", "Includes tracked and unarmed APCs and IFVs, be those tracked or wheeled."],
    ["Magic Mag - Vehicles", "2. Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["apc"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["apc"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_land_Tanks",
    "CHECKBOX",
    ["Land - Tanks", "Includes Wheeled or tracked tanks."],
    ["Magic Mag - Vehicles", "2. Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["tank"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["tank"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_land_Artillery",
    "CHECKBOX",
    ["Land - Artillery", "Includes artillery, self propelled: 120mm, MLRS, and everything inbetween."],
    ["Magic Mag - Vehicles", "2. Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["artillery"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["artillery"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_land_AAs",
    "CHECKBOX",
    ["Land - Anti-Air", "Includes mobile anti-air artillery"],
    ["Magic Mag - Vehicles", "2. Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["aa"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["aa"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_air_Helicopters",
    "CHECKBOX",
    ["Air - Helicopters", "Includes helicopters in general. VTOLs are not helicopters!"],
    ["Magic Mag - Vehicles", "2. Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["helicopter"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["helicopter"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_air_Planes",
    "CHECKBOX",
    ["Air - Planes", "Includes planes such as jet fighters and VTOLs, even if they look like helicopters..."],
    ["Magic Mag - Vehicles", "2. Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["plane"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["plane"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_sea_Boats",
    "CHECKBOX",
    ["Sea - Boats", "Includes fast attack craft by default. Static ships with turrets NOT affected!"],
    ["Magic Mag - Vehicles", "2. Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["boat"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["boat"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_sea_Submersibles",
    "CHECKBOX",
    ["Sea - Submersibles", "Includes submersibles, such as the SDV."],
    ["Magic Mag - Vehicles", "2. Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["submersible"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["submersible"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_misc_Turrets",
    "CHECKBOX",
    ["Misc - Turrets", "Includes deployable and static turrets suchs as GMGs, HMGs, Mortars. Also included: Radars, Anti Air Batteries, etc"],
    ["Magic Mag - Vehicles", "2. Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["turret"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["turret"];
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_misc_Drones",
    "CHECKBOX",
    ["Misc - Drones", "Includes drones of all kinds, from the smallest to the biggest."],
    ["Magic Mag - Vehicles", "2. Vehicle Classes"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmv_AllowedVehicleClasses append ["drone"];
		} else {
			FABHH_mmv_AllowedVehicleClasses = FABHH_mmv_AllowedVehicleClasses - ["drone"];
		};
		
	}
] call CBA_fnc_addSetting;

//
// Dynamic Loadouts - Cooldown Multipliers
//

[
    "FABHH_mmv_DLReloadMultiplier",
    "SLIDER",
    ["Pylon Multiplier", "Multiplies the 'reloadTime' CfgWeapon value by this number. use this to stop pylons from reloading instantly on Dynamic Loadout Vehicles. Default value recommended."],
    ["Magic Mag - Vehicles", "3. Dynamic Loadouts"],
    [1, 1000, 100, 0],
    true
] call CBA_fnc_addSetting;

//
// MISC
//

[
    "FABHH_mmv_debugMessages",
    "CHECKBOX",
    ["Debug Messages", "Enable this if you're filling a bug report or need help."],
    ["Magic Mag - Vehicles", "4. Misc"],
    [false]
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_bypassClasses",
    "CHECKBOX",
    ["Allow All Vehicles", "If enabled, all and any vehicles will be enabled regardless of class or category. Useful if you have many mods. Use with caution."],
    ["Magic Mag - Vehicles", "4. Misc"],
    [false]
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_useCompatibility",
    "CHECKBOX",
    ["Compatibility - Toggle", "If enabled, the categories in 'Extra Compatibility' will be enabled and used."],
    ["Magic Mag - Vehicles", "4. Misc"],
    [true]
] call CBA_fnc_addSetting;

[
    "FABHH_mmv_compatibility",
    "EDITBOX",
    ["Compatibility - Categories", "Fill this box with the 'editorSubCategory' of your vehicle. eg: 'alienmod_flyingsaucers'. Enable 'Debug Messages' and enter the vehicle to discover its category."],
    ["Magic Mag - Vehicles", "4. Misc"],
    [""],
	true,
	{
		FABHH_mmv_compatibility = toLower FABHH_mmv_compatibility splitString ", ";
	}
] call CBA_fnc_addSetting;

