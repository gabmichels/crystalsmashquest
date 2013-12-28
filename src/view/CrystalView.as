package view {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;

	import model.vo.GridVo;

	import org.osflash.signals.Signal;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class CrystalView extends Sprite
	{
		private var _vo : GridVo;

		public function CrystalView(vo : GridVo) {
			_vo = vo;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void {
//			var w : int = GameConstants.GRID_CELL_SIZE;
//			var h : int = GameConstants.GRID_CELL_SIZE;
//			var s2:flash.display.Shape = new flash.display.Shape();
//			s2.graphics.beginFill(Math.random() * 0xFFFFFF, 1);
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

		public function init(bmp : Bitmap) : void {
			var texture	:Texture 	= Texture.fromBitmap(bmp);
			var img		:Image 		= new Image(texture);
			addChild(img);
		}

		public function get vo():GridVo {
			return _vo;
		}

		public function set vo(value:GridVo):void {
			_vo = value;
		}
	}
}
