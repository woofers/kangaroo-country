import openfl.display.MovieClip;
import openfl.events.Event;

class Block extends MovieClip
{
    public var solid : Bool;
    public var scale : Float;
    
    public function new(X : Int, Y : Int, Tile : Int = 1, Scale : Float = 1)
    {
        super();
        // Positions
        x = X;
        y = Y;
        
        // Scale
        setMyScale(Scale);
        
        solid = true;
        
        // Go To Image
        gotoAndPlay(Tile);
        
        addEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }
    
    public function setMyScale(scaleFactor : Float) : Void
    {
        scale = scaleFactor;
        scaleX = scale;
        scaleY = scale;
    }
    
    public function hitTestAlpha(player : Player) : Bool
    {
        return hitTestObject(player.hitBox) && player.alpha > 0;
    }
    
    private function destroy(e : Event) : Void
    {
        removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        solid = false;
        scale = 0;
    }
}

