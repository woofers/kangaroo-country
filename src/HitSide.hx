import openfl.display.Graphics;
import openfl.display.Shape;
import openfl.display.MovieClip;
import openfl.events.Event;

class HitSide extends Shape
{
    public var blocked : Bool;
    public var isInWall : Bool;
    
    public function new(X : Int, Y : Int, Width : Float, Height : Float, Alpha : Float = 0)
    {
        super();
        x = X;
        y = Y;
        
        graphics.beginFill(0x00FFFF, Alpha);
        graphics.drawRect(0, 0, Width, Height);
        graphics.endFill();
        
        // Add Event Handlers
        addEventListener(Event.ENTER_FRAME, update);
    }
    
    private function update(e : Event)
    // Collision
    {
        
        blocked = false;
        isInWall = false;
        var i : Int = 0;
        while (i < Main.instance.playState.map.blocks.length)
        {
            if (hitTestObject(Main.instance.playState.map.blocks[i]) && Main.instance.playState.map.blocks[i].solid)
            {
                blocked = true;
            }
            i++;
        }
        var j : Int = 0;
        while (j < Main.instance.playState.map.walls.length)
        {
            if (hitTestObject(Main.instance.playState.map.walls[j]) && Main.instance.playState.map.walls[j].solid)
            {
                blocked = true;
                isInWall = true;
            }
            j++;
        }
    }
}

