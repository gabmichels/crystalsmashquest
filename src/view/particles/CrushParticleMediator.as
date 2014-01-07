package view.particles {
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.notifications.DestroyParticleSignal;

	import signals.requests.RequestParticleSignal;
	import signals.response.ResponseParticleSignal;

	import starling.textures.Texture;

	public class CrushParticleMediator extends StarlingMediator{

		[Inject]
		public var pView			: CrushParticleView;

		[Inject]
		public var requestParticle 	: RequestParticleSignal;

		[Inject]
		public var responseParticle : ResponseParticleSignal;

		[Inject]
		public var destroyParticle	: DestroyParticleSignal;


		override public function initialize():void {

			pView.requestParticleDataSignal.add(handleParticleRequest);
			pView.destroySignal.add(handleDestroyParticle);
			responseParticle.add(handleParticleResponse);

		}

		private function handleDestroyParticle(view : CrushParticleView):void {
			destroyParticle.dispatch(view);
		}

		private function handleParticleResponse(xml : XML, texture : Texture):void {
			pView.init(xml, texture);
		}

		private function handleParticleRequest():void {
			requestParticle.dispatch();
		}

	}
}
