/*
Author: Fab

Description:
	given a string, try to find one of the known cursor types.

Parameter(s):
	0: String: cursor - string suspected of harboring a cursor type. E.g.: "CUP_gl_rifle"
	
Returns:
	String: extracted type
	
*/

private _weapon = param [0];
private _muzzle = param [1];

private _isMuzzle = (_weapon != _muzzle);

private _cursor = "";

if _isMuzzle then {

	_cursor = getText (configFile >> "CfgWeapons" >> _weapon >> _muzzle >> "cursor");
	
	if (_cursor == "EmptyCursor") then {
	
		_cursor = getText (configFile >> "CfgWeapons" >> _weapon >> _muzzle >> "cursoraim");
		
	};
	
} else {

	_cursor = getText (configFile >> "CfgWeapons" >> _weapon >> "cursor");
	
};

_cursor;