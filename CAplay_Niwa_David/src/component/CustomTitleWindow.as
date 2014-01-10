package component
{
	import spark.components.TitleWindow;
	
	public class CustomTitleWindow extends TitleWindow
	{
		[Bindable]
		public var headerHeight:Number;	
		
		[Embed("assets/closeWindowIcon.jpg")]
		public const closeWindowIcon:Class;
		
		public function CustomTitleWindow()
		{
			super();
		}
	}
}