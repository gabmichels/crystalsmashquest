package view.base {
	import view.*;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.requests.LoadCrystalSignal;

	public class GameMediator extends StarlingMediator{

		[Inject]
		public var logger:ILogger;

		[Inject]
		public var view:GameView;

		[Inject]
		public var loadCrystalSignal:LoadCrystalSignal;

		public function GameMediator() {
		}

		override public function initialize():void {

			logger.info( "initialized" );

			loadCrystalSignal.dispatch();

		}



	}
}
