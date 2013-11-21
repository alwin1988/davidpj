package david.pages.CA.folder
{
	import mx.controls.Label;
	
	public class descriptionLabel extends Label
	{
		private const BLACK_COLOR:uint = 0x000000; // Black
		private const REG_COLOR:uint = 0xdbcccc; // Red

		public function descriptionLabel()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			setStyle("color", (data.isChange) ? REG_COLOR : BLACK_COLOR);
		}
	}
}