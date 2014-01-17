package components
{
	import mx.core.UIComponent;
	
	import spark.components.ComboBox;
	
	public class CustomComboBox extends ComboBox
	{

		private var partArray:Array = new Array();
		
		public function CustomComboBox()
		{
			super();
		}
		
		protected override function childrenCreated():void
		{
			//TODO Auto-generated method stub
			super.childrenCreated();
			var len:int = partArray.length;
			var comp:UIComponent;
			//reset those pesky minimum heights
			for (var i:int = 0 ; i< len; i++)
			{
				comp = UIComponent(partArray[i])
				comp.explicitMinHeight = Math.min(height,comp.minHeight);
				comp.explicitMinWidth = Math.min(width, comp.minWidth);
			}
		}
		
		protected override function partAdded(partName:String, instance:Object):void
		{
			//TODO Auto-generated method stub
			super.partAdded(partName,instance);
			partArray.push(instance);
		}		
	}
}