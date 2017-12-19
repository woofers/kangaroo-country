package
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class HitSide extends Shape
	{
		public var blocked:Boolean;
		public var isInWall:Boolean;

		public function HitSide(X:int, Y:int, Width:Number, Height:Number, Alpha:Number = 0)
		{
			x = X;
			y = Y;

			graphics.beginFill(0x00FFFF, Alpha);
			graphics.drawRect(0, 0, Width, Height);
			graphics.endFill();

			// Add Event Handlers
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e:Event)
		{
			// Collision
			blocked = false;
			isInWall = false;
			for (var i:int = 0; i < Main.instance.playState.map.blocks.length; i++)
			{
				if (hitTestObject(Main.instance.playState.map.blocks[i]) && Main.instance.playState.map.blocks[i].solid)
				{
					blocked = true;
				}
			}
			for (var j:int = 0; j < Main.instance.playState.map.walls.length; j++)
			{
				if (hitTestObject(Main.instance.playState.map.walls[j]) && Main.instance.playState.map.walls[j].solid)
				{
					blocked = true;
					isInWall = true;
				}
			}
		}
	}
}
