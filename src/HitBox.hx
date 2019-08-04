import openfl.display.MovieClip;

class HitBox extends MovieClip
{
    public var up : HitSide;
    public var down : HitSide;
    public var left : HitSide;
    public var right : HitSide;
    
    private var swap : Float;
    
    public function new(Width : Float, Height : Float, Scale : Float, Offset : Int = 2, Alpha : Float = 0)
    {
        super();
        up = new HitSide((Offset), 0, ((Width / Scale) - (Offset * 2)), 1, Alpha);
        addChild(up);
        
        down = new HitSide((Offset), Std.int((Height / Scale) - 1), ((Width / Scale) - (Offset * 2)), 1, Alpha);
        addChild(down);
        
        left = new HitSide(0, (Offset), 1, ((Height / Scale) - (Offset * 2)), Alpha);
        addChild(left);
        
        right = new HitSide(Std.int((Width / Scale) - 1), (Offset), 1, Std.int(Height / Scale) - (Offset * 2), Alpha);
        addChild(right);
    }
    
    public function flip() : Void
    {
        swap = left.x;
        left.x = right.x;
        right.x = swap;
    }
}


