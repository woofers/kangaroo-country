package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class BallSpawner extends Block
	{
		private var direction:int;
		public var ball:Ball;


		public function BallSpawner(X:int, Y:int, Direction = 0)
		{
			super(X, Y, 1, 1);

			solid = false;

			direction = Direction;

			createBall();

			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}

		public function createBall():void
		{
			ball = new Ball(0, 0, 5, direction);

			// Get Correct Position
			if (direction)
			{
				ball.y += ball.width + ball.width / 2;
			}
			else
			{
				ball.x += ball.height;
				ball.y += ball.width / 2;
			}
			addChild(ball)
		}

		public function removeBall():void
		{
			ball = null;
			createBall();
		}

		private function destroy(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			if (ball)
			{
				removeChild(ball);
				ball = null;
			}
			direction = 0;
		}
	}
}
