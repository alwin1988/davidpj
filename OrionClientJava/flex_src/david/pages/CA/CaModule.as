package david.pages.CA
{
	import david.pages.CA.folder.Folders;
	import david.pages.CA.user.Users;

	
	public class CaModule
	{
		private static var _instance:CaModule = new CaModule();
		
		[Bindable] public var user:Users;
		[Bindable] public var folder:Folders;
		[Bindable] public var level1:Boolean = false;	
		[Bindable] public var lv1OpenClose:Boolean = false;
		[Bindable] public var level2:Boolean = false;	
		[Bindable] public var lv2OpenClose:Boolean = false;
		[Bindable] public var level3:Boolean = false;	
		[Bindable] public var lv3OpenClose:Boolean = false;
		[Bindable] public var level4:Boolean = false;	
		[Bindable] public var lv4OpenClose:Boolean = false;
 
		[Bindable] public var headChk:Boolean = false;
		
	    private var _currentDept:int = -1;
		
		public  function CaModule()
		{
			if (_instance != null)
			{
				throw new Error("Singleton can only be accessed through Singleton.instance");
			}
			
			user = new Users();
			folder = new Folders();
		}
		
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
				}
			} else if(value == 1  ){
				if(!chk){
					lv1OpenClose = false;
					lv2OpenClose = false;
					lv3OpenClose = false;
					lv4OpenClose = false;
				}
			} 			
		}

		
		public function setCurrDeptOpen(value:int,chk:Boolean):void {
			_currentDept = value;
			
			if(value == 4 && chk ){
				lv3OpenClose = true;				
			}
			
			
			if(value == 3 && chk ){
				lv3OpenClose = true;				
			}
			
			
			if(value == 2 && chk ){
				lv2OpenClose = true;				
			}

			if(value == 1 && chk ){
				lv1OpenClose = true;				
			}
			
			
		}
		
		public static function get getInstance():CaModule {
			return _instance;
		}
		
	}
}