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

_isAllowed = FABHH_mmv_AllowedVehicleClasses findIf {_x in _category} != -1;

_displayName = getText (configFile >> "CfgVehicles" >> _class >> "displayName");

if ((_displayName in FABHH_mmv_compatibility)) then {
	_isAllowed = true;
};

_isAllowed;