/*
Author: Fab

Description:
	attaches the "Fired" Event handler to a vehicle, granting unlimited ammo

Parameter(s):
	0: Vehicle - Required. The vehicle to receive the event handler.

Note(s):
	Assumes parameter is never null (Handled by CanAttachVehicleEH)
*/

private _vehicle = param[0];
private _canAttach = _vehicle call FABHH_fnc_infAmmoVeh_CanAttachVehicleEH;
private _mmvEHIndex = -1;

if (!_canAttach) exitWith {};

private _isDLv = _vehicle call FABHH_fnc_infAmmoVeh_isDynamicLoadout;

if (_isDLv) then {

	_vehicle setVariable ["mmvBusyPylons", [], true]; // array to keep track of pylons that are reloading
	_vehicle setVariable ["mmvPylonCount", count (getAllPylonsInfo _vehicle), true];
	_vehicle setVariable ["mmvNormalWeapons", ["CMFlareLauncher"], true]; // start with cm launcher as 'weapons' wont return it
	
	{ // gather information of all non-pylon weapons in a vehicle
		if(!("Pylon" in str(getArray (configFile >> "CfgWeapons" >> _x >> "magazines")))) then {
			_vehicle setVariable ["mmvNormalWeapons", ((_vehicle getVariable "mmvNormalWeapons") + [_x]), true];
		};
	} forEach weapons _vehicle;

	_mmvEHIndex = _vehicle addEventHandler ["Fired", {

		params ["_thisvehicle", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
		
		if not (_weapon in (_thisvehicle getVariable "mmvNormalWeapons")) then {
		
			{
			
				if ((_x select 4 == 0) and !(_forEachIndex+1 in (_thisvehicle getVariable "mmvBusyPylons"))) then { 
					//index 3 is where the magazine class is stored, 4 is ammo count
					private _delay = getNumber (configFile >> "CfgWeapons" >> _muzzle >> "reloadTime") * FABHH_mmv_DLReloadMultiplier;
					[_thisvehicle, _forEachIndex+1, _delay] spawn FABHH_fnc_infAmmoVeh_AddPylonAmmoDelayed;
			
				};

			} forEach getAllPylonsInfo _thisvehicle;	
			
		} else {
			if (_thisvehicle magazineTurretAmmo [_magazine, _thisvehicle unitTurret _gunner] == 0) then {
				_currentTurretPath = _thisvehicle unitTurret _gunner;
				_thisvehicle removeMagazineTurret [_magazine, _currentTurretPath];
				_thisvehicle addMagazineTurret [_magazine, _currentTurretPath];
				_thisvehicle loadMagazine [_currentTurretPath, _weapon, _magazine];
			};
		};
		
		/* Old implementation as follows, for reference
		if (_gunner ammo _muzzle == 0) then {
		
			systemchat "0";

			private _pylonMagazines = getPylonMagazines _thisvehicle;
			
			if (!(_magazine in _pylonMagazines)) exitWith { // this means that the weapon is not a pylon weapon, such as integrated cannons.
				// This is optimistic: Possibly, a non-pylon weapon can use the same kind of magazine as a pylon weapon. Rare, but can happen.
				
				_currentTurretPath = _thisvehicle unitTurret _gunner;
				_thisvehicle removeMagazineTurret [_magazine, _currentTurretPath];
				_thisvehicle addMagazineTurret [_magazine, _currentTurretPath];
				_thisvehicle loadMagazine [_currentTurretPath, _weapon, _magazine];
			};

			{
			
				if ((_magazine == _x select 3) and (_x select 4 == 0) and !(_forEachIndex+1 in (_thisvehicle getVariable "mmvBusyPylons"))) then { 
					//index 3 is where the magazine class is stored, 4 is ammo count
					// weapons with different bays such as internal bays/pylons will only reload last type of bay.
					private _delay = getNumber (configFile >> "CfgWeapons" >> _muzzle >> "reloadTime") * FABHH_mmv_DLReloadMultiplier;
					[_thisvehicle, _forEachIndex+1, _delay] spawn FABHH_fnc_infAmmoVeh_AddPylonAmmoDelayed;
			
				};

			} forEach getAllPylonsInfo _thisvehicle;
			
		};
		*/
	
	}]; //end EH
	
} else {

	_mmvEHIndex = _vehicle addEventHandler ["Fired", {

		params ["_thisvehicle", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	
		if (_thisvehicle magazineTurretAmmo [_magazine, _thisvehicle unitTurret _gunner] == 0) then {
			private _currentTurretPath = _thisvehicle unitTurret _gunner;
			_thisvehicle removeMagazineTurret [_magazine, _currentTurretPath];
			_thisvehicle addMagazineTurret [_magazine, _currentTurretPath];
			_thisvehicle loadMagazine [_currentTurretPath, _weapon, _magazine];
		};

	}]; //end EH

};

_vehicle setVariable ["mmvEHIndex", _mmvEHIndex, true];

if (FABHH_mmv_debugMessages && (_mmvEHIndex != -1)) then {
	systemChat "[ i ] Magic Mag Vehicles: Attached Event Handler to vehicle successfully";
}