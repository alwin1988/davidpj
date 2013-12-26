package david.pages
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class WmModel
	{
		public var		EntityType:String;
		public var		Priority:String;
		public var 		ID:String; 
		public var		Type:String; 
		public var		Pages:String; 
		public var		Docs:String; 
		public var		Source:String; 
		public var		Filename:String; 
		public var		Status:String; 
		public var		Started:String; 
		public var		Completed:String; 
		public var		Estimate:String; 
		public var		Deadline:String; 
		public var		checked:String; 
		public var		children:ArrayCollection = new ArrayCollection(); 
	}
}