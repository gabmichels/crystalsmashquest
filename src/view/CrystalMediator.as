package view {
	import flash.display.Bitmap;

	import model.CrystalModel;
	import model.GameModel;
	import model.GridModel;
	import model.vo.CrystalVo;
	import model.vo.GridVo;

	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.display.Image;

	import utils.DictionaryUtils;

	public class CrystalMediator extends StarlingMediator{

		[Inject]
		public var logger			: ILogger;

		[Inject]
		public var crystalView		: CrystalView;

		[Inject]
		public var crystalModel 	: CrystalModel;

		[Inject]
		public var gridModel		: GridModel;

		[Inject]
		public var gameModel		: GameModel;


		public function CrystalMediator() {
		}

		override public function initialize():void {
			if(gameModel.state == GameConstants.STATE_GAME_INIT) {
				startupCrystalCreation();
			} else if(gameModel.state == GameConstants.STATE_GAME_RUNNING) {

			}


		}

		private function startupCrystalCreation():void {
			var vo 			: GridVo = crystalView.vo;
			var bm 			: Bitmap;
			var colorNum 	: int;
			var crystals	: Vector.<CrystalVo> = crystalModel.crystals;

			if(vo.idX > 2 || vo.idY > 2) {

				crystals = getAvailableCrystals(vo);
			}

			colorNum 	= Math.random() * crystals.length;
			bm 			= crystals[colorNum].bitmap;
			vo.color	= crystals[colorNum].color;

			crystalView.init(bm);
		}

		private function getAvailableCrystals(vo : GridVo) : Vector.<CrystalVo> {
			var availableColors : Vector.<CrystalVo> = new <CrystalVo>[];
			var gridDataLeft1 	: GridVo = gridModel.getGridById(vo.idX - 1, vo.idY);
			var gridDataLeft2 	: GridVo = gridModel.getGridById(vo.idX - 2, vo.idY);
			var gridDataTop1 	: GridVo = gridModel.getGridById(vo.idX, vo.idY - 1);
			var gridDataTop2 	: GridVo = gridModel.getGridById(vo.idX, vo.idY - 2);
			var color 			: String;

			for(var i : int = 0; i < crystalModel.crystals.length;i++) {
				color = crystalModel.crystals[i].color;

				if(vo.idX > 2 && vo.idY <= 2) {
					if(!(gridDataLeft1.color == color && gridDataLeft2.color == color)) {
						availableColors.push(crystalModel.crystals[i]);
					}
				} else if(vo.idX <= 2 && vo.idY > 2) {
					if(!(gridDataTop1.color == color && gridDataTop2.color == color)) {
						availableColors.push(crystalModel.crystals[i]);
					}
				}  else if(vo.idX > 2 && vo.idY > 2) {
					if(	!(gridDataTop1.color == color && gridDataTop2.color == color) &&
						!(gridDataLeft1.color == color && gridDataLeft2.color == color)) {
						availableColors.push(crystalModel.crystals[i]);
					}
				}

			}

			return availableColors;
		}
	}
}
