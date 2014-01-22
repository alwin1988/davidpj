package itemRenderer
{
	import avmplus.getQualifiedClassName;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.HierarchicalCollectionView;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.CheckBox;
	import mx.controls.Image;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.advancedDataGridClasses.MXAdvancedDataGridItemRenderer;
	
	public class CheckBoxItemRenderer extends MXAdvancedDataGridItemRenderer
	{
		private static const ARRAY_C:String = "mx.collections::ArrayCollection";
		private static const HIERARCHICAL_C:String = "mx.collections::HierarchicalCollectionView";
		
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
		
		public function CheckBoxItemRenderer()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			myCheckBox=new CheckBox();
			myCheckBox.setStyle("verticalAlign", "middle");
			myCheckBox.addEventListener(MouseEvent.CLICK, checkBoxToggleHandler);
			
			myCheckBox.setStyle("horizontalCenter", "0");
			myCheckBox.setStyle("horizontalAlign", "center");
			myCheckBox.setStyle("verticalCenter", "0");
			myCheckBox.setStyle("verticalAlign", "middle");
			myCheckBox.setStyle("chromeColor", "white");
			
			addElement(myCheckBox);
			//myImage = new Image();
			//myImage.source = ICON_INNER;
			//myImage.addEventListener(MouseEvent.CLICK, imageToggleHandlder);
			//myImage.setStyle("verticalAlign", "middle");
			//addElement(myImage);
		}

		/*private function imageToggleHandlder(event:MouseEvent):void
		{
			myCheckBox.selected=!myCheckBox.selected;
			checkBoxToggleHandler(event);
		}*/
		
		private function checkBoxToggleHandler(event:MouseEvent):void
		{
			if (data)
			{
				var o:Object = AdvancedDataGrid(AdvancedDataGridListData(listData).owner).selectedItem;	
				var adgld:AdvancedDataGridListData = listData as AdvancedDataGridListData;
				trace(adgld.dataField);
					
				//check class name
				if (getQualifiedClassName(AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider) == HIERARCHICAL_C)
				{	
					o[adgld.dataField] = myCheckBox.selected;		
					var hcv:HierarchicalCollectionView = AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider as HierarchicalCollectionView;
					if (hcv != null)
					{
						hcv.refresh();
					}
				}
				else if (getQualifiedClassName(AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider) == ARRAY_C)
				{	
					o[adgld.dataField] = myCheckBox.selected;
					ArrayCollection(AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider).setItemAt(o,AdvancedDataGrid(AdvancedDataGridListData(listData).owner).selectedIndex);					
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
				if (myCheckBox != null)
				{
					myCheckBox.selected = value[adgld.dataField];
				}
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			myCheckBox.x = 2;
		}
	}
}