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
		
		public  function CaModule()
		{
			if (_instance != null)
			{
				throw new Error("Singleton can only be accessed through Singleton.instance");
			}
			
			user = new Users();
			folder = new Folders();
		}
		
		public static function get getInstance():CaModule {
			return _instance;
		}
		
	}
}