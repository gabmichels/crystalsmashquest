package model {
	import model.vo.CrystalVo;

	public class CrystalModel {

		private var _crystals:Vector.<CrystalVo> = new <CrystalVo>[];

		public function get crystals():Vector.<CrystalVo> {
			return _crystals;
		}

		public function set crystals(value:Vector.<CrystalVo>):void {
			_crystals = value;
		}

	}
}
