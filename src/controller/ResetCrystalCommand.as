package controller {
	import model.vo.ResetCrystalVo;

	import service.IGridService;

	public class ResetCrystalCommand {

		[Inject]
		public var gridService : IGridService;

		[Inject]
		public var vo : ResetCrystalVo;

		public function execute() : void {
			gridService.resetCrystal(vo.id, vo.color, vo.xpos);
		}
	}
}
