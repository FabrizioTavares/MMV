/*
Author: Fab

Description:
	attaches the "GetInMan" Event handler to a unit.
	this event handler is necessary to attach another event handler to the vehicle.
	units with this event handler will bless valid vehicles with unlimited ammo.

Parameter(s):
	0: Unit - Required. The unit to receive the event handler.
	
Note(s):
	We need to fairly remove the "Fired" event handler from a vehicle after leaving it. See "CanRemoveVehicleEH" function.
	Removing the event handler upon leaving is necessary to avoid unblessed units from taking advantage of blessed vehicles.
*/

private _infantry = param[0];

private _targetIndexIn = _infantry getVariable "mmvEHIndex_GetIn";
private _targetIndexOut = _infantry getVariable "mmvEHIndex_GetOut";
private _targetIndexDeath = _infantry getVariable "mmvEHIndex_Death";
private _potentialVehicle = objectParent _infantry;

if (!(isNil "_targetIndexIn") or !(isNil "_targetIndexOut") or !(isNil "_targetIndexDeath")) exitWith {
	if (FABHH_mmv_debugMessages) then {
		systemChat "[ i ] MMV (AttachEHUnit): Unit already has EHs - ignoring";
	};
};

//GetInMan
private _Index = _infantry addEventHandler ["GetInMan", {

	params ["_unit", "_role", "_vehicle", "_turret"];

	_vehicle spawn FABHH_fnc_infAmmoVeh_AttachEHVehicle;

}]; //end EH

_infantry setVariable ["mmvEHIndex_GetIn", _Index, true];


// GetOutMan
private _Index = _infantry addEventHandler ["GetOutMan", {

	params ["_unit", "_role", "_vehicle", "_turret"];
	
	_vehicle spawn FABHH_fnc_infAmmoVeh_DetachEHVehicle;


}]; //end EH

_infantry setVariable ["mmvEHIndex_GetOut", _Index, true];

private _Index = _infantry addEventHandler ["Killed", {

	params ["_unit", "_killer", "_instigator", "_useEffects"];
	
	if (!isNull (objectParent _unit)) then {
		objectParent _unit spawn FABHH_fnc_infAmmoVeh_DetachEHVehicle
	};
	
}];

_infantry setVariable ["mmvEHIndex_Death", _Index, true];

// If already in vehicle, try attaching
if (!(isNull _potentialVehicle)) then {
	_potentialVehicle spawn FABHH_fnc_infAmmoVeh_AttachEHVehicle;
};

if (FABHH_mmv_debugMessages) then {
	systemChat (format ["[ i ] MMV (AttachEHUnit): Added Event Handlers to %1", _infantry]);
};




