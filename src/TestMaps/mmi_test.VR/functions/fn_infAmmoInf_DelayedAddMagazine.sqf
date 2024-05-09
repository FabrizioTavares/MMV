/*
Author: Fab

Description:
	adds a new magazine to the unit with time to resupply depending on their weapon class.

Parameter(s):
	0: muzzle = muzzle of weapon
	1: weapon - weapon of the unit.
	2: unit - unit that fired the weapon.
	3: magazine - magazine to resupply the unit with.
	
*/

params ["_muzzle", "_weapon" , "_unit", "_magazine"];

private _weaponClass = [_weapon, _muzzle] call FABHH_fnc_infAmmoInf_GetWeaponType;
private _supplyTime = _weaponClass call FABHH_fnc_infAmmoInf_GetClassReloadTime;

if (FABHH_mmi_debugMessages) then {
	systemchat format["[ i ] MMI (AddMagazine): Class: %1, Time: %2", _weaponClass, _supplyTime];
};

if (_supplyTime == -1) exitWith {}; // Weapon class not found or weapon not allowed

sleep _supplyTime;

_unit addMagazine (_magazine);

if (!(_magazine in (magazines _unit))) then { // check if the magazine has been inserted

	_possibleVehicle = objectParent _unit;
	
	if (!(isNull _possibleVehicle)) then {
		_possibleVehicle addMagazineCargo [_magazine, 1];
	} else {
	
		_magGround = createVehicle ["GroundWeaponHolder", getPosATL _unit, [], 0,"CAN_COLLIDE"];
		_magGround addMagazineCargo [_magazine, 1];
		
	};
};

if (FABHH_mmi_PlaySound) then {
	playSound3D ["a3\sounds_f\sfx\ui\vehicles\vehicle_rearm.wss", _unit, false, getPosASL _unit, 5, 1, 5];
};

if ((_unit ammo _muzzle == 0) && !(isPlayer _unit)) then {

	/*
	condition 1: unit runs out of 30rd magazines (this function is now running and sleeping - no more same types of this magazine), switches to 100rd magazine.
	Unit does not finishes firing 100rd magazine, function calls for reload. stops firing 100 rnd mag to reload. bad.
	*/
	
	reload _unit;
	
};