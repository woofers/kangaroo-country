import openfl.display.MovieClip;
import openfl.display.Loader;
import openfl.net.URLRequest;
import openfl.events.Event;

class MenuState extends MovieClip
{
    private var loader : Loader = new Loader();
    private var isInstructions : Bool;
    
    public function new()
    {
        super();
        loader.load(new URLRequest("assets/images/ui/startScreen.png"));
        addChild(loader);
        
        // Add Event Handlers
        addEventListener(Event.ENTER_FRAME, update);
        addEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }
    
    private function update(e : Event) : Void
    {
        if (Main.instance.keys.anyTap())
        {
            if (isInstructions) {
            
            // Start Play State{
                
                Main.instance.playState = new PlayState();
                parent.addChild(Main.instance.playState);
                
                // Destroy This State
                parent.removeChild(this);
            }
            else
            {
                isInstructions = true;
                loader.load(new URLRequest("assets/images/ui/instructions.png"));
            }
        }
    }
    
    private function destroy(e : Event) : Void
    // Remove Event Handlers
    {
        
        removeEventListener(Event.ENTER_FRAME, update);
        removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        
        Main.instance.menuState = null;
    }
}

