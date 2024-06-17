/*
Author: Fab

Description:
	Adds ammo to a pylon, but with a delay

Parameter(s):
	0: Vehicle - Required. Vehicle with pylons
	1: PylonIndex - Required. Pylon to rearm
	2: Delay (seconds) - Required.
*/

private _vehicle = param[0];
private _pylonIndex = param[1];
private _delay = param[2];

_vehicle setVariable ["mmvBusyPylons", ((_vehicle getVariable "mmvBusyPylons") + [_pylonIndex])];

sleep _delay;

_vehicle setVariable ["mmvBusyPylons", ((_vehicle getVariable "mmvBusyPylons") - [_pylonIndex])];

if (_vehicle ammoOnPylon _pylonIndex == 0) then { // vehicle could have resupplied in the meanwhile
	_vehicle setAmmoOnPylon [_pylonIndex, 9000]; // pylon indexes start at 1
}
	