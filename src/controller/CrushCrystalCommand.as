package controller {
	import model.vo.GridVo;

	import service.IGridService;

	public class CrushCrystalCommand {

		[Inject]
		public var gridService : IGridService;

		[Inject]
		public var data : Vector.<GridVo>;

		public function execute() : void {
			gridService.crushCrystals(data);
		}
	}
}
