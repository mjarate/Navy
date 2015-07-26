#include "Kami_Macros.h"

#ifndef NAVY_MACROS_H
#define NAVY_MACROS_H

#define NAVY_VERSION			0.6.1
#define NAVY_VERSION_STR		'0.6.1'
#define NAVY_VERSION_ARRAY		[0,6,1]

#define PRECOMPILE(SCRIPT) 			call compile preProcessFileLineNumbers SCRIPT 
#define WAIT(CODE) 					waitUntil {CODE}
#define WAIT_DELAY(DELAY,CODE)		waitUntil {sleep DELAY; CODE}
#define DEBUG						if (Navy_Debug) then
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

#define SIDE_ARRAY				[BLU,OPF,IND,CIV]
#define SIDE_ARRAY_STR			[BLU_STR,OPF_STR,IND_STR,CIV_STR]

#define CONFIG				 		missionConfigFile
#define NAVY_CONFIG					CONFIG >> "Navy"
#define NAVY_ROUTINES				NAVY_CONFIG >> "Routines"
#define NAVY_VEHICLES				NAVY_CONFIG >> "Vehicles"

#define CONFIG_TYPE_ARRAY	0
#define CONFIG_TYPE_NUMBER	1
#define CONFIG_TYPE_STRING	2

#define ADM_CONFIG_INFANTRY_FIELD	"infantry"
#define ADM_CONFIG_CREWMEN_FIELD	"crewmen"
#define ADM_CONFIG_CAMP_FIELD		"Camp"
#define ADM_CONFIG_PATROL_FIELD		"Patrol"
#define ADM_CONFIG_CQC_FIELD		"CQC"

#define NAVY_DRIVER_SKILL_LEVEL 			1

#define NAVY_ALTITUDE_FOR_ANIMATION			12
#define NAVY_FIXED_WING_STARTING_VELOCITY 	[0,300,50]

#define NAVY_DEFAULT_SPAWN_POSITION 	[10000,10000]
#define NAVY_DEFAULT_SPAWN_FORM			'FLY'
#define NAVY_DEFAULT_LANDING_DISTANCE	150
#define NAVY_DEFAULT_LANDING_ALTITUDE	150
#define NAVY_DEFAULT_PARADROP_DELAY		0.7
#define NAVY_DEFAULT_PARADROP_DISTANCE	400
#define NAVY_DEFAULT_CLEANUP_DISTANCE	600
#define NAVY_DEFAULT_INSERT_DISTANCE	350
#define NAVY_DEFAULT_CARGO_UNIT_RADIUS 	300

#define NAVY_FLIGHT_HEIGHT_DEFAULT		150

#define DEBUG_HEADER			format ["%1-[NAVY]: ",time]
#define DEBUG_RPT				true
#define DEBUG_HINTS				true
#define DEBUG_SIDECHAT			true
#define DEBUG_MULTIPLAYER		false

#define DEBUG_MARKER_SIZE_UNIT			[0.7,0.7]
#define DEBUG_MARKER_SIZE_VEHICLE		[1.8,1.8]
#define DEBUG_MARKER_SIZE_WAYPOINT		[0.2,0.2]
#define DEBUG_MARKER_COLOUR_UNIT		"ColorGreen"
#define DEBUG_MARKER_COLOUR_VEHICLE		"ColorBrown"
#define DEBUG_MARKER_UNIT_DELAY			0.5
#define DEBUG_MARKER_VEHI_DELAY			0.25

#endif //NAVY_MACROS_H