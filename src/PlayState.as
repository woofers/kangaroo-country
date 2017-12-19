package
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.system.System;
	import flash.display.Loader;
	import flash.net.URLRequest;


	public class PlayState extends MovieClip
	{
		public var characters:Characters;
		public var map:Map;
		public var camera:Camera;
		public var isPaused:Boolean;
		private var loader:Loader = new Loader();

		public function PlayState()
		{

			map = new Map();
			addChild(map);

			characters = new Characters();
			addChild(characters);

			camera = new Camera(characters, map);
		}

		public function win():void
		{
			loader.load(new URLRequest("assets/images/ui/win.png"));
			addChild(loader);
		}
	}
}
