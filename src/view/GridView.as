package view {
	import model.vo.GridVo;

	import starling.display.Sprite;

	public class GridView extends Sprite {

		public function init(data:Vector.<GridVo>):void {
				var gridData	: GridVo;
				var crystal		: CrystalView;
				for (var i:int = 0; i < data.length; i++) {
					gridData 	= data[i];
					crystal 	= new CrystalView(gridData);
					crystal.x 	= gridData.x;
					crystal.y 	= gridData.y;
					addChild(crystal);
				}
		}
	}
}
