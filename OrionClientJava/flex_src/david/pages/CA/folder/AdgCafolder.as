package david.pages.CA.folder
{
	import mx.collections.CursorBookmark;
	import mx.collections.HierarchicalCollectionView;
	import mx.collections.IHierarchicalCollectionViewCursor;
	import mx.controls.AdvancedDataGrid;
	
	public class AdgCafolder extends AdvancedDataGrid
	{
		
		
		public function AdgCafolder()
		{
			super();
		}
		
		private var dataCursor:IHierarchicalCollectionViewCursor;
		
		override public function set dataProvider(value:Object):void
		{
			super.dataProvider = value;
			
			/* The dataProvider property has not been updated at this point, so call 
			commitProperties() so that the HierarchicalData value is available. */
			super.commitProperties();
			
			if (dataProvider is HierarchicalCollectionView)
				dataCursor = dataProvider.createCursor();
		}
		
		public function setOpenNodes(numLevels:int = 1):void
		{
			dataCursor.seek(CursorBookmark.FIRST);
			
			while (!dataCursor.afterLast)
			{
				if (dataCursor.currentDepth < numLevels)
					dataProvider.openNode(dataCursor.current);
				else
					dataProvider.closeNode(dataCursor.current);
				
				dataCursor.moveNext();
			}
			
			dataCursor.seek(CursorBookmark.FIRST, verticalScrollPosition);
			
			// Refresh the data provider to properly display the newly opened nodes
			dataProvider.refresh();
		}
		
		
	}
}