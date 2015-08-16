#include "navy_macros.h"

class Logic;
class Module_F: Logic {
    class ModuleDescription {};
};

class Navy_Module: Module_F {
    scope = 1;
    displayName = "Navy Module";
    icon = ADDON_PATH(resources\heli.paa);
    category = "Navy";
    function = "";
    functionPriority = 1;
    isTriggerActivated = 0;
    isGlobal = 0;
    isDisposable = 0;
    vehicleClass = "Modules";
    class ModuleDescription: ModuleDescription {
        description = "Navy Module";
    };
};

class Navy_Paradrop: Navy_Module {
    scope = 2;
    condition = "navy_isEnabled";
    displayName = "Paradrop";
    function = "navy_module_paradrop";
    class ModuleDescription {
        description = "Spawns a unit paradrop";
    };
     class Arguments {
        class Vehicle_Classname {
            displayName = "Vehicle Classname";
            description = "The classname of the helicopter that will be spawned";
            typeName = "STRING";
            defaultValue = "B_Heli_Transport_03_black_F";
        };
    };
};