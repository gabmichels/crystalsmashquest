package view.layer {
	import feathers.controls.Button;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;

	public class GUIView extends Sprite{

		public var startSignal 		: Signal = new Signal();
		public var gameOverSignal 	: Signal = new Signal();

		private var _startbutton	: Button;
		private var _label 			: TextField;
		private var _timer 			: Timer;
		private var _secondsPassed	: int;


		public function GUIView() {
			_startbutton = new Button();
			_startbutton.label = "START GAME";
			_startbutton.x = 80;
			_startbutton.y = 30;

			_secondsPassed = GameConstants.ROUND_TIME;

			_label = new TextField(400,100,"","GoodGirl", 65, 0xFF6600 );
			_label.x = 100;
			_label.y = 100;
			_label.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;

			addChild(_label);
			addChild(DisplayObject(_startbutton));

			_startbutton.addEventListener(Event.TRIGGERED, handleStartClick);
		}

		private function handleGameOver(event:TimerEvent):void {
			gameOverSignal.dispatch();
			_label.text = "GAME OVER";
		}

		private function handleCountdown(event:TimerEvent):void {
			_label.text = String(--_secondsPassed);
		}

		private function handleStartClick(event:Event):void {
			startSignal.dispatch();
			_startbutton.label = "RESTART GAME";
			_label.text = String(GameConstants.ROUND_TIME);

			if(!_timer) {
				_timer = new Timer(1000, GameConstants.ROUND_TIME);
				_timer.addEventListener(TimerEvent.TIMER, handleCountdown)
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, handleGameOver);
				_timer.start();
			} else {
				_timer.reset();
				_timer.start();
				_secondsPassed = GameConstants.ROUND_TIME;
			}

		}
	}
}
