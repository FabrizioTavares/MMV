class CfgPatches
{
	class FABHH_infAmmoVeh
	{
		name = "Magic Mag - Vehicles";
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
	magicMagVehSettings = "call compile preprocessFileLineNumbers ""\infAmmoVeh\XEH_postInit.sqf""";
};

class CfgFunctions
{
	class FABHH
	{
		class mmv
		{
			file = "\infAmmoVeh\functions";
			class infAmmoVeh_AttachEHUnit {};
			class infAmmoVeh_AttachEHVehicle {};
			class infAmmoVeh_DetachEHVehicle {};
			class infAmmoVeh_DetachEHUnit {};
			class infAmmoVeh_IsDynamicLoadout {};
			class infAmmoVeh_CanRemoveVehicleEH {};
			class infAmmoVeh_CanAttachVehicleEH {};
			class infAmmoVeh_IsVehicleAllowed {};
			class infAmmoVeh_AddPylonAmmoDelayed {};
			class infAmmoVeh_IsUnitAllowed {};
			class infAmmoVeh_HandleNewGroups {postInit = 1};

		};
	};
};