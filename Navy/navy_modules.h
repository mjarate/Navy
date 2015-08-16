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
};