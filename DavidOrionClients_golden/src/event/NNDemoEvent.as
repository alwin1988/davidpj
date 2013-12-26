package event
{
	import flash.events.Event;
	
	public class NNDemoEvent extends Event
	{
		public static const NNDEMO_CHANGE:String = "nndemoChange";
		public static const NNDEMO_CLOSE:String = "nndemoClose";
		public static const NNDEMO_CLOSE_2:String = "nndemoClose2";
		public var nndemo_index:int=0;
		public function NNDemoEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}