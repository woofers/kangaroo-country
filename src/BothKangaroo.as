package
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class BothKangaroo extends Player
	{
		public function BothKangaroo(X:int, Y:int, Scale:Number = 3)
		{
			super(X, Y, Scale, 10);

			// Physics
			alpha      = 1;
			speed      = 5;
			jumpHeight = 15;
			character  = "BothKangaroo";

			// Hitbox
			hitBox.y		+= 5;
			hitBox.up.y		+= 4;
			hitBox.left.x	+= 4;
			hitBox.right.x	-= 8;

			// Add Event Handlers
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e:Event):void
		{
			if (Main.instance.playState.characters.currentCharacter == character)
			{
				// Switch To Baby
				if (Main.instance.keys.shiftTap())
				{
					if (isFacingRight())
					{
						if (!hitBox.right.blocked)
						{
							Main.instance.playState.characters.setPlayer("Baby", true);
						}
					}
					else
					{
						if (!hitBox.left.blocked)
						{
							Main.instance.playState.characters.setPlayer("Baby", true);
						}
					}
				}
			}
		}
	}

}
