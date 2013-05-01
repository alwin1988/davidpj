package events
{
	import flash.events.Event;
	
	public class MyGridEvent extends Event
	{
		public static var DRAWGRID:String = "drawgrid";
		public function MyGridEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}