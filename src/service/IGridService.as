package service {
	import model.vo.GridUpdateVo;
	import model.vo.GridVo;

	public interface IGridService {

		function initGrid() : void;
		function resetColors() : void;
		function swapCrystals(data1 : GridVo, data2: GridVo) : void;
		function updateGridObject(data : GridUpdateVo) : void;
	}
}
