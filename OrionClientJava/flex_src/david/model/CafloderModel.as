package david.model
{
	import mx.collections.ArrayCollection;

//	[Bindable] [RemoteClass(alias="com.shopsthai.david.hibernate.Cafolder")] 
	public class CafloderModel
	{
		public var idx:int;
		public var name:String;
		public var label:String;
		public var description:String;
		public var parentid:int;
		public var isBranch:String;
		public var state:String;
		public var isOpen:String;
		public var children:ArrayCollection = new ArrayCollection();
	}
}