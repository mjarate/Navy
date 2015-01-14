#include "Navy_Macros.h"

Navy_PreInit =
{
	if (Navy_WaitForHull3) then
	{
		WAIT(hull3_isInitialized);
	};
	
};

Navy_Init =
{
	
};