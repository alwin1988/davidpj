package utility
{
	import flash.display.Sprite;
	
	import mx.containers.Canvas;
	import mx.controls.Text;
	
	import spark.components.BorderContainer;
	import spark.components.Image;
	
	public class TexturedText extends Sprite
	{
		public function TexturedText()
		{
			super();
		}
		
		public function getTextMaskText(imgTxt:Image, txt:String="",fontSize:int=0, fontWeight:String="", fontFamily:String=""):BorderContainer
		{
			var bdc:BorderContainer = new BorderContainer();
			bdc.setStyle("borderVisible",false);
			bdc.setStyle("backgroundAlpha",0);
			bdc.horizontalCenter = 0;
			bdc.verticalCenter = 0;
			bdc.setStyle('horizontalAlign','center')
			bdc.setStyle('verticalAlign','middle')
			if (txt != "")
			{
				var mxTxt:Text = new Text();
				mxTxt.text = txt;
				
				if (fontSize!=0)
					mxTxt.setStyle("fontSize", fontSize);
				if (fontWeight!="")
					mxTxt.setStyle("fontWeight", fontWeight);
				if (fontFamily!="")
					mxTxt.setStyle("fontFamily", fontFamily);
				
				mxTxt.cacheAsBitmap = true;
				imgTxt.cacheAsBitmap = true;
				imgTxt.mask = mxTxt;
				bdc.addElement(imgTxt);
				bdc.addElement(mxTxt);
			} 
			return bdc;
		}
		
		public function getTextMaskImage(imgTxt:Image, imgSrc:Image):BorderContainer
		{
			var bdc:BorderContainer = new BorderContainer();
			bdc.setStyle("borderVisible",false);
			bdc.setStyle("backgroundAlpha",0);
			bdc.horizontalCenter = 0;
			bdc.verticalCenter = 0;
			bdc.setStyle('horizontalAlign','center')
			bdc.setStyle('verticalAlign','middle')

			imgTxt.cacheAsBitmap = true;
			imgTxt.setStyle('horizontalAlign','center')
			imgTxt.setStyle('verticalAlign','middle')
			imgTxt.verticalCenter = 0;
			imgTxt.horizontalCenter = 0;

			imgSrc.cacheAsBitmap = true;
			imgSrc.setStyle('horizontalAlign','center')
			imgSrc.setStyle('verticalAlign','middle')
			imgSrc.verticalCenter = 0;
			imgSrc.horizontalCenter = 0;
				
			imgTxt.mask = imgSrc;
			bdc.addElement(imgTxt);
			bdc.addElement(imgSrc);

			return bdc;
		}
	}
}