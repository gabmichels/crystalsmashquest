package view.base {
	import starling.display.Sprite;

	import view.BackgroundView;

	public class GameView extends Sprite{
		public function GameView(){

			addChild( new BackgroundView());
		}
	}
}
