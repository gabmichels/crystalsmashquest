package controller {
	import model.CrystalModel;
	import model.GameModel;
	import model.GridModel;
	import model.vo.CrystalVo;
	import model.vo.GridVo;

	import signals.response.ResponseCrystalDataSignal;

	public class GetCrystalDataCommand {

		[Inject]
		public var crystalModel : CrystalModel;

		[Inject]
		public var gameModel 	: GameModel;

		[Inject]
		public var gridModel 	: GridModel;

		[Inject]
		public var response 	: ResponseCrystalDataSignal;

		public function execute() : void {
			var gridData 		: Vector.<GridVo> 		= gridModel.grid;
			var crystalData 	: Vector.<CrystalVo> 	= crystalModel.crystals; // TODO pass all top, left, right, bottom crystals
			var gameState 		: int 					= gameModel.state;

			response.dispatch(gridData, crystalData, gameState);
		}
	}
}
