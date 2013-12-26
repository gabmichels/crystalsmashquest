package view {
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.requests.LoadCrystalSignal;

	public class BackgroundMediator extends StarlingMediator{

		[Inject]
		public var logger:ILogger;

		[Inject]
		public var view:BackgroundView;

		public function BackgroundMediator() {
		}

		override public function initialize():void {

			logger.info( "initialized" );

		}



	}
}
