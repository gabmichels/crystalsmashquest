package signals.requests {
	import model.vo.CollapseUpdateVo;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class RequestCollapseUpdateSignal extends Signal implements ISignal{
		public function RequestCollapseUpdateSignal() {
			super (CollapseUpdateVo);
		}
	}
}
