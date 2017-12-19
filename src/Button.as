package
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Button extends Wall
	{
		public var weighted:Boolean;
		public var isTouched:Boolean;
		public var isUsed:Boolean;

		public function Button(X:int, Y:int, Index:int)
		{
			super(X, Y, Index);

			// Add Stage
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event)
		{
			// Remove Stage
			removeEventListener(Event.ADDED_TO_STAGE, init);

			addEventListener(Event.ENTER_FRAME, update);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}

		private function update(e:Event):void
		{
			if (hitTestAnyPlayer())
			{
				isTouched = true;
			}
			else if (weighted)
			{
				isTouched = false;
			}

			if (!isUsed)
			{
				if (isTouched)
				{
					isUsed = true;
					if (!weighted)
					{
						alpha = 0;
						if (wallsAreSolid())
						{
							activate();
						}
						else
						{
							deactivate();
						}
					}
					else
					{
						if (wallsAreSolid())
						{
							activate();
						}
						else
						{
							deactivate();
						}
					}
				}
			}

			if (isUsed && !isTouched && weighted)
			{
				isUsed = false;
				if (wallsAreSolid())
				{
					activate();
				}
				else
				{
					deactivate();
				}
			}

		}

		private function hitTestAnyPlayer():Boolean
		{
			return hitTestAlpha(Main.instance.playState.characters.bothKangaroo) || hitTestAlpha(Main.instance.playState.characters.baby) || hitTestAlpha(Main.instance.playState.characters.mother);
		}

		public function activate():void
		{
			// Remove Walls
			for (var i:int = 0; i < Main.instance.playState.map.walls.length; i++)
			{
				if (Main.instance.playState.map.walls[i].solid && Main.instance.playState.map.walls[i].index == index)
				{
					Main.instance.playState.map.walls[i].solid = false;
					Main.instance.playState.map.walls[i].alpha = 0;
				}
			}

		}

		public function deactivate():void
		{
			// Recreate Walls
			for (var i:int = 0; i < Main.instance.playState.map.walls.length; i++)
			{
				if (!Main.instance.playState.map.walls[i].solid && Main.instance.playState.map.walls[i].index == index)
				{
					Main.instance.playState.map.walls[i].solid = true;
					Main.instance.playState.map.walls[i].alpha = 1;
				}
			}

		}

		private function wallsAreSolid():Boolean
		{
			// Remove Walls
			for (var i:int = 0; i < Main.instance.playState.map.walls.length; i++)
			{
				if (Main.instance.playState.map.walls[i].index == index)
				{
					if (Main.instance.playState.map.walls[i].solid)
					{
						return true;
					}
					else
					{
						return false;
					}
				}
			}
			return false;
		}

		private function destroy(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			removeEventListener(Event.ENTER_FRAME, update);
			weighted  = false;
			isTouched = false;
			isUsed    = false;
		}
	}
}
