package
{
	import flash.events.Event;
	
	public class CustomCompEvent extends Event
	{		
		public static const BUTTON_ONE:String="buttonOne";
		public static const BUTTON_TWO:String="buttonTwo";
		public static const BUTTON_THREE:String="buttonThree";
		public static const BUTTON_FOUR:String="buttonFour";
		
		public function CustomCompEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}