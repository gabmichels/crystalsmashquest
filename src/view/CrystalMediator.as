package view {
	import model.vo.CrystalVo;
	import model.vo.GridVo;

	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.notifications.GridUpdateSignal;

	import signals.notifications.RestartSignal;

	import signals.notifications.StateUpdateSignal;

	import signals.requests.RequestCrystalDataSignal;
	import signals.response.ResponseCrystalDataSignal;

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


		public function CrystalMediator() {
		}

		override public function initialize():void {
			responseCrystalData.add(handleDataResponse);
			crystalView.requestSignal.add(handleViewRequest);
			stateSignal.add(handleStateUpdate);
			restartSignal.add(handleRestart);
		}

		private function handleRestart():void {
			gridUpdateSignal.add(handleGridUpdate);
		}

		private function handleGridUpdate(grid : Vector.<GridVo>):void {
			gridUpdateSignal.remove(handleGridUpdate);
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
