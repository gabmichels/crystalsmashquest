package {
	public class GameConstants {

		public static const GRID_ROWS 					: int = 8;
		public static const GRID_COLS 					: int = 8;
		public static const GRID_CELL_SIZE 				: int = 43;
		public static const GRID_XPOS	 				: int = 345;
		public static const GRID_YPOS	 				: int = 120;
		public static const DRAG_DISTANCE				: int = 15;

		// game states
		public static const STATE_APP_INIT				: int = 0;
		public static const STATE_GAME_INIT				: int = 1;
		public static const STATE_GAME_RUNNING			: int = 2;

		public static const MINIMUM_COMBINATION_COUNT	: int = 3;
		public static const HORIZONTAL					: String = "horizontal";
		public static const VERTICAL					: String = "vertical";

		// grid types
		public static const GAME_GRID					: int = 0;
		public static const COLLAPSE_GRID				: int = 1;
		public static const ALL_GRIDS					: int = 2;

	}
}
