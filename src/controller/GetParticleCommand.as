package controller {
	import model.DataModel;

	import signals.response.ResponseParticleSignal;

	public class GetParticleCommand {

		[Inject]
		public var fileModel : DataModel;

		[Inject]
		public var responseSignal : ResponseParticleSignal;

		public function execute() : void {
			responseSignal.dispatch(fileModel.crushParticleXML, fileModel.crushParticleTexture);
		}
	}
}
