package
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;

	public class Camera
	{
		private var position:Point = new Point();
		private var map:Map;
		private var characters:Characters;

		public function Camera(Character:Characters, Level:Map)
		{
			position	= new Point();
			characters	= Character;
			map			= Level;
			center();
		}

		public function center():void
		{
			x = Main.gameWidth / 2;
			y = Main.gameHeight / 2;
		}

		public function set x(value:int):void
		{
			if (value < position.x || position.x <= 0)
			{
				if (value > Main.gameWidth / 2)
				{
					position.x = value;
				}
				else
				{
					position.x	= Main.gameWidth / 2;
				}
			}
			else
			{
				if (value < map.mapWidth - Main.gameWidth / 2)
				{
					position.x	= value;
				}
				else
				{
					position.x	= map.mapWidth - Main.gameWidth / 2;
				}
			}

			map.x			= -position.x + (Main.gameWidth  / 2);
			characters.x	= -position.x + (Main.gameWidth  / 2);
		}

		public function set y(value:int):void
		{
			position.y		= value;
			map.y			= -position.y + (Main.gameHeight / 2);
			characters.y	= -position.y + (Main.gameHeight / 2);
		}

		public function get x():int
		{
			return position.x;
		}

		public function get y():int
		{
			return position.y;
		}

	}
}
