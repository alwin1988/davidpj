package nndemo
{
	import flash.events.Event;
	
	public class MyTitleWindowEvent extends Event
	{
		public static const RD1_CLICK:String = "rd1ClickEvent"
		public static const RD2_CLICK:String = "rd2ClickEvent"
		public static const RD3_CLICK:String = "rd3ClickEvent"
			
		public function MyTitleWindowEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}