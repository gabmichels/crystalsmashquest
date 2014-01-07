package signals.requests {
	import model.vo.CollapseUpdateVo;
	import model.vo.GridVo;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class RequestCollapseSignal extends Signal implements ISignal{
		public function RequestCollapseSignal() {
			super (GridVo);
		}
	}
}
