package signals.requests {
	import model.vo.GridUpdateVo;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class RequestGridObjectUpdateSignal extends Signal implements ISignal{
		public function RequestGridObjectUpdateSignal() {
			super (GridUpdateVo);
		}
	}
}
