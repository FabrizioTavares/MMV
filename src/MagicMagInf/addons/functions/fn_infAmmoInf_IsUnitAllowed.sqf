/*
Author: Fab

Description:
	Checks if a unit is allowed to receive the event handler.

Parameter(s):
	0: unit. The unit to check

Return:
	0: Bool. True if allowed, False if not allowed.
*/

private _unit = param[0];

private _allowed = false;

if ((str (side _unit) in FABHH_mmi_affectedSides) and !(isPlayer _unit)) exitWith { // for AI
	_allowed = true;
	_allowed;
};

if ((isPlayer _unit) and FABHH_mmi_Players) exitWith { // for players
	_allowed = true;
	_allowed;
};

_allowed;