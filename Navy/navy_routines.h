class Routines {
    class Default {
        flight_height = 0;
        waypoint_count = 0;
        waypoint_speed[] = {};
        waypoint_type[] = {};
        waypoint_behaviour[] = {};
        waypoint_combatmode[] = {};
        waypoint_statements[] = {{"",""}, {"",""}, {"",""}};
    };

    class Loiter : Default {
        flight_height = 250;
        waypoint_count = 1;
        waypoint_speed[] = {"", "", "LIMITED"};
        waypoint_type[] = {"", "", "LOITER"};
        waypoint_behaviour[] = {"", "", "AWARE"};
        waypoint_combatmode[] = {"", "", "RED"};
    };

    class CAS_Patrol : Default {
        flight_height = 250;
        waypoint_count = 3;
        waypoint_speed[] = {"LIMITED", "LIMITED", "LIMITED"};
        waypoint_type[] = {"SAD", "SAD", "SAD"};
        waypoint_behaviour[] = {"AWARE", "AWARE", "AWARE"};
        waypoint_combatmode[] = {"RED", "RED", "RED"};
        waypoint_statements[] = {{"",""}, {"",""}, {"true","(group this) setCurrentWaypoint [group this,1]"}};
    };

    class Heli_Insert : Default {
        flight_height = 100;
        waypoint_count = 2;
        waypoint_speed[] = {"NORMAL", "FULL"};
        waypoint_type[] = {"MOVE", "MOVE"};
        waypoint_behaviour[] = {"CARELESS", "AWARE"};
        waypoint_combatmode[] = {"BLUE", "BLUE"};
    };

    class Paradrop : Default {
        flight_height = 200;
        waypoint_count = 2;
        waypoint_speed[] = {"", "NORMAL", "NORMAL"};
        waypoint_type[] = {"", "MOVE", "MOVE"};
        waypoint_behaviour[] = {"", "AWARE", "AWARE"};
        waypoint_combatmode[] = {"", "BLUE", "BLUE"};
    };
};