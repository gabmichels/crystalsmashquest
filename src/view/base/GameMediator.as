package view.base {
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.notifications.CrystalsLoadedSignal;
	import signals.requests.GameStartupSignal;

	import starling.core.Starling;

	import view.layer.GUIView;

	public class GameMediator extends StarlingMediator{

		[Inject]
		public var logger:ILogger;

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

			logger.info( "initialized" );

			gameStartupSignal.dispatch();
			crystalLoaded.add(handleGameLoaded);

		}

		private function handleGameLoaded():void {
			trace("game loaded -> show start layer");
			view.showLayer();
		}



	}
}
