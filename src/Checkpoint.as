package
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Checkpoint extends Block
	{
		public var activated:Boolean;

		public function Checkpoint(X:int, Y:int, Scale:Number = 2)
		{
			super(X, Y, 1, Scale);

			solid = false;

			// Add Event Handlers
			addEventListener(Event.ENTER_FRAME, update);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}

		private function update(e:Event)
		{
			if (hitTestAlpha(Main.instance.playState.characters.baby) && hitTestAlpha(Main.instance.playState.characters.mother) || hitTestAlpha(Main.instance.playState.characters.bothKangaroo))
			{
				activate();
			}
		}

		public function activate():void
		{
			if (!activated)
			{
				// Deactivate Checkpoints
				for (var i:int = 0; i < Main.instance.playState.map.checkpoints.length; i++)
				{
					Main.instance.playState.map.checkpoints[i].deactivate();
				}
				activated = true;
				Main.instance.playState.map.start.x = x;
				Main.instance.playState.map.start.y = y - 20;
				gotoAndPlay(2);
			}
		}

		public function deactivate():void
		{
			if (activated)
			{
				gotoAndPlay(1);
				activated = false;
			}
		}

		private function destroy(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, update);
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			activated = false;
		}
	}
}
