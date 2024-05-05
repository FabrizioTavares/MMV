/*
Author: Fab

Description:
	Attaches and Detaches mission event handler N

Parameter(s):
	None
*/

private _exists = missionNamespace getVariable "mmvHandleGroupsIndex";
	
if (!(isNil "_exists")) exitWith {
	if (FABHH_mmv_debugMessages) then {
		systemChat "[ i ] Magic Mag Vehicles (HandleNewGroups): already present, exiting";
	}
};

private _handleGroupsIndex = addMissionEventHandler ["EntityCreated", {

	params ["_unit"];
	
	if (!(_unit isKindOf "Man") or not FABHH_mmv_ApplyNewUnits) exitWith {};
	
	private _allow = _unit call FABHH_fnc_infAmmoVeh_IsUnitAllowed;

	if (_allow) then {
		_unit call FABHH_fnc_infAmmoVeh_AttachEHUnit;
	};
	
}];

missionNamespace setVariable ["mmvHandleGroupsIndex", _handleGroupsIndex];
	
