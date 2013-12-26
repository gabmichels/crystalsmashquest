package controller {
	import service.ICrystalImageService;

	public class LoadCrystalImagesCommand {

		[Inject]
		public var crystalLoader : ICrystalImageService;

		public function execute() {
			trace("load images command")
			crystalLoader.loadImages();
		}
	}
}
