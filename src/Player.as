package
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Player extends MovieClip
	{
		protected var speed:int			= 4;
		protected var jumpHeight:int	= 11;

		protected var gravity:int;
		protected var scale:Number;
		protected var character:String;
		protected var currentAnimation:String;
		protected var velocity:Point = new Point();

		public var hitBox:HitBox;
		private var canJump:Boolean;
		private var animationTimer:Timer = new Timer(1000 / 10);


		public function Player(X:int, Y:int, Scale:Number = 1, Offset:int = 2)
		{
			// Positions
			x = X;
			y = Y;

			// Scale
			setScale(Scale);

			// Create Hitbox
			hitBox = new HitBox(height, width, scale, Offset);
			addChild(hitBox);

			// Play Animation
			playAnimation("walk");

			// Create Animation Timer
			animationTimer.addEventListener(TimerEvent.TIMER, changeFrame);
			animationTimer.start();

			// Add Event Handlers
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e:Event):void
		{
			// Animation
			if (velocity.x == 0)
			{
				playAnimation("idle");
			}
			else
			{
				playAnimation("walk");
			}

			// Movement
			if (Main.instance.playState.characters.currentCharacter == character)
			{
				// Camera And Arrow
				if (isFacingRight())
				{
					Main.instance.playState.camera.x = x;
					Main.instance.playState.characters.arrow.x = x + width / 2;
				}
				else
				{
					Main.instance.playState.camera.x = x - width;
					Main.instance.playState.characters.arrow.x = x - width / 2 - Main.instance.playState.characters.arrow.width;
				}

				// Offset Arrow For Baby
				if (character == "Baby")
				{
					Main.instance.playState.characters.arrow.y = y + 10;
				}
				else
				{
					Main.instance.playState.characters.arrow.y = y - 8;
				}

				// Right
				if (Main.instance.keys.right)
				{
					// Move Right
					velocity.x = speed;

					// Flip Right
					if (!isFacingRight())
					{
						flip();
						Main.instance.playState.camera.x = x;
					}
				}

				// Left
				if (Main.instance.keys.left)
				{
					// Move Left
					velocity.x = -speed;

					// Flip Left
					if (isFacingRight())
					{
						flip();
					}

				}

				// Jump
				if (Main.instance.keys.up && canJump)
				{
					canJump	= false;
					velocity.y = -jumpHeight;
				}

				// Stop
				if (!Main.instance.keys.left && !Main.instance.keys.right)
				{
					velocity.x = 0;
				}
			}
			else
			{
				velocity.x = 0;
			}

			// Collision

			// Grounded
			if (hitBox.down.blocked)
			{
				canJump = true;
				velocity.y = 0;
				y --;
			}
			// Falling
			else
			{
				canJump = false;
				velocity.y ++;
			}
			if (hitBox.up.blocked)
			{
				if (velocity.y < 0)
				{
					velocity.y *= -1;
				}
			}
			if (hitBox.left.blocked)
			{
				velocity.x = speed;
				Main.instance.playState.camera.x += speed;
			}
			if (hitBox.right.blocked)
			{
				velocity.x = -speed;
				Main.instance.playState.camera.x -= speed;
			}

			// Rest
			if (y > Main.gameHeight * 1.5 && alpha)
			{
				Main.instance.playState.characters.reset();
			}
			if (hitBox.right.isInWall && hitBox.left.isInWall && hitBox.down.isInWall && hitBox.up.isInWall)
			{
				Main.instance.playState.characters.reset();
			}

			// Update Position
			x += velocity.x;
			y += velocity.y;
		}

		public function setScale(scaleFactor:Number):void
		{
			scale  = scaleFactor;
			scaleX = scale;
			scaleY = scale;
		}

		public function setPosition(player:Player):void
		{
			x = player.x;
			y = player.y;
		}

		public function flip():void
		{
			if (scaleX > 0)
			{
				x += width;
			}
			else
			{
				x -= width;
			}
			scaleX *= -1;
			hitBox.flip();
		}

		public function flipToMatch(player:Player):void
		{
			flipTo(player.scaleX);
		}

		public function flipTo(scale:Number):void
		{
			if (scaleX !== scale)
			{
				flip();
			}
		}

		protected function isFacingRight():Boolean
		{
			return scaleX > 0;
		}

		private function playAnimation(animation:String):void
		{
			if (currentAnimation !== animation)
			{
				currentAnimation = animation;
				gotoAndPlay(currentAnimation);
			}
		}

		private function changeFrame(e:TimerEvent):void
		{
			if (currentFrame == totalFrames)
			{
				gotoAndPlay(currentAnimation);
				return;
			}
			nextFrame();
		}
	}
}