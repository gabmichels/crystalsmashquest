package view.layer {
	import feathers.controls.Button;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import org.osflash.signals.Signal;

	import starling.animation.Transitions;

	import starling.animation.Tween;
	import starling.core.Starling;

	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;

	public class GUIView extends Sprite{

		public var startSignal 		: Signal = new Signal();
		public var gameOverSignal 	: Signal = new Signal();

		private var _startbutton	: Button;
		private var _label 			: TextField;
		private var _tryAgain		: TextField;
		private var _timer 			: Timer;
		private var _secondsPassed	: int;


		public function GUIView() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void {
			_startbutton 			= new Button();
			_startbutton.label 		= "START GAME";
			_startbutton.x 			= 80;
			_startbutton.y 			= 30;
			_startbutton.addEventListener(Event.TRIGGERED, handleStartClick);

			_secondsPassed 			= GameConstants.ROUND_TIME;

			_label 					= new TextField(400,100,"","GoodGirl", 65, 0xFF6600 );
			_label.x				= 100;
			_label.y 				= 100;
			_label.autoSize 		= TextFieldAutoSize.BOTH_DIRECTIONS;

			_tryAgain 				= new TextField(stage.stageWidth,stage.stageHeight,"Wasn't that fun?! Try Again!","GoodGirl", 65, 0xFFFFFF );
			_tryAgain.x 			= (stage.stageWidth / 2) - (_tryAgain.width / 2);
			_tryAgain.y 			= (stage.stageHeight / 2) - (_tryAgain.height / 2) - 100;
			_tryAgain.visible		= false;

			addChild(_tryAgain);
			addChild(_label);
			addChild(DisplayObject(_startbutton));
		}

		private function handleGameOver(event:TimerEvent):void {
			var tween : Tween;

			tween 					= new Tween(_tryAgain, 3, Transitions.LINEAR);
			_tryAgain.visible 		= true;
			_tryAgain.alpha			= 1;
			_label.text				= "";

			tween.delay = 3;
			tween.fadeTo(0);

			Starling.juggler.add(tween);
			gameOverSignal.dispatch();
		}

		private function handleCountdown(event:TimerEvent):void {
			_label.text 			= String(--_secondsPassed);
		}

		private function handleStartClick(event:Event):void {
			_startbutton.label 		= "RESTART GAME";
			_label.text 			= String(GameConstants.ROUND_TIME);
			startSignal.dispatch();

			_tryAgain.visible 		= false;

			if(!_timer) {
				_timer = new Timer(1000, GameConstants.ROUND_TIME);
				_timer.addEventListener(TimerEvent.TIMER, handleCountdown);
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
