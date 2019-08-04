import openfl.display.MovieClip;
import openfl.events.Event;

class BothKangaroo extends Player
{
    public function new(X : Int, Y : Int, Scale : Float = 3)
    {
        super(X, Y, Scale, 10);
        
        // Physics
        alpha = 1;
        speed = 5;
        jumpHeight = 15;
        character = "BothKangaroo";
        
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
        if (Main.instance.playState.characters.currentCharacter == character) {
        
        // Switch To Baby{
            
            if (Main.instance.keys.shiftTap())
            {
                if (isFacingRight())
                {
                    if (!hitBox.right.blocked)
                    {
                        Main.instance.playState.characters.setPlayer("Baby", true);
                    }
                }
                else if (!hitBox.left.blocked)
                {
                    Main.instance.playState.characters.setPlayer("Baby", true);
                }
            }
        }
    }
}


