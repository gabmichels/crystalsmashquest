package controller {
	import model.GameModel;

	import service.ICrystalImageService;
	import service.IGridService;

	public class GameRestartCommand {

		[Inject]
		public var crystalLoader : ICrystalImageService;

		[Inject]
		public var gridService : IGridService;

		[Inject]
		public var gameModel : GameModel;

		public function execute() : void {
			gridService.resetColors();
		}
	}
}
