class Routines {
	class Default {
		Flight_Height = 0;
		WP_Count = 3;
		WP_Speed[] = {};
		WP_Type[] = {};
		WP_Behaviour[] = {};
	};
	
	class LOITER {
		Flight_Height = 250;
		WP_Count = 1;
		WP_Speed[] = {"LIMITED"};
		WP_Type[] = {"LOITER"};
		WP_Behaviour[] = {"AWARE"};
	};
	
	class SAD_Cycle {
		Flight_Height = 250;
		WP_Speed[] = {"LIMITED","LIMITED","LIMITED"};
		WP_Type[] = {"SAD","SAD","SAD"};
		WP_Behaviour[] = {"AWARE","AWARE","AWARE"};
	};
	
	class Heli_Insert {
		Flight_Height = 100;
		WP_Speed[] = {"LIMITED","LIMITED","LIMITED"};
		WP_Type[] = {"SAD","SAD","SAD"};
		WP_Behaviour[] = {"AWARE","AWARE","AWARE"};
	};
	
	class Paradrop {
		Flight_Height = 200;
		WP_Speed[] = {"LIMITED","LIMITED","LIMITED"};
		WP_Type[] = {"SAD","SAD","SAD"};
		WP_Behaviour[] = {"AWARE","AWARE","AWARE"};
	};
};