/*
Author: Fab

Description:
	Determines if a vehicle can receive the event handler

Parameter(s):
	0: Vehicle - Required. The vehicle that shall be judged.
	
Returns(s):
	True - Vehicle class is can receive event handler
	False - Vehicle class is can not receive event handler
	
Condition(s):
	Vehicle must not already have Event Handler.
	Vehicle must be in Allowed via the AllowedVehicleClasses array.
*/

private _vehicle = param[0];
private _canAttach = false;

private _targetIndex = _vehicle getVariable "mmvEHIndex";

if (!(isNil "_targetIndex")) exitWith {
	if (FABHH_mmv_debugMessages) then {
		systemChat "[ i ] Magic Mag Vehicles (CanAttachVehicleEH): Vehicle already has Event Handler.";
	};
	_canAttach;
};

private _isAllowed = _vehicle call FABHH_fnc_infAmmoVeh_isVehicleAllowed;

if (! _isAllowed) exitWith {
	if (FABHH_mmv_debugMessages) then {
		private _editorclass = getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "editorSubcategory");
		systemChat format["[ i ] Magic Mag Vehicles (CanAttachVehicleEH): Vehicle class not allowed: %1", _editorclass];
	};
	_canAttach;
};

_canAttach = true;
_canAttach;