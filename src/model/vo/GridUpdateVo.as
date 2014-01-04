package model.vo {
	public class GridUpdateVo {

		public var crystalID	: int;
		public var color		: String;
		public var gridVo		: GridVo;

		public function GridUpdateVo(id, color, vo) {
			this.crystalID = id;
			this.color = color;
			this.gridVo = vo;
		}
	}
}
