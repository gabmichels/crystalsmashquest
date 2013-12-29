package view {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;

	import model.vo.GridVo;

	import org.osflash.signals.Signal;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.events.Event;

	public class GridView extends Sprite {

		public var gridComplete : Signal;

		public function GridView() {
			gridComplete = new Signal();
		}

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

			gridComplete.dispatch();
		}
	}
}
