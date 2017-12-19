package
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.FocusEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;

	public class Keys extends MovieClip
	{
		public var up:Boolean;
		public var down:Boolean;
		public var left:Boolean;
		public var right:Boolean;
		public var shift:Boolean;
		public var shiftDown:Boolean;
		public var escape:Boolean;
		public var any:Boolean;
		public var anyDown:Boolean;
		public var focus:Boolean = true;

		public function Keys()
		{
			// Add Stage
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event)
		{
			// Remove Stage
			removeEventListener(Event.ADDED_TO_STAGE, init);

			// Add Key Handlers
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);

			// Add Focus Handlers
			stage.addEventListener(Event.DEACTIVATE, focusLostHandler);
			stage.addEventListener(Event.RESIZE, focusLostHandler);
		}

		private function keyDownHandler(e:KeyboardEvent):void
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

		private function keyUpHandler(e:KeyboardEvent):void
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
				shift		= false;
				shiftDown	= false;
			}
			if (e.keyCode == Keyboard.ESCAPE || e.keyCode == Keyboard.P)
			{
				escape = false;
			}
		}

		private function lostFocus():void
		{
			up			= false;
			down		= false;
			left		= false;
			right		= false;
			shift		= false;
			shiftDown	= false;
			escape		= false;
			focus		= false;
			any			= false;
		}

		private function focusLostHandlerMouse(e:MouseEvent):void
		{
			lostFocus();
		}

		private function focusLostHandler(e:Event):void
		{
			lostFocus();
		}

		public function shiftTap():Boolean
		{
			if (shift && !shiftDown)
			{
				shiftDown = true;
				return true;
			}
			return false;
		}

		public function anyTap():Boolean
		{
			if (any && !anyDown)
			{
				anyDown = true;
				return true;
			}
			return false;
		}
	}
}