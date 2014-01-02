package signals.notifications {
	import model.vo.SwapCrystalVo;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class SwapCrystalsSignal extends Signal implements ISignal{
		public function SwapCrystalsSignal() {
			super (SwapCrystalVo);
		}
	}
}
