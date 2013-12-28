package view {
	import model.CrystalModel;
	import model.GridModel;

	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.notifications.GameStartSignal;

	import signals.requests.GameStartupSignal;

	public class GridMediator extends StarlingMediator{

		[Inject]
		public var logger			: ILogger;

		[Inject]
		public var gridView 		: GridView;

		[Inject]
		public var gridModel 		: GridModel;

		[Inject]
		public var gameStartSignal 	: GameStartSignal;

		public function GridMediator() {
			trace("grid mediator")
		}

		override public function initialize():void {

			logger.info( "initialized" );
			gameStartSignal.add(handleGameStart);

		}

		private function handleGameStart():void {
			gridView.init(gridModel.grid);
		}



	}
}
