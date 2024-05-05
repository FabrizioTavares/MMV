/*
Author: Fab

Description:
	Determines if a vehicle uses dynamic loadouts.

Parameter(s):
	0: Vehicle - Required.
*/

private _judgedVehicle = param[0];

private _isDynamicLoadout = isClass(configOf _judgedVehicle >> "Components" >> "TransportPylonsComponent");

_isDynamicLoadout;