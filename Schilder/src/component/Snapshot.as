package flexScript
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.display.Bitmap;
	import mx.controls.Image;
	import mx.core.UIComponent;
	
	public class UISnapShot extends Image
	{
		private var UITarget:UIComponent;
		
		public function UISnapShot()
		{
			super();
		}
		
		public function set target(trgt:UIComponent):void
		{UITarget = trgt;
			drawUISnapShot(UITarget);
		}
		
		private function drawUISnapShot(target:UIComponent):void
		{
			var UIBData:BitmapData = new BitmapData(target.width,target.height);
			var UIMatrix:Matrix = new Matrix();
			UIBData.draw(target, UIMatrix);
			source = new Bitmap(UIBData);
			invalidateDisplayList();
		}
	}
}