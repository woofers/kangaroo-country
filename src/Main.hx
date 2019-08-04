import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;

import openfl.Assets;

class Main extends MovieClip
{
    public static var instance(get, never) : Main;
    public static var gameWidth(get, never) : Int;
    public static var gameHeight(get, never) : Int;

    public var keys : Keys;
    public var menuState : MenuState;
    public var playState : PlayState;
    
    private static var _instance : Main;
    private static var _width : Int;
    private static var _height : Int;
    
    public function new()
    {
        super();
		
        _instance = this;
        
        _width = stage.stageWidth;
        _height = stage.stageHeight;
        
        // Add Key Handler
        keys = new Keys();
        addChild(keys);
        
        // Add Menu State
        menuState = new MenuState();
        addChild(menuState);
        
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        
		var cat = Assets.getMovieClip("library:Baby");
		addChild(cat);
		
		
    }
    
    public function random(min : Int, max : Int) : Int
    {
        return (max - min + 1) * Std.int(Math.random()) + min;
    }
    
    private static function get_instance() : Main
    {
        return _instance;
    }
    
    private static function get_gameWidth() : Int
    {
        return _width;
    }
    
    private static function get_gameHeight() : Int
    {
        return _height;
    }
}

