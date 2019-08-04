import openfl.display.MovieClip;
import openfl.geom.Point;
import openfl.events.Event;

class Camera
{
    public var x(get, set) : Float;
    public var y(get, set) : Float;

    private var position : Point = new Point();
    private var map : MyMap;
    private var characters : Characters;
    
    public function new(Character : Characters, Level : MyMap)
    {
        position = new Point();
        characters = Character;
        map = Level;
        center();
    }
    
    public function center() : Void
    {
        x = Main.gameWidth / 2;
        y = Main.gameHeight / 2;
    }
    
    private function set_x(value : Float) : Float
    {
        if (value < position.x || position.x <= 0)
        {
            if (value > Main.gameWidth / 2)
            {
                position.x = value;
            }
            else
            {
                position.x = Main.gameWidth / 2;
            }
        }
        else if (value < map.mapWidth - Main.gameWidth / 2)
        {
            position.x = value;
        }
        else
        {
            position.x = map.mapWidth - Main.gameWidth / 2;
        }
        
        map.x = -position.x + (Main.gameWidth / 2);
        characters.x = -position.x + (Main.gameWidth / 2);
        return value;
    }
    
    private function set_y(value : Float) : Float
    {
        position.y = value;
        map.y = -position.y + (Main.gameHeight / 2);
        characters.y = -position.y + (Main.gameHeight / 2);
        return value;
    }
    
    private function get_x() : Float
    {
        return position.x;
    }
    
    private function get_y() : Float
    {
        return position.y;
    }
}

