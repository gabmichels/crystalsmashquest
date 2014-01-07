package view.base {
	import feathers.themes.AeonDesktopTheme;

	import starling.display.Sprite;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.pixelmask.PixelMaskDisplayObject;

	import view.BackgroundView;
	import view.GridView;
	import view.layer.GUIView;
	import view.particles.CrushParticleView;

	public class GameView extends Sprite{

		private var _background : Sprite;
		private var _startLayer : Sprite;
		private var _grid		: PixelMaskDisplayObject;

		public function GameView(){

			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );

		}

		private function onAddedToStage(event:Event):void {
			var theme : AeonDesktopTheme 	= new AeonDesktopTheme( stage );
			_background 					= new BackgroundView();
			_grid 							= new GridView();
			_grid.x							= GameConstants.GRID_XPOS;
			_grid.y							= GameConstants.GRID_YPOS;

			addChild(_background);
			addChild(_grid);
		}

		public function showLayer() : void {
			if(!_startLayer) {
				_startLayer = new GUIView();
				addChild(_startLayer);
			} else {
				_startLayer.visible = true;
			}
		}

	}
}
