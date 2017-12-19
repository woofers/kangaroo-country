package
{
	import flash.display.MovieClip;

	public class HitBox extends MovieClip
	{
		public var up:HitSide;
		public var down:HitSide;
		public var left:HitSide;
		public var right:HitSide;

		private var swap:int;

		public function HitBox(Width:Number, Height:Number, Scale:Number, Offset:int = 2, Alpha:Number = 0)
		{
			up = new HitSide((Offset), 0, (Width / Scale) - (Offset * 2), 1, Alpha);
			addChild(up);

			down = new HitSide((Offset), (Height / Scale) - 1, (Width / Scale) - (Offset * 2), 1, Alpha);
			addChild(down);

			left = new HitSide(0, (Offset), 1, (Height / Scale) - (Offset * 2), Alpha);
			addChild(left);

			right = new HitSide((Width / Scale) - 1, (Offset), 1, (Height / Scale) - (Offset * 2), Alpha);
			addChild(right);
		}

		public function flip():void
		{
			swap	= left.x;
			left.x	= right.x;
			right.x	= swap;
		}
	}

}
