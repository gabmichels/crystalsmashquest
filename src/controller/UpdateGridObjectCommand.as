package controller {
	import model.vo.GridUpdateVo;
	import model.vo.SwapCrystalVo;

	import service.IGridService;

	public class UpdateGridObjectCommand {

		[Inject]
		public var gridService : IGridService;

		[Inject]
		public var data : GridUpdateVo;

		public function execute() : void {
			gridService.updateGridObject(data);
		}
	}
}
