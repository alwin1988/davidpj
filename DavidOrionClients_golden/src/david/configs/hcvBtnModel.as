package david.configs
{
	[Bindable]
	public class hcvBtnModel
	{
		
		[Bindable] [Embed(source="assets/folderopen.jpg")]
		public var FLODER_OPEN3:Class;
		
		[Bindable] [Embed(source="assets/folderclose.jpg")]
		public var FLODER_CLOSE3:Class;
		
		public var btnvisible:Boolean = true;
		public var openClose:Boolean = true;
	}
}