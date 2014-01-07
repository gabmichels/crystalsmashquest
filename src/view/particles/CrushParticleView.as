package view.particles {
	import org.osflash.signals.Signal;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	public class CrushParticleView extends Sprite{

		public var returnSignal : Signal;

		private var _particles 	: PDParticleSystem;
		private var _xml 		: XML;
		private var _texture 	: Texture;
		private var _refId 		: int;

		public function CrushParticleView(xml : XML, texture : Texture) {
			returnSignal 				= new Signal();
			_xml 						= xml;
			_texture 					= texture;

			_particles = new PDParticleSystem(_xml, _texture);
			addChild(_particles);
		}

		public function init() : void {
			_particles.start(0.3);
			Starling.juggler.add(_particles);
			addEventListener(Event.ENTER_FRAME,checkParticleLifetime);
		}

		private function checkParticleLifetime(event:Event):void {
			if(!_particles.isEmitting) {
				removeEventListener(Event.ENTER_FRAME,checkParticleLifetime);
				returnSignal.dispatch(this)
			}
		}

		public function get refId():int {
			return _refId;
		}

		public function set refId(value:int):void {
			_refId = value;
		}
	}
}
