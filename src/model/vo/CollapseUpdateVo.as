package model.vo {
	public class CollapseUpdateVo {

		public var id 				: int;
		public var oldVo			: GridVo;
		public var collapseCount 	: int;

		public function CollapseUpdateVo(id, oldVo : GridVo, count : int) {
			this.id 			= id;
			this.oldVo 			= oldVo;
			this.collapseCount 	= count;
		}
	}
}
