package
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Goal extends Block
	{
		public function Goal(X:int, Y:int, Scale:Number = 1)
		{
			super(X, Y, 1, Scale);

			// Add Event Handlers
			addEventListener(Event.ENTER_FRAME, update);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}

		private function update(e:Event):void
		{
			if (hitTestAlpha(Main.instance.playState.characters.baby) && hitTestAlpha(Main.instance.playState.characters.mother) || hitTestAlpha(Main.instance.playState.characters.bothKangaroo))
			{
				Main.instance.playState.map.loadNextLevel();
			}
		}

		private function destroy(e:Event)
		{
			removeEventListener(Event.ENTER_FRAME, update);
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
	}
}
