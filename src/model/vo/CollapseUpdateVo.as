package model.vo {
	public class CollapseUpdateVo {

		public var id 		: int;
		public var idx		: int;
		public var idy		: int;
		public var color	: String;

		public function CollapseUpdateVo(id, color, idx, idy) {
			this.id 		= id;
			this.idx 		= idx;
			this.idy 		= idy;
			this.color 		= color;
		}
	}
}
