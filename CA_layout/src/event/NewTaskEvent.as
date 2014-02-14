package event
{
	import flash.events.Event;
	
	public class NewTaskEvent extends Event
	{
		public static const NewTask_CHANGE:String = "newtaskChange";
		public static const NewTask_CLOSE:String = "newtaskClose";
		public var docviewer_index:int=0;
		public function NewTaskEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}