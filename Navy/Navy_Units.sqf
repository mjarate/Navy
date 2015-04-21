#include "Navy_Macros.h"

Navy_Units_SpawnUnit =
{
	FUN_ARGS_5(_group,_unit_template,_form,_admiral_unit_type,_admiral_zone_type);
	DECLARE(_classnames) = [_unit_template,_admiral_unit_type] call adm_common_fnc_getUnitTemplateArray;
	if (isNil "_admiral_zone_type") then
	{
		_admiral_zone_type = ADM_CONFIG_CAMP_FIELD;
	};
	DECLARE(_skill_array) = [_admiral_zone_type] call adm_common_fnc_getZoneTemplateSkillValues;
	if (isNil "_form") then
	{
		_form = "NONE";
	};
	DECLARE(_unit) = _group createUnit[SELECT_RAND(_classnames),Navy_Spawn_Position,[],0,_form];
	WAIT_DELAY(0.1,!isNil "_unit");
	[_unit,_skill_array] call adm_common_fnc_initUnit;
	DEBUG
	{
		Navy_Units pushBack _unit;
		INC(Navy_Unit_Counter);
	};
	_unit;
};

Navy_Units_SpawnDriver =
{
	FUN_ARGS_1(_unit_template);
	DECLARE(_group) = createGroup ([_unit_template] call adm_common_fnc_getUnitTemplateSide);
	DECLARE(_driver) = 
	[
		_group,
		_unit_template,
		"NONE",
		ADM_CONFIG_CREWMEN_FIELD,
		ADM_CONFIG_CAMP_FIELD
	] call Navy_Units_SpawnUnit;
	WAIT_DELAY(0.1,!isNil "_driver");
	_driver setSkill NAVY_DRIVER_SKILL_LEVEL;
	_driver disableAI "AUTOTARGET";
	_group setBehaviour "CARELESS";
	DEBUG
	{
		[["Driver %1 spawned in group %2 from unit template %3",_driver,_group,_unit_template]] call Navy_Debug_HintRPT;
	};
	_driver;
};

Navy_Units_SpawnGunner =
{
	FUN_ARGS_1(_unit_template);
	DECLARE(_group) = createGroup ([_unit_template] call adm_common_fnc_getUnitTemplateSide);
	DECLARE(_gunner) =
	[
		_group,
		_unit_template,
		"NONE",
		ADM_CONFIG_CREWMEN_FIELD,
		ADM_CONFIG_CAMP_FIELD
	] call Navy_Units_SpawnUnit;
	WAIT_DELAY(0.1,!isNil "_gunner");
	_group setBehaviour "COMBAT";
	DEBUG
	{
		[["Gunner %1 spawned in group %2 from unit template %3",_gunner,_group,_unit_template]] call Navy_Debug_HintRPT;
	};
	_gunner;
};

Navy_Units_SpawnCargoUnit =
{
	FUN_ARGS_2(_unit_template,_group);
	DECLARE(_cargo_unit) =
	[
		_group,
		_unit_template,
		"FORM",
		ADM_CONFIG_INFANTRY_FIELD,
		ADM_CONFIG_CAMP_FIELD
	] call Navy_Units_SpawnUnit;
	WAIT_DELAY(0.1,!isNil "_cargo_unit");
	DEBUG
	{
		[["Cargo Unit %1 spawned in group %2 from unit template %3",_cargo_unit,_group,_unit_template]] call Navy_Debug_HintRPT;
		[_cargo_unit] spawn Navy_Debug_TrackUnit;
	};
	_cargo_unit;
};

Navy_Units_AssignParachute =
{
	FUN_ARGS_1(_group);
	{
		removeBackpack _x;
		_x addBackpackGlobal "B_Parachute";
	} forEach units _group;
};