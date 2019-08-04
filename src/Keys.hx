import openfl.display.MovieClip;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.events.FocusEvent;
import openfl.events.Event;
import openfl.ui.Keyboard;

class Keys extends MovieClip
{
    public var up : Bool;
    public var down : Bool;
    public var left : Bool;
    public var right : Bool;
    public var shift : Bool;
    public var shiftDown : Bool;
    public var escape : Bool;
    public var any : Bool;
    public var anyDown : Bool;
    public var focus : Bool = true;
    
    public function new()
    {
        super();
        // Add Stage
        addEventListener(Event.ADDED_TO_STAGE, init);
    }
    
    private function init(e : Event)
    // Remove Stage
    {
        
        removeEventListener(Event.ADDED_TO_STAGE, init);
        
        // Add Key Handlers
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        
        // Add Focus Handlers
        stage.addEventListener(Event.DEACTIVATE, focusLostHandler);
        stage.addEventListener(Event.RESIZE, focusLostHandler);
    }
    
    private function keyDownHandler(e : KeyboardEvent) : Void
    {
        any = true;
        
        if (e.keyCode == Keyboard.W || e.keyCode == Keyboard.UP || e.keyCode == Keyboard.SPACE)
        {
            up = true;
        }
        if (e.keyCode == Keyboard.S || e.keyCode == Keyboard.DOWN)
        {
            down = true;
        }
        if (e.keyCode == Keyboard.A || e.keyCode == Keyboard.LEFT)
        {
            left = true;
        }
        if (e.keyCode == Keyboard.D || e.keyCode == Keyboard.RIGHT)
        {
            right = true;
        }
        if (e.keyCode == Keyboard.SHIFT)
        {
            shift = true;
        }
        if (e.keyCode == Keyboard.ESCAPE || e.keyCode == Keyboard.P)
        {
            escape = true;
        }
    }
    
    private function keyUpHandler(e : KeyboardEvent) : Void
    {
        any = false;
        anyDown = false;
        
        if (e.keyCode == Keyboard.W || e.keyCode == Keyboard.UP || e.keyCode == Keyboard.SPACE)
        {
            up = false;
        }
        if (e.keyCode == Keyboard.S || e.keyCode == Keyboard.DOWN)
        {
            down = false;
        }
        if (e.keyCode == Keyboard.A || e.keyCode == Keyboard.LEFT)
        {
            left = false;
        }
        if (e.keyCode == Keyboard.D || e.keyCode == Keyboard.RIGHT)
        {
            right = false;
        }
        if (e.keyCode == Keyboard.SHIFT)
        {
            shift = false;
            shiftDown = false;
        }
        if (e.keyCode == Keyboard.ESCAPE || e.keyCode == Keyboard.P)
        {
            escape = false;
        }
    }
    
    private function lostFocus() : Void
    {
        up = false;
        down = false;
        left = false;
        right = false;
        shift = false;
        shiftDown = false;
        escape = false;
        focus = false;
        any = false;
    }
    
    private function focusLostHandlerMouse(e : MouseEvent) : Void
    {
        lostFocus();
    }
    
    private function focusLostHandler(e : Event) : Void
    {
        lostFocus();
    }
    
    public function shiftTap() : Bool
    {
        if (shift && !shiftDown)
        {
            shiftDown = true;
            return true;
        }
        return false;
    }
    
    public function anyTap() : Bool
    {
        if (any && !anyDown)
        {
            anyDown = true;
            return true;
        }
        return false;
    }
}
