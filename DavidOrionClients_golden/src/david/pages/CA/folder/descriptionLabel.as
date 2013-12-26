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
		
		
		private function chkChange():Boolean {
			if(data.isChange  && data.name == data.description ){
				return true;
			} else {
				return false;
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			setStyle("color", (chkChange()) ? REG_COLOR : BLACK_COLOR);
		}
	}
}