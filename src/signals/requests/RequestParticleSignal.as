package signals.requests {
	import model.vo.GridVo;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class RequestParticleSignal extends Signal implements ISignal{
		public function RequestParticleSignal() {
			super (GridVo);
		}
	}
}
