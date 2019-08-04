import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.net.URLLoader;
import openfl.net.URLRequest;

class Level
{
    public var data : Array<Dynamic>;
    private var string : String = "";
    public var levelData : Array<Dynamic>;
    private var loader : URLLoader = new URLLoader();
    
    public function new(level : String)
    {
        loader.load(new URLRequest(level));
        loader.addEventListener(Event.COMPLETE, onLoaded);
    }
    
    private function onLoaded(e : Event) : Void
    // Import Text File
    {
        /*
        data = e.target.data.split(new EReg('\\n', ""));
        
        // Remove Excess
        data = data.slice(13, data.length - 2);
        
        // Add Brackets
        var i : Int = 0;
        while (i < data.length - 1)
        {
            if (i != 0)
            {
                data[i] = "[" + Std.string(data[i]).slice(0, Std.string(data[i]).length - 2) + "],";
            }
            else
            {
                data[i] = "[[" + Std.string(data[i]).slice(0, Std.string(data[i]).length - 2) + "],";
            }
            i++;
        }
        data[data.length - 1] = "[" + data[data.length - 1] + "]]";
        
        // Convert To String
        var j : Int = 0;
        while (j < data.length)
        {
            string = string + data[j];
            j++;
        }
        */
        // Convert to array
        //levelData = try cast(haxe.Json.decode(string), Array</*AS3HX WARNING no type*/>) catch(e:Dynamic) null;
        
        // Create Level
        Main.instance.playState.map.map = levelData;
        Main.instance.playState.map.loadMap();
        Main.instance.playState.characters.reset();
        
        // Clean Up Data
        loader = null;
        levelData = null;
        string = null;
    }
}

