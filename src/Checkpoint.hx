import openfl.display.MovieClip;
import openfl.events.Event;

class Checkpoint extends Block
{
    public var activated : Bool;
    
    public function new(X : Int, Y : Int, Scale : Float = 2)
    {
        super(X, Y, 1, Scale);
        
        solid = false;
        
        // Add Event Handlers
        addEventListener(Event.ENTER_FRAME, update);
        addEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }
    
    private function update(e : Event)
    {
        if (hitTestAlpha(Main.instance.playState.characters.baby) && hitTestAlpha(Main.instance.playState.characters.mother) || hitTestAlpha(Main.instance.playState.characters.bothKangaroo))
        {
            activate();
        }
    }
    
    public function activate() : Void
    {
        if (!activated) {
        
        // Deactivate Checkpoints{
            
            var i : Int = 0;
            while (i < Main.instance.playState.map.checkpoints.length)
            {
                Main.instance.playState.map.checkpoints[i].deactivate();
                i++;
            }
            activated = true;
            Main.instance.playState.map.start.x = x;
            Main.instance.playState.map.start.y = y - 20;
            gotoAndPlay(2);
        }
    }
    
    public function deactivate() : Void
    {
        if (activated)
        {
            gotoAndPlay(1);
            activated = false;
        }
    }
    
    private override function destroy(e : Event) : Void
    {
        removeEventListener(Event.ENTER_FRAME, update);
        removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        activated = false;
    }
}

