package components
{
	import spark.components.TextInput;
	
	public class CustomTextInput extends TextInput
	{
		[Bindable]
		public var borderColor:uint = 0x000000;
		[Bindable]
		public var borderThickness:Number = 1;
		[Bindable]
		public var borderAlpha:Number;

		private var _backgroundColor:uint = 0xFFFFFF;
		[Bindable]
		public var backgroundAlpha:Number;
		
		public function CustomTextInput()
		{
			super();
		}

		[Bindable]
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:uint):void
		{
			//var s:String = "#161616";
			//var color:uint = uint("0x" + s.substr(1));
			/*
			var value1:String = value.toString();
			
			if (value1.indexOf("#")!=-1)
			{
				_backgroundColor = uint("0x" + value1.substr(1));
			}
			else
			{
				_backgroundColor = uint(value1);
			}		
			*/
			_backgroundColor = value;
		}
	}
}