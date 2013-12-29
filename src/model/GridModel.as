package model {
	import model.vo.GridVo;

	public class GridModel {

		private var _grid : Vector.<GridVo>;

		public function get grid():Vector.<GridVo> {
			return _grid;
		}

		public function set grid(value:Vector.<GridVo>):void {
			_grid = value;
		}
	}
}
