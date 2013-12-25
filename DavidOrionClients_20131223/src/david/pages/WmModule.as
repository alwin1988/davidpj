package david.pages
{
	import mx.collections.HierarchicalCollectionView;

	[Bindable]
	public class WmModule
	{
		
		public var hcv:HierarchicalCollectionView = new HierarchicalCollectionView();
		public var level1:Boolean = true;
		public var level2:Boolean = true;
		public var level3:Boolean = true;
		public var level4:Boolean = true;
		public var lv1OpenClose:Boolean = true;
		public var lv2OpenClose:Boolean = true;
		public var lv3OpenClose:Boolean = true;
		public var lv4OpenClose:Boolean = true;
		
		
		
		
		
		
		
		
		
		
		
		
		private static var  _instance:WmModule =  new  WmModule();
		
		public function WmModule()
		{
			super();
			if (_instance != null)
			{
				throw new Error("Singleton can only be accessed through Singleton.instance");
			}
		}
		
		public static function get getInstance(): WmModule {
			return _instance;
			
		}
		
		
		
	}
}