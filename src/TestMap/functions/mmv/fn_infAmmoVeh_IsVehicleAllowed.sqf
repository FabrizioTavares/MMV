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

private _class = typeOf _vehicle;
private _isAllowed = false;

_category = getText (configFile >> "CfgVehicles" >> _class >> "editorSubcategory");

{
	if(_x in _category) exitWith{
		_isAllowed = true;
	}
} forEach FABHH_mmv_AllowedVehicleClasses;

_isAllowed;