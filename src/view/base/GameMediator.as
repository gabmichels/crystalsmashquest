package view.base {
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.notifications.CrystalsLoadedSignal;
	import signals.requests.GameStartupSignal;

	import starling.core.Starling;

	public class GameMediator extends StarlingMediator{

		[Inject]
		public var view:GameView;

		[Inject]
		public var _starlingRoot:Starling;

		[Inject]
		public var gameStartupSignal:GameStartupSignal;

		[Inject]
		public var crystalLoaded : CrystalsLoadedSignal;

		public function GameMediator() {
		}

		override public function initialize():void {

			gameStartupSignal.dispatch();
			crystalLoaded.add(handleGameLoaded);

		}

		private function handleGameLoaded():void {

			view.showLayer();
		}



	}
}
