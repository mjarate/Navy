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
	// WEST: https://community.bistudio.com/wiki/Arma_3_CfgVehicles_WEST

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
		Ordnance[] = {};
	};
	
	// EAST: https://community.bistudio.com/wiki/Arma_3_CfgVehicles_EAST
	// Covered Mi-290 Taru
	class O_Heli_Transport_04_covered_F: Rotary {
		Name = "Mi-290 Taru (Covered)";
		Animation[] = {"Door_4_source","Door_5_source","Door_6_source"};
	};
	
	// Fixed Wing Aircraft
	// WEST: https://community.bistudio.com/wiki/Arma_3_CfgVehicles_WEST

	class B_Plane_CAS_01_F: Fixed {
		Name = " A-164 Wipeout";
		Ordnance[] = {{-1},"Bomb_04_Plane_CAS_01_F"};
	};
};