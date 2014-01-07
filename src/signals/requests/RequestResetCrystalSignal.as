package signals.requests {
	import model.vo.ResetCrystalVo;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class RequestResetCrystalSignal extends Signal implements ISignal{
		public function RequestResetCrystalSignal() {
			super (ResetCrystalVo);
		}
	}
}
