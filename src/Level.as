package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.adobe.serialization.json.JSON;

	public class Level
	{
		public var data:Array;
		private var string:String = "";
		public var levelData:Array;
		private var loader:URLLoader = new URLLoader();

		public function Level(level:String)
		{
			loader.load(new URLRequest(level));
			loader.addEventListener(Event.COMPLETE, onLoaded);
		}

		private function onLoaded(e:Event):void
		{
			// Import Text File
			data = e.target.data.split(/\n/);

			// Remove Excess
			data = data.slice(13, data.length - 2);

			// Add Brackets
			for (var i:int = 0; i < data.length - 1; i++)
			{
				if (i)
				{
					data[i] = "[" + data[i].toString().slice(0, data[i].toString().length - 2) + "],";
				}
				else
				{
					data[i] = "[[" + data[i].toString().slice(0, data[i].toString().length - 2) + "],";
				}
			}
			data[data.length - 1] = "[" + data[data.length - 1] + "]]";

			// Convert To String
			for (var j:int = 0; j < data.length; j++)
			{
				string = string + data[j];
			}

			// Convert to array
			levelData = JSON.decode(string) as Array;

			// Create Level
			Main.instance.playState.map.map = levelData;
			Main.instance.playState.map.loadMap();
			Main.instance.playState.characters.reset();

			// Clean Up Data
			loader    = null;
			levelData = null;
			string    = null;
		}
	}
}
