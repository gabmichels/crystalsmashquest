package signals.notifications {
	import model.vo.GridVo;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class CrystalUpdateSignal extends Signal implements ISignal{
		public function CrystalUpdateSignal() {
			super (GridVo);
		}
	}
}
