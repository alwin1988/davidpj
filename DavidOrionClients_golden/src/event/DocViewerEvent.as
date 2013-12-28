package event
{
	import flash.events.Event;
	
	public class DocViewerEvent extends Event
	{
		public static const DocViewer_CHANGE:String = "docviewerChange";
		public static const DocViewer_CLOSE:String = "docviewerClose";
		public var docviewer_index:int=0;
		public function DocViewerEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}