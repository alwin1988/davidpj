package components
{
	import spark.components.TitleWindow;
	
	public class CustomTitleWindow extends TitleWindow
	{
		[Bindable]
		public var headerHeight:Number;	
		[Embed("assets/closeWindowIcon.jpg")]
		public const closeWindowIcon:Class;
		[Bindable]
		public var showCloseButton:Boolean = true;
		
		public function CustomTitleWindow()
		{
			super();
		}
	}
}