if (!(isServer)) exitWith {};

FABHH_mmi_affectedSides = [];

/*
Notes:

The script on the settings runs every respective change and at mission start and LOAD.
*/

[
    "FABHH_mmi_ApplyNewUnits",
    "CHECKBOX",
    ["Apply to new groups", "Apply to new units created after mission start (Scripts, Zeus). Recommended ON."],
    ["Magic Mag - Infantry", "0. Mod Setting"],
    [true],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_ModSetting",
    "LIST",
    ["Mod behavior", "'No Magazines Left': Resupply after having no more magazines of a kind. 'On Magazine Spent': Resupply after spending a magazine."],
    ["Magic Mag - Infantry", "0. Mod Setting"],
    [[0, 1], ["No Magazines Left","On Magazine Spent"], 0],
    true
] call CBA_fnc_addSetting;

//
// APPLY TO
//

[
    "FABHH_mmi_Players",
    "CHECKBOX",
    ["Players", "All players, independent on side."],
    ["Magic Mag - Infantry", "1. Apply to"],
    [true],
    true,
	{

		params["_value"];
		
		if (_value) then {
			{
				[_x] call FABHH_fnc_infAmmoInf_AttachEH;
			} forEach (call BIS_fnc_listPlayers)
		} else {
			{
				[_x] call FABHH_fnc_infAmmoInf_DetachEH;
			} forEach (call BIS_fnc_listPlayers)
		};
		
	}
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_BLUFORAI",
    "CHECKBOX",
    ["BLUFOR AI", "BLUFOR, includes NATO, peacekeeping forces, etc."],
    ["Magic Mag - Infantry", "1. Apply to"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmi_affectedSides append ["WEST"];
			{
				[_x] call FABHH_fnc_infAmmoInf_AttachEH;
			} forEach (units west - (call BIS_fnc_listPlayers));
		} else {
			FABHH_mmi_affectedSides = FABHH_mmi_affectedSides - ["WEST"];
			{
				[_x] call FABHH_fnc_infAmmoInf_DetachEH;
			} forEach (units west - (call BIS_fnc_listPlayers));
		};
		
	} // Refresh list of sides
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_OPFORAI",
    "CHECKBOX",
    ["OPFOR AI", "OPFOR, mainly CSAT."],
    ["Magic Mag - Infantry", "1. Apply to"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmi_affectedSides append ["EAST"];
			{
				[_x] call FABHH_fnc_infAmmoInf_AttachEH;
			} forEach (units east - (call BIS_fnc_listPlayers));
		} else {
			FABHH_mmi_affectedSides = FABHH_mmi_affectedSides - ["EAST"];
			{
				[_x] call FABHH_fnc_infAmmoInf_DetachEH;
			} forEach (units east - (call BIS_fnc_listPlayers));
		};
		
	} // Refresh list of sides
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_INDFORAI",
    "CHECKBOX",
    ["INDFOR AI", "Independent units, local military, insurgents and guerrilas."],
    ["Magic Mag - Infantry", "1. Apply to"],
    [true],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmi_affectedSides append ["GUER"];
			{
				[_x] call FABHH_fnc_infAmmoInf_AttachEH;
			} forEach (units independent - (call BIS_fnc_listPlayers));
		} else {
			FABHH_mmi_affectedSides = FABHH_mmi_affectedSides - ["GUER"];
			{
				[_x] call FABHH_fnc_infAmmoInf_DetachEH;
			} forEach (units independent - (call BIS_fnc_listPlayers));
		};
		
	} // Refresh list of sides
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_CIVAI",
    "CHECKBOX",
    ["CIV AI", "Gives civilians unlimited ammo. The terror of any government!"],
    ["Magic Mag - Infantry", "1. Apply to"],
    [false],
    true,
	{
		params["_value"];
		
		if (_value) then {
			FABHH_mmi_affectedSides append ["CIV"];
			{
				[_x] call FABHH_fnc_infAmmoInf_AttachEH;
			} forEach (units civilian - (call BIS_fnc_listPlayers));
		} else {
			FABHH_mmi_affectedSides = FABHH_mmi_affectedSides - ["CIV"];
			{
				[_x] call FABHH_fnc_infAmmoInf_DetachEH;
			} forEach (units civilian - (call BIS_fnc_listPlayers));
		};
		
	} // Refresh list of sides
] call CBA_fnc_addSetting;

//
// ALLOWED WEAPON CLASSES
//

[
    "FABHH_mmi_reloadAssaultRifle",
    "CHECKBOX",
    ["Assault Rifles", "Automatic rifles, Service rifles. Warning: This value will be used as 'Default' value."],
    ["Magic Mag - Infantry", "2. Allowed weapons"],
    [true],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_reloadLMG",
    "CHECKBOX",
    ["Machineguns", "Squad automatic weapons, light and medium machineguns."],
    ["Magic Mag - Infantry", "2. Allowed weapons"],
    [true],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_reloadSniper",
    "CHECKBOX",
    ["Snipers", "Snipers, anti-materiel rifles, DMRs."],
    ["Magic Mag - Infantry", "2. Allowed weapons"],
    [true],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_reloadSMG",
    "CHECKBOX",
    ["SMGs", "PDWs, SMGs of various calibers. Can also include some full auto pistols."],
    ["Magic Mag - Infantry", "2. Allowed weapons"],
    [true],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_reloadGL",
    "CHECKBOX",
    ["Grenade Launchers", "Underbarrel grenade launchers or standalone grenade launchers."],
    ["Magic Mag - Infantry", "2. Allowed weapons"],
    [true],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_reloadLauncher",
    "CHECKBOX",
    ["Rocket Launchers", "Unguided rocket launchers or 'basic' guided launchers such as the PCML."],
    ["Magic Mag - Infantry", "2. Allowed weapons"],
    [true],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_reloadMissile",
    "CHECKBOX",
    ["Advanced Launchers", "Advanced fire-and-forget launchers such as the Titan."],
    ["Magic Mag - Infantry", "2. Allowed weapons"],
    [true],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_reloadHandgrenade",
    "CHECKBOX",
    ["Hand grenades", "Hand thrown hand grenades, flares, smokes, etc."],
    ["Magic Mag - Infantry", "2. Allowed weapons"],
    [true],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_reloadHandgun",
    "CHECKBOX",
    ["Handguns", "Pistols and revolvers, also can include small SMGs and autopistols."],
    ["Magic Mag - Infantry", "2. Allowed weapons"],
    [true],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_reloadShotgun",
    "CHECKBOX",
    ["Shotguns", "Pump and automatic shotguns, also includes underbarrel shotguns."],
    ["Magic Mag - Infantry", "2. Allowed weapons"],
    [true],
    true
] call CBA_fnc_addSetting;

//
// COOLDOWNS
//

[
    "FABHH_mmi_AssaultRifleReloadTime",
    "SLIDER",
    ["Assault Rifles [Default]", "This reload value will be used for unknown weapons!"],
    ["Magic Mag - Infantry", "3. Cooldowns (seconds)"],
    [0, 300, 30, 0],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_LMGReloadTime",
    "SLIDER",
    "LMGs",
    ["Magic Mag - Infantry", "3. Cooldowns (seconds)"],
    [0, 300, 45, 0],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_SniperReloadTime",
    "SLIDER",
    "Snipers/DMRs",
    ["Magic Mag - Infantry", "3. Cooldowns (seconds)"],
    [0, 300, 45, 0],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_SMGReloadTime",
    "SLIDER",
    "SMGs",
    ["Magic Mag - Infantry", "3. Cooldowns (seconds)"],
    [0, 300, 30, 0],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_GLReloadTime",
    "SLIDER",
    ["Grenade Launchers", "Includes standalone and underbarrel grenade launchers."],
    ["Magic Mag - Infantry", "3. Cooldowns (seconds)"],
    [0, 300, 30, 0],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_LauncherReloadTime",
    "SLIDER",
    ["RPGs, Basic Launchers", "Includes unguided rocket launchers and some mouse guided launchers"],
    ["Magic Mag - Infantry", "3. Cooldowns (seconds)"],
    [0, 300, 60, 0],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_MissileReloadTime",
    "SLIDER",
    ["Advanced Launchers", "Includes most if not all fire-and-forget launchers."],
    ["Magic Mag - Infantry", "3. Cooldowns (seconds)"],
    [0, 300, 120, 0],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_GrenadeReloadTime",
    "SLIDER",
    "Hand Grenades",
    ["Magic Mag - Infantry", "3. Cooldowns (seconds)"],
    [0, 300, 30, 0],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_HandgunReloadTime",
    "SLIDER",
    "Handguns",
    ["Magic Mag - Infantry", "3. Cooldowns (seconds)"],
    [0, 300, 10, 0],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_ShotgunReloadTime",
    "SLIDER",
    "Shotguns",
    ["Magic Mag - Infantry", "3. Cooldowns (seconds)"],
    [0, 300, 30, 0],
    true
] call CBA_fnc_addSetting;



//
// MISC
//

[
    "FABHH_mmi_PlaySound",
    "CHECKBOX",
    "Play sound on resupply",
    ["Magic Mag - Infantry", "4. Misc"],
    [true],
    true
] call CBA_fnc_addSetting;

[
    "FABHH_mmi_debugMessages",
    "CHECKBOX",
    "Debug Messages",
    ["Magic Mag - Infantry", "4. Misc"],
    [false]
] call CBA_fnc_addSetting;
