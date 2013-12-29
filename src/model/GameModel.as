package model {
	import signals.notifications.StateUpdateSignal;

	public class GameModel {

		[Inject]
		public var stateSignal : StateUpdateSignal;

		private var _state : int;
		private var _initialized : Boolean;

		public function get state():int {
			return _state;
		}

		public function set state(value:int):void {
			_state = value;
			stateSignal.dispatch(_state);
		}

		public function get initialized():Boolean {
			return _initialized;
		}

		public function set initialized(value:Boolean):void {
			_initialized = value;
		}
	}
}
