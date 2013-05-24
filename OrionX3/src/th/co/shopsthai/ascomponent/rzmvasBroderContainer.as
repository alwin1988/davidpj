package th.co.shopsthai.ascomponent
{
	import flex.utils.spark.resize.MoveManager;
	import flex.utils.spark.resize.ResizeHandleLines;
	import flex.utils.spark.resize.ResizeHandleLinesL;
	import flex.utils.spark.resize.ResizeHandleLinesR;
	
	import spark.components.BorderContainer;
	import spark.components.Group;
			
	public class rzmvasBroderContainer extends BorderContainer
	{
		
		public static const DRAG_START:String = "dragStart";
		
		public static const DRAGGING:String = "dragging";
		
		public static const DRAG_END:String = "dragEnd";
		
		[Bindable] public var LR:Boolean = false;
		[Bindable] public var RR:Boolean = false;
		[Bindable] public var MV:Boolean = false;
		
		
		[Bindable] public var color:uint = 0xFFFFFF;
		
		[SkinPart(required="false")]
		public var moveControl:Group;
		
		[SkinPart(required="false")]
		public var resizeControl:ResizeHandleLines;
		
		[SkinPart(required="false")]
		public var resizeControlL:ResizeHandleLinesL;

		[SkinPart(required="false")]
		public var resizeControlR:ResizeHandleLinesR;
		
		public function rzmvasBroderContainer()
		{
			super();
		}
		
	}
}