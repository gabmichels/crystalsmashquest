package controller {
	import model.DataModel;
	import model.GameModel;
	import model.GridModel;
	import model.vo.CrystalVo;
	import model.vo.GridVo;

	import signals.response.ResponseCrystalDataSignal;

	public class GetCrystalDataCommand {

		[Inject]
		public var dataModel 	: DataModel;

		[Inject]
		public var gameModel 	: GameModel;

		[Inject]
		public var gridModel 	: GridModel;

		[Inject]
		public var response 	: ResponseCrystalDataSignal;

		public function execute() : void {
			var gridData 		: Vector.<GridVo> 		= gridModel.grid;
			var crystalData 	: Vector.<CrystalVo> 	= dataModel.crystals;
			var gameState 		: int 					= gameModel.state;

			response.dispatch(gridData, crystalData, gameState);
		}
	}
}
