/*
Author: Fab

Description:
		attaches the "Fired" EH to a unit.
		
Parameter(s):
	0: unit - unit to be blessed with infinite ammo.
*/
	
private _infantry = param [0];


private _targetIndex = _infantry getVariable "mmiEHIndex";
	
if (!(isNil "_targetIndex")) exitWith {
		
	if (FABHH_mmi_debugMessages) then {
		systemChat "[i] Magic Mag: Unit already has EH";
	};
		
};

	
private _mmiIndex = _infantry addEventHandler ["Fired", {

	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
		
	if (((_unit ammo _muzzle) == 0) or {(_muzzle isKindOf ["ThrowMuzzle", configFile >> "CfgWeapons" >> _weapon])}) then {
	
		switch (FABHH_mmi_ModSetting) do {
		
			case 0: {
			
				if (not ((_magazine) in magazines _unit)) then { // only add if no more magazines of a kind found in unit's containers.

					[_muzzle, _weapon, _unit, _magazine] spawn FABHH_fnc_infAmmoInf_delayedAddMagazine;
			
				};
			
			};
			
			case 1: {

				[_muzzle, _weapon, _unit, _magazine] spawn FABHH_fnc_infAmmoInf_delayedAddMagazine;
			
			};
		
		};
	
	}; //end if
	
}]; //end EH


if (FABHH_mmi_debugMessages) then {
	systemChat format["[ i ] MMI (Attach): Attached Event Handler to %1 successfully.", _infantry];
};


_infantry setVariable ["mmiEHIndex", _mmiIndex, true];