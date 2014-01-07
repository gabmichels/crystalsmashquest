package view {
	import model.vo.CollapseUpdateVo;
	import model.vo.CrystalVo;
	import model.vo.GridUpdateVo;
	import model.vo.GridVo;
	import model.vo.ResetCrystalVo;
	import model.vo.SwapCrystalVo;

	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.notifications.CollapseCompleteSignal;

	import signals.notifications.CombinationSignal;
	import signals.notifications.GridUpdateSignal;
	import signals.notifications.ResetCompleteSignal;
	import signals.notifications.RestartSignal;
	import signals.notifications.ReturnParticleSignal;
	import signals.notifications.StateUpdateSignal;
	import signals.notifications.SwapCrystalsSignal;
	import signals.requests.RequestCollapseUpdateSignal;
	import signals.requests.RequestCrystalDataSignal;
	import signals.requests.RequestGridObjectUpdateSignal;
	import signals.requests.RequestParticleSignal;
	import signals.requests.RequestResetCrystalSignal;
	import signals.response.ResponseCrystalDataSignal;
	import signals.response.ResponseGridObjectUpdateSignal;
	import signals.response.ResponseParticleSignal;
	import signals.response.ResponseResetCrystalSignal;

	import view.particles.CrushParticleView;

	public class CrystalMediator extends StarlingMediator{

		[Inject]
		public var logger					: ILogger;

		[Inject]
		public var crystalView				: CrystalView;

		[Inject]
		public var requestCrystalData		: RequestCrystalDataSignal;

		[Inject]
		public var responseCrystalData		: ResponseCrystalDataSignal;

		[Inject]
		public var stateSignal				: StateUpdateSignal;

		[Inject]
		public var gridUpdateSignal			: GridUpdateSignal;

		[Inject]
		public var restartSignal			: RestartSignal;

		[Inject]
		public var swapSignal				: SwapCrystalsSignal;

		[Inject]
		public var responseGridObjectUpdate	: ResponseGridObjectUpdateSignal;

		[Inject]
		public var requestGridObjectUpdate	: RequestGridObjectUpdateSignal;

		[Inject]
		public var combinationSignal		: CombinationSignal;

		[Inject]
		public var requestCollapseUpdate	: RequestCollapseUpdateSignal;

		[Inject]
		public var responseReset			: ResponseResetCrystalSignal;

		[Inject]
		public var requestReset				: RequestResetCrystalSignal;

		[Inject]
		public var resetComplete			: ResetCompleteSignal;

		[Inject]
		public var collapseComplete			: CollapseCompleteSignal;


		public function CrystalMediator() {
		}

		override public function initialize():void {
			crystalView.requestSignal.add(handleViewRequest);
			crystalView.swapSignal.add(handleCrystalSwap);
			crystalView.updateGridRefSignal.add(handleGridObjectUpdateRequest);
			crystalView.combinationSignal.add(handleCombinationSignal)
			crystalView.requestCollapseUpdate.add(handleCollapseUpdateRequest);
			crystalView.resetSignal.add(handleRequestReset);
			crystalView.resetComplete.add(handleResetComplete);
			crystalView.collapseComplete.add(handleCollapseComplete);
			responseCrystalData.add(handleDataResponse);
			stateSignal.add(handleStateUpdate);
			restartSignal.add(handleRestart);
			responseGridObjectUpdate.add(handleGridObjectUpdateResponse);
			gridUpdateSignal.add(handleGridUpdate);
			responseReset.add(handleResetResponse);
		}

		private function handleCollapseComplete():void {
			collapseComplete.dispatch();
		}

		private function handleResetComplete():void {
			resetComplete.dispatch();
		}

		private function handleResetResponse(vo : GridVo):void {
			crystalView.updateAfterReset(vo);
		}

		private function handleRequestReset(resetVo : ResetCrystalVo):void {
			requestReset.dispatch(resetVo);
		}

		private function handleCollapseUpdateRequest(vo : CollapseUpdateVo):void {
			requestCollapseUpdate.dispatch(vo);
		}

		private function handleCombinationSignal(combo : Vector.<GridVo>):void {
			combinationSignal.dispatch(combo);
		}

		private function handleGridObjectUpdateRequest(vo : GridUpdateVo):void {
			requestGridObjectUpdate.dispatch(vo)
		}

		private function handleGridUpdate(grid : Vector.<GridVo>):void {
			crystalView.gridData = grid;
		}

		private function handleGridObjectUpdateResponse(newVo : GridVo):void {
			crystalView.update(newVo);
		}

		private function handleCrystalSwap(data : SwapCrystalVo):void {
			swapSignal.dispatch( data );
		}

		private function handleRestart():void {
			gridUpdateSignal.addOnce(handleRestartGridUpdate);
		}

		private function handleRestartGridUpdate(grid : Vector.<GridVo>):void {
			crystalView.init(grid);
		}

		private function handleStateUpdate(newState : int):void {
			crystalView.state = newState;
		}

		private function handleViewRequest():void {
		 	requestCrystalData.dispatch();
		}

		private function handleDataResponse(grid : Vector.<GridVo>, crystals : Vector.<CrystalVo>, state : int) : void {
			responseCrystalData.remove(handleDataResponse);
			crystalView.init(grid, crystals, state);
		}
	}
}
