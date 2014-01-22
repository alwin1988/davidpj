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
	
	public class DeleteIconHeaderRenderer extends MXAdvancedDataGridItemRenderer
	{
		protected var myImage:Image;
		[Bindable] [Embed("assets/delete.png")]
		public var ICON_DELETE:Class;
		
		public function DeleteIconHeaderRenderer()
		{
			super();
			super.autoDrawBackground = false;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			myImage = new Image();
			myImage.source = ICON_DELETE;
			myImage.width=14;
			myImage.width=14;
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
			myImage.verticalAlign = AdvancedDataGrid(listData.owner).getStyle("verticalAlign");
			//myImage.x = 2;
			//myImage.y = 10;
		}
	}
}