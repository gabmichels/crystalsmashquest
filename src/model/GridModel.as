package model {
	import model.vo.GridVo;

	import signals.notifications.GridUpdateSignal;
	import signals.response.ResponseGridObjectUpdateSignal;

	public class GridModel {

		[Inject]
		public var gridUpdateSignal : GridUpdateSignal;
		[Inject]
		public var updateSignal	: ResponseGridObjectUpdateSignal;

		private var _grid : Vector.<GridVo>;

		public function get grid():Vector.<GridVo> {
			return _grid;
		}

		public function set grid(value:Vector.<GridVo>):void {
			_grid = value;
			gridUpdateSignal.dispatch(_grid);
		}

		public function updateGridObject(index : int, vo : GridVo) {
			_grid[index] = vo;
		}
	}
}
