package service {
	import model.GridModel;
	import model.vo.CollapseUpdateVo;
	import model.vo.GridUpdateVo;
	import model.vo.GridVo;

	import signals.response.ResponseCollapseSignal;

	import signals.response.ResponseGridObjectUpdateSignal;
	import signals.response.ResponseResetCrystalSignal;

	public class GridService implements IGridService{

		[Inject]
		public var gridModel 			: GridModel;

		[Inject]
		public var gridObjectUpdate 	: ResponseGridObjectUpdateSignal;

		[Inject]
		public var resetCrystalResponse : ResponseResetCrystalSignal;

		[Inject]
		public var collapseColumnResponse : ResponseCollapseSignal;


		public function initGrid():void {
			var totalCells 		: int 				= GameConstants.GRID_ROWS * GameConstants.GRID_COLS;
			var grid 			: Vector.<GridVo> 	= new Vector.<GridVo>();
			var collapsegrid 	: Vector.<GridVo> 	= new Vector.<GridVo>();

			for(var i : int = 0; i < totalCells; i++) {
				var idx : int = (i % 8) + 1;
				var idy : int = Math.ceil((i + 1) / 8);
				var x 	: int = (idx - 1) * GameConstants.GRID_CELL_SIZE;
				var y 	: int = (idy - 1) * GameConstants.GRID_CELL_SIZE;
				var id	: int = -1;

				grid.push(new GridVo(id, idx, idy, x, y));
				collapsegrid.push(new GridVo(id, idx, -idy, x, -y - GameConstants.GRID_CELL_SIZE));
			}

			gridModel.grid = grid;
			gridModel.collapseGrid = collapsegrid;
		}

		public function resetColors() : void {
			var grid 		: Vector.<GridVo> 	= gridModel.grid;
			var cell 		: GridVo;

			for(var i : int = 0; i < grid.length; i++) {
				cell 		= grid[i];
				cell.color 	= null;
			}

			gridModel.grid = grid;
		}

		public function swapCrystals(data1 : GridVo, data2 : GridVo) : void {
			var grid 		: Vector.<GridVo> 	= gridModel.grid;
			var currentVo 	: GridVo;
			var id1			: int				= data1.crystalID;
			var id2			: int				= data2.crystalID;
			var color1 		: String			= data1.color;
			var color2 		: String			= data2.color;

			for(var i : int = 0; i < grid.length; i++) {
				currentVo = grid[i];

				if(currentVo.idX == data1.idX && currentVo.idY == data1.idY) {
					updateGridObject(new GridUpdateVo(id2, color2,data1));
				} else if (currentVo.idX == data2.idX && currentVo.idY == data2.idY) {
					updateGridObject(new GridUpdateVo(id1, color1,data2));
				}
			}

			gridModel.grid = grid;
		}

		public function updateGridObject(vo : GridUpdateVo) : void {
			var updatedVo 	: GridVo 			= vo.gridVo;
			updatedVo.crystalID 				= vo.crystalID;
			updatedVo.color 					= vo.color;
			gridObjectUpdate.dispatch(updatedVo);
		}

		public function collapseUpdate(data:CollapseUpdateVo):void {
			var oldVo : GridVo			= data.oldVo;
			var collapseCount : int 	= (oldVo.idY < 1) ? data.collapseCount + 1 : data.collapseCount; // avoid idY = 0
			var newVo : GridVo 			= getGridById(oldVo.idX, oldVo.idY + collapseCount);

			if(oldVo.idY < 1) {
				updateGridObject(new GridUpdateVo(data.id, oldVo.color,newVo));
				oldVo.crystalID = -1;
				oldVo.color 	= null;
			} else {
				updateGridObject(new GridUpdateVo(data.id, oldVo.color,newVo));
			}
		}

		public function resetCrystal(id:int, color : String, xpos:int):void {
			var columnData		: Vector.<GridVo> = getGridColumn(xpos, GameConstants.COLLAPSE_GRID);
			var currentVo 		: GridVo;

			for(var i : int = 0; i < columnData.length; i++) {
				currentVo = columnData[i];

				if(currentVo.crystalID == -1 && !currentVo.color) {
					currentVo.crystalID = id;
					currentVo.color = color;
					resetCrystalResponse.dispatch(currentVo);
					break;
				}
			}
		}

		public function requestCollapseData(data:GridVo):void {
			var columnData		: Vector.<GridVo> = getGridColumn(data.idX, GameConstants.ALL_GRIDS);
			var collapseData    : Vector.<GridVo> = new <GridVo>[];
			var currentVo 		: GridVo;

			for(var i : int = 0; i < columnData.length; i++) {
				currentVo = columnData[i];

				if(currentVo.idY < data.idY && currentVo.crystalID != -1 && currentVo.color != null) {
					collapseData.push(currentVo);
				}
			}

			collapseColumnResponse.dispatch(collapseData);
		}


		// helper functions

		private function getGridColumn(xpos : int, type : int) : Vector.<GridVo> {
			var grid 	: Vector.<GridVo> 	= getGrid(type);
			var currentVo 		: GridVo;
			var columnData		: Vector.<GridVo> = new <GridVo>[];

			for(var i : int = 0; i < grid.length; i++) {
				currentVo = grid[i];
				if(currentVo.idX == xpos) {
					columnData.push(currentVo);
				}
			}

			return columnData;
		}

		private function getGrid(type : int) : Vector.<GridVo> {
			switch (type) {
				case (GameConstants.GAME_GRID):
					return gridModel.grid;
					break;
				case (GameConstants.COLLAPSE_GRID):
					return gridModel.collapseGrid;
					break;
				case (GameConstants.ALL_GRIDS):
				    return gridModel.collapseGrid.concat(gridModel.grid);
					break;
				default:
					return gridModel.grid;
			}

			return null;
		}

		private function getGridById(x : int, y : int) : GridVo {
			var grid 		: Vector.<GridVo> 	= gridModel.grid;

			for(var i : int = 0; i < grid.length; i++) {
				if(grid[i].idX == x && grid[i].idY == y) {
					return grid[i];
				}
			}

			return null;
		}

	}
}
