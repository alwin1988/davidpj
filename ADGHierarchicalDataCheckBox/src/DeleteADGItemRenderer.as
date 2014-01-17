package
{
	import avmplus.getQualifiedClassName;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.HierarchicalCollectionView;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.advancedDataGridClasses.MXAdvancedDataGridItemRenderer;
	
	import spark.components.Image;
	
	public class DeleteADGItemRenderer extends MXAdvancedDataGridItemRenderer
	{
		private static const ARRAY_C:String = "mx.collections::ArrayCollection";
		private static const HIERARCHICAL_C:String = "mx.collections::HierarchicalCollectionView";
		
		protected var myImage:Image;
		[Bindable] [Embed("assets/delete.png")]
		public var ICON_BIN:Class;
		
		public function DeleteADGItemRenderer()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			myImage = new Image();
			myImage.source = ICON_BIN;
			myImage.addEventListener( MouseEvent.CLICK, img_clickHandler );
			myImage.visible = true;
			addElement(myImage);
		}

		protected function img_clickHandler(event:MouseEvent):void
		{
			var adg:AdvancedDataGrid = event.currentTarget.parent.parent.parent.parent as AdvancedDataGrid;
			trace(adg.selectedIndex);
			if (adg !=null)
			{
				var adgld:AdvancedDataGridListData = listData as AdvancedDataGridListData;
				trace(adgld.dataField);
				
				if (getQualifiedClassName(AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider) == ARRAY_C)
				{
					var ac:ArrayCollection = adg.dataProvider as ArrayCollection;
					if (ac != null)
					{
						ac.removeItemAt(adg.selectedIndex);
						ac.refresh();
					}
				}
				else if (getQualifiedClassName(AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider) == HIERARCHICAL_C)
				{
					var hcv:HierarchicalCollectionView = AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider as HierarchicalCollectionView;
					if (hcv != null)
					{
						hcv.removeChild(hcv.getParentItem(adg.selectedItem),adg.selectedItem);
						hcv.refresh();
					}
				}
			}
		}
		
		override public function set data(value:Object):void
		{
			if (value != null)
			{
				super.data=value;
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
		}
	}
}