#include "Kami_Macros.h"

#ifndef NAVY_MACROS_H
#define NAVY_MACROS_H

#define Navy_Version			0.1

#define PRECOMPILE(SCRIPT) 		call compile preProcessFileLineNumbers SCRIPT 
#define WAIT(CODE) 				waitUntil {CODE}
#define DEBUG					if (Navy_Debug) then
#define RUN_ON_SERVER			if (isServer) then
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

#define DEBUG_HEADER		format ["%1-[NAVY]: ",time]
#define DEBUG_RPT			true
#define DEBUG_HINTS			true
#define DEBUG_SIDECHAT		true
#define DEBUG_MULTIPLAYER	false

#define DEBUG_MARKER_SIZE_UNIT			[0.3,0.3]
#define DEBUG_MARKER_SIZE_VEHICLE		[0.6,0.6]
#define DEBUG_MARKER_COLOUR_UNIT		"ColorGreen"
#define DEBUG_MARKER_COLOUR_VEHICLE		"ColorBrown"
#define DEBUG_MARKER_UPDATE_DELAY		2

#endif //NAVY_MACROS_H