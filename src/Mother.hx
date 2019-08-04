import openfl.display.MovieClip;
import openfl.events.Event;

class Mother extends Player
{
    public function new(X : Int, Y : Int, Scale : Float = 3)
    {
        super(X, Y, Scale, 10);
        
        // Physics
        alpha = 0;
        speed = 6;
        jumpHeight = 18;
        character = "Mother";
        
        // Hitbox
        hitBox.y += 5;
        hitBox.up.y += 4;
        hitBox.left.x += 4;
        hitBox.right.x -= 8;
        
        // Add Event Handlers
        addEventListener(Event.ENTER_FRAME, update);
    }
    
    private override function update(e : Event) : Void
    {
        if (Main.instance.playState.characters.currentCharacter == character)
        {
            if (Main.instance.keys.shiftTap())
            {
                Main.instance.playState.characters.setPlayer("Baby");
            }
        }
    }
}


