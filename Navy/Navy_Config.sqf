#include "Navy_Macros.h"

Navy_Config_GetConfigValue =
{
	FUN_ARGS_4(_type,_superclass,_name,_field);
	// missionConfigFile >> "Navy" >> "Routines"/"Vehicles"(_superclass) >> (routine/vehicle name) >> _field;
	PVT_1(_return);
	if (_superclass isEqualTo "Routines") then
	{
		switch (_type) do
		{
			case CONFIG_TYPE_ARRAY: 	{_return = [(NAVY_ROUTINES >> _name >> _field)] call Navy_Config_GetArray;};
			case CONFIG_TYPE_NUMBER: 	{_return = [(NAVY_ROUTINES >> _name >> _field)] call Navy_Config_GetNumber;};
			case CONFIG_TYPE_STRING: 	{_return = [(NAVY_ROUTINES >> _name >> _field)] call Navy_Config_GetText;};
			//default:				{};
		};
	}
	else
	{
		switch (_type) do
		{
			case CONFIG_TYPE_ARRAY: 	{_return = [(NAVY_VEHICLES >> _name >> _field)] call Navy_Config_GetArray;};
			case CONFIG_TYPE_NUMBER: 	{_return = [(NAVY_VEHICLES >> _name >> _field)] call Navy_Config_GetNumber;};
			case CONFIG_TYPE_STRING: 	{_return = [(NAVY_VEHICLES >> _name >> _field)] call Navy_Config_GetText;};
			//default:				{};
		};
	};
	DEBUG
	{
		[["Config value type: %1 in superclass %2 of name %3 in field %4 returned: %5",_type,_superclass,_name,_field,_return]] call Navy_Debug_HintRPT;
	};
	_return;
};

Navy_Config_GetArray =
{
	FUN_ARGS_1(_path);
	getArray(_path);
};

Navy_Config_GetNumber =
{
	FUN_ARGS_1(_path);
	getNumber(_path);
};

Navy_Config_GetText =
{
	FUN_ARGS_1(_path);
	getText(_path);
};