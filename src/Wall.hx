import openfl.display.MovieClip;
import openfl.events.Event;

class Wall extends Block
{
    public var index : Int;
    
    public function new(X : Int, Y : Int, Index : Int)
    {
        super(X, Y, 1, 1);
        
        solid = true;
        index = Index;
        
        addEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }
    
    private override function destroy(e : Event) : Void
    {
        removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        index = 0;
    }
}


