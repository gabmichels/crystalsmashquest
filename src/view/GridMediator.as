package view {
	import model.vo.GridVo;

	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.notifications.GameStartSignal;
	import signals.requests.RequestGridSignal;
	import signals.response.ResponseGridSignal;

	public class GridMediator extends StarlingMediator{

		[Inject]
		public var logger				: ILogger;

		[Inject]
		public var gridView 			: GridView;

		[Inject]
		public var gameStartSignal 		: GameStartSignal;

		[Inject]
		public var requestGridSignal 	: RequestGridSignal;

		[Inject]
		public var responseGridSignal 	: ResponseGridSignal;


		override public function initialize():void {

			logger.info( "initialized" );
			gameStartSignal.add(handleGameStart);
			gridView.gridComplete.add(handleGridComplete);
			responseGridSignal.add(handleGridResponse)

		}

		private function handleGridResponse(data : Vector.<GridVo>):void {
			gridView.init(data);
		}

		private function handleGridComplete():void {

		}

		private function handleGameStart():void {
			requestGridSignal.dispatch();
		}



	}
}
