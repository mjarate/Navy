#include "navy_macros.h"

navy_spawn_fnc_airVehicle = {
    FUN_ARGS_2(_vehicleClassname,_trigger);

    PVT_2(_spawnPosition,_vehicle);
    if (isNil "_trigger") exitWith {
        [["No trigger was provided to try and spawn the vehicle with classname: %1", _vehicleClassname], DEBUG_ERROR] call navy_debug_fnc_logToServer;
    };
    _spawnPosition = [(triggerArea _trigger), (getposATL _trigger), true] call adm_api_fnc_getRandomPositionInArea;
    SET_ALTITUDE(_spawnPosition,NAVY_DEFAULT_ALTITUDE);
    _vehicle = createVehicle [_vehicleClassname, _spawnPosition, [], 0, "FLY"];
    _vehicle setPosATL _spawnPosition;
    _vehicle flyInHeight NAVY_DEFAULT_ALTITUDE;  // TODO: Set this in the config
    DEBUG {
        [["Spawned vehicle: %1 at position: %2", _vehicle, _spawnPosition], DEBUG_INFO] call navy_debug_fnc_log
    };

    _vehicle;
};

navy_spawn_fnc_pilot = {
    FUN_ARGS_3(_pilotClassname,_pilotSide,_vehicle);

    DECLARE(_pilotGroup) = createGroup _pilotSide;
    DECLARE(_pilot) = [NAVY_SPAWN_POSITION, _pilotGroup, [_pilotClassname], NAVY_PILOT_SKILL_ARRAY] call adm_common_fnc_placeMan;
    _pilot disableAI "AUTOTARGET";
    _pilot setBehaviour "CARELESS";
    _pilot moveInDriver _vehicle;

    DEBUG {
        [["Spawned pilot: %1 and placed inside vehicle: %2", _pilot, _vehicle], DEBUG_INFO] call navy_debug_fnc_log;
        [_pilot] spawn navy_debug_trackUnit;
    };

    _pilot;
};

navy_spawn_fnc_cargoUnits = {
    FUN_ARGS_5(_unitClassnames,_unitSide,_amount,_vehicle,_addParachute);

    if (isNil "_addParachute") then {
        _addParachute = false;
    };
    PVT_1(_unit);
    DECLARE(_cargoUnits) = [];
    DECLARE(_vehicleCargoLimit) = [NAVY_CONFIG_FILE, "Vehicles", (typeOf _vehicle)] call navy_config_fnc_getNumber;
    DECLARE(_skillArray) = ["Camp"] call adm_common_fnc_getZoneTemplateSkillValues;
    if (_vehicleCargoLimit > _amount) then {
        _amount = _vehicleCargoLimit;
        DEBUG {
            [["Cargo amount requested: %1 is above the limit: %2 for vehicle: %3. Reverting to limit", _amount, _vehicleCargoLimit, _vehicle], DEBUG_WARN] call navy_debug_fnc_log;
        };
    };
    DECLARE(_unitGroup) = createGroup _unitSide;
    for "_i" from 1 to _amount step 1 do {
        _unit = [NAVY_SPAWN_POSITION, _unitGroup, _unitClassnames, _skillArray] call adm_common_fnc_placeMan;
        // TODO: put zone template as option field in the module
        _unit moveInCargo _vehicle;
        _cargoUnits pushBack _unit;
    };
    if (_addParachute) then {
        {
            removeBackpack _x;
            _x addBackpackGlobal "B_Parachute";
        } forEach _cargoUnits;
    };

    DEBUG {
        [["Cargo units: %1 placed in vehicle cargo: %2 with parachutes: %3", _cargoUnits, _vehicle, _addParachute], DEBUG_INFO] call navy_debug_fnc_log;
        {
            [_x] spawn navy_debug_trackUnit;
        } forEach _cargoUnits;
    };

    _cargoUnits;
};