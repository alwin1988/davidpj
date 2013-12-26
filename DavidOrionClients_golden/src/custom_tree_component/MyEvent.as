package components
{
	import flash.events.Event;
	
	public class MyEvent extends Event
	{
		public static const EXPAND_ALL:String="expandAllEvent";
		public static const HIDE_ALL:String="hideAllEvent";
		public static const STATE2:String="state2";
		public var myHeight:Number=0;
		
		public function MyEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}