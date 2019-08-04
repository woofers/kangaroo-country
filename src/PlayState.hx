import openfl.display.MovieClip;
import openfl.geom.Point;
import openfl.events.Event;
import openfl.system.System;
import openfl.display.Loader;
import openfl.net.URLRequest;

class PlayState extends MovieClip
{
    public var characters : Characters;
    public var map : MyMap;
    public var camera : Camera;
    public var isPaused : Bool;
    private var loader : Loader = new Loader();
    
    public function new()
    {
        super();
        
        map = new MyMap();
        addChild(map);
        
        characters = new Characters();
        addChild(characters);
        
        camera = new Camera(characters, map);
    }
    
    public function win() : Void
    {
        loader.load(new URLRequest("assets/images/ui/win.png"));
        addChild(loader);
    }
}

