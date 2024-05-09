/*
Author: Fab

Description:
	given an item class, get its respective reload time if allowed.

Parameter(s):
	0: itemType - handed down by
	
Returns:
	Scalar: Reload time in seconds for given muzzle. -1 if unknown or forbidden class.
	
*/

private _itemType = param [0];

private _reloadTime = -1;

switch (_itemType) do
{

	case "arifle": {
		if (FABHH_mmi_reloadAssaultRifle) then {
			_reloadTime = FABHH_mmi_AssaultRifleReloadTime;
		};
	};
	
	case "mg": {
		if (FABHH_mmi_reloadLMG) then {
			_reloadTime = FABHH_mmi_LMGReloadTime;
		};
	};
	
	case "srifle": {
		if (FABHH_mmi_reloadSniper) then {
			_reloadTime = FABHH_mmi_SniperReloadTime;
		};
	};
	
	case "smg": {
		if (FABHH_mmi_reloadSMG) then {
			_reloadTime = FABHH_mmi_SMGReloadTime;
		};
	};
	
	case "rocket": {
		if (FABHH_mmi_reloadLauncher) then {
			_reloadTime = FABHH_mmi_LauncherReloadTime;
		};
	};
	
	case "missile": {
		if (FABHH_mmi_reloadMissile) then {
			_reloadTime = FABHH_mmi_MissileReloadTime;
		};
	};
	
	case "throw": {
		if (FABHH_mmi_reloadHandgrenade) then {
			_reloadTime = FABHH_mmi_GrenadeReloadTime;
		};
	};
		
	case "hgun": {
		if (FABHH_mmi_reloadHandgun) then {
			_reloadTime = FABHH_mmi_HandgunReloadTime;
		};
	};
	
	case "sgun": {
		if (FABHH_mmi_reloadShotgun) then {
			_reloadTime = FABHH_mmi_ShotgunReloadTime;
		};
	};
	
	case "gl": {
		if (FABHH_mmi_reloadGL) then {
			_reloadTime = FABHH_mmi_GLReloadTime;
		};
	};
	
	default {
	
		if (FABHH_mmi_reloadAssaultRifle) then {
			_reloadTime = FABHH_mmi_AssaultRifleReloadTime;
		};
		
		if (FABHH_mmi_debugMessages) then {
			systemchat "[ ! ] MMI (ReloadTime): Weapon defaulted!";
		};
		
	};
	
};

_reloadTime;