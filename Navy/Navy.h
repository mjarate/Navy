#include "ark_macros.h"

// ark_scripts
// Contains config values to be used in the future.

// For Modules
class CfgFactionClasses {
    class NO_CATEGORY;
    class Navy: NO_CATEGORY {
        displayName = "Navy";
    };
};

class CfgVehicles {
    #include "navy_modules.hpp"
};

class Navy {
    
};