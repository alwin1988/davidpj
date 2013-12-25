package david.pages.CA.folder
{
	import david.pages.CA.CaModule;
	import david.pages.CA.valueObjects.Cafolder;
	
	import mx.collections.CursorBookmark;
	import mx.collections.HierarchicalCollectionView;
	import mx.collections.HierarchicalCollectionViewCursor;
	import mx.collections.IHierarchicalCollectionViewCursor;
	import mx.controls.AdvancedDataGrid;
	import mx.states.OverrideBase;
	import mx.utils.ObjectUtil;
	
	public class AdgCafolder extends AdvancedDataGrid
	{
		
		
		public function AdgCafolder()
		{
			super();
		}
		
		public var dataCursor:IHierarchicalCollectionViewCursor;
		
		[Bindable] private var openItems:Object;
		
		
		override public function set dataProvider(value:Object):void
		{
			super.dataProvider = value;
			
			/* The dataProvider property has not been updated at this point, so call 
			commitProperties() so that the HierarchicalData value is available. */
			super.commitProperties();
			
			if (dataProvider is HierarchicalCollectionView)
				dataCursor = dataProvider.createCursor();
			HierarchicalCollectionViewCursor;
			
//				trace('curr depth',dataCursor.currentDepth);
//				dataCursor.moveNext();
//				trace('curr depth1',dataCursor.currentDepth);
//				dataCursor.moveNext();
//				trace('curr depth2',dataCursor.currentDepth);
//				dataCursor.moveNext();
//				trace('curr depth3',dataCursor.currentDepth);
//				trace('currobj',dataCursor.current.name);
//				trace('after last',dataCursor.afterLast);
//				trace('befor first',dataCursor.beforeFirst);
//				dataCursor.seek(CursorBookmark.CURRENT);
//				trace('currobj seek curr',dataCursor.currentDepth);
//				dataCursor.seek(CursorBookmark.FIRST);
//				trace('currobj seek first',dataCursor.currentDepth);
//				dataCursor.seek(CursorBookmark.LAST);
//				trace('currobj seek last',dataCursor.currentDepth);
		}
		
		public function setOpenNodes(numLevels:int = 1):void
		{
			dataCursor.seek(CursorBookmark.FIRST);
			
			while (!dataCursor.afterLast)
			{
//				trace('isopen',isItemOpen(dataCursor.current));
				if (dataCursor.currentDepth < numLevels) {
//					trace('currdepth',dataCursor.currentDepth);
					if((dataCursor.current as Cafolder).children.length > 0 ){
						dataProvider.openNode(dataCursor.current);
					}
				} else {
					dataProvider.closeNode(dataCursor.current);
				}
				dataCursor.moveNext();
			}
			
			dataCursor.seek(CursorBookmark.FIRST, verticalScrollPosition);
			
			// Refresh the data provider to properly display the newly opened nodes
			dataProvider.refresh();
		}
		
		public function getCurrentDepth(item:Object):int {
			return getDepth(item);
		}

		
	}
}