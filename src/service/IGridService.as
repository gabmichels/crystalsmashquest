package service {
	import model.vo.CollapseUpdateVo;
	import model.vo.GridUpdateVo;
	import model.vo.GridVo;

	public interface IGridService {

		function initGrid() : void;
		function resetColors() : void;
		function swapCrystals(data1 : GridVo, data2: GridVo) : void;
		function updateGridObject(data : GridUpdateVo) : void;
		function collapseUpdate(data : CollapseUpdateVo) : void;
		function resetCrystal(id : int, color : String, xpos : int) : void;
		function requestCollapseData(data:Vector.<GridVo>):void;
	}
}
