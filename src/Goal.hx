import openfl.display.MovieClip;
import openfl.events.Event;

class Goal extends Block
{
    public function new(X : Int, Y : Int, Scale : Float = 1)
    {
        super(X, Y, 1, Scale);
        
        // Add Event Handlers
        addEventListener(Event.ENTER_FRAME, update);
        addEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }
    
    private function update(e : Event) : Void
    {
        if (hitTestAlpha(Main.instance.playState.characters.baby) && hitTestAlpha(Main.instance.playState.characters.mother) || hitTestAlpha(Main.instance.playState.characters.bothKangaroo))
        {
            Main.instance.playState.map.loadNextLevel();
        }
    }
    
    private override function destroy(e : Event)
    {
        removeEventListener(Event.ENTER_FRAME, update);
        removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }
}

