class CfgPatches
{
	class FABHH_infAmmoInf
	{
		name = "Magic Mag - Infantry";
		author = "Fab";
		url = "https://steamcommunity.com/id/Fab2";
		requiredVersion = 2.16;
		requiredAddons[] = { "cba_common", "cba_xeh" };
		skipWhenMissingDependencies = 0;
		units[]={};
		weapons[]={};
	};
};

class Extended_PostInit_EventHandlers
{
	magicMagInfSettings = "call compile preprocessFileLineNumbers ""\infAmmoInf\XEH_postInit.sqf""";
};

class CfgFunctions
{
	class FABHH
	{
		class mmi
		{
			file = "\infAmmoInf\functions";
			class infAmmoInf_AttachEH {};
			class infAmmoInf_DetachEH {};
			class infAmmoInf_DelayedAddMagazine {};
			class infAmmoInf_IsUnitAllowed {};
			class infAmmoInf_GetClassReloadTime {};
			class infAmmoInf_GetWeaponTypeFromClass {};
			class infAmmoInf_GetWeaponTypeFromCursor {};
			class infAmmoInf_GetWeaponType {};
			class infAmmoInf_HandleNewGroups {PostInit = 1;};
		};
	};
};