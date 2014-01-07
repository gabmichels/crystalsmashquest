package controller {
	import service.IParticleService;

	public class InitParticlesCommand {

		[Inject]
		public var particleService : IParticleService;

		public function execute() : void {
			particleService.initialize();
		}
	}
}
