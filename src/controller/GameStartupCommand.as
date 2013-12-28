package controller {
	import model.GameModel;

	import service.ICrystalImageService;
	import service.IGridService;

	public class GameStartupCommand {

		[Inject]
		public var crystalLoader : ICrystalImageService;

		[Inject]
		public var gridService : IGridService;

		[Inject]
		public var gameModel : GameModel;

		public function execute() {
			trace("load images command")
			crystalLoader.loadImages();
			gridService.initGrid();
			gameModel.state = GameConstants.STATE_GAME_INIT;
		}
	}
}
