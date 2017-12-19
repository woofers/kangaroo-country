package
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Wall extends Block
	{
		public var index:int;

		public function Wall(X:int, Y:int, Index:int)
		{
			super(X, Y, 1, 1);

			solid = true;
			index = Index;

			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}

		private function destroy(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			index = 0;
		}
	}

}
