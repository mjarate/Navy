#include "Navy_Macros.h"

// Required:
// spawn_item
// drop_item_1 - drop_item_10
// cleanup_item
// attack_item
Navy_StressTest_Paradrop =
{
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_1,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_2,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_3,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_4,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_5,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_6,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_7,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_8,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_9,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_10,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
};

Navy_StressTest_HeliInsert =
{
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_1,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_2,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_3,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_4,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_5,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_6,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_7,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_8,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
};

Navy_StressTest_Combined =
{
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_1,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_2,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_3,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_4,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_5,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_6,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_7,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,heli_insert_item_8,cleanup_item,attack_item] spawn Navy_RunHeliInsert;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_1,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_2,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_3,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_4,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_5,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_6,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_7,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_8,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
	["NATO_WOODLAND","B_Heli_Transport_01_F",8,spawn_item,drop_item_9,cleanup_item,attack_item] spawn Navy_RunParadrop;
	sleep 6;
};

Navy_Reinforcement_1 =
{

};