package component
{
	import mx.core.UIComponent;
	
	import spark.components.DropDownList;
	
	public class CustomDropDownList extends DropDownList
	{
		private var partArray:Array = new Array();
		
		
		private var _enableSelectedLabel:Boolean = false;
		private var _visibleSelectedLabel:Boolean = true;
		
		public function CustomDropDownList()
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

		[Bindable]
		public function get enableSelectedLabel():Boolean
		{
			return _enableSelectedLabel;
		}

		public function set enableSelectedLabel(value:Boolean):void
		{
			_enableSelectedLabel = value;
		}

		[Bindable]
		public function get visibleSelectedLabel():Boolean
		{
			return _visibleSelectedLabel;
		}

		public function set visibleSelectedLabel(value:Boolean):void
		{
			_visibleSelectedLabel = value;
		}


	}
}