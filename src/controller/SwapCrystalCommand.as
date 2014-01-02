package controller {
	import model.vo.SwapCrystalVo;

	import service.IGridService;

	public class SwapCrystalCommand {

		[Inject]
		public var gridService : IGridService;

		[Inject]
		public var data : SwapCrystalVo;

		public function execute() : void {
			gridService.swapCrystals(data.data1, data.data2);
		}
	}
}
