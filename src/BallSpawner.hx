import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

class BallSpawner extends Block
{
    private var direction : Int;
    public var ball : Ball;
    
    
    public function new(X : Int, Y : Int, Direction)
    {
        super(X, Y, 1, 1);
        
        solid = false;
        
        direction = Direction;
        
        createBall();
        
        addEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }
    
    public function createBall() : Void
    {
        ball = new Ball(0, 0, 5, direction);
        
        // Get Correct Position
        if (direction != 0)
        {
            ball.y += ball.width + ball.width / 2;
        }
        else
        {
            ball.x += ball.height;
            ball.y += ball.width / 2;
        }
        addChild(ball);
    }
    
    public function removeBall() : Void
    {
        ball = null;
        createBall();
    }
    
    private override function destroy(e : Event) : Void
    {
        removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        if (ball != null)
        {
            removeChild(ball);
            ball = null;
        }
        direction = 0;
    }
}

