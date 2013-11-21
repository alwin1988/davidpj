package component
{
	import spark.components.TitleWindow;
	
	public class CustomTitleWindow extends TitleWindow
	{
		[Bindable]
		public var headerHeight:Number;	
		public function CustomTitleWindow()
		{
			super();
		}
	}
}