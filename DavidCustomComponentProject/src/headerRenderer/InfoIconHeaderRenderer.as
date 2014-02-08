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
	
	public class InfoIconHeaderRenderer extends MXAdvancedDataGridItemRenderer
	{
		protected var myImage:Image;
		[Bindable] [Embed("assets/iconinfo.png")]
		public var ICON_INFO:Class;
		
		public function InfoIconHeaderRenderer()
		{
			super();
			super.autoDrawBackground = false;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			myImage = new Image();
			myImage.source = ICON_INFO;
			myImage.width=12.5;
			myImage.width=12.5;
			//myImage.setStyle("horizontalCenter", "-2");
			myImage.setStyle("horizontalCenter", "0");
			myImage.setStyle("horizontalAlign", "center");
			myImage.setStyle("verticalCenter", "0");
			myImage.setStyle("verticalAlign", "middle");
			myImage.visible = true;
			addElement(myImage);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			var adgld:AdvancedDataGridListData = listData as AdvancedDataGridListData;
			trace(AdvancedDataGrid(listData.owner).getStyle("verticalAlign"));
			//trace(adgld.dataField);			
			//myImage.verticalAlign = AdvancedDataGrid(listData.owner).getStyle("verticalAlign");
			//myImage.horizontalAlign = AdvancedDataGrid(listData.owner).getStyle("horizontalAlign");
			//myImage.verticalCenter = AdvancedDataGrid(listData.owner).verticalCenter;
			//myImage.horizontalCenter = AdvancedDataGrid(listData.owner).horizontalCenter;
		}
	}
}