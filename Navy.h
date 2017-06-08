#include "navy_macros.h"

// For Modules
class CfgFactionClasses {
    class NO_CATEGORY;
    class Navy: NO_CATEGORY {
        displayName = "Navy";
    };
};

class CfgVehicles {
    #include "navy_modules.h"
};

class Navy {
    class Settings {
        isEnabled = 0;
        debugEnabled = 1;
        paradropDistance = 300;
		bombingDistance = 250;
        flightAltitude = 200;
        cleanupDistance = 600;
        patrolRadius = 500;
    };
    #include "navy_routines.h"
    #include "navy_vehicles.h"
};