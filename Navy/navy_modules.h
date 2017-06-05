#include "navy_macros.h"

class Logic;
class Module_F: Logic {
    class ModuleDescription {};
};

class Navy_Module: Module_F {
    scope = 1;
    condition = "navy_isEnabled";
    displayName = "Navy Module";
    icon = ADDON_PATH(resources\heli.paa);
    category = "Navy";
    function = "";
    functionPriority = 1;
    isTriggerActivated = 1;
    isGlobal = 0;
    isDisposable = 0;
    vehicleClass = "Modules";

    class ModuleDescription: ModuleDescription {
        description = "Navy Module";
    };
};

class Navy_Paradrop: Navy_Module {
    scope = 2;
    displayName = "Paradrop";
    icon = ADDON_PATH(resources\paradrop.paa);
    function = "navy_init_fnc_initFromModule";

    class ModuleDescription {
        description = "Spawns a unit paradrop";
    };

    class Arguments {
        class Unit_Template {
            displayName = "Vehicle Unit Template";
            description = "The admiral unit template that navy will spawn units for";
            typeName = "STRING";
            defaultValue = "NATO_WOODLAND";
        };

        class Vehicle_Classname {
            displayName = "Vehicle Classname";
            description = "The classname of the helicopter that will be spawned";
            typeName = "STRING";
            defaultValue = "B_Heli_Transport_03_black_F";
        };

        class Cargo_Amount {
            displayName = "Cargo Unit Amount";
            description = "The amount of cargo units that will be placed inside the helicopter";
            typeName = "NUMBER";
            defaultValue = 10;
        };

        class Assault_Position {
            displayName = "Assault Position Object";
            description = "The object on the position the cargo units will converge to after drop off. If left empty, the units will act like an admiral patrol";
            typeName = "STRING";
            defaultValue = "";
        };

        class Routine_Function {
            displayName = "Routine Function";
            description = "The function called by this module. Do not change this unless you know what it does";
            typeName = "STRING";
            defaultValue = "navy_method_fnc_paradrop";
        };
    };
};

class Navy_barrelbomb: Navy_Module {
    scope = 2;
    displayName = "barrelbomb";
    icon = ADDON_PATH(resources\barrel.paa);
    function = "navy_init_fnc_initFromModule";

    class ModuleDescription {
        description = "Spawns a unit barrelbomber";
    };

    class Arguments {
        class Unit_Template {
            displayName = "Vehicle Unit Template";
            description = "The faction the aircraf pilot will belong to (Admiral template)";
            typeName = "STRING";
            defaultValue = "NATO_WOODLAND";
        };

        class Vehicle_Classname {
            displayName = "Vehicle Classname";
            description = "The classname of the helicopter that will be spawned";
            typeName = "STRING";
            defaultValue = "B_Heli_Transport_03_black_F";
        };

        class Cargo_Amount {
            displayName = "Barrel bomb Amount (1-3)";
            description = "The amount of barrel bombs that will be dropped";
            typeName = "NUMBER";
            defaultValue = 1;
        };

        class Routine_Function {
            displayName = "Routine Function";
            description = "The function called by this module. Do not change this unless you know what it does";
            typeName = "STRING";
            defaultValue = "navy_method_fnc_barrelbomb";
        };
    };
};

class Navy_HeliInsert: Navy_Module {
    scope = 2;
    displayName = "Heli Insert";
    function = "navy_init_fnc_initFromModule";

    class ModuleDescription {
        description = "Spawns a helicopter which will land the cargo units at the given location";
    };

    class Arguments {
        class Unit_Template {
            displayName = "Vehicle Unit Template";
            description = "The admiral unit template that navy will spawn units for";
            typeName = "STRING";
            defaultValue = "NATO_WOODLAND";
        };

        class Vehicle_Classname {
            displayName = "Vehicle Classname";
            description = "The classname of the helicopter that will be spawned";
            typeName = "STRING";
            defaultValue = "B_Heli_Transport_03_black_F";
        };

        class Cargo_Amount {
            displayName = "Cargo Unit Amount";
            description = "The amount of cargo units that will be placed inside the helicopter";
            typeName = "NUMBER";
            defaultValue = 10;
        };

        class Assault_Position {
            displayName = "Assault Position Object";
            description = "The object on the position the cargo units will converge to after drop off. If left empty, the units will act like an admiral patrol";
            typeName = "STRING";
            defaultValue = "";
        };

        class Routine_Function {
            displayName = "Routine Function";
            description = "The function called by this module. Do not change this unless you know what it does";
            typeName = "STRING";
            defaultValue = "navy_method_fnc_heliInsert";
        };
    };
};
