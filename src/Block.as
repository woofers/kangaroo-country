package
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Block extends MovieClip
	{
		public var solid:Boolean;
		public var scale:Number;

		public function Block(X:int, Y:int, Tile:int = 1, Scale:Number = 1)
		{
			// Positions
			x = X;
			y = Y;

			// Scale
			setScale(Scale);

			solid = true;

			// Go To Image
			gotoAndPlay(Tile);

			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}

		public function setScale(scaleFactor:Number):void
		{
			scale  = scaleFactor;
			scaleX = scale;
			scaleY = scale;
		}

		public function hitTestAlpha(player:Player):Boolean
		{
			return hitTestObject(player.hitBox) && player.alpha;
		}

		private function destroy(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			solid = false;
			scale = 0;
		}
	}
}
