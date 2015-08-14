#include "navy_macros.h"

navy_config_fnc_getNumber = {
    FUN_ARGS_3(_config,_class,_field);
    
    getNumber (_config >> _class >> _field);
};

navy_config_fnc_getBool = {
    FUN_ARGS_3(_config,_class,_field);
    
    getNumber (_config >> _class >> _field) == 1;
};

navy_config_fnc_getArray = {
    FUN_ARGS_3(_config,_class,_field);
    
    getArray (_config >> _class >> _field);
};

navy_config_fnc_getText = {
    FUN_ARGS_3(_config,_class,_field);
    
    getText (_config >> _class >> _field);
};