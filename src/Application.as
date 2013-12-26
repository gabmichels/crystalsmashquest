package {
	import bundles.SignalCommandMapBundle;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.impl.Context;
	import robotlegs.extensions.starlingViewMap.StarlingViewMapExtension;

	import starling.core.Starling;

	import view.base.GameView;

	[SWF(width="755", height="600", frameRate="60", backgroundColor="#333333")]
	public class Application extends Sprite{

		private var _starling 	: Starling;
		private var _context	: Context;

		public function Application() {

			stage.align		= StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			// init starling
			Starling.handleLostContext 	= true;
			_starling 					= new Starling(GameView, stage);
			_starling.showStats 		= true;

			// Init Robotlegs.
			_context = new Context();
			_context.install( MVCSBundle, StarlingViewMapExtension, SignalCommandMapBundle );
			_context.configure( AppConfig, this, _starling );
			_context.configure( new ContextView( this ) );

			_starling.start();

		}
	}
}
