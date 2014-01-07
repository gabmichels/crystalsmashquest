package signals.notifications {
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import view.particles.CrushParticleView;

	public class ReturnParticleSignal extends Signal implements ISignal{
		public function ReturnParticleSignal() {
			super (CrushParticleView);
		}
	}
}
