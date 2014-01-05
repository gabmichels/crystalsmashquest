package view {
	import model.vo.GridVo;

	import starling.animation.Transitions;

	import starling.animation.Tween;
	import starling.core.Starling;

	import starling.display.Sprite;

	public class GridView extends Sprite {

		private var _crystals : Vector.<CrystalView> = new <CrystalView>[];
		private var _grid : Vector.<GridVo>;

		public function init(data:Vector.<GridVo>):void {
			_grid = data;

			var gridData	: GridVo;
			var crystal		: CrystalView;
			for (var i:int = 0; i < data.length; i++) {
				gridData 	= data[i];
				crystal 	= new CrystalView(gridData);
				crystal.x 	= gridData.x;
				crystal.y 	= gridData.y;
				crystal.id	= i + 1;
				addChild(crystal);
				_crystals.push(crystal);
			}
		}

		public function swapCrystals(data1 : GridVo, data2 : GridVo) : void {
			var crystal1 	: CrystalView 	= getCrystalById(data1.crystalID);
			var crystal2 	: CrystalView 	= getCrystalById(data2.crystalID);
			var tween1		: Tween 		= new Tween(crystal1, 0.2, Transitions.EASE_IN);
			var tween2		: Tween 		= new Tween(crystal2, 0.2, Transitions.EASE_IN);

			tween1.onComplete 				= handleTweenComplete;
			tween1.onCompleteArgs 			= [crystal1];

			tween2.onComplete 				= handleTweenComplete;
			tween2.onCompleteArgs 			= [crystal2];



			tween1.moveTo(data2.x, data2.y);
			tween2.moveTo(data1.x, data1.y);

			Starling.juggler.add(tween1);
			Starling.juggler.add(tween2);

		}

		private function handleTweenComplete(target : CrystalView):void {
			target.checkCombination();
//			target.addListener();
		}

		private function getCrystalById(id : int) : CrystalView {
			for(var i : int = 0; i < _crystals.length; i++) {
				if(id == _crystals[i].id) {
					return _crystals[i];
				}
			}
			return null;
		}

		private function getCrystalByPos(idx : int, idy : int) : CrystalView {
			for(var i : int = 0; i < _crystals.length; i++) {
				if(idx == _crystals[i].vo.idX && idy == _crystals[i].vo.idY) {
					return _crystals[i];
				}
			}
			return null;
		}

		public function crushCrystals(data:Vector.<GridVo>):void {
			var crystal : CrystalView;

			for(var i : int = 0; i < data.length; i++) {
				crystal = getCrystalById(data[i].crystalID);
				crystal.crush();
			}
		}

		public function initCollapse(data:Vector.<GridVo>):void {
			var collapseRowCount 		: Vector.<int>	= getCollapseCount(data);
			var currentVo 				: GridVo;
			var currentCollapseCount 	: int;
			var vList					: Vector.<GridVo>
			data.sort(sortDataX);

			vList = getVerticalList(data);

			if(vList.length > 0)
				data.push(vList[0]);

			for(var i : int = 0; i < data.length; i++) {
				currentVo = data[i];
				currentCollapseCount = collapseRowCount[currentVo.idX - 1];

				if(currentCollapseCount > 0) {
					collapseCrystals(getAllCollapsableCrystals(currentVo), currentCollapseCount);
				}
			}
		}

		private function collapseCrystals(crystals:Vector.<CrystalView>, collapseCount : int):void {
			var crystal : CrystalView;

			for(var i : int = 0; i < crystals.length; i++) {
				crystal = crystals[i];
				crystal.collapse(collapseCount);
			}
		}

		private function getAllCollapsableCrystals(vo : GridVo) : Vector.<CrystalView> {

			var crystals : Vector.<CrystalView> = new <CrystalView>[];

			for(var i : int = 0; i < _crystals.length; i++) {
				if(_crystals[i].vo.idX == vo.idX && _crystals[i].vo.idY < vo.idY) {
					crystals.push(_crystals[i]);
				}
			}

			return crystals;
		}


		private function getVerticalList(data:Vector.<GridVo>):Vector.<GridVo> {
			var idx 		: int;
			var vList 		: Vector.<GridVo> = new <GridVo>[];

			for(var i : int = 0; i < data.length; i++) {
				idx = data[i].idX;
				if((i + 1) < data.length - 1 && data[i + 1].idX == idx) {
					while(i < data.length && idx == data[i].idX ) {
						vList.push(data[i]);
						data.splice(i,1);
					}
					break;
				}
			}

			return vList.sort(sortDataY);
		}

		private function getCollapseCount(data:Vector.<GridVo>): Vector.<int> {
			var currentVo 			: GridVo;
			var collapseRowCount 	: Vector.<int> = new <int>[0,0,0,0,0,0,0,0];

			for(var i : int = 0; i < data.length; i++) {
				currentVo = data[i];
				collapseRowCount[currentVo.idX - 1] += 1;
			}

			return collapseRowCount;
		}

		// sort functions
		private function sortDataY(x : GridVo, y : GridVo):int {
			if(x.idY < y.idY) {
				return -1
			} else if(x.idY == y.idY){
				return 0;
			} else {
				return 1;
			}
		}

		private function sortDataX(x : GridVo, y : GridVo):int {
			if(x.idX < y.idX) {
				return 1
			} else if(x.idX == y.idX){
				return 0;
			} else {
				return -1;
			}
		}

	}
}
