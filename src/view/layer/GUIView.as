package view.layer {
	import feathers.controls.Button;

	import org.osflash.signals.Signal;

	import starling.display.Sprite;
	import starling.events.Event;

	import view.particles.CrushParticleView;

	public class GUIView extends Sprite{

		public var startSignal : Signal = new Signal();

		public function GUIView() {
			var startButton : Button = new Button();
			startButton.label = "START";
			startButton.x = 100;
			startButton.y = 100;
			addChild(startButton);

			startButton.addEventListener(Event.TRIGGERED, handleStartClick);
		}

		private function handleStartClick(event:Event):void {
			startSignal.dispatch();
		}
	}
}
