package david.pages
{
	import mx.collections.HierarchicalCollectionView;

	[Bindable]
	public class WmModule
	{
		
		public var hcv:HierarchicalCollectionView = new HierarchicalCollectionView();
		public var level1:Boolean = true;
		public var level2:Boolean = false;
		public var level3:Boolean = false;
		public var level4:Boolean = false;
		public var lv1OpenClose:Boolean = false;
		public var lv2OpenClose:Boolean = false;
		public var lv3OpenClose:Boolean = false;
		public var lv4OpenClose:Boolean = false;
		
		
		
		
		
		
		
		
		
		
		
		
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
		
		private var _currentDept:int = -1;
		/**
		 * 
		 * @param value
		 * @param chk
		 * 
		 */
		public function setCurrentDeptClose(value:int,chk:Boolean):void
		{
			_currentDept = value;
			
			if(value == 4  ){
				if(!chk){
					lv4OpenClose = false;
				}
			} else if(value == 3  ){
				if(!chk){
					lv3OpenClose = false;
					lv4OpenClose = false;
				}
			} else if(value == 2  ){
				if(!chk){
					lv2OpenClose = false;
					lv3OpenClose = false;
					lv4OpenClose = false;
					level1 = true;
					level2 = true;
					level3 = false;
					level4 = false;
				}
			} else if(value == 1  ){
				if(chk){
//					level1 = true;
//					level2 = true;
//					level3 = false;
//					level4 = false;
				} else {
					lv1OpenClose = false;
					lv2OpenClose = false;
					lv3OpenClose = false;
					lv4OpenClose = false;
					level1 = true;
					level2 = false;
					level3 = false;
					level4 = false;
				}
			} 			
		}
		
		/**
		 * 
		 * @param value
		 * @param chk
		 * 
		 */		
		public function setCurrDeptOpen(value:int,chk:Boolean):void {
			_currentDept = value;
			
			if(value == 4 && chk ){
				lv3OpenClose = true;				
				level3 = chk;
			}
			
			
			if(value == 3 && chk ){
				lv3OpenClose = true;				
				level3 = chk;
				level4 = chk;
			}
			
			
			if(value == 2 && chk ){
				lv2OpenClose = true;				
				level2 = chk;
				level3 = chk;
			}
			
			if(value == 1 ){
				lv1OpenClose = true;
				level1 = true;
				level2 = chk;
				
			}
		}	
			
		
		
		
		
		
	}
}