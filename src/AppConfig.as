package {

	import controller.LoadCrystalImagesCommand;

	import flash.events.IEventDispatcher;

	import model.CrystalModel;

	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.framework.api.LogLevel;

	import service.CrystalImageService;
	import service.ICrystalImageService;

	import signals.notifications.CrystalsLoaded;

	import signals.requests.LoadCrystalSignal;

	import view.BackgroundMediator;
	import view.BackgroundView;
	import view.CrystalMediator;
	import view.CrystalView;
	import view.base.GameMediator;
	import view.base.GameView;

	public class AppConfig implements IConfig
	{
		[Inject]
		public var context:IContext;

		[Inject]
		public var commandMap:ISignalCommandMap;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var injector:IInjector;

		[Inject]
		public var logger:ILogger;

		[Inject]
		public var contextView:ContextView;

		[Inject]
		public var dispatcher:IEventDispatcher;

		public function configure():void {

			// Configure logger.
			context.logLevel = LogLevel.DEBUG;
			logger.info( "configuring application" );

			// Map commands.
			commandMap.map( LoadCrystalSignal).toCommand(LoadCrystalImagesCommand);
			commandMap.map( CrystalsLoaded).toCommand(ShowStartLayerCommand);

			// Map independent notification signals.
//			injector.map( CrystalsLoaded ).asSingleton();

			// Map views.
			mediatorMap.map( GameView ).toMediator( GameMediator );
			mediatorMap.map( BackgroundView ).toMediator( BackgroundMediator );
			mediatorMap.map( CrystalView ).toMediator( CrystalMediator );

			// Map models.
			injector.map( CrystalModel ).asSingleton();

			// Map services.
			injector.map( ICrystalImageService ).toSingleton( CrystalImageService );

			// Start.
			context.afterInitializing( init );

		}

		private function init():void {

			logger.info( "application ready" );

		}
	}
}
