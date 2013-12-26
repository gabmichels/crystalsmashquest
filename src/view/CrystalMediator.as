package view {
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	public class CrystalMediator extends StarlingMediator{

		[Inject]
		public var logger:ILogger;

		[Inject]
		public var view:CrystalView;


		public function CrystalMediator() {
		}

		override public function initialize():void {

			logger.info( "initialized" );


		}
	}
}
