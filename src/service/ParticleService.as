package service {
	import model.DataModel;

	import view.particles.CrushParticleView;

	public class ParticleService implements IParticleService{

		[Inject]
		public var dataModel : DataModel;

		private static var MAX_VALUE		: uint = 15;
		private static var pool				: Vector.<CrushParticleView>;
		private var _counter				: uint;

		public function initialize():void {

			var i:uint 		= MAX_VALUE;
			_counter 		= MAX_VALUE;

			pool = new Vector.<CrushParticleView>(MAX_VALUE);
			while (--i > -1)
				pool[i] = new CrushParticleView(dataModel.crushParticleXML, dataModel.crushParticleTexture);

		}

		public function getParticleSystem():CrushParticleView {
			if (_counter > 0) {
				return pool[--_counter];
			} else
				throw new Error("Particle Pool reached its limit!");

		}

		public function returnParticleSystem(particle : CrushParticleView):void {
			particle.refId = -1;
			pool[_counter++] = particle;
		}

	}
}
