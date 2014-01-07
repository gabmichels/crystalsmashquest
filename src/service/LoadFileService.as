package service {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.display.ContentDisplay;

	import flash.display.Bitmap;

	import model.DataModel;
	import model.vo.CrystalVo;

	import signals.notifications.CrystalsLoadedSignal;

	import starling.display.Image;
	import starling.textures.Texture;

	public class LoadFileService implements ILoadFileService{

		[Inject]
		public var dataModel : DataModel;

		[Inject]
		public var completeSignal:CrystalsLoadedSignal;

		private var _queues : int = 0;

		public function loadCrystalImages() :void {
			var queue:LoaderMax = new LoaderMax({name:"imageQueue" , onComplete:handleQueueComplete});
			_queues++;

			//append several loaders
			queue.append( new ImageLoader("../assets/release/blue.png", {name:"blue", noCache: false, onComplete: handleImageComplete}) );
			queue.append( new ImageLoader("../assets/release/red.png", {name:"red", noCache: false, onComplete: handleImageComplete}) );
			queue.append( new ImageLoader("../assets/release/yellow.png", {name:"yellow", noCache: false, onComplete: handleImageComplete}) );
			queue.append( new ImageLoader("../assets/release/purple.png", {name:"purple", noCache: false, onComplete: handleImageComplete}) );
			queue.append( new ImageLoader("../assets/release/green.png", {name:"green", noCache: false, onComplete: handleImageComplete}) );

			//start loading
			queue.load();

		}

		public function loadParticles():void {
			var queue:LoaderMax = new LoaderMax({name:"particleQueue" , onComplete:handleQueueComplete});
			_queues++;
			queue.append(new XMLLoader("../assets/release/particle.pex", {onComplete: handleXMLComplete}));
			queue.append(new ImageLoader("../assets/release/texture.png", {onComplete: handleParticleTextureComplete}));
			queue.load();
		}

		private function handleParticleTextureComplete(event:LoaderEvent):void {
			var bmp 		: Bitmap 	= event.target.rawContent;
			var texture		: Texture 	= Texture.fromBitmap(bmp);

			dataModel.crushParticleTexture = texture;
		}

		private function handleXMLComplete(event:LoaderEvent):void {
			trace(event.target + " Image is complete!");
			var xml	: XML = (event.target as XMLLoader).content;
			dataModel.crushParticleXML = xml;
		}

		private function handleImageComplete(event:LoaderEvent) : void {
			var bmp 		: Bitmap 	= event.target.rawContent;
			var texture		:Texture 	= Texture.fromBitmap(bmp);

			dataModel.crystals.push( new CrystalVo(texture, event.target.name ) );
			trace(event.target + " Image is complete!");

		}

		private function handleQueueComplete(event:LoaderEvent):void {
			trace(event.target + " is complete!");
			_queues--;
			if(_queues == 0)
				completeSignal.dispatch();
		}
	}
}
