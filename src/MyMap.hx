import openfl.display.MovieClip;
import openfl.geom.Point;
import openfl.events.Event;
//import fl.motion.Color;

class MyMap extends MovieClip
{
    private var level : Level;
    private var index : Int = 0;
    
    public var mapHeight : Int;
    public var mapWidth : Int;
    public var goal : Goal;
    
    public var map : Array<Dynamic> = new Array<Dynamic>();
    public var blocks : Array<Dynamic> = new Array<Dynamic>();
    public var checkpoints : Array<Dynamic> = new Array<Dynamic>();
    public var buttons : Array<Dynamic> = new Array<Dynamic>();
    public var walls : Array<Dynamic> = new Array<Dynamic>();
    public var start : Point = new Point();
    //private var buttonColor : Color = new Color();
    
    private var blockSize : Int;
    private var checkpointSize : Int;
    private var buttonSize : Int;
    private var wallSize : Int;
    private var cellSize : Int = 70;
    
    
    public function new()
    {
        super();
        loadNextLevel();
        
        // Add Stage
        addEventListener(Event.ADDED_TO_STAGE, init);
    }
    
    private function init(e : Event)
    // Remove Stage
    {
        
        removeEventListener(Event.ADDED_TO_STAGE, init);
        addEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }
    
    public function loadMap() : Void
    // Get Map Scale
    {
        
        mapHeight = map.length * cellSize;
        mapWidth = 0;//map[0].length * cellSize;
        
        // Rows
        var row : Int = 0;
        while (row < map.length) {
        
        // Column{
            
            var column : Int = 0;
            while (column < map[row].length)
            {
                var data : Int = map[row][column];
                
                switch (data)
                {
                    // Continue
                    case 0:
                        column++;
                        continue;
                        
                    
                    // Start Positions
                    case 2:
                        start.x = column * cellSize;
                        start.y = (row * cellSize) - 30;
                    
                    case 3:
                        goal = new Goal(column * cellSize, row * cellSize);
                        addChild(goal);
                    case 7, 8:
                        if (data == 7)
                        {
                            blocks[blockSize] = new BallSpawner(column * cellSize, row * cellSize, 180);
                        }
                        else
                        {
                            blocks[blockSize] = new BallSpawner(column * cellSize, row * cellSize, 0);
                        }
                        
                        addChild(blocks[blockSize]);
                        blockSize++;
                    
                    // Checkpoints
                    case 9:
                        checkpoints[checkpointSize] = new Checkpoint(column * cellSize, row * cellSize);
                        addChild(checkpoints[checkpointSize]);
                        checkpointSize++;
                    case 12, 13, 14:
                        setButtonColor(data - 10);
                        buttons[buttonSize] = new Button(column * cellSize, row * cellSize, data - 10);
                        //buttons[buttonSize].transform.colorTransform = buttonColor;
                        addChild(buttons[buttonSize]);
                        buttonSize++;
                    case 22, 23, 24:
                        setButtonColor(data - 20);
                        buttons[buttonSize] = new Button(column * cellSize, row * cellSize, data - 20);
                        buttons[buttonSize].weighted = true;
                        //buttons[buttonSize].transform.colorTransform = buttonColor;
                        addChild(buttons[buttonSize]);
                        buttonSize++;
                    case 32, 33, 34:
                        setButtonColor(data - 30);
                        walls[wallSize] = new Wall(column * cellSize, row * cellSize, data - 30);
                        //walls[wallSize].transform.colorTransform = buttonColor;
                        addChild(walls[wallSize]);
                        wallSize++;
                    // Blocks
                    default:
                        blocks[blockSize] = new Block(column * cellSize, row * cellSize, data);
                        addChild(blocks[blockSize]);
                        blockSize++;
                }
                column++;
            }
            row++;
		}
    }
    
    private function setButtonColor(object : Int, tintMultiplier : Int = 1) : Void
    {
		/*
        switch (object)
        {
            // Red
            case 2:
                buttonColor.setTint(0xE26F7D, tintMultiplier);
            // Yellow
            case 3:
                buttonColor.setTint(0xF5D750, tintMultiplier);
            // Orange
            case 4:
                buttonColor.setTint(0xF58C50, tintMultiplier);
        }
		*/
    }
    
    private function destroy(e : Event) : Void
    // Remove Event Handlers
    {
        
        removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        clearLevel();
    }
    
    private function clearLevel() : Void
    // Null Object
    {
        
        removeChild(goal);
        start = new Point();
        level = null;
        map = null;
        goal = null;
        
        mapHeight = 0;
        mapWidth = 0;
        blockSize = 0;
        checkpointSize = 0;
        buttonSize = 0;
        wallSize = 0;
        
        var i : Int = 0;
        while (i < blocks.length)
        {
            removeChild(blocks[i]);
            blocks[i] = null;
            i++;
        }
        //as3hx.Compat.setArrayLength(blocks, 0);
        i = 0;
        while (i < checkpoints.length)
        {
            removeChild(checkpoints[i]);
            checkpoints[i] = null;
            i++;
        }
        //as3hx.Compat.setArrayLength(checkpoints, 0);
        i = 0;
        while (i < buttons.length)
        {
            removeChild(buttons[i]);
            buttons[i] = null;
            i++;
        }
        //as3hx.Compat.setArrayLength(buttons, 0);
        i = 0;
        while (i < walls.length)
        {
            removeChild(walls[i]);
            walls[i] = null;
            i++;
        }
        //as3hx.Compat.setArrayLength(walls, 0);
    }
    
    public function loadNextLevel() : Void
    {
        if (level != null)
        {
            clearLevel();
        }
        if (index == 2)
        {
            Main.instance.playState.win();
            return;
        }
        
        index++;
        
        level = new Level("assets/levels/level" + index + ".txt");
    }
}

