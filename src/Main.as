package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

	public class Main extends MovieClip
	{
		public var keys:Keys;
		public var menuState:MenuState;
		public var playState:PlayState;

		private static var _instance:Main;
		private static var _width:int;
		private static var _height:int;

		public function Main()
		{
			_instance = this;

			_width = stage.stageWidth;
			_height = stage.stageHeight;

			// Add Key Handler
			keys = new Keys();
			addChild(keys);

			// Add Menu State
			menuState = new MenuState();
			addChild(menuState);

			stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
		}

		public function random(min:int, max:int):int
		{
			return (max - min + 1) * Math.random() + min;
		}

		public static function get instance():Main
		{
			return _instance;
		}

		public static function get gameWidth():int
		{
			return _width;
		}

		public static function get gameHeight():int
		{
			return _height;
		}
	}
}
