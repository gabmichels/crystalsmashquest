package controller {
	import flash.text.Font;

	import model.GameModel;

	import service.ILoadFileService;
	import service.IGridService;

	public class GameStartupCommand {

		[Embed(source="/../assets/release/GOODGIRL.TTF", fontName="GoodGirl", fontWeight="normal", advancedAntiAliasing="true", embedAsCFF=false, mimeType = "application/x-font")]
		public var GoodGirl : Class;

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
			Font.registerFont(GoodGirl);
		}
	}
}
