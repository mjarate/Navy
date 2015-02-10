#include "Navy_Macros.h"

Navy_Units_SpawnDriver =
{
	FUN_ARGS_1(_unit_template);
	DECLARE(_group) = createGroup ([_unit_template] call adm_common_fnc_getUnitTemplateSide);
	DECLARE(_driver) =
	[
		Navy_SpawnLocation,
		_group,
		_unit_template,
		CONFIG_CAMP_FIELD,
		CONFIG_CREWMEN_FIELD
	] call adm_patrol_fnc_placeMan;
	WAIT_DELAY(0.1,!isNil "_driver");
	Navy_Units pushBack _driver;
	_driver allowFleeing 0;
	INC(Navy_Unit_Counter);
	DEBUG
	{
		[["Driver %1 spawned in group %2 from unit template %3",_driver,_group,_unit_template]] call Navy_Debug_HintRPT;
		//[_driver] spawn Navy_Debug_TrackUnit;
	};
	_driver;
};

Navy_Units_SpawnCargoUnit =
{
	FUN_ARGS_2(_unit_template,_group);
	DECLARE(_cargo_unit) =
	[
		Navy_SpawnLocation,
		_group,
		_unit_template,
		CONFIG_CAMP_FIELD,
		CONFIG_INFANTRY_FIELD
	] call adm_patrol_fnc_placeMan;
	WAIT_DELAY(0.1,!isNil "_cargo_unit");
	Navy_Units pushBack _cargo_unit;
	INC(Navy_Unit_Counter);
	DEBUG
	{
		[["Cargo Unit %1 spawned in group %2 from unit template %3",_cargo_unit,_group,_unit_template]] call Navy_Debug_HintRPT;
		[_cargo_unit] spawn Navy_Debug_TrackUnit;
	};
	_cargo_unit;
};