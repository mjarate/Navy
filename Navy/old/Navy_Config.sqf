#include "Navy_Macros.h"

// missionConfigFile >> "Navy" >> "Routines"/"Vehicles"(_superclass) >> (routine/vehicle name) >> _field;
Navy_Config_GetConfigValue =
{
	FUN_ARGS_4(_type,_superclass,_name,_field);
	PVT_1(_return);
	if (_superclass isEqualTo "Routines") then
	{
		switch (_type) do
		{
			case CONFIG_TYPE_ARRAY: 	{_return = getArray(NAVY_ROUTINES >> _name >> _field);};
			case CONFIG_TYPE_NUMBER: 	{_return = getNumber(NAVY_ROUTINES >> _name >> _field);};
			case CONFIG_TYPE_STRING: 	{_return = getText(NAVY_ROUTINES >> _name >> _field);};
		};
	}
	else
	{
		switch (_type) do
		{
			case CONFIG_TYPE_ARRAY: 	{_return = getArray(NAVY_VEHICLES >> _name >> _field);};
			case CONFIG_TYPE_NUMBER: 	{_return = getNumber(NAVY_VEHICLES >> _name >> _field);};
			case CONFIG_TYPE_STRING: 	{_return = getText(NAVY_VEHICLES >> _name >> _field);};
		};
	};
	DEBUG
	{
		[["Config value type: %1 in superclass %2 of name %3 in field %4 returned: %5",([_type] call Navy_Debug_ReturnConfigType),_superclass,_name,_field,_return]] call Navy_Debug_HintRPT;
	};
	_return;
};