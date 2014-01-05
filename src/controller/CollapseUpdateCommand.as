package controller {
	import model.vo.CollapseUpdateVo;
	import model.vo.GridVo;

	import service.IGridService;

	public class CollapseUpdateCommand {

		[Inject]
		public var gridService : IGridService;

		[Inject]
		public var data : CollapseUpdateVo;

		public function execute() : void {
			gridService.collapseUpdate(data);
		}
	}
}
