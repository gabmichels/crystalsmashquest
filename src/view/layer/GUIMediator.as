package view.layer {
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.notifications.GameStartSignal;
	import signals.notifications.RestartSignal;

	public class GUIMediator extends StarlingMediator{

		[Inject]
		public var logger			: ILogger;

		[Inject]
		public var startLayerView	: GUIView;

		[Inject]
		public var gameStartSignal 	: GameStartSignal;

		[Inject]
		public var restartSignal 	: RestartSignal;

		public function GUIMediator() {
		}

		override public function initialize():void {

			logger.info( "initialized" );
			startLayerView.startSignal.add(handleGameStart);

		}

		private function handleGameStart():void {
			startLayerView.startSignal.remove(handleGameStart);
			startLayerView.startSignal.add(handleRestart);
			gameStartSignal.dispatch();
		}

		private function handleRestart():void {
			restartSignal.dispatch();
		}



	}
}
