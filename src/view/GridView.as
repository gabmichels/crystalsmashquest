package view {
	import model.vo.GridVo;

	import starling.animation.Transitions;

	import starling.animation.Tween;
	import starling.core.Starling;

	import starling.display.Sprite;

	public class GridView extends Sprite {

		private var _crystals : Vector.<CrystalView> = new <CrystalView>[];

		public function init(data:Vector.<GridVo>):void {
			var gridData	: GridVo;
			var crystal		: CrystalView;
			for (var i:int = 0; i < data.length; i++) {
				gridData 	= data[i];
				crystal 	= new CrystalView(gridData);
				crystal.x 	= gridData.x;
				crystal.y 	= gridData.y;
				addChild(crystal);
				_crystals.push(crystal);
			}
		}

		public function swapCrystals(data1 : GridVo, data2 : GridVo) : void {
			var crystal1 : CrystalView = getCrystalById(data1.idX, data1.idY);
			var crystal2 : CrystalView = getCrystalById(data2.idX, data2.idY);

			var tween1	:Tween 		= new Tween(crystal1, 0.2, Transitions.EASE_IN);
			var tween2	:Tween 		= new Tween(crystal2, 0.2, Transitions.EASE_IN);
			tween1.moveTo(crystal2.vo.x, crystal2.vo.y);
			tween2.moveTo(crystal1.vo.x, crystal1.vo.y);

			Starling.juggler.add(tween1);
			Starling.juggler.add(tween2);

		}

		private function getCrystalById(x : int, y : int) : CrystalView {
			for(var i : int = 0; i < _crystals.length; i++) {
				if(x == _crystals[i].vo.idX && y == _crystals[i].vo.idY) {
					return _crystals[i];
				}
			}

			return null;
		}
	}
}
