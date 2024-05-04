/*
Author: Fab

Description:
	Removes Magic Mag Vehicles' EH from a vehicle if conditions are right, cursing the vehicle with limited ammo.

Parameter(s):
	0: Vehicle - Required. The vehicle to lose the event handler.
*/

private _vehicle = param[0];

private _canRemove = _vehicle call FABHH_fnc_infAmmoVeh_CanRemoveVehicleEH;

if (! _canRemove) exitWith{
	if (FABHH_mmv_debugMessages) then {
		systemChat (format ["[ i ] Magic Mag Vehicles (DetachEHVehicle): Fail, see above. Vehicle: vehicle %1", _vehicle]);
	};
};

private _targetIndex = _vehicle getVariable "mmvEHIndex";

_vehicle removeEventHandler["Fired", _targetIndex];
_vehicle setVariable ["mmvEHIndex", nil, true];

if (FABHH_mmv_debugMessages) then {
	systemChat (format ["[ i ] Magic Mag Vehicles (DetachEHVehicle): Removed Event Handler from vehicle %1 succesfully", _vehicle]);
};

