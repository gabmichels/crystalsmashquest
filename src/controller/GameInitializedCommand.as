package controller {
	import model.GameModel;

	import service.ICrystalImageService;
	import service.IGridService;

	public class GameInitializedCommand {

		[Inject]
		public var gameModel : GameModel;

		public function execute() {
			gameModel.initialized = true;
		}
	}
}
