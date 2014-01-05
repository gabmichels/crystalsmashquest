package signals.notifications {
	import model.vo.GridVo;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class CombinationSignal extends Signal implements ISignal{
		public function CombinationSignal() {
			super (Vector.<GridVo>);
		}
	}
}
