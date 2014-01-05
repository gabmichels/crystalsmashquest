package view {
	import model.vo.CrystalVo;
	import model.vo.GridUpdateVo;
	import model.vo.GridVo;
	import model.vo.SwapCrystalVo;

	import org.osflash.signals.Signal;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class CrystalView extends Sprite
	{
		public var requestSignal 		: Signal;
		public var swapSignal	 		: Signal;
		public var updateGridRefSignal	: Signal;
		public var combinationSignal	: Signal;

		private var _vo 				: GridVo;
		private var _state				: int;
		private var _gridData			: Vector.<GridVo>;
		private var _crystalData		: Vector.<CrystalVo>;
		private var _dragStartX			: Number;
		private var _dragStartY			: Number;
		private var _id					: int;

		public function CrystalView(vo : GridVo) {
			_vo 					= vo;
			requestSignal 			= new Signal();
			swapSignal				= new Signal();
			updateGridRefSignal		= new Signal();
			combinationSignal		= new Signal();

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void {
			this.alpha = 0;
			requestSignal.dispatch();
		}

		public function init(grid : Vector.<GridVo>, crystals : Vector.<CrystalVo> = null, state : int = -1) : void {
			while(numChildren > 0) removeChildAt(0); // remove old crystal
			this.alpha 			= 0;	// set alpha to zero for fade in

			if(!(isNaN(state)))
				_state 			= state;

			if(crystals != null)
				_crystalData 	= crystals;

			_gridData 			= grid;

			initCrystal();
		}


		private function addCrystalTexture(texture : Texture) : void {

			var img		:Image 		= new Image(texture);
			var tween	:Tween 		= new Tween(this, 0.5, Transitions.LINEAR);
			img.pivotX 				= int(img.width / 2);
			img.pivotY 				= int(img.height / 2);
			addChild(img);

			tween.delay 			= (_vo.idX + _vo.idY) * 0.03;
			tween.fadeTo(1);
			Starling.juggler.add(tween);

			addEventListener(TouchEvent.TOUCH, handleTouch);
		}

		private function initCrystal():void {
			var texture 	: Texture;
			var colorNum 	: int;
			var crystals	: Vector.<CrystalVo> = _crystalData;

			if(vo.idX > 2 || vo.idY > 2) {
				crystals = getAddableCrystals(vo);
			}

			colorNum 	= Math.random() * crystals.length;
			texture 	= crystals[colorNum].texture;
			updateGridRefSignal.dispatch(new GridUpdateVo(id, crystals[colorNum].color, vo));

			addCrystalTexture(texture);

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

				if(vo.idX > 2 && vo.idY <= 2) { // get 2 crystals left from this
					gridDataLeft1 	= getGridById(vo.idX - 1, vo.idY);
					gridDataLeft2 	= getGridById(vo.idX - 2, vo.idY);

					if(!(gridDataLeft1.color == color && gridDataLeft2.color == color)) { // only add when the checked crystal colors do not match
						availableColors.push(_crystalData[i]);
					}
				} else if(vo.idX <= 2 && vo.idY > 2) { // get 2 crystals top from this
					gridDataTop1 	= getGridById(vo.idX, vo.idY - 1);
					gridDataTop2 	= getGridById(vo.idX, vo.idY - 2);

					if(!(gridDataTop1.color == color && gridDataTop2.color == color)) { // only add when the checked crystal colors do not match
						availableColors.push(_crystalData[i]);
					}
				}  else if(vo.idX > 2 && vo.idY > 2) {   // get 2 crystals left AND top from this

					gridDataLeft1 	= getGridById(vo.idX - 1, vo.idY);
					gridDataLeft2 	= getGridById(vo.idX - 2, vo.idY);
					gridDataTop1 	= getGridById(vo.idX, vo.idY - 1);
					gridDataTop2 	= getGridById(vo.idX, vo.idY - 2);

					if(	!(gridDataTop1.color == color && gridDataTop2.color == color) &&
							!(gridDataLeft1.color == color && gridDataLeft2.color == color)) { // only add when the checked crystal colors do not match
						availableColors.push(_crystalData[i]);
					}
				}
			}

			return availableColors;
		}

		public function checkCombination() : void {

			var horizontalList 	: Vector.<GridVo> = getList(GameConstants.HORIZONTAL);
			var verticalList 	: Vector.<GridVo> = getList(GameConstants.VERTICAL);

			var vCombo 			: Vector.<GridVo> = checkListCombination(verticalList);
			var hCombo 			: Vector.<GridVo> = checkListCombination(horizontalList);
			var mergedCombo 	: Vector.<GridVo>;

			if(hCombo && vCombo) {
				mergedCombo = mergeCombinations(vCombo, hCombo);
				combinationSignal.dispatch(mergedCombo);
			} else if(hCombo && !vCombo) {
				combinationSignal.dispatch(hCombo);
			} else if(!hCombo && vCombo) {
				combinationSignal.dispatch(vCombo);
			}

		}

		private function mergeCombinations(vCombo:Vector.<GridVo>, hCombo:Vector.<GridVo>):Vector.<GridVo> {
			var merged : Vector.<GridVo> = vCombo.concat(hCombo);

			var lastVoPos : int = merged.lastIndexOf(vo);

			merged.splice(lastVoPos,1);

			return merged;
		}

		private function checkListCombination(list:Vector.<GridVo>):Vector.<GridVo> {
			var currentVo 		: GridVo;
			var combination 	: Vector.<GridVo> = new <GridVo>[];
			var rest			: int = list.length;

			for(var i : int = 0; i < list.length; i++) {
				currentVo = list[i];
				if(currentVo) {
					if(currentVo.color == vo.color && (rest + combination.length) >= GameConstants.MINIMUM_COMBINATION_COUNT) {
						combination.push(currentVo);
					} else if(currentVo.color != vo.color && combination.length >= GameConstants.MINIMUM_COMBINATION_COUNT && combination.indexOf(vo) != -1) {
						break;
					} else if(currentVo.color != vo.color && combination.length < GameConstants.MINIMUM_COMBINATION_COUNT && rest >= GameConstants.MINIMUM_COMBINATION_COUNT) {
						combination = new <GridVo>[];
					}
				}
				rest--;
			}

			if(combination.length >= GameConstants.MINIMUM_COMBINATION_COUNT) {
				return combination;
			} else {
				return null;
			}
		}

		private function getGridById(x : int, y : int) : GridVo {

			for(var i : int = 0; i < _gridData.length; i++) {
				if(_gridData[i].idX == x && _gridData[i].idY == y) {
					return _gridData[i];
				}
			}

			return null;
		}

		private function getList(direction : String) : Vector.<GridVo> {
			var currentVo 	: GridVo;
			var list 		: Vector.<GridVo> = new <GridVo>[];

			for(var i : int = 0; i < _gridData.length; i++) {
				currentVo = _gridData[i];

				if(currentVo.idX == vo.idX && direction == GameConstants.HORIZONTAL) {
					list.push(currentVo);
				}

				if(currentVo.idY == vo.idY && direction == GameConstants.VERTICAL) {
					list.push(currentVo);
				}
			}

			return list;
		}

		private function checkDragging(touch : Touch) : void {
			var crystal2 	: GridVo;
			var swapVo		: SwapCrystalVo;

			if(touch.globalX >= (_dragStartX + GameConstants.DRAG_DISTANCE) ) {
				crystal2 = getGridById(vo.idX + 1, vo.idY);

				if(crystal2) {
					removeEventListener(TouchEvent.TOUCH, handleTouch);
					swapVo			= new SwapCrystalVo();
					swapVo.data1	= vo;
					swapVo.data2	= crystal2;

					swapSignal.dispatch(swapVo);
				}
			}

			if(touch.globalX <= (_dragStartX - GameConstants.DRAG_DISTANCE) ) {
				crystal2 		= getGridById(vo.idX - 1, vo.idY);

				if(crystal2) {
					removeEventListener(TouchEvent.TOUCH, handleTouch);

					swapVo			= new SwapCrystalVo();
					swapVo.data1	= vo;
					swapVo.data2	= crystal2;

					swapSignal.dispatch(swapVo);
				}
			}

			if(touch.globalY >= (_dragStartY + GameConstants.DRAG_DISTANCE) ) {
				crystal2 = getGridById(vo.idX, vo.idY + 1);

				if(crystal2) {
					removeEventListener(TouchEvent.TOUCH, handleTouch);

					swapVo			= new SwapCrystalVo();
					swapVo.data1	= vo;
					swapVo.data2	= crystal2;

					swapSignal.dispatch(swapVo);
				}
			}

			if(touch.globalY <= (_dragStartY - GameConstants.DRAG_DISTANCE) ) {
				crystal2 = getGridById(vo.idX, vo.idY - 1);
				if(crystal2) {
					removeEventListener(TouchEvent.TOUCH, handleTouch);

					swapVo			= new SwapCrystalVo();
					swapVo.data1	= vo;
					swapVo.data2	= crystal2;

					swapSignal.dispatch(swapVo);
				}
			}
		}

		public function update(newVo : GridVo) : void {
			if(newVo.crystalID == id) {
				vo = newVo;
			}
		}

		public function crush():void {
			var tween : Tween = new Tween(this, 0.2, Transitions.EASE_IN);
			tween.fadeTo(0);
			tween.scaleTo(0);

			Starling.juggler.add(tween);
			destroy();
			// TODO add particles
		}

		public function collapse(collapseCount:int):void {
			var tween : Tween = new Tween(this, 0.5, Transitions.EASE_OUT_BOUNCE);
			tween.moveTo(vo.x, vo.y + collapseCount * GameConstants.GRID_CELL_SIZE);

			Starling.juggler.add(tween);
		}

		public function addListener() : void {
			if(!(hasEventListener(TouchEvent.TOUCH)))
				addEventListener(TouchEvent.TOUCH, handleTouch);
		}

		public function destroy():void {
			removeEventListener(TouchEvent.TOUCH, handleTouch);
		}

		// events

		private function handleTouch(event:TouchEvent):void {
			var touch:Touch = event.getTouch(this);
			if (touch && touch.phase == TouchPhase.BEGAN) {
				_dragStartX = touch.globalX;
				_dragStartY = touch.globalY;
			} else if(touch && touch.phase == TouchPhase.MOVED) {
				checkDragging(touch);
			}
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

		public function get id():int {
			return _id;
		}

		public function set id(value:int):void {
			_id = value;
		}

		public function set gridData(value:Vector.<GridVo>):void {
			_gridData = value;
		}

	}
}
