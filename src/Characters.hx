import openfl.display.MovieClip;
import openfl.geom.Point;
import openfl.events.Event;

class Characters extends MovieClip
{
    public var bothKangaroo : BothKangaroo;
    public var mother : Mother;
    public var baby : Baby;
    public var arrow : Arrow;
    public var currentCharacter : String;
    
    public function new()
    {
        super();
        // Add Mother
        mother = new Mother(500, 500);
        addChild(mother);
        
        // Add Baby
        baby = new Baby(500, 500);
        addChild(baby);
        
        // Add Both Kangaroos
        bothKangaroo = new BothKangaroo(500, 500);
        addChild(bothKangaroo);
        
        // Add Arrow
        arrow = new Arrow();
        addChild(arrow);
        
        // Add Stage
        addEventListener(Event.ADDED_TO_STAGE, init);
    }
    
    private function init(e : Event)
    // Remove Stage
    {
        
        removeEventListener(Event.ADDED_TO_STAGE, init);
        
        reset();
    }
    
    public function reset() : Void
    {
        moveToStart(baby);
        moveToStart(mother);
        moveToStart(bothKangaroo);
        
        setPlayer("BothKangaroo");
        
        // Face Right
        if (bothKangaroo.scaleX < 0)
        {
            bothKangaroo.flip();
            bothKangaroo.x += bothKangaroo.width;
        }
    }
    
    private function moveToStart(player : Player)
    {
        player.x = Main.instance.playState.map.start.x;
        player.y = Main.instance.playState.map.start.y;
    }
    
    public function setPlayer(player : String, fromBoth : Bool = false)
    {
        currentCharacter = player;
        if (currentCharacter == "BothKangaroo") {
        
        // Hide{
            
            mother.alpha = 0;
            baby.alpha = 0;
            bothKangaroo.alpha = 1;
            
            // Flip
            bothKangaroo.flipToMatch(mother);
            
            // Positions
            bothKangaroo.setPosition(mother);
        }
        // Hide
        else
        {
            
            mother.alpha = 1;
            baby.alpha = 1;
            bothKangaroo.alpha = 0;
            
            // Baby
            if (currentCharacter == "Baby" && fromBoth) {
            
            // Flip{
                
                baby.flipToMatch(bothKangaroo);
                mother.flipToMatch(bothKangaroo);
                
                // Positions
                baby.setPosition(bothKangaroo);
                mother.setPosition(bothKangaroo);
                
                baby.x += 30 * baby.scaleX / 3;
            }
        }
    }
}


