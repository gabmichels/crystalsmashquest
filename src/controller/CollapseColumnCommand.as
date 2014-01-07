package controller {
	import model.vo.CollapseUpdateVo;
	import model.vo.GridVo;

	import service.IGridService;

	public class CollapseColumnCommand {

		[Inject]
		public var gridService : IGridService;

		[Inject]
		public var data : GridVo;

		public function execute() : void {
			gridService.requestCollapseData(data);
		}
	}
}
