package
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Ball extends MovieClip
	{
		private var speed:int;
		private var wallHit:Boolean;

		public function Ball(X:int, Y:int, Speed:int = 5, Rotation:int = 0, Scale:Number = 3)
		{
			// Positions
			x = X;
			y = Y;

			// Speed
			speed = Speed;

			// Scale
			width	*= Scale;
			height	*= Scale;

			//  Rotation
			rotation = Rotation;

			// Flip Image If Needed
			if (rotation)
			{
				gotoAndPlay(2);
			}

			// Add Event Handlers
			addEventListener(Event.ENTER_FRAME, update);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}

		private function update(e:Event):void
		{
			// Movement
			x += (Math.cos(rotation * Math.PI / 180)) * speed;
			y += (Math.sin(rotation * Math.PI / 180)) * speed;

			// Hit Detection
			hitDetection(Main.instance.playState.characters.mother);
			hitDetection(Main.instance.playState.characters.baby);
			hitDetection(Main.instance.playState.characters.bothKangaroo);

			// Delete When Hit Walls
			for (var i:int = 0; i < Main.instance.playState.map.blocks.length; i++)
			{
				if (hitTestObject(Main.instance.playState.map.blocks[i]) && Main.instance.playState.map.blocks[i].solid)
				{
					wallHit = true;
					MovieClip(parent).removeChild(this);
				}
			}
			for (i = 0; i < Main.instance.playState.map.walls.length; i++)
			{
				if (hitTestObject(Main.instance.playState.map.walls[i]) && Main.instance.playState.map.walls[i].solid)
				{
					wallHit = true;
					MovieClip(parent).removeChild(this);
				}
			}

		}

		private function hitDetection(player:Player):void
		{
			if (hitTestObject(player.hitBox) && player.alpha == 1)
			{
				Main.instance.playState.characters.reset();
			}
		}

		private function destroy(e:Event):void
		{
			// Remove Event Handlers
			removeEventListener(Event.ENTER_FRAME, update);
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);

			if (wallHit)
			{
				// Null Object
				MovieClip(parent).removeBall();
			}
		}
	}
}
