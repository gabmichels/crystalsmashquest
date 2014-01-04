package signals.response {
	import model.vo.GridVo;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class ResponseGridObjectUpdateSignal extends Signal implements ISignal{
		public function ResponseGridObjectUpdateSignal() {
			super (GridVo);
		}
	}
}
