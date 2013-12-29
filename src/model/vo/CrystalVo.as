package model.vo {
	import starling.textures.Texture;

	public class CrystalVo {

		public var texture 	: Texture;
		public var color	: String;

		public function CrystalVo(texture, col) {
			this.texture 	= texture;
			this.color 		= col;
		}
	}
}
