﻿package
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Baby extends Player
	{
		public function Baby(X:int, Y:int, Scale:Number = 3)
		{
			super(X, Y, Scale, 12);

			// Physics
			alpha      = 0;
			speed      = 10;
			jumpHeight = 14;
			character  = "Baby";

			// Hitbox
			hitBox.y		+= 5;
			hitBox.up.y		+= 12;
			hitBox.left.x	+= 8;
			hitBox.right.x	-= 8;
			hitBox.left.y	+= 4;
			hitBox.right.y	+= 4;

			// Create Update Loop
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e:Event):void
		{
			if (Main.instance.playState.characters.currentCharacter == character)
			{
				// Switch To Mother
				if (Main.instance.keys.shiftTap())
				{
					Main.instance.playState.characters.setPlayer("Mother");
				}

				// Touch Parent
				if (scaleX == -Main.instance.playState.characters.mother.scaleX)
				{
					if (hitTestObject(Main.instance.playState.characters.mother.hitBox) && Main.instance.playState.characters.baby.hitBox.down.blocked)
					{
						Main.instance.playState.characters.setPlayer("BothKangaroo");
					}
				}
			}
		}
	}
}
