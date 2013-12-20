package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import starling.core.Starling;

	import view.base.GameStart;

	[SWF(width="755", height="600", frameRate="60", backgroundColor="#333333")]
	public class Application extends Sprite{

		private var _starling : Starling;

		public function Application() {

			stage.align		= StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			// init starling
			Starling.handleLostContext 	= true;
			_starling 					= new Starling(GameStart, stage);
			_starling.showStats 		= true;

			_starling.start();

		}
	}
}
