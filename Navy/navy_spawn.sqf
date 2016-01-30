#include "navy_macros.h"

navy_spawn_fnc_airVehicle = {
    FUN_ARGS_2(_vehicleClassname,_trigger);

    DECLARE(_flightAltitude) = [NAVY_CONFIG_FILE, "Settings", "flightAltitude"] call navy_config_fnc_getNumber;
    PVT_2(_spawnPosition,_vehicle);
    if (isNil "_trigger") exitWith {
        [["No trigger was provided to try and spawn the vehicle with classname: %1", _vehicleClassname], DEBUG_ERROR] call navy_debug_fnc_logToServer;
    };
    _spawnPosition = [(triggerArea _trigger), (getposATL _trigger), true] call adm_api_fnc_getRandomPositionInArea;
    SET_ALTITUDE(_spawnPosition,_flightAltitude);
    _vehicle = createVehicle [_vehicleClassname, _spawnPosition, [], 0, "FLY"];
    _vehicle setPosATL _spawnPosition;
    _vehicle flyInHeight _flightAltitude;

    DEBUG {
        [["Spawned vehicle: %1 at position: %2", _vehicle, _spawnPosition], DEBUG_INFO] call navy_debug_fnc_log
    };

    _vehicle;
};

navy_spawn_fnc_pilot = {
    FUN_ARGS_3(_pilotClassname,_pilotSide,_vehicle);

    DECLARE(_pilotGroup) = createGroup _pilotSide;
    DECLARE(_pilot) = [NAVY_SPAWN_POSITION, _pilotGroup, [_pilotClassname], NAVY_PILOT_SKILL_ARRAY] call adm_common_fnc_placeMan;
    _pilot moveInDriver _vehicle;
    {
        _pilot disableAI _x;
    } forEach NAVY_PILOT_DISABLE_AI_ARRAY;
    _pilot setBehaviour "CARELESS";

    DEBUG {
        [["Spawned pilot: %1 and placed inside vehicle: %2", _pilot, _vehicle], DEBUG_INFO] call navy_debug_fnc_log;
        [_pilot] spawn navy_debug_trackUnit;
    };

    _pilot;
};

navy_spawn_fnc_cargoUnits = {
    FUN_ARGS_5(_unitClassnames,_unitSide,_amount,_vehicle,_addParachute);

    if (_amount == 0) then {
        DEBUG {
            [["Attempted to fill vehicle: %1 with no cargo units", _vehicle], DEBUG_WARN] call navy_debug_fnc_log;
        };
    };
    if (isNil "_addParachute") then {
        _addParachute = false;
    };
    PVT_1(_unit);
    DECLARE(_cargoUnits) = [];
    DECLARE(_vehicleCargoLimit) = [NAVY_CONFIG_VEHICLES, (typeOf _vehicle), "cargo_limit"] call navy_config_fnc_getNumber;
    if (_vehicleCargoLimit == 0) exitWith {
        DEBUG {
            [["Attempted to fill vehicle: %1 with cargo units but it has no cargo space!", _vehicle], DEBUG_ERROR] call navy_debug_fnc_log;
        };
    };
    DECLARE(_skillArray) = ["Camp"] call adm_common_fnc_getZoneTemplateSkillValues;
    if (_amount > _vehicleCargoLimit) then {
        DEBUG {
            [["Cargo amount requested: %1 is above the limit: %2 for vehicle: %3. Reverting to limit", _amount, _vehicleCargoLimit, _vehicle], DEBUG_WARN] call navy_debug_fnc_log;
            _amount = _vehicleCargoLimit;
        };
    };
    DECLARE(_unitGroup) = createGroup _unitSide;
    for "_i" from 1 to _amount step 1 do {
        _unit = [NAVY_SPAWN_POSITION, _unitGroup, _unitClassnames, _skillArray] call adm_common_fnc_placeMan;
        _unit moveInCargo _vehicle;
        _cargoUnits pushBack _unit;
        DEBUG {
            [["Spawned cargo unit: %1 number: %2 for vehicle: %3", _unit, _i, _vehicle], DEBUG_INFO] call navy_debug_fnc_log;
        };
        sleep NAVY_SPAWN_DELAY;
    };
    if (_addParachute) then {
        DEBUG {
            [["Adding parachutes to the cargo units: %1 of vehicle: %2", _cargoUnits, _vehicle], DEBUG_INFO] call navy_debug_fnc_log;
        };
        
        {
            removeBackpack _x;
            _x addBackpackGlobal "B_Parachute";
            sleep NAVY_GEAR_ADD_DELAY;
        } forEach _cargoUnits;
    };

    DEBUG {
        [["Cargo units: %1 placed in vehicle cargo: %2 with parachutes: %3", _cargoUnits, _vehicle, _addParachute], DEBUG_INFO] call navy_debug_fnc_log;
        {
            [_x] spawn navy_debug_trackUnit;
        } forEach _cargoUnits;
    };

    _unitGroup;
};
