package model.vo {
	public class GridVo {

		public var crystalID	: int;
		public var idX 			: int;
		public var idY 			: int;
		public var x 			: int;
		public var y 			: int;
		public var color		: String;

		public function GridVo(idx, idy, x, y) {
			this.idX = idx;
			this.idY = idy;
			this.x = x;
			this.y = y;
		}
	}
}
