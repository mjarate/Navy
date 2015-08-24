// WEST: https://community.bistudio.com/wiki/Arma_3_CfgVehicles_WEST
// EAST: https://community.bistudio.com/wiki/Arma_3_CfgVehicles_EAST

class Vehicles {
    class Default {
        name = ""; // Informal vehicle's name, used for logging
        type = "";
        cargo_limit = 0;
        animations[] = {};
        ordnance[] = {}; // Only the ordnance's WEAPON that you wish removed
    };

    class Rotary: Default {
        type = "ROTARY";
        slingload = 0;
        slingload_limit = 0;
    };

    class Fixed: Default {
        type = "FIXED";
    };

// Rotary Aircraft
// WEST

    class B_Heli_Transport_01_F: Rotary {
        name = "Black Ghosthawk";
        animations[] = {"Door_L","Door_R"}; // "CargoRamp_Open" appears to make no difference
        slingload = 1;
        slingload_limit = 4000;
        cargo_limit = 8;
    };

    class B_Heli_Transport_01_camo_F: B_Heli_Transport_01_F {
        name = "Camo Ghosthawk";
    };

    class B_Heli_Attack_01_F: Rotary {
        name = "AH-99 Blackfoot";
        ordnance[] = {{0},"missiles_DAGR",{0},"missiles_ASRAAM"};
    };

    class B_Heli_Light_01_F:  Rotary {
        name = "MH-9 Hummingbird";
        //animations[] = {"DoorL_Front_Open","DoorR_Front_Open","DoorL_Back_Open","DoorR_Back_Open"};
        slingload = 1;
        slingload_limit = 500;
        cargo_limit = 6;
    };

    class B_Heli_Light_01_armed_F: B_Heli_Light_01_F {
        name = "AH-9 Pawnee";
        ordnance[] = {{-1},"missiles_DAR"};
        cargo_limit = 0;
    };

    class B_Heli_Transport_03_F: Rotary {
        name = "CH-67 Huron";
        slingload = 1;
        slingload_limit = 10000;
        cargo_limit = 16;
        animations[] = {"Door_R_source","Door_L_source","Door_rear_source"};
    };

    class B_Heli_Transport_03_unarmed_F: B_Heli_Transport_03_F {
        name = "CH-67 Huron (Black)";
    };
    
    class B_Heli_Transport_03_black_F: B_Heli_Transport_03_unarmed_F {};

    class B_Heli_Transport_03_unarmed_green_F: B_Heli_Transport_03_F {};

// EAST

    class O_Heli_Light_02_unarmed_F: Rotary {
        name = "PO-30 Orca (Black)";
        slingload = 1;
        slingload_limit = 500;
        cargo_limit = 8;
    };

    class O_Heli_Light_02_F: O_Heli_Light_02_unarmed_F {
        name = "PO-30 Orca";
        ordnance[] = {{-1},"missiles_DAGR"};
    };

    class O_Heli_Light_02_v2_F: O_Heli_Light_02_F {};

    class O_Heli_Light_02_v2_F: O_Heli_Light_02_F {
        name = "PO-30 Orca (Black & White)";
        ordnance[] = {{-1},"missiles_DAR"};
        slingload_limit = 2000;
    };

    class O_Heli_Attack_02_F: Rotary {
        name = "Mi-48 Kajman";
        ordnance[] = {{-1},"missiles_SCALPEL",{-1},"rockets_Skyfire"}; // Turret paths require confirmation
        cargo_limit = 8;
        animations[] = {"door_L","door_R","door_L_pop","door_R_pop"};
    };

    class O_Heli_Attack_02_black_F: O_Heli_Attack_02_F {
        name = "Mi-48 Kajman (Black)";
    };

    class O_Heli_Transport_04_F: Rotary {
        name = "Mi-290 Taru";
        animations[] = {"Door_1_source","Door_2_source","Door_3_source"};
        slingload = 1;
        slingload_limit = 12000;
    };

    class O_Heli_Transport_04_ammo_F: Rotary {
        name = "Mi-290 Taru (Ammo)";
        animations[] = {"Door_1_source","Door_2_source","Door_3_source"};
    };

    class O_Heli_Transport_04_bench_F: Rotary {
        name = "Mi-290 Taru (Bench)";
        cargo_limit = 8;
        animations[] = {};
    };

    class O_Heli_Transport_04_fuel_F: O_Heli_Transport_04_ammo_F {
        name = "Mi-290 Taru (Fuel)";
    };

    class O_Heli_Transport_04_medevac_F: Rotary {
        name = "Mi-290 Taru (Medevac)";
        animations[] = {"Door_1_source","Door_2_source","Door_3_source","Door_4_source","Door_6_source"};
    };

    class O_Heli_Transport_04_repair_F: O_Heli_Transport_04_ammo_F {
        name = "Mi-290 Taru (Repair)";
    };

    class O_Heli_Transport_04_covered_F: Rotary {
        name = "Mi-290 Taru (Covered)";
        cargo_limit = 16;
        animations[] = {"Door_4_source","Door_5_source","Door_6_source"};
    };

// IND

    class I_Heli_Transport_02_F: Rotary {
        name = "CH-49 Mohawk";
        cargo_limit = 16;
        animations[] = {"CargoRamp_Open","Door_Back_L","Door_Back_R"};
        slingload = 1;
        slingload_limit = 4000;
    };

    class I_Heli_light_03_F: I_Heli_Transport_02_F {
        name = "WY-55 Hellcat";
        cargo_limit = 6;
        ordnance[] = {{-1},"missiles_DAR"};
        slingload_limit = 2000;
    };

    class I_Heli_light_03_unarmed_F: Rotary {
        name = "WY-55 Hellcat (Green)";
        slingload = 1;
        slingload_limit = 2000;
    };

// CIV

    class C_Heli_Light_01_civil_F: Rotary {
        name = "M-900";
        cargo_limit = 2;
        slingload = 1;
        slingload_limit = 500;
        animations[] = {"DoorL_Front_Open","DoorR_Front_Open","DoorL_Back_Open","DoorR_Back_Open"};
    };

// Fixed Wing Aircraft
// WEST

    class B_Plane_CAS_01_F: Fixed {
        name = " A-164 Wipeout";
        ordnance[] = {{-1},"Bomb_04_Plane_CAS_01_F"};
    };

// EAST

    class O_Plane_CAS_02_F: Fixed {
        name = "To-199 Neophron (CAS)";
        ordnance[] = {{-1},"Bomb_03_Plane_CAS_02_F"};
    };
 
// IND
 
    class I_Plane_Fighter_03_CAS_F: Fixed {
        name = "A-143 Buzzard (CAS)";
        ordnance[] = {{-1},"GBU12BombLauncher"};
    };

    class I_Plane_Fighter_03_AA_F: Fixed {
        name = "A-143 Buzzard (AA)";
    };
};