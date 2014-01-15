package component
{
	import flash.events.MouseEvent;
	
	import mx.collections.HierarchicalCollectionView;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.CheckBox;
	import mx.controls.Image;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.advancedDataGridClasses.MXAdvancedDataGridItemRenderer;
	
	public class HADGCheckBoxItemRenderer extends MXAdvancedDataGridItemRenderer
	{
		
		protected var myImage:Image;
		protected var myCheckBox:CheckBox;
		private var imageWidth:Number=9;
		private var imageHeight:Number=9;
		//private var inner:String="@Embed('../assets/inner.png')";
		[Bindable] [Embed("assets/inner.png")]
		public var ICON_INNER:Class;
		
		static private var STATE_SCHRODINGER:String="schrodinger";
		static private var STATE_CHECKED:String="checked";
		static private var STATE_UNCHECKED:String="unchecked";
		
		public function HADGCheckBoxItemRenderer()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			myCheckBox=new CheckBox();
			myCheckBox.setStyle("verticalAlign", "middle");
			myCheckBox.addEventListener(MouseEvent.CLICK, checkBoxToggleHandler);
			addElement(myCheckBox);
			//myImage = new Image();
			//myImage.source = ICON_INNER;
			//myImage.addEventListener(MouseEvent.CLICK, imageToggleHandlder);
			//myImage.setStyle("verticalAlign", "middle");
			//addElement(myImage);
		}
		
		private function imageToggleHandlder(event:MouseEvent):void
		{
			myCheckBox.selected=!myCheckBox.selected;
			checkBoxToggleHandler(event);
		}
		
		private function checkBoxToggleHandler(event:MouseEvent):void
		{
			if (data)
			{
				var adgld:AdvancedDataGridListData = listData as AdvancedDataGridListData;
				trace(adgld.dataField);
				
				var o:Object = AdvancedDataGrid(AdvancedDataGridListData(listData).owner).selectedItem;
				//o.checked = myCheckBox.selected;		
				o[adgld.dataField] = myCheckBox.selected;		
				var hcv:HierarchicalCollectionView = AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider as HierarchicalCollectionView;
				if (hcv != null)
				{
					hcv.refresh();
				}
			}
		}
		
		override public function set data(value:Object):void
		{
			if (value != null)
			{
				super.data=value;
				var adgld:AdvancedDataGridListData = listData as AdvancedDataGridListData;
				trace(adgld.dataField);
				
				//myCheckBox.selected = value.checked;
				myCheckBox.selected = value[adgld.dataField];
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			myCheckBox.x = 2;
		}
	}
}