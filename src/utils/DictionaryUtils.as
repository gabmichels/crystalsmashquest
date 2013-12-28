package utils {
	import flash.utils.Dictionary;

	public class DictionaryUtils {

		public static function length(dict:Dictionary):int
		{
			var n:int = 0;
			for (var key:* in dict) {
				n++;
			}
			return n;
		}
	}
}
