class Routines {
	class Default {
		Flight_Height = 0;
		WP_Speed[] = {};
		WP_Type[] = {};
		WP_Behaviour[] = {};
		WP_CombatMode[] = {};
		WP_Statements[] = {{"",""},{"",""},{"",""}};
	};
	
	class LOITER: Default {
		Flight_Height = 250;
		WP_Speed[] = {"LIMITED"};
		WP_Type[] = {"LOITER"};
		WP_Behaviour[] = {"AWARE"};
		WP_CombatMode[] = {"RED"};
	};
	
	class CAS_Patrol: Default {
		Flight_Height = 250;
		WP_Speed[] = {"LIMITED","LIMITED","LIMITED"};
		WP_Type[] = {"SAD","SAD","SAD"};
		WP_Behaviour[] = {"AWARE","AWARE","AWARE"};
		WP_CombatMode[] = {"RED","RED","RED"};
		WP_Statements[] = {{"",""},{"",""},{"true","(group this) setCurrentWaypoint [group this,1]"}};
	};
	
	class Heli_Insert: Default {
		Flight_Height = 100;
		WP_Speed[] = {"NORMAL","FULL"};
		WP_Type[] = {"MOVE","MOVE"};
		WP_Behaviour[] = {"CARELESS","AWARE"};
		WP_CombatMode[] = {"BLUE","BLUE"};
	};
	
	class Paradrop: Default {
		Flight_Height = 200;
		WP_Speed[] = {"NORMAL","NORMAL"};
		WP_Type[] = {"MOVE","MOVE"};
		WP_Behaviour[] = {"AWARE","AWARE"};
		WP_CombatMode[] = {"BLUE","BLUE"};
	};
};