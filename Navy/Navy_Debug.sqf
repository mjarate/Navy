#include "Navy_Macros.h"

Navy_Debug_RPT =
{
	FUN_ARGS_1(_message);
	if (DEBUG_LOGTORPT) then
	{
		diag_log format _message;
	};
};

Navy_Debug_Hint =
{
	FUN_ARGS_2(_message,_silent);
	// _silent parameter: decided whether hint or hintSilent is used. Default is true
	if (DEBUG_HINTS) then
	{
		if (isNil "_silent") then
		{
			_silent = true;
		};
		if (_silent) then
		{
			hintSilent format _message;
		}
		else
		{
			hint format _message;
		};
	};
};

Navy_Debug_SideChat =
{
	FUN_ARGS_1(_message);
	if (DEBUG_SIDECHAT) then
	{
		player sideChat format _message;
	};
};

Navy_Debug_TrackUnit =
{
	
};