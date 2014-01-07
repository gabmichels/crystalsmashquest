package service {
	import view.particles.CrushParticleView;

	public interface IParticleService {

		function initialize() : void;
		function getParticleSystem() : CrushParticleView;
		function returnParticleSystem(val : CrushParticleView) : void;
	}
}
