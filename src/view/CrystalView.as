package view {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;

	import flash.display.Bitmap;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class CrystalView extends Sprite
	{
		private var _loader				: ImageLoader;
		private var _stoneImages	 	: Vector.<Sprite>;
		private var _queue				: LoaderMax;

		public function CrystalView() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void {

		}

		private function handleComplete(event:LoaderEvent) : void {
			var bmp 		: Bitmap 	= _loader.rawContent;
			var texture 	: Texture 	= Texture.fromBitmap(bmp);
			var img 	   	: Image		= new Image(texture);
			var sprite 		: Sprite	= new Sprite();

			sprite.addChild(img);
			_stoneImages.push(sprite);
		}

	}
}
