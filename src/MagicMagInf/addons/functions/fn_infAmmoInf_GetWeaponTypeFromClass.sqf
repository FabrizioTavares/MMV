/*
Author: Fab

Description:
	given a string, try to find a match in the known classes.

Parameter(s):
	0: weapon - string suspected of harboring a cursor type. E.g.: "CUP_gl_rifle"
	
Returns:
	String: extracted type
	
*/

private _weapon = param[0];
_weapon = toLower _weapon;

private _extraction = "";

private _classList = ["arifle", "gl", "missile", "rocket", "srifle", "smg", "mg", "hgun", "sgun"];

{

    if (_x in _weapon) exitWith {
        _extraction = _x;
    };
	
} forEach _classList;

_extraction;