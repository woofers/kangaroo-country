import openfl.display.Graphics;
import openfl.display.Shape;
import openfl.geom.Point;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

class Player extends MovieClip
{
    private var speed : Int = 4;
    private var jumpHeight : Int = 11;
    
    private var gravity : Int;
    private var scale : Float;
    private var character : String;
    private var currentAnimation : String;
    private var velocity : Point = new Point();
    
    public var hitBox : HitBox;
    private var canJump : Bool;
    private var animationTimer : Timer = new Timer(1000 / 10);
    
    
    public function new(X : Int, Y : Int, Scale : Float = 1, Offset : Int = 2)
    {
        super();
        // Positions
        x = X;
        y = Y;
        
        // Scale
        setScale(Scale);
        
        // Create Hitbox
        hitBox = new HitBox(height, width, scale, Offset);
        addChild(hitBox);
        
        // Play Animation
        playAnimation("walk");
        
        // Create Animation Timer
        animationTimer.addEventListener(TimerEvent.TIMER, changeFrame);
        animationTimer.start();
        
        // Add Event Handlers
        addEventListener(Event.ENTER_FRAME, update);
    }
    
    private function update(e : Event) : Void
    // Animation
    {
        
        if (velocity.x == 0)
        {
            playAnimation("idle");
        }
        else
        {
            playAnimation("walk");
        }
        
        // Movement
        if (Main.instance.playState.characters.currentCharacter == character) {
        
        // Camera And Arrow{
            
            if (isFacingRight())
            {
                Main.instance.playState.camera.x = x;
                Main.instance.playState.characters.arrow.x = x + width / 2;
            }
            else
            {
                Main.instance.playState.camera.x = x - width;
                Main.instance.playState.characters.arrow.x = x - width / 2 - Main.instance.playState.characters.arrow.width;
            }
            
            // Offset Arrow For Baby
            if (character == "Baby")
            {
                Main.instance.playState.characters.arrow.y = y + 10;
            }
            else
            {
                Main.instance.playState.characters.arrow.y = y - 8;
            }
            
            // Right
            if (Main.instance.keys.right) {
            
            // Move Right{
                
                velocity.x = speed;
                
                // Flip Right
                if (!isFacingRight())
                {
                    flip();
                    Main.instance.playState.camera.x = x;
                }
            }
            
            // Left
            if (Main.instance.keys.left) {
            
            // Move Left{
                
                velocity.x = -speed;
                
                // Flip Left
                if (isFacingRight())
                {
                    flip();
                }
            }
            
            // Jump
            if (Main.instance.keys.up && canJump)
            {
                canJump = false;
                velocity.y = -jumpHeight;
            }
            
            // Stop
            if (!Main.instance.keys.left && !Main.instance.keys.right)
            {
                velocity.x = 0;
            }
        }
        else
        {
            velocity.x = 0;
        }
        
        // Collision
        
        // Grounded
        if (hitBox.down.blocked)
        {
            canJump = true;
            velocity.y = 0;
            y--;
        }
        // Falling
        else
        {
            
            {
                canJump = false;
                velocity.y++;
            }
        }
        if (hitBox.up.blocked)
        {
            if (velocity.y < 0)
            {
                velocity.y *= -1;
            }
        }
        if (hitBox.left.blocked)
        {
            velocity.x = speed;
            Main.instance.playState.camera.x += speed;
        }
        if (hitBox.right.blocked)
        {
            velocity.x = -speed;
            Main.instance.playState.camera.x -= speed;
        }
        
        // Rest
        if (y > Main.gameHeight * 1.5 && alpha > 0)
        {
            Main.instance.playState.characters.reset();
        }
        if (hitBox.right.isInWall && hitBox.left.isInWall && hitBox.down.isInWall && hitBox.up.isInWall)
        {
            Main.instance.playState.characters.reset();
        }
        
        // Update Position
        x += velocity.x;
        y += velocity.y;
    }
    
    public function setScale(scaleFactor : Float) : Void
    {
        scale = scaleFactor;
        scaleX = scale;
        scaleY = scale;
    }
    
    public function setPosition(player : Player) : Void
    {
        x = player.x;
        y = player.y;
    }
    
    public function flip() : Void
    {
        if (scaleX > 0)
        {
            x += width;
        }
        else
        {
            x -= width;
        }
        scaleX *= -1;
        hitBox.flip();
    }
    
    public function flipToMatch(player : Player) : Void
    {
        flipTo(player.scaleX);
    }
    
    public function flipTo(scale : Float) : Void
    {
        if (scaleX != scale)
        {
            flip();
        }
    }
    
    private function isFacingRight() : Bool
    {
        return scaleX > 0;
    }
    
    private function playAnimation(animation : String) : Void
    {
        if (currentAnimation != animation)
        {
            currentAnimation = animation;
            gotoAndPlay(currentAnimation);
        }
    }
    
    private function changeFrame(e : TimerEvent) : Void
    {
        if (currentFrame == totalFrames)
        {
            gotoAndPlay(currentAnimation);
            return;
        }
        nextFrame();
    }
}
