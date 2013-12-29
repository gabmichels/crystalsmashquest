package view {
	import flash.display.Bitmap;

	import model.vo.CrystalVo;

	import model.vo.GridVo;

	import org.osflash.signals.Signal;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class CrystalView extends Sprite
	{
		public var requestSignal 	: Signal;

		private var _vo 			: GridVo;
		private var _state			: int;
		private var _gridData		: Vector.<GridVo>;
		private var _crystalData	: Vector.<CrystalVo>;

		public function CrystalView(vo : GridVo) {
			_vo 			= vo;
			requestSignal 	= new Signal();

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void {
			this.alpha = 0;
			requestSignal.dispatch();
		}

		public function init(grid : Vector.<GridVo>, crystals : Vector.<CrystalVo>, state : int) : void {
			_state 			= state;
			_gridData 		= grid;
			_crystalData 	= crystals;

			if(_state == GameConstants.STATE_GAME_INIT) {
				startupCrystalCreation();
			} else if(_state == GameConstants.STATE_GAME_RUNNING) {

			}
		}

		private function addCrystalBitmap(bmp : Bitmap) : void {
			var texture	:Texture 	= Texture.fromBitmap(bmp);
			var img		:Image 		= new Image(texture);
			var tween	:Tween 		= new Tween(this, 0.5, Transitions.LINEAR);

			addChild(img);

			tween.delay 			= (_vo.idX + _vo.idY) * 0.03;
			tween.fadeTo(1);
			Starling.juggler.add(tween);
		}

		private function startupCrystalCreation():void {
			var bm 			: Bitmap;
			var colorNum 	: int;
			var crystals	: Vector.<CrystalVo> = _crystalData;

			if(vo.idX > 2 || vo.idY > 2) {

				crystals = getAddableCrystals(vo);
			}

			colorNum 	= Math.random() * crystals.length;
			bm 			= crystals[colorNum].bitmap;
			vo.color	= crystals[colorNum].color;

			addCrystalBitmap(bm);

		}

		private function getAddableCrystals(vo : GridVo) : Vector.<CrystalVo> {
			var availableColors : Vector.<CrystalVo> = new <CrystalVo>[];
			var gridDataLeft1 	: GridVo;
			var gridDataLeft2 	: GridVo;
			var gridDataTop1 	: GridVo;
			var gridDataTop2 	: GridVo;
			var color 			: String;

			for(var i : int = 0; i < _crystalData.length;i++) {
				color = _crystalData[i].color;

				if(vo.idX > 2 && vo.idY <= 2) {
					gridDataLeft1 	= getGridById(vo.idX - 1, vo.idY);
					gridDataLeft2 	= getGridById(vo.idX - 2, vo.idY);

					if(!(gridDataLeft1.color == color && gridDataLeft2.color == color)) {
						availableColors.push(_crystalData[i]);
					}
				} else if(vo.idX <= 2 && vo.idY > 2) {
					gridDataTop1 	= getGridById(vo.idX, vo.idY - 1);
					gridDataTop2 	= getGridById(vo.idX, vo.idY - 2);

					if(!(gridDataTop1.color == color && gridDataTop2.color == color)) {
						availableColors.push(_crystalData[i]);
					}
				}  else if(vo.idX > 2 && vo.idY > 2) {

					gridDataLeft1 	= getGridById(vo.idX - 1, vo.idY);
					gridDataLeft2 	= getGridById(vo.idX - 2, vo.idY);
					gridDataTop1 	= getGridById(vo.idX, vo.idY - 1);
					gridDataTop2 	= getGridById(vo.idX, vo.idY - 2);

					if(	!(gridDataTop1.color == color && gridDataTop2.color == color) &&
							!(gridDataLeft1.color == color && gridDataLeft2.color == color)) {
						availableColors.push(_crystalData[i]);
					}
				}
			}

			return availableColors;
		}

		public function getGridById(x : int, y : int) : GridVo {

			for(var i : int = 0; i < _gridData.length; i++) {
				if(_gridData[i].idX == x && _gridData[i].idY == y) {
					return _gridData[i];
				}
			}

			return null;
		}

		// getter and setter
		public function get vo():GridVo {
			return _vo;
		}

		public function set vo(value:GridVo):void {
			_vo = value;
		}

		public function set state(value:int):void {
			_state = value;
		}
	}
}
