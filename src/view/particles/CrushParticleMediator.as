package view.particles {
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import signals.notifications.ReturnParticleSignal;

	public class CrushParticleMediator extends StarlingMediator{

		[Inject]
		public var pView			: CrushParticleView;

		[Inject]
		public var returnParticle	: ReturnParticleSignal;


		override public function initialize():void {

			pView.returnSignal.add(handleReturnParticle);

		}

		private function handleReturnParticle(particle : CrushParticleView):void {
			returnParticle.dispatch(particle);
		}


	}
}
