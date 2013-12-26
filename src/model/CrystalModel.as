package model {
	import starling.display.Image;

	public class CrystalModel {

		private var _crystalImages:Vector.<Image> = new Vector.<Image>();

		public function get crystalImages():Vector.<Image> {
			return _crystalImages;
		}

		public function set crystalImages(value:Vector.<Image>):void {
			_crystalImages = value;
		}
	}
}
