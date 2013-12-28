package view {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;

	import flash.display.Bitmap;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class BackgroundView extends Sprite {

		public function BackgroundView() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private var _loader:ImageLoader;
		private var _backgroundImage:Sprite;

		private function onAddedToStage(event:Event):void {
			_loader = new ImageLoader("../assets/release/background.jpg", {onComplete: handleComplete, onError: handleError});
			_loader.load();

			_backgroundImage = new Sprite();
			addChild(_backgroundImage);
		}

		private function handleComplete(event:LoaderEvent):void {
			var bmp		:Bitmap 	= _loader.rawContent;
			var texture	:Texture 	= Texture.fromBitmap(bmp);
			var img		:Image 		= new Image(texture);

			_backgroundImage.addChild(img);
		}

		private function handleError(event:LoaderEvent):void {

		}
	}
}
