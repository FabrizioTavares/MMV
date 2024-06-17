/*
Author: Fab

Description:
	Removes Magic Mag Vehicles' EH from a unit if conditions are right, removing the unit's ability to add "Fired" EH to a vehicle.

Parameter(s):
	0: Vehicle - Required. The vehicle to lose the event handler.

*/

private _infantry = param[0];

private _targetIndexIn = _infantry getVariable "mmvEHIndex_GetIn";
private _targetIndexOut = _infantry getVariable "mmvEHIndex_GetOut";
private _targetIndexDeath = _infantry getVariable "mmvEHIndex_Death";
private _potentialVehicle = objectParent _infantry;


if ((isNil "_targetIndexIn") and (isNil "_targetIndexOut")) exitWith {
	
	if (FABHH_mmv_debugMessages) then {
		systemChat "[ i ] MMV: Unit does not have Event Handlers - ignoring";
	};
	
};

if (FABHH_mmv_debugMessages) then {
	systemChat (format["[ i ] MMV: Removing Event Handlers from unit %1", _infantry]);
};

_infantry removeEventHandler["GetInMan", _targetIndexIn];
_infantry setVariable ["mmvEHIndex_GetIn", nil, true];

_infantry removeEventHandler["GetOutMan", _targetIndexOut];
_infantry setVariable ["mmvEHIndex_GetOut", nil, true];

_infantry removeEventHandler["Killed", _targetIndexOut];
_infantry setVariable ["mmvEHIndex_Death", nil, true];


/*
This checks if the unit is already in a vehicle.
given the opportunity, also remove the event handler from the vehicle too.
*/
if (!(isNull _potentialVehicle)) then {

	_potentialVehicle spawn FABHH_fnc_infAmmoVeh_DetachEHVehicle;

}