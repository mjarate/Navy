#include "Navy_Macros.h"

Navy_General_ReturnPosAndDir =
{
	FUN_ARGS_1(_unit);
	DECLARE(_pos) = getposATL _unit;
	DECLARE(_dir) = direction _unit;
	[_pos,_dir];
};

Navy_General_Log =
{
	FUN_ARGS_1(_message);
	diag_log format ["%1%2",DEBUG_HEADER,format _message];
	DEBUG
	{
		[_message] call Navy_Debug_Hint;
	};
};