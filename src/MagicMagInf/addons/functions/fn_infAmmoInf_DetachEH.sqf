/*
Author: Fab

Description:
	Removes Magic Mag Infantry' EH from a unit.

Parameter(s):
	0: unit - Required. The unit to lose the event handler.

*/

private _infantry = param[0];

private _targetIndex = _infantry getVariable "mmiEHIndex";


if (isNil "_targetIndex") exitWith {
	
	if (FABHH_mmi_debugMessages) then {
		systemChat "[ i ] MMI: Unit does not have Event Handlers - ignoring";
	};
	
};

_infantry removeEventHandler["Fired", _targetIndex];
_infantry setVariable ["mmiEHIndex", nil, true];

if (FABHH_mmi_debugMessages) then {
	systemChat (format["[ i ] MMI (Detach): Removed Event Handlers from unit %1", _infantry]);
};