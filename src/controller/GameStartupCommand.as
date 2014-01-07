package controller {
	import model.GameModel;

	import service.ILoadFileService;
	import service.IGridService;

	public class GameStartupCommand {

		[Inject]
		public var fileLoader : ILoadFileService;

		[Inject]
		public var gridService : IGridService;

		[Inject]
		public var gameModel : GameModel;

		public function execute() : void {
			fileLoader.loadCrystalImages();
			fileLoader.loadParticles();
			gridService.initGrid();
			gameModel.state = GameConstants.STATE_GAME_INIT;
		}
	}
}
