package view.layer {
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.notifications.GameStartSignal;

	public class StartLayerMediator extends StarlingMediator{

		[Inject]
		public var logger:ILogger;

		[Inject]
		public var startLayerView:StartLayerView;

		[Inject]
		public var gameStartSignal : GameStartSignal;

		public function StartLayerMediator() {
		}

		override public function initialize():void {

			logger.info( "initialized" );
			startLayerView.startSignal.add(handleGameStart)

		}

		private function handleGameStart():void {
			// TODO dispatch
			trace("start game from mediator")
			gameStartSignal.dispatch();
		}



	}
}
