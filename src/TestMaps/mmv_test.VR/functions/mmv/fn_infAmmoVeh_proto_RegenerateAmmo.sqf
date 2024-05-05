private _vehicle = cursorObject;
private _a = 0;

while {alive _vehicle} do {
	sleep 5;
	_a = _vehicle ammo currentMuzzle gunner _vehicle;
	_vehicle setAmmo [currentMuzzle gunner _vehicle, _a+1];
};