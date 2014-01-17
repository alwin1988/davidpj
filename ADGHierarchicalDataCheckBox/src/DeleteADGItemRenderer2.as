package
{
	import mx.controls.advancedDataGridClasses.MXAdvancedDataGridItemRenderer;
	
	public class DeleteADGItemRenderer2 extends MXAdvancedDataGridItemRenderer
	{
		public function DeleteADGItemRenderer2()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
		}
		
		override public function set data(value:Object):void
		{
			if (value != null)
			{
				super.data=value;
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
		}
	}
}