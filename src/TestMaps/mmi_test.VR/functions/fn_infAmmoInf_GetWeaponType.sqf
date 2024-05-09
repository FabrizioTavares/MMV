/*
Author: Fab

Description:
	
Parameter(s):
	0: Weapon
	
Returns:
	String: Type
	
*/

private _weapon = toLower param [0];
private _muzzle = toLower param [1];

private _isMuzzle = (_weapon != _muzzle);

private _itemType = "";


// Attempt 1: Try to find weapon type from its class name

private _classList = ["arifle", "gl", "missile", "rocket", "srifle", "smg", "mg", "hgun", "sgun", "throw"];

{

    if (_x in _muzzle) exitWith {
        _itemType = _x;
    };
	
} forEach _classList;


// Attempt 2: Try to find weapon type from its cursor

if (_itemType == "") then {

	if _isMuzzle then {

		_itemType = getText (configFile >> "CfgWeapons" >> _weapon >> _muzzle >> "cursor");
		
		if (_itemType == "EmptyCursor") then {
		
			_itemType = getText (configFile >> "CfgWeapons" >> _weapon >> _muzzle >> "cursoraim");
			
		};
		
	} else {
		
		_itemType = getText (configFile >> "CfgWeapons" >> _weapon >> "cursor");
	
	};

};

toLower _itemType;