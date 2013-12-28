package {

	import controller.GameStartupCommand;

	import flash.events.IEventDispatcher;

	import model.CrystalModel;
	import model.GameModel;
	import model.GridModel;

	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.bender.framework.api.ILogger;
	import robotlegs.bender.framework.api.LogLevel;

	import service.CrystalImageService;
	import service.GridService;
	import service.ICrystalImageService;
	import service.IGridService;

	import signals.notifications.CrystalsLoadedSignal;
	import signals.notifications.GameStartSignal;
	import signals.requests.GameStartupSignal;

	import view.BackgroundMediator;
	import view.BackgroundView;
	import view.CrystalMediator;
	import view.CrystalView;
	import view.GridMediator;
	import view.GridView;
	import view.base.GameMediator;
	import view.base.GameView;
	import view.layer.StartLayerMediator;
	import view.layer.StartLayerView;

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
			commandMap.map( GameStartupSignal).toCommand(GameStartupCommand);

			// Map independent notification signals.
			injector.map( CrystalsLoadedSignal ).asSingleton();
			injector.map( GameStartSignal ).asSingleton();

			// Map views.
			mediatorMap.map( GameView ).toMediator( GameMediator );
			mediatorMap.map( BackgroundView ).toMediator( BackgroundMediator );
			mediatorMap.map( CrystalView ).toMediator( CrystalMediator );
			mediatorMap.map( StartLayerView ).toMediator( StartLayerMediator );
			mediatorMap.map( GridView ).toMediator( GridMediator );

			// Map models.
			injector.map( CrystalModel ).asSingleton();
			injector.map( GridModel ).asSingleton();
			injector.map( GameModel ).asSingleton();

			// Map services.
			injector.map( ICrystalImageService ).toSingleton( CrystalImageService );
			injector.map( IGridService ).toSingleton( GridService );

			// Start.
			context.afterInitializing( init );

		}

		private function init():void {

			logger.info( "application ready" );

		}
	}
}
