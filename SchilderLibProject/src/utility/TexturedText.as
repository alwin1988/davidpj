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
		{/*
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
			*/
			var bdc6:BorderContainer = new BorderContainer();
			bdc6.setStyle("borderColor","green");
			var txt1:Text = new Text();
			txt1.text = "A";
			txt1.setStyle("fontSize",10);
			txt1.setStyle("fontFamily", fontFamily);
			txt1.verticalCenter = 0;
			txt1.horizontalCenter = 0;
			//txt.width = 31;
			//txt.height = 58
			
			var img11:Image = imgTxt;
			//img11.source = "texture.jpg";
			img11.width = 40;
			img11.height = 58;
			img11.verticalCenter = 0;
			img11.horizontalCenter = 0;
			
			img11.cacheAsBitmap = true;
			txt1.cacheAsBitmap = true;
			img11.mask = txt1;
			
			bdc6.addElement(img11);
			bdc6.addElement(txt1);
			bdc6.width;
			bdc6.height;
			return bdc6;
			//return bdc;
		}
		
		public function getTextMaskImage(imgTxt:Image, imgSrc:Image):BorderContainer
		{
			var bdc:BorderContainer = new BorderContainer();
			bdc.setStyle("borderVisible",false);
			bdc.setStyle("backgroundAlpha",0);
			//bdc.horizontalCenter = 0;
			//bdc.verticalCenter = 0;
			//bdc.setStyle('horizontalAlign','center')
			bdc.setStyle('verticalAlign','middle')

			imgTxt.cacheAsBitmap = true;
			imgSrc.cacheAsBitmap = true;
			imgTxt.mask = imgSrc;
			bdc.addElement(imgTxt);
			bdc.addElement(imgSrc);

			return bdc;
		}
	}
}