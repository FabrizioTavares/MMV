/*
Author: Fab

Description:
	Checks if the "Fired" event handler can be fairly removed from a vehicle after stepping out.

Parameter(s):
	0: Vehicle - Required. The vehicle to lose the event handler.
	
Use case:
	Blufor soldier steps out of the tank, with two more blufor soldiers in it.
	GetOutMan event handler calls for removal of the vehicle's Fired event handler.
	The two other soldiers are cursed with limited ammo! This shouldn't happen.
	
	To see if the event handler can be fairly removed, check for the first occurrence of an allowed Side.
	Or, if not an AI side, a player. But, "FABHH_mmv_Players", which is the option to give players unlimited
	vehicle ammo, must also be true.
*/

private _vehicle = param[0];
private _targetIndex = _vehicle getVariable "mmvEHIndex";
private _canRemove = true;

if (isNil "_targetIndex") exitWith {
	if (FABHH_mmv_debugMessages) then {
		systemChat "[ i ] Magic Mag Vehicles (CanRemoveVehicleEH): No event handler in this vehicle to check for removal!";
		_canRemove = false;
		_canRemove;
	}
};

private _allowedVehicle = _vehicle call FABHH_fnc_infAmmoVeh_isVehicleAllowed;

if (!_allowedVehicle) exitWith{
	// this vehicle's class left the allowed vehicle classes, allow removal independent of crew.
	if (FABHH_mmv_debugMessages) then {
		systemChat "[ i ] Magic Mag Vehicles (CanRemoveVehicleEH): Unallowed vehicle has event handler. Allowing removal.";
	};
	_canRemove = true;
	_canRemove;
};

// Check if the ALLOWED vehicle is still in use by ALLOWED AI/players.
{
	if (str (side _x) in (FABHH_mmv_Sides) and !(isPlayer _x)) exitWith{
		if (FABHH_mmv_debugMessages) then {
			systemChat "[ i ] Magic Mag Vehicles (CanRemoveVehicleEH): Can't remove EH from vehicle due to allowed AI units inside";
		};
		_canRemove = false;
		_canRemove;
	};
	if ((isPlayer _x) and FABHH_mmv_Players) exitWith {
		if (FABHH_mmv_debugMessages) then {
			systemChat "[ i ] Magic Mag Vehicles (CanRemoveVehicleEH): Can't remove EH from vehicle due to allowed players inside";
		};
		_canRemove = false;
		_canRemove;
	};
	
} forEach crew _vehicle;

_canremove;

