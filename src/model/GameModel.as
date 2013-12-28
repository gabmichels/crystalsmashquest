package model {
	public class GameModel {
		private var _state : int;

		public function get state():int {
			return _state;
		}

		public function set state(value:int):void {
			_state = value;
		}
	}
}
