#include "navy_macros.h"

class CfgPatches {
    class Navy {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"CBA_MAIN", "admiral"};
        author = Jarate_ARK;
        authorUrl = "https://github.com/mjarate";
    };
};

#include "navy.h"

class Extended_PreInit_EventHandlers {
    class Navy {
        init = "[] call compile preProcessFileLineNumbers 'x\ark\addons\navy\navy_preinit.sqf';";
    };
};

class Extended_PostInit_EventHandlers {
    class Navy {
        init = "[] spawn compile preProcessFileLineNumbers 'x\ark\addons\navy\navy_postinit.sqf';";
    };
};
