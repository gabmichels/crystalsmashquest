package view.layer {
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.notifications.GameOverSignal;
	import signals.notifications.GameStartSignal;
	import signals.notifications.RestartSignal;

	public class GUIMediator extends StarlingMediator{


		[Inject]
		public var startLayerView	: GUIView;

		[Inject]
		public var gameStartSignal 	: GameStartSignal;

		[Inject]
		public var restartSignal 	: RestartSignal;

		[Inject]
		public var gameOverSignal 	: GameOverSignal;

		override public function initialize():void {

			startLayerView.startSignal.add(handleGameStart);
			startLayerView.gameOverSignal.add(handleGameOver);

		}

		private function handleGameOver():void {
			gameOverSignal.dispatch();
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
