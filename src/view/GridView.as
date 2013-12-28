package view {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;

	import model.vo.GridVo;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.events.Event;

	public class GridView extends Sprite
	{

		public function init(data : Vector.<GridVo>) : void {
			var gridData 	: GridVo;
			var crystal     : CrystalView;
			for(var i : int = 0; i < data.length; i++) {
				gridData 	= data[i];
				crystal 	= new CrystalView(gridData);
				crystal.x   = gridData.x;
				crystal.y   = gridData.y;
				addChild(crystal);
			}


//			var w : int = cols * size;
//			var h : int = rows * size;
//			var s2:flash.display.Shape = new flash.display.Shape();
//			s2.graphics.beginFill(0x990000, 1);
//			s2.graphics.drawRect(0, 0, w, h);
//			s2.graphics.endFill();
//
//			var bmpData:BitmapData = new BitmapData(w,h);
//			bmpData.draw(s2);
//
//			var bmp:Image = Image.fromBitmap(new Bitmap(bmpData, "auto", true));
//
//			addChild(bmp)
		}


	}
}
