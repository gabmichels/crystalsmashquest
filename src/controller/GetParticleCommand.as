package controller {
	import model.vo.GridVo;

	import service.IParticleService;

	import signals.response.ResponseParticleSignal;

	import view.particles.CrushParticleView;

	public class GetParticleCommand {

		[Inject]
		public var particleService : IParticleService;

		[Inject]
		public var responseSignal : ResponseParticleSignal;

		[Inject]
		public var data : GridVo;

		public function execute() : void {
			var particle : CrushParticleView = particleService.getParticleSystem();
				particle.refId = data.crystalID;
			responseSignal.dispatch(particle, data);
		}
	}
}
