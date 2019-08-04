import openfl.display.MovieClip;
import openfl.events.Event;

class Ball extends MovieClip
{
    private var speed : Int;
    private var wallHit : Bool;
    
    public function new(X : Int, Y : Int, Speed : Int = 5, Rotation : Int = 0, Scale : Float = 3)
    {
        super();
        // Positions
        x = X;
        y = Y;
        
        // Speed
        speed = Speed;
        
        // Scale
        width *= Scale;
        height *= Scale;
        
        //  Rotation
        rotation = Rotation;
        
        // Flip Image If Needed
        if (rotation > 0)
        {
            gotoAndPlay(2);
        }
        
        // Add Event Handlers
        addEventListener(Event.ENTER_FRAME, update);
        addEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }
    
    private function update(e : Event) : Void
    // Movement
    {
        
        x += (Math.cos(rotation * Math.PI / 180)) * speed;
        y += (Math.sin(rotation * Math.PI / 180)) * speed;
        
        // Hit Detection
        hitDetection(Main.instance.playState.characters.mother);
        hitDetection(Main.instance.playState.characters.baby);
        hitDetection(Main.instance.playState.characters.bothKangaroo);
        
        // Delete When Hit Walls
        var i : Int = 0;
        while (i < Main.instance.playState.map.blocks.length)
        {
            if (hitTestObject(Main.instance.playState.map.blocks[i]) && Main.instance.playState.map.blocks[i].solid)
            {
                wallHit = true;
                cast((parent), MovieClip).removeChild(this);
            }
            i++;
        }
        i = 0;
        while (i < Main.instance.playState.map.walls.length)
        {
            if (hitTestObject(Main.instance.playState.map.walls[i]) && Main.instance.playState.map.walls[i].solid)
            {
                wallHit = true;
                cast((parent), MovieClip).removeChild(this);
            }
            i++;
        }
    }
    
    private function hitDetection(player : Player) : Void
    {
        if (hitTestObject(player.hitBox) && player.alpha == 1)
        {
            Main.instance.playState.characters.reset();
        }
    }
    
    private function destroy(e : Event) : Void
    // Remove Event Handlers
    {
        
        removeEventListener(Event.ENTER_FRAME, update);
        removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        
        if (wallHit) {
        
        // Null Object{
            
            cast((parent), BallSpawner).removeBall();
        }
    }
}

