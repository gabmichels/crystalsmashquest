package view {
	import model.vo.GridVo;

	import org.osflash.signals.Signal;

	import starling.animation.Transitions;

	import starling.animation.Tween;
	import starling.core.Starling;

	import starling.display.Sprite;

	public class GridView extends Sprite {

		public var combinationSignal	: Signal;

		private var _crystals : Vector.<CrystalView> = new <CrystalView>[];
		private var _grid : Vector.<GridVo>;
		private var _count : int = 0;

		public function GridView() {
			combinationSignal = new Signal();
		}

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

			tween1.moveTo(data2.x, data2.y);
			tween2.moveTo(data1.x, data1.y);

			Starling.juggler.add(tween1);
			Starling.juggler.add(tween2);

		}

		private function handleTweenComplete():void {
			initCombinationLookup();
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

		public function destroyCrystal(id : int) : void {
			for(var i : int = 0; i < _crystals.length; i++) {
				if(_crystals[i].id == id) {
					_crystals.splice(i,1);
					break;
				}
			}
		}

		public function crushCrystals(data:Vector.<GridVo>):void {
			var currentVo 				: GridVo;
			var crystal 				: CrystalView;
			var collapseRowCount 		: Vector.<int>	= getCollapseCount(data);
			var currentCollapseCount 	: int;

			for(var i : int = 0; i < data.length; i++) {
				currentVo 	= data[i];
				crystal 	= getCrystalById(data[i].crystalID);
				currentCollapseCount = collapseRowCount[currentVo.idX - 1];
				if(crystal)
					crystal.crush();
			}
		}
		// collapse functions
		public function initCollapse(data:Vector.<GridVo>):void {
			var collapseRowCount 		: Vector.<int>	= getCollapseCount(data);
			var currentVo 				: GridVo;
			var currentCollapseCount 	: int;
			var vList					: Vector.<GridVo>;
			_count = 0;
			data.sort(sortDataX);

			vList = getVerticalList(data);

			if(vList.length > 0)
				data.push(vList[0]);

			for(var i : int = 0; i < data.length; i++) {
				currentVo = data[i];
				currentCollapseCount = collapseRowCount[currentVo.idX - 1];

				if(currentCollapseCount > 0) {
					var test : Vector.<CrystalView> = getAllCollapsableCrystals(currentVo);
//					collapseCrystals(test, currentCollapseCount);
				}
			}
			trace("dropcount: ",_count);
		}

		private function collapseCrystals(crystals:Vector.<CrystalView>, collapseCount : int):void {
			var crystal : CrystalView;

			for(var i : int = 0; i < crystals.length; i++) {
				_count++;
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
				if((i + 1) < data.length && data[i + 1].idX == idx) {
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

		// combination check functions

		public function initCombinationLookup() : void {
			var data 		: Vector.<GridVo>;
			var combo 		: Vector.<GridVo>;
			var allCombos 	: Vector.<GridVo> = new <GridVo>[];
			var i 			: int;

			for(i = 1; i <= GameConstants.GRID_COLS; i++) {
				data = getColumnData(i);
				combo = checkCombination(data);

				if(data.length > 0 && allCombos.length > 0 && combo) {
					allCombos = allCombos.concat(combo);
				} else if(data.length > 0 && allCombos.length == 0 && combo){
					allCombos = combo;
				}
			}

			for(i = 1; i <= GameConstants.GRID_ROWS; i++) {
				data = getRowData(i);
				combo = checkCombination(data);

				if(data.length > 0 && allCombos.length > 0 && combo) {
					allCombos = allCombos.concat(combo);
				} else if(data.length > 0 && allCombos.length == 0 && combo){
					allCombos = combo;
				}
			}

			allCombos = mergeCombinations(allCombos.sort(sortDataID));

			crushCrystals(allCombos);
			initCollapse(allCombos);
		}

		private function mergeCombinations(data:Vector.<GridVo>):Vector.<GridVo> {
			var id : int;

			for(var i : int = data.length - 1; i >= 0; i--) {
				id = data[i].crystalID;
				if((i - 1) >= 0) {
					if(data[i - 1].crystalID == id) {
						data.splice(i,1);
					}
				}
			}

			return data;
		}

		private function checkCombination(list:Vector.<GridVo>):Vector.<GridVo> {
			var currentVo 		: GridVo;
			var nextVo 			: GridVo;
			var prevVo 			: GridVo;
			var combination 	: Vector.<GridVo> = new <GridVo>[];
			var tempCombo	 	: Vector.<GridVo> = new <GridVo>[];
			var rest			: int = list.length;

			for(var i : int = 0; i < list.length; i++) {
				currentVo = list[i];
				nextVo =(i + 1 < list.length) ? list[i + 1] : null;
				prevVo =(i > 0) ? list[i - 1] : null;

				if(currentVo.color) {
					if(nextVo) {
						if(currentVo.color == nextVo.color && (rest + tempCombo.length) >= GameConstants.MINIMUM_COMBINATION_COUNT) {
							tempCombo.push(currentVo);
						} else if(currentVo.color != nextVo.color) {
							if(prevVo && currentVo.color == prevVo.color) {
								tempCombo.push(currentVo);

								if(tempCombo.length >= GameConstants.MINIMUM_COMBINATION_COUNT) {
									if(combination.length == 0) {
										combination = tempCombo;
									} else {
										combination = combination.concat(tempCombo);
									}
								}
							}

							if(rest >= GameConstants.MINIMUM_COMBINATION_COUNT)
								tempCombo = new <GridVo>[];

						} else if(currentVo.color != nextVo.color && tempCombo.length >= GameConstants.MINIMUM_COMBINATION_COUNT && rest >= GameConstants.MINIMUM_COMBINATION_COUNT) {

							if(combination.length == 0) {
								combination = tempCombo;
							} else {
								combination = combination.concat(tempCombo);
							}
							tempCombo = new <GridVo>[];
						}
					} else {
						if(prevVo && currentVo.color == prevVo.color) {
							tempCombo.push(currentVo);

							if(tempCombo.length >= GameConstants.MINIMUM_COMBINATION_COUNT) {
								if(combination.length == 0) {
									combination = tempCombo;
								} else {
									combination = combination.concat(tempCombo);
								}
							}
						}
					}
				}
				rest--;
			}

			if(combination.length >= GameConstants.MINIMUM_COMBINATION_COUNT) {
				return combination;
			} else {
				return null;
			}
		}

		private function getColumnData(id : int) : Vector.<GridVo> {
			var data : Vector.<GridVo> = new <GridVo>[];

			for(var i : int = 0; i < _grid.length; i++) {
				if(_grid[i].idX == id) {
					data.push(_grid[i]);
				}
			}

			return data;
		}

		private function getRowData(id : int) : Vector.<GridVo> {
			var data : Vector.<GridVo> = new <GridVo>[];

			for(var i : int = 0; i < _grid.length; i++) {
				if(_grid[i].idY == id) {
					data.push(_grid[i]);
				}
			}

			return data;
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

		private function sortDataID(x : GridVo, y : GridVo):int {
			if(x.crystalID < y.crystalID) {
				return -1
			} else if(x.crystalID == y.crystalID){
				return 0;
			} else {
				return 1;
			}
		}

		public function get grid():Vector.<GridVo> {
			return _grid;
		}

		public function set grid(value:Vector.<GridVo>):void {
			_grid = value;
		}
	}
}
