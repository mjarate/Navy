#include "Navy_Macros.h"

Navy_Units_SpawnDriver =
{
	FUN_ARGS_1(_unit_template);
	DECLARE(_group) = createGroup ([_unit_template] call adm_common_fnc_getUnitTemplateSide);
	_driver = [Navy_SpawnLocation,_group,_unit_template,"Camp","crewmen"] call adm_patrol_fnc_placeMan;
	_driver;
};