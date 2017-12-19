package
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import fl.motion.Color;

	public class Map extends MovieClip
	{
		private var level:Level;
		private var index:int = 0;

		public var mapHeight:int;
		public var mapWidth:int;
		public var goal:Goal;

		public var map:Array			= new Array();
		public var blocks:Array			= new Array();
		public var checkpoints:Array	= new Array();
		public var buttons:Array		= new Array();
		public var walls:Array			= new Array();
		public var start:Point			= new Point();
		private var buttonColor:Color	= new Color();

		private var blockSize:int;
		private var checkpointSize:int;
		private var buttonSize:int;
		private var wallSize:int;
		private var cellSize:int = 70;


		public function Map()
		{
			loadNextLevel();

			// Add Stage
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event)
		{
			// Remove Stage
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}

		public function loadMap():void
		{
			// Get Map Scale
			mapHeight	= map.length * cellSize;
			mapWidth	= map[0].length * cellSize;

			// Rows
			for (var row:int = 0; row < map.length; row++)
			{
				// Column
				for (var column:int = 0; column < map[row].length; column++)
				{
					var data:int = map[row][column];

					switch (data)
					{
						// Continue
						case 0:
							continue;
						break;

						// Start Positions
						case 2:
							start.x = column * cellSize;
							start.y = (row * cellSize) - 30;
						break;

						case 3:
							goal = new Goal(column * cellSize, row * cellSize);
							addChild(goal);
						break;

						// Create Ball Spawner
						case 7:
						case 8:
							if (data == 7)
							{
								blocks[blockSize] = new BallSpawner(column * cellSize, row * cellSize, 180);
							}
							else
							{
								blocks[blockSize] = new BallSpawner(column * cellSize, row * cellSize, 0);
							}

							addChild(blocks[blockSize]);
							blockSize ++;
						break;

						// Checkpoints
						case 9:
							checkpoints[checkpointSize] = new Checkpoint(column * cellSize, row * cellSize);
							addChild(checkpoints[checkpointSize]);
							checkpointSize ++;
						break;

						// Buttons
						case 12:
						case 13:
						case 14:
							setButtonColor(data - 10);
							buttons[buttonSize] = new Button(column * cellSize, row * cellSize, data - 10);
							buttons[buttonSize].transform.colorTransform = buttonColor;
							addChild(buttons[buttonSize]);
							buttonSize ++;
						break;

						// Weighted Buttons
						case 22:
						case 23:
						case 24:
							setButtonColor(data - 20);
							buttons[buttonSize] = new Button(column * cellSize, row * cellSize, data - 20);
							buttons[buttonSize].weighted = true;
							buttons[buttonSize].transform.colorTransform = buttonColor;
							addChild(buttons[buttonSize]);
							buttonSize ++;
						break;

						// Buttons Walls
						case 32:
						case 33:
						case 34:
							setButtonColor(data - 30);
							walls[wallSize] = new Wall(column * cellSize, row * cellSize, data - 30);
							walls[wallSize].transform.colorTransform = buttonColor;
							addChild(walls[wallSize]);
							wallSize ++;
						break;

						// Blocks
						default:
							blocks[blockSize] = new Block(column * cellSize, row * cellSize, data);
							addChild(blocks[blockSize]);
							blockSize ++;
						break;
					}
				}
			}
		}

		private function setButtonColor(object:int, tintMultiplier:int = 1):void
		{
			switch (object)
			{
				// Red
				case 2:
					buttonColor.setTint(0xE26F7D, tintMultiplier);
				break;
				// Yellow
				case 3:
					buttonColor.setTint(0xF5D750, tintMultiplier);
				break;
				// Orange
				case 4:
					buttonColor.setTint(0xF58C50, tintMultiplier);
				break;
			}
		}

		private function destroy(e:Event):void
		{
			// Remove Event Handlers
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			clearLevel();
		}

		private function clearLevel():void
		{
			// Null Object
			removeChild(goal);
			start   = new Point();
			level	= null;
			map		= null;
			goal	= null;

			mapHeight      = 0;
			mapWidth       = 0;
			blockSize      = 0;
			checkpointSize = 0;
			buttonSize     = 0;
			wallSize       = 0;

			for (var i:int = 0; i < blocks.length; i++)
			{
				removeChild(blocks[i]);
				blocks[i] = null;
			}
			blocks.length = 0;
			for (i = 0; i < checkpoints.length; i++)
			{
				removeChild(checkpoints[i])
				checkpoints[i] = null;
			}
			checkpoints.length = 0;
			for (i = 0; i < buttons.length; i++)
			{
				removeChild(buttons[i]);
				buttons[i] = null;
			}
			buttons.length = 0;
			for (i = 0; i < walls.length; i++)
			{
				removeChild(walls[i]);
				walls[i] = null;
			}
			walls.length = 0;
		}

		public function loadNextLevel():void
		{

			if (level)
			{
				clearLevel();
			}
			if (index == 2)
			{
				Main.instance.playState.win();
				return;
			}

			index ++;

			level = new Level("assets/levels/level" + index + ".txt")
		}
	}
}
