package view {
	import model.vo.GridVo;

	import org.osflash.signals.Signal;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;

	import view.particles.CrushParticleView;

	public class GridView extends Sprite {

		public var requestCollapseSignal	: Signal;
		public var requestParticleSignal	: Signal;

		private var _crystals 					: Vector.<CrystalView> = new <CrystalView>[];
		private var _particles 					: Vector.<CrushParticleView> = new <CrushParticleView>[];
		private var _grid 						: Vector.<GridVo>;
		private var _crystalCrushAmount 		: int;
		private var _combinationData			: Vector.<GridVo>;
		private var _crystalCollapseAmount		: int;

		public function GridView() {
			requestCollapseSignal = new Signal();
			requestParticleSignal = new Signal();
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

		public function checkResetStatus():void {
			if(_crystalCrushAmount > 1) {
				_crystalCrushAmount--;
			} else {
				if(_combinationData)
					initCollapse(_combinationData);
			}
		}

		public function checkCollapseStatus():void {
			if(_crystalCollapseAmount > 1) {
				_crystalCollapseAmount--;
			} else {
				trace("check again");
				initCombinationLookup();
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
		}

		private function getCrystalById(id : int) : CrystalView {
			for(var i : int = 0; i < _crystals.length; i++) {
				if(id == _crystals[i].id) {
					return _crystals[i];
				}
			}
			return null;
		}

		public function crushCrystals(data:Vector.<GridVo>):void {
			var currentVo 				: GridVo;
			var crystal 				: CrystalView;
			_crystalCrushAmount = data.length;

			for(var i : int = 0; i < data.length; i++) {
				currentVo 	= data[i];
				crystal 	= getCrystalById(data[i].crystalID);
				if(crystal) {
					crystal.crush();

					requestParticleSignal.dispatch(data[i]);
				}
			}
		}

		public function addParticle(particle : CrushParticleView, vo : GridVo) : void {
			_particles.push(particle);
			addChild(particle);
			particle.init();
			particle.x = vo.x;
			particle.y = vo.y;
		}

		// collapse functions
		public function initCollapse(data:Vector.<GridVo>):void {
			_crystalCollapseAmount = 0;

			data.sort(sortDataByPos);
			data = cleanUpVerticalCombinations(data); // remove all vertical gridvos from data to simplify looking for collapsable crystals

			requestCollapseSignal.dispatch(data);

		}

		public function collapse(collapseData:Vector.<GridVo>):void {
			var crystal 			: CrystalView;
			var collapseCount 		: int;

			_crystalCollapseAmount = collapseData.length;

			trace(_crystalCollapseAmount);

			for(var i : int = collapseData.length - 1; i >= 0; i--) {
				collapseCount = getCollapseCount(collapseData, collapseData[i].idX);
				crystal = getCrystalById(collapseData[i].crystalID);
				crystal.collapse(collapseCount);
			}
		}

		private function getCollapseCount(collapseData : Vector.<GridVo>, xPos : int) : int {
		    var column			: Vector.<GridVo> = new <GridVo>[];
			var collapseCount 	: int = 0;
			var i 				: int;
			var currentVo 		: GridVo;

			for(i = 0; i < collapseData.length; i++) {
				currentVo = collapseData[i];
				if(currentVo.idX == xPos) column.push(currentVo)
			}

			for(i = 0; i < column.length; i++) {
				currentVo = column[i];
				if(currentVo.idY < 0) collapseCount++;

			}

			return collapseCount;
		}


		private function cleanUpVerticalCombinations(data:Vector.<GridVo>) : Vector.<GridVo> {
			var idx 		: int;
			var count 		: int;
			var newlist		: Vector.<GridVo> = new <GridVo>[];

			for(var i : int = 0; i < data.length; i++) {
				idx 	= data[i].idX;
				count 	= 1;

				if((i + count) < data.length && idx == data[i + count].idX) {
					newlist.push(data[i]);
					while((i + count) < data.length && idx == data[i + count].idX) {
						i++;
					}
				} else {
					newlist.push(data[i]);
				}
			}

			return newlist;
		}

		// combination check functions

		public function initCombinationLookup() : void {
			var data 		: Vector.<GridVo>;
			var combo 		: Vector.<GridVo>;
			var i 			: int;

			_combinationData = new Vector.<GridVo>();

			for(i = 1; i <= GameConstants.GRID_COLS; i++) {
				data = getColumnData(i);
				combo = checkCombination(data);

				if(data.length > 0 && _combinationData.length > 0 && combo) {
					_combinationData = _combinationData.concat(combo);
				} else if(data.length > 0 && _combinationData.length == 0 && combo){
					_combinationData = combo;
				}
			}

			for(i = 1; i <= GameConstants.GRID_ROWS; i++) {
				data = getRowData(i);
				combo = checkCombination(data);

				if(data.length > 0 && _combinationData.length > 0 && combo) {
					_combinationData = _combinationData.concat(combo);
				} else if(data.length > 0 && _combinationData.length == 0 && combo){
					_combinationData = combo;
				}
			}

			if(_combinationData) {
				_combinationData = mergeCombinations(_combinationData.sort(sortDataID));

				crushCrystals(_combinationData);
			}
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

		private function sortDataByPos(x : GridVo, y : GridVo):int {

			if(x.idX < y.idX) {
				return -1
			} else if(x.idX == y.idX && x.idY < y.idY){
				return -1;
			} else if(x.idX == y.idX && x.idY > y.idY){
				return 1;
			} else if(x.idX == y.idX && x.idY == y.idY){
				return 0;
			}else {
				return 1;
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

		public function set grid(value:Vector.<GridVo>):void {
			_grid = value;
		}


	}
}
