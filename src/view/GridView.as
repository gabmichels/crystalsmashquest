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
				crystal.id	= i + 1;
				addChild(crystal);
				_crystals.push(crystal);
			}
		}

		public function swapCrystals(data1 : GridVo, data2 : GridVo) : void {
			var crystal1 	: CrystalView 	= getCrystalById(data1.crystalID);
			var crystal2 	: CrystalView 	= getCrystalById(data2.crystalID);
			var tween1		: Tween 		= new Tween(crystal1, 0.2, Transitions.EASE_IN);
			var tween2		: Tween 		= new Tween(crystal2, 0.2, Transitions.EASE_IN);

			tween1.moveTo(data2.x, data2.y);
			tween2.moveTo(data1.x, data1.y);

			Starling.juggler.add(tween1);
			Starling.juggler.add(tween2);

		}

		private function getCrystalById(id : int) : CrystalView {
			for(var i : int = 0; i < _crystals.length; i++) {
				if(id == _crystals[i].id) {
					return _crystals[i];
				}
			}
			return null;
		}
	}
}
