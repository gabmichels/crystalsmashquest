package service {
	import model.GridModel;
	import model.vo.GridVo;

	public class GridService implements IGridService{

		[Inject]
		public var gridModel : GridModel;

		public function initGrid():void {
			var totalCells 	: int 				= GameConstants.GRID_ROWS * GameConstants.GRID_COLS;
			var grid 		: Vector.<GridVo> 	= new Vector.<GridVo>();

			for(var i : int = 0; i < totalCells; i++) {
				var idx : int = (i % 8) + 1;
				var idy : int = Math.ceil((i + 1) / 8);
				var x 	: int = (idx - 1) * GameConstants.GRID_CELL_SIZE;
				var y 	: int = (idy - 1) * GameConstants.GRID_CELL_SIZE;

				grid.push(new GridVo(idx, idy, x, y));
			}

			gridModel.grid = grid;
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

			for(var i : int = 0; i < grid.length; i++) {
				currentVo = grid[i];

				if(currentVo.idX == data1.idX && currentVo.idY == data1.idY) {
					currentVo = data2;
				}

				if(currentVo.idX == data2.idX && currentVo.idY == data2.idY) {
					currentVo = data1;
				}
			}

			gridModel.grid = grid;

		}
	}
}
