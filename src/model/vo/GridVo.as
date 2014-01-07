package model.vo {
	public class GridVo {

		public var crystalID	: int;
		public var color		: String;

		private var _idX 		: int;
		private var _idY 		: int;
		private var _x 			: int;
		private var _y 			: int;

		public function GridVo(id, idx, idy, x, y) {
			this.crystalID = id;
			_idX = idx;
			_idY = idy;
			_x = x;
			_y = y;
		}

		public function get idX():int {
			return _idX;
		}

		public function get idY():int {
			return _idY;
		}

		public function get x():int {
			return _x;
		}

		public function get y():int {
			return _y;
		}
	}
}
