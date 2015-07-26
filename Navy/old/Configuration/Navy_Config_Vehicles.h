// WEST: https://community.bistudio.com/wiki/Arma_3_CfgVehicles_WEST
// EAST: https://community.bistudio.com/wiki/Arma_3_CfgVehicles_EAST

class Vehicles {
	class Default {
		Name = ""; // Informal vehicle's name, used for logging
		Type = "";
		Animation[] = {};
		Ordnance[] = {}; // Only the ordnance's WEAPON that you wish removed
		Slingload = 0; // 0: False, 1: True
		Slingload_Limit = 0;
	};
	
	class Rotary: Default {
		Type = "ROTARY";
	};
	
	class Fixed: Default {
		Type = "FIXED";
	};
	
	// Rotary Aircraft
	// WEST
	
	class B_Heli_Transport_01_F: Rotary {
		Name = "Black Ghosthawk";
		Animation[] = {"Door_L","Door_R"}; // "CargoRamp_Open" appears to make no difference
		Slingload = 1;
		Slingload_Limit = 4000;
	};

	class B_Heli_Transport_01_camo_F: B_Heli_Transport_01_F {
		Name = "Camo Ghosthawk";
	};

	class B_Heli_Attack_01_F: Rotary {
		Name = "AH-99 Blackfoot";
		Ordnance[] = {{0},"missiles_DAGR",{0},"missiles_ASRAAM"};
	};
	
	class B_Heli_Light_01_F:  Rotary {
		Name = "MH-9 Hummingbird";
		//Animation[] = {"DoorL_Front_Open","DoorR_Front_Open","DoorL_Back_Open","DoorR_Back_Open"};
		Slingload = 1;
		Slingload_Limit = 500;
	};
	
	class B_Heli_Light_01_armed_F: B_Heli_Light_01_F {
		Name = "AH-9 Pawnee";
		Ordnance[] = {{-1},"missiles_DAR"};
	};
	
	class B_Heli_Transport_03_F: Rotary {
		Name = "CH-67 Huron";
		Slingload = 1;
		Slingload_Limit = 10000;
		Animation[] = {"Door_R_source","Door_L_source","Door_rear_source"};
	};
	
	class B_Heli_Transport_03_unarmed_F: B_Heli_Transport_03_F {
		Name = "CH-67 Huron (Black)";
	};
	
	// EAST
	
	class O_Heli_Light_02_unarmed_F: Rotary {
		Name = "PO-30 Orca (Black)";
		Slingload = 1;
		Slingload_Limit = 500;
	};
	
	class O_Heli_Light_02_F: O_Heli_Light_02_unarmed_F {
		Name = "PO-30 Orca";
		Ordnance[] = {{-1},"missiles_DAGR"};
	};
	
	class O_Heli_Light_02_v2_F: O_Heli_Light_02_F {
		Name = "PO-30 Orca (Black & White)";
		Ordnance[] = {{-1},"missiles_DAR"};
		Slingload_Limit = 2000;
	};
	
	class O_Heli_Attack_02_F: Rotary {
		Name = "Mi-48 Kajman";
		Ordnance[] = {{-1},"missiles_SCALPEL",{-1},"rockets_Skyfire"}; // Turret paths require confirmation
		Animation[] = {"door_L","door_R","door_L_pop","door_R_pop"};
	};
	
	class O_Heli_Attack_02_black_F: O_Heli_Attack_02_F {
		Name = "Mi-48 Kajman (Black)";
	};
	
	class O_Heli_Transport_04_F: Rotary {
		Name = "Mi-290 Taru";
		Animation[] = {"Door_1_source","Door_2_source","Door_3_source"};
		Slingload = 1;
		Slingload_Limit = 12000;
	};
	
	class O_Heli_Transport_04_ammo_F: Rotary {
		Name = "Mi-290 Taru (Ammo)";
		Animation[] = {"Door_1_source","Door_2_source","Door_3_source"};
	};
	
	class O_Heli_Transport_04_bench_F: Rotary {
		Name = "Mi-290 Taru (Bench)";
		// Animation[] = {"Door_1_source","Door_2_source","Door_3_source"};
	};
	
	class O_Heli_Transport_04_fuel_F: O_Heli_Transport_04_ammo_F {
		Name = "Mi-290 Taru (Fuel)";
	};
	
	class O_Heli_Transport_04_medevac_F: Rotary {
		Name = "Mi-290 Taru (Medevac)";
		Animation[] = {"Door_1_source","Door_2_source","Door_3_source","Door_4_source","Door_6_source"};
	};
	
	class O_Heli_Transport_04_repair_F: O_Heli_Transport_04_ammo_F {
		Name = "Mi-290 Taru (Repair)";
	};
	
	class O_Heli_Transport_04_covered_F: Rotary {
		Name = "Mi-290 Taru (Covered)";
		Animation[] = {"Door_4_source","Door_5_source","Door_6_source"};
	};
	
	// IND
	
	class I_Heli_Transport_02_F: Rotary {
		Name = "CH-49 Mohawk";
		Animation[] = {"CargoRamp_Open","Door_Back_L","Door_Back_R"};
		Slingload = 1;
		Slingload_Limit = 4000;
	};
	
	class I_Heli_light_03_F: I_Heli_Transport_02_F {
		Name = "WY-55 Hellcat";
		Ordnance[] = {{-1},"missiles_DAR"};
		Slingload_Limit = 2000;
	};
	
	class I_Heli_light_03_unarmed_F: Rotary {
		Name = "WY-55 Hellcat (Green)";
		Slingload = 1;
		Slingload_Limit = 2000;
	};
	
	// CIV
	
	class C_Heli_Light_01_civil_F: Rotary {
		Name = "M-900";
		Slingload = 1;
		Slingload_Limit = 500;
		Animation[] = {"DoorL_Front_Open","DoorR_Front_Open","DoorL_Back_Open","DoorR_Back_Open"};
	};
	
	// Fixed Wing Aircraft
	// WEST

	class B_Plane_CAS_01_F: Fixed {
		Name = " A-164 Wipeout";
		Ordnance[] = {{-1},"Bomb_04_Plane_CAS_01_F"};
	};
	
	// EAST
	
	 class O_Plane_CAS_02_F: Fixed {
		Name = "To-199 Neophron (CAS)";
		Ordnance[] = {{-1},"Bomb_03_Plane_CAS_02_F"};
	 };
	 
	 // IND
	 
	 class I_Plane_Fighter_03_CAS_F: Fixed {
		Name = "A-143 Buzzard (CAS)";
		Ordnance[] = {{-1},"GBU12BombLauncher"};
	 };
	 
	 class I_Plane_Fighter_03_AA_F: Fixed {
		 Name = "A-143 Buzzard (AA)";
	 };
};