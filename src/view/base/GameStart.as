package view.base {
	import starling.display.Sprite;

	import view.BackgroundView;

	public class GameStart extends Sprite{
		public function GameStart(){

			addChild( new BackgroundView());
		}
	}
}
