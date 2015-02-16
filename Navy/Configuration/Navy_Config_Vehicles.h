class Vehicles {
	class Default {
		Name = ""; // Informal vehicle's name, used for logging
		Type = "";
		Anim_Open[] = {}; // First the "most" important like a ramp, doors the rest.
		Anim_Close[] = {};
		Ordnance[] = {}; // Only the ordnance that you wish removed
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
		Anim_Open[] = {"Door_L","Door_R"}; // "CargoRamp_Open" appears to make no difference
		Anim_Close[] = {};
		Slingload = 1;
		Slingload_Limit = 4000;
	};

	class B_Heli_Transport_01_camo_F: B_Heli_Transport_01_F {
		Name = "Camo Ghosthawk";
		Anim_Open[] = {"Door_L","Door_R"}; // "CargoRamp_Open" appears to make no difference
		Anim_Close[] = {};
		Slingload = 1;
		Slingload_Limit = 4000;
	};

	class B_Heli_Attack_01_F: Rotary {
		Name = "AH-99 Blackfoot";
		Ordnance[] = {};
	};
	
	// Fixed Wing Aircraft
	// WEST: https://community.bistudio.com/wiki/Arma_3_CfgVehicles_WEST

	class B_Plane_CAS_01_F: Fixed {
		Name = " A-164 Wipeout";
		Ordnance[] = {};
	};
};