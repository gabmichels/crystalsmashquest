package controller {
	import service.IParticleService;

	import starling.extensions.PDParticleSystem;

	import view.particles.CrushParticleView;

	public class ReturnParticleCommand {

		[Inject]
		public var particleService : IParticleService;

		[Inject]
		public var particle : CrushParticleView;

		public function execute() : void {
			particleService.returnParticleSystem(particle);
		}
	}
}
