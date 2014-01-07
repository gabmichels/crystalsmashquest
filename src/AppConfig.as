package {

	import controller.CollapseColumnCommand;
	import controller.CollapseUpdateCommand;
	import controller.GameRestartCommand;
	import controller.GameStartupCommand;
	import controller.GetCrystalDataCommand;
	import controller.GetGridCommand;
	import controller.ResetCrystalCommand;
	import controller.SwapCrystalCommand;
	import controller.UpdateGridObjectCommand;

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

	import signals.notifications.CollapseCompleteSignal;

	import signals.notifications.CombinationSignal;
	import signals.notifications.CrystalsLoadedSignal;
	import signals.notifications.GameStartSignal;
	import signals.notifications.GridUpdateSignal;
	import signals.notifications.ResetCompleteSignal;
	import signals.notifications.RestartSignal;
	import signals.notifications.StateUpdateSignal;
	import signals.notifications.SwapCrystalsSignal;
	import signals.requests.GameStartupSignal;
	import signals.requests.RequestCollapseSignal;
	import signals.requests.RequestCollapseUpdateSignal;
	import signals.requests.RequestCrystalDataSignal;
	import signals.requests.RequestGridObjectUpdateSignal;
	import signals.requests.RequestGridSignal;
	import signals.requests.RequestResetCrystalSignal;
	import signals.response.ResponseCollapseSignal;
	import signals.response.ResponseCrystalDataSignal;
	import signals.response.ResponseCrystalsSignal;
	import signals.response.ResponseGridObjectUpdateSignal;
	import signals.response.ResponseGridSignal;
	import signals.response.ResponseResetCrystalSignal;

	import view.BackgroundMediator;
	import view.BackgroundView;
	import view.CrystalMediator;
	import view.CrystalView;
	import view.GridMediator;
	import view.GridView;
	import view.base.GameMediator;
	import view.base.GameView;
	import view.layer.GUIMediator;
	import view.layer.GUIView;

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

			context.logLevel = LogLevel.DEBUG;
			logger.info( "configuring application" );

			// commands.
			commandMap.map( GameStartupSignal).toCommand(GameStartupCommand);
			commandMap.map( RestartSignal).toCommand(GameRestartCommand);
			commandMap.map( RequestGridSignal).toCommand(GetGridCommand);
			commandMap.map( SwapCrystalsSignal).toCommand(SwapCrystalCommand);
			commandMap.map( RequestCrystalDataSignal).toCommand(GetCrystalDataCommand);
			commandMap.map( RequestGridObjectUpdateSignal).toCommand(UpdateGridObjectCommand);
			commandMap.map( RequestResetCrystalSignal).toCommand(ResetCrystalCommand);
			commandMap.map( RequestCollapseSignal).toCommand(CollapseColumnCommand);
			commandMap.map( RequestCollapseUpdateSignal).toCommand(CollapseUpdateCommand);

			// signals.
			injector.map( CrystalsLoadedSignal ).asSingleton();
			injector.map( GameStartSignal ).asSingleton();
			injector.map( ResponseGridSignal ).asSingleton();
			injector.map( ResponseCrystalsSignal ).asSingleton();
			injector.map( ResponseCrystalDataSignal ).asSingleton();
			injector.map( StateUpdateSignal ).asSingleton();
			injector.map( GridUpdateSignal ).asSingleton();
			injector.map( ResponseGridObjectUpdateSignal ).asSingleton();
			injector.map( CombinationSignal ).asSingleton();
			injector.map( ResponseResetCrystalSignal ).asSingleton();
			injector.map( ResetCompleteSignal ).asSingleton();
			injector.map( ResponseCollapseSignal ).asSingleton();
			injector.map( CollapseCompleteSignal ).asSingleton();

			// views.
			mediatorMap.map( GameView ).toMediator( GameMediator );
			mediatorMap.map( BackgroundView ).toMediator( BackgroundMediator );
			mediatorMap.map( CrystalView ).toMediator( CrystalMediator );
			mediatorMap.map( GUIView ).toMediator( GUIMediator );
			mediatorMap.map( GridView ).toMediator( GridMediator );

			// models.
			injector.map( CrystalModel ).asSingleton();
			injector.map( GridModel ).asSingleton();
			injector.map( GameModel ).asSingleton();

			// services.
			injector.map( ICrystalImageService ).toSingleton( CrystalImageService );
			injector.map( IGridService ).toSingleton( GridService );

		}

	}
}
