/*
Author: Fab

Description:
	Judges if the vehicle class is in the list of allowed classes

Parameter(s):
	0: Vehicle - Required. The vehicle that shall be judged.
	
Returns(s):
	True - Vehicle class is allowed
	False - Vehicle class is not allowed
*/

private _vehicle = param[0];
private _isAllowed = false;

if (FABHH_mmv_bypassClasses) exitWith {
	_isAllowed = true;
	_isAllowed
};

private _class = typeOf _vehicle;

_category = toLower (getText (configFile >> "CfgVehicles" >> _class >> "editorSubcategory"));

_isAllowed = FABHH_mmv_AllowedVehicleClasses findIf {_x in _category} != -1;

if (_isAllowed) exitWith {_isAllowed;};

if ((FABHH_mmv_useCompatibility) and {(_category in FABHH_mmv_compatibility)}) then {
	_isAllowed = true;
};

_isAllowed;