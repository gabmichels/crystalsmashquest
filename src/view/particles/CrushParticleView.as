package view.particles {
	import org.osflash.signals.Signal;

	import starling.core.Starling;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	public class CrushParticleView extends Sprite{

		public var requestParticleDataSignal : Signal;
		public var destroySignal : Signal;

		private var _particles : PDParticleSystem;

		public function CrushParticleView() {
			requestParticleDataSignal 	= new Signal();
			destroySignal 				= new Signal();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void {
			requestParticleDataSignal.dispatch();
		}

		public function init(xml : XML, texture : Texture) : void {
			_particles = new PDParticleSystem(xml, texture);
			addChild(_particles);
			_particles.start(0.3);
			Starling.juggler.add(_particles);
			addEventListener(Event.ENTER_FRAME,checkParticleLifetime);
		}


		override public function dispose():void {
			super.dispose();

			Starling.juggler.remove(_particles);
			removeChild(_particles, true);
			_particles = null;
		}

		private function checkParticleLifetime(event:Event):void {
			if(!_particles.isEmitting) {
				removeEventListener(Event.ENTER_FRAME,checkParticleLifetime);
				destroySignal.dispatch(this);
			}
		}

	}
}
