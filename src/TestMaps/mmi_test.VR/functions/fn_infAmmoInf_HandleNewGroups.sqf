/*
Author: Fab

Description:
	Attaches and Detaches mission event handler N

Parameter(s):
	None
*/

private _exists = missionNamespace getVariable "mmiHandleGroupsIndex";
	
if (!(isNil "_exists")) exitWith {
	if (FABHH_mmi_debugMessages) then {
		systemChat "[ i ] MMI (HandleNewGroups): already present, exiting";
	}
};

private _handleGroupsIndex = addMissionEventHandler ["EntityCreated", {

	params ["_unit"];
	
	if (!(_unit isKindOf "Man") or not FABHH_mmi_ApplyNewUnits) exitWith {};
	
	private _allow = _unit call FABHH_fnc_infAmmoInf_IsUnitAllowed;

	if (_allow) then {
		_unit call FABHH_fnc_infAmmoInf_AttachEH;
	};
	
}];

missionNamespace setVariable ["mmiHandleGroupsIndex", _handleGroupsIndex];
	
