package model.vo {
	import flash.display.Bitmap;

	public class CrystalVo {

		public var bitmap 	: Bitmap;
		public var color	: String;

		public function CrystalVo(bitmap, col) {
			this.bitmap 	= bitmap;
			this.color 		= col;
		}
	}
}
