import openfl.display.MovieClip;
import openfl.events.Event;

class Button extends Wall
{
    public var weighted : Bool;
    public var isTouched : Bool;
    public var isUsed : Bool;
    
    public function new(X : Int, Y : Int, Index : Int)
    {
        super(X, Y, Index);
        
        // Add Stage
        addEventListener(Event.ADDED_TO_STAGE, init);
    }
    
    private function init(e : Event)
    // Remove Stage
    {
        
        removeEventListener(Event.ADDED_TO_STAGE, init);
        
        addEventListener(Event.ENTER_FRAME, update);
        addEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }
    
    private function update(e : Event) : Void
    {
        if (hitTestAnyPlayer())
        {
            isTouched = true;
        }
        else if (weighted)
        {
            isTouched = false;
        }
        
        if (!isUsed)
        {
            if (isTouched)
            {
                isUsed = true;
                if (!weighted)
                {
                    alpha = 0;
                    if (wallsAreSolid())
                    {
                        activate();
                    }
                    else
                    {
                        deactivate();
                    }
                }
                else if (wallsAreSolid())
                {
                    activate();
                }
                else
                {
                    deactivate();
                }
            }
        }
        
        if (isUsed && !isTouched && weighted)
        {
            isUsed = false;
            if (wallsAreSolid())
            {
                activate();
            }
            else
            {
                deactivate();
            }
        }
    }
    
    private function hitTestAnyPlayer() : Bool
    {
        return hitTestAlpha(Main.instance.playState.characters.bothKangaroo) || hitTestAlpha(Main.instance.playState.characters.baby) || hitTestAlpha(Main.instance.playState.characters.mother);
    }
    
    public function activate() : Void
    // Remove Walls
    {
        
        var i : Int = 0;
        while (i < Main.instance.playState.map.walls.length)
        {
            if (Main.instance.playState.map.walls[i].solid && Main.instance.playState.map.walls[i].index == index)
            {
                Main.instance.playState.map.walls[i].solid = false;
                Main.instance.playState.map.walls[i].alpha = 0;
            }
            i++;
        }
    }
    
    public function deactivate() : Void
    // Recreate Walls
    {
        
        var i : Int = 0;
        while (i < Main.instance.playState.map.walls.length)
        {
            if (!Main.instance.playState.map.walls[i].solid && Main.instance.playState.map.walls[i].index == index)
            {
                Main.instance.playState.map.walls[i].solid = true;
                Main.instance.playState.map.walls[i].alpha = 1;
            }
            i++;
        }
    }
    
    private function wallsAreSolid() : Bool
    // Remove Walls
    {
        
        var i : Int = 0;
        while (i < Main.instance.playState.map.walls.length)
        {
            if (Main.instance.playState.map.walls[i].index == index)
            {
                if (Main.instance.playState.map.walls[i].solid)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            i++;
        }
        return false;
    }
    
    private override function destroy(e : Event) : Void
    {
        removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        removeEventListener(Event.ENTER_FRAME, update);
        weighted = false;
        isTouched = false;
        isUsed = false;
    }
}

