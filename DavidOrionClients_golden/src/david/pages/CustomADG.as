package david.pages
{
	
	import mx.collections.CursorBookmark;
	import mx.collections.HierarchicalCollectionView;
	import mx.collections.HierarchicalCollectionViewCursor;
	import mx.collections.IHierarchicalCollectionViewCursor;
	import mx.controls.AdvancedDataGrid;
	
	public class CustomADG extends AdvancedDataGrid
	{
		
		public function CustomADG()
		{
			super();
		}
		
		public var dataCursor:IHierarchicalCollectionViewCursor;
		
		[Bindable] private var openItems:Object;
		
		override public function set dataProvider(value:Object):void
		{
			super.dataProvider = value;
//			super.commitProperties();
			if (dataProvider is HierarchicalCollectionView) {
				dataCursor = dataProvider.createCursor();
			}
			
//			HierarchicalCollectionViewCursor;
		}
		
		public function setOpenNodes(numLevels:int = 1):void
		{
			dataCursor.seek(CursorBookmark.FIRST);
			
			while (!dataCursor.afterLast)
			{
				if (dataCursor.currentDepth < numLevels) {
					if(dataCursor.current.children.length > 0 ){
						dataProvider.openNode(dataCursor.current);
					}
				} else {
					dataProvider.closeNode(dataCursor.current);
				}
				dataCursor.moveNext();
			}
			
			dataCursor.seek(CursorBookmark.FIRST, verticalScrollPosition);
			dataProvider.refresh();
		}
		
		public function getCurrentDepth(item:Object):int {
			return getDepth(item);
		}

		
	}
}