package headerRenderer
{
	import components.WmTitleWindows;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.HBox;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.advancedDataGridClasses.MXAdvancedDataGridItemRenderer;
	import mx.core.FlexGlobals;
	import mx.core.mx_internal;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Image;
	import spark.layouts.VerticalAlign;
	
	public class InfoButtonHeaderRenderer extends MXAdvancedDataGridItemRenderer
	{
		protected var myImage:Image;
		[Bindable] [Embed("assets/iconinfo.png")]
		public var ICON_INFO:Class;
		
		public function InfoButtonHeaderRenderer()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			myImage = new Image();
			myImage.source = ICON_INFO;
			myImage.width=14;
			myImage.width=14;
			myImage.visible = true;
			addElement(myImage);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			var adgld:AdvancedDataGridListData = listData as AdvancedDataGridListData;
			trace(AdvancedDataGrid(listData.owner).getStyle("verticalAlign"));
			//trace(adgld.dataField);
			myImage.verticalAlign = AdvancedDataGrid(listData.owner).getStyle("verticalAlign");
			//myImage.x = 2;
			//myImage.y = 10;
		}
	}
}