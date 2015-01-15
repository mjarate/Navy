#include "Navy_Macros.h"

Navy_General_ReturnPosAndDir =
{
	FUN_ARGS_1(_unit);
	DECLARE(_pos) = getposATL _unit;
	DECLARE(_dir) = direction _unit;
	//DECLARE(_pos_and_dir) = [_pos,_dir];
	//_pos_and_dir;
	[_pos,_dir];
};
