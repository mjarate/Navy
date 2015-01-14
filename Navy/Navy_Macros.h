#include "Kami_Macros.h"

#ifndef NAVY_MACROS_H
#define NAVY_MACROS_H

#define Navy_Version			0.1

#define PRECOMPILE(SCRIPT) 		call compile preProcessFileLineNumbers SCRIPT 
#define WAIT(CODE) 				waitUntil {CODE}
#define DEBUG					if (Navy_Debug) then
#define ALTITUDE(OBJECT)		((getposATL OBJECT) select 2)
#define HC_NAMES				adm_hc_defaultNames
#define isHC(VAR)				((name VAR) in HC_NAMES)

#define BLU			west
#define OPF			east
#define IND			resistance
#define CIV			civilian

#define BLU_STR		"WEST"
#define OPF_STR		"EAST"
#define IND_STR		"GUER"
#define CIV_STR		"CIV"

#define SIDE_ARRAY			[BLU,OPF,IND,CIV]
#define SIDE_ARRAY_STR		[BLU_STR,OPF_STR,IND_STR,CIV_STR]

#define DEBUG_HEADER	format ["%1-[CH]",time]

#endif //NAVY_MACROS_H