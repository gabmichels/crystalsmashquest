package model {
	import model.vo.CrystalVo;

	import starling.extensions.PDParticleSystem;

	import starling.textures.Texture;

	public class DataModel {

		private var _crystals : Vector.<CrystalVo> = new <CrystalVo>[];
		private var _crushParticleXML : XML;
		private var _crushParticleTexture : Texture;

		public function get crushParticleXML():XML {
			return _crushParticleXML;
		}

		public function set crushParticleXML(value:XML):void {
			_crushParticleXML = value;
		}

		public function get crystals():Vector.<CrystalVo> {
			return _crystals;
		}

		public function set crystals(value:Vector.<CrystalVo>):void {
			_crystals = value;
		}

		public function get crushParticleTexture():Texture {
			return _crushParticleTexture;
		}

		public function set crushParticleTexture(value:Texture):void {
			_crushParticleTexture = value;
		}
	}
}
