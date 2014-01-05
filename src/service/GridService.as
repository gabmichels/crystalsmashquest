package service {
	import model.GridModel;
	import model.vo.CollapseUpdateVo;
	import model.vo.GridUpdateVo;
	import model.vo.GridVo;

	import signals.response.ResponseGridObjectUpdateSignal;

	public class GridService implements IGridService{

		[Inject]
		public var gridModel : GridModel;

		[Inject]
		public var gridObjectUpdate : ResponseGridObjectUpdateSignal;

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
			var grid 		: Vector.<GridVo> 	= gridModel.grid;
			var currentVo 	: GridVo;
			var updatedVo 	: GridVo 			= vo.gridVo;
			updatedVo.crystalID 				= vo.crystalID;
			updatedVo.color 					= vo.color;
			gridObjectUpdate.dispatch(updatedVo);

			for(var i : int = 0; i < grid.length; i++) {
				currentVo = grid[i];
				if(updatedVo == currentVo) {
					gridModel.updateGridObject(i,updatedVo);
				}
			}
		}

		public function collapseUpdate(data:CollapseUpdateVo):void {
			var vo : GridVo 			= getGridById(data.idx, data.idy);
			vo.crystalID 				= data.id;
			vo.color 					= data.color;
			gridObjectUpdate.dispatch(vo);
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
