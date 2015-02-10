#include "Kami_Macros.h"

#ifndef NAVY_MACROS_H
#define NAVY_MACROS_H

#define NAVY_VERSION			0.2

#define PRECOMPILE(SCRIPT) 			call compile preProcessFileLineNumbers SCRIPT 
#define WAIT(CODE) 					waitUntil {CODE}
#define WAIT_DELAY(DELAY,CODE)		waitUntil {sleep DELAY; CODE}
#define DEBUG						if (Navy_Debug) then
#define RUN_ON_SERVER				if (isServer) then
#define ALTITUDE(OBJECT)			((getposATL OBJECT) select 2)
#define SET_ALTITUDE(ARRAY,NUM)		ARRAY set [2,NUM]
#define HC_NAMES					adm_hc_defaultNames
#define isHC(VAR)					((name VAR) in HC_NAMES)

#define REMOVE_ELEMENT(ARRAY,VAR)	ARRAY deleteAt (ARRAY find VAR)

#define BLU			west
#define OPF			east
#define IND			resistance
#define CIV			civilian

#define BLU_STR		"WEST"
#define OPF_STR		"EAST"
#define IND_STR		"RESISTANCE"
#define CIV_STR		"CIV"

#define SIDE_ARRAY			[BLU,OPF,IND,CIV]
#define SIDE_ARRAY_STR		[BLU_STR,OPF_STR,IND_STR,CIV_STR]

#define CONFIG_INFANTRY_FIELD	"infantry"
#define CONFIG_CREWMEN_FIELD	"crewmen"
#define CONFIG_CAMP_FIELD		"Camp"
#define CONFIG_PATROL_FIELD		"Patrol"
#define CONFIG_CQC_FIELD		"CQC"

#define NAVY_DRIVER_SKILL_LEVEL 		1
#define NAVY_SPAWN_LOCATION_POS 		[10000,10000]
#define NAVY_DEFAULT_LANDING_DISTANCE	150
#define NAVY_DEFAULT_PARADROP_DELAY		0.6
#define NAVY_DEFAULT_PARADROP_DISTANCE	400
#define NAVY_DEFAULT_CLEANUP_DISTANCE	300

#define NAVY_PATROL_SPEEDS		["FULL","NORMAL"]
#define NAVY_PARADROP_SPEEDS	["FULL"]

#define DEBUG_HEADER		format ["%1-[NAVY]: ",time]
#define DEBUG_RPT			true
#define DEBUG_HINTS			true
#define DEBUG_SIDECHAT		true
#define DEBUG_MULTIPLAYER	false

#define DEBUG_MARKER_SIZE_UNIT			[0.5,0.5]
#define DEBUG_MARKER_SIZE_VEHICLE		[1.3,1.3]
#define DEBUG_MARKER_COLOUR_UNIT		"ColorGreen"
#define DEBUG_MARKER_COLOUR_VEHICLE		"ColorBrown"
#define DEBUG_MARKER_UNIT_DELAY			0.5
#define DEBUG_MARKER_VEHI_DELAY			0.25

#endif //NAVY_MACROS_H