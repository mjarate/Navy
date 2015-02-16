class Routines {
	class Default {
		WP_Count = 3;
		WP_Speed[] = {};
		WP_Type[] = {};
		WP_Behaviour[] = {};
	};
	
	class LOITER {
		WP_Count = 1;
		WP_Speed[] = {"LIMITED"};
		WP_Type[] = {"LOITER"};
		WP_Behaviour[] = {"AWARE"};
	};
	
	class SAD_Cycle {
		WP_Speed[] = {"LIMITED","LIMITED","LIMITED"};
		WP_Type[] = {"SAD","SAD","SAD"};
		WP_Behaviour[] = {"AWARE","AWARE","AWARE"};
	};
};