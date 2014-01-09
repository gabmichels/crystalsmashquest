package view {
	import model.vo.GridVo;
	import model.vo.SwapCrystalVo;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.notifications.CollapseCompleteSignal;
	import signals.notifications.GameOverSignal;
	import signals.notifications.GameStartSignal;
	import signals.notifications.GridUpdateSignal;
	import signals.notifications.ResetCompleteSignal;
	import signals.notifications.RestartSignal;
	import signals.notifications.ReturnParticleSignal;
	import signals.notifications.SwapCrystalsSignal;
	import signals.requests.RequestCollapseSignal;
	import signals.requests.RequestGridSignal;
	import signals.requests.RequestParticleSignal;
	import signals.response.ResponseCollapseSignal;
	import signals.response.ResponseGridSignal;
	import signals.response.ResponseParticleSignal;

	import view.particles.CrushParticleView;

	public class GridMediator extends StarlingMediator{

		[Inject]
		public var gridView 			: GridView;

		[Inject]
		public var gameStartSignal 		: GameStartSignal;

		[Inject]
		public var requestGridSignal 	: RequestGridSignal;

		[Inject]
		public var responseGridSignal 	: ResponseGridSignal;

		[Inject]
		public var swapSignal			: SwapCrystalsSignal;

		[Inject]
		public var updategrid 			: GridUpdateSignal;

		[Inject]
		public var resetComplete 		: ResetCompleteSignal;

		[Inject]
		public var requestCollapse		: RequestCollapseSignal;

		[Inject]
		public var responseCollapse		: ResponseCollapseSignal;

		[Inject]
		public var collapseComplete		: CollapseCompleteSignal;

		[Inject]
		public var requestParticle		: RequestParticleSignal;

		[Inject]
		public var responseParticle		: ResponseParticleSignal;

		[Inject]
		public var returnParticle		: ReturnParticleSignal;

		[Inject]
		public var gameOverSignal		: GameOverSignal;

		[Inject]
		public var restartSignal		: RestartSignal;


		override public function initialize():void {

			gameStartSignal.add(handleGameStart);
			responseGridSignal.add(handleGridResponse);
			updategrid.add(handleGridUpdate);
			gridView.requestCollapseSignal.add(handleRequestCollapse);
			gridView.requestParticleSignal.add(handleRequestParticle);
			gridView.swapSignal.add(handleCrystalSwap);
			resetComplete.add(handleResetComplete);
			responseCollapse.add(handleResponseCollapse);
			collapseComplete.add(handleCollapseComplete);
			responseParticle.add(handleResponseParticle);
			swapSignal.add(handleSwap);
			gameOverSignal.add(handleGameOver);
			restartSignal.add(handleGameRestart)
		}

		private function handleGameRestart():void {
			gridView.touchable = true;
		}

		private function handleGameOver():void {
			gridView.touchable = false;
		}

		private function handleCrystalSwap(data : SwapCrystalVo):void {
			swapSignal.dispatch( data );
		}


		private function handleResponseParticle(particle : CrushParticleView, vo : GridVo):void {
			gridView.addParticle(particle, vo);
		}

		private function handleRequestParticle(vo : GridVo):void {
			requestParticle.dispatch(vo);
		}

		private function handleCollapseComplete():void {
			gridView.checkCollapseStatus();
		}

		private function handleResponseCollapse(collapseData : Vector.<GridVo>):void {
			gridView.collapse(collapseData);
		}

		private function handleResetComplete():void {
			gridView.checkCrushingComplete();
		}

		private function handleRequestCollapse(vo : Vector.<GridVo>):void {
			requestCollapse.dispatch(vo);
		}

		private function handleGridUpdate(grid : Vector.<GridVo>):void {
			gridView.grid = grid;
		}

		private function handleGridResponse(data : Vector.<GridVo>):void {
			responseGridSignal.remove(handleGridResponse);
			gridView.init(data);
		}

		private function handleGameStart():void {
			gameStartSignal.remove(handleGameStart);
			requestGridSignal.dispatch();
		}

		private function handleSwap(data : SwapCrystalVo):void {
			gridView.swapCrystals(data);
		}

	}
}
