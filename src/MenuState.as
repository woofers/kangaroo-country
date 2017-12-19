package
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;

	public class MenuState extends MovieClip
	{
		private var loader:Loader = new Loader();
		private var isInstructions:Boolean;

		public function MenuState()
		{
			loader.load(new URLRequest("assets/images/ui/startScreen.png"));
			addChild(loader);

			// Add Event Handlers
			addEventListener(Event.ENTER_FRAME, update);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}

		private function update(e:Event):void
		{
			if (Main.instance.keys.anyTap())
			{
				if (isInstructions)
				{
					// Start Play State
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

		private function destroy(e:Event):void
		{
			// Remove Event Handlers
			removeEventListener(Event.ENTER_FRAME, update);
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);

			Main.instance.menuState = null;
		}
	}
}
