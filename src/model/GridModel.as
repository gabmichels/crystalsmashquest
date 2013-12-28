package model {
	import model.vo.GridVo;

	public class GridModel {

		private var _grid : Vector.<GridVo>;

		public function getGridById(x : int, y : int) : GridVo {

			for(var i : int = 0; i < _grid.length; i++) {
				if(_grid[i].idX == x && _grid[i].idY == y) {
					return _grid[i];
				}
			}

			return null;
		}

		public function get grid():Vector.<GridVo> {
			return _grid;
		}

		public function set grid(value:Vector.<GridVo>):void {
			_grid = value;
		}
	}
}
