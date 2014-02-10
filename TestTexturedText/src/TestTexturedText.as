package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class TestTexturedText extends Sprite
	{
		private var m_text:TextField        = null;         // the TextField that we use to write our text
		private var m_texture:BitmapData    = null;         // the texture that we're going to texture our TextField with
		private var m_textBMD:BitmapData    = null;         // the BitmapData that we use to draw our TextField
		private var m_drawPoint:Point       = new Point;    // Point used in drawing the final BitmapData
		private var m_drawRect:Rectangle    = new Rectangle;// the Rectangle we use to determine which part of the texture to take
		
		// the texture we're using
		[Embed(source="texture.jpg")]
		private var m_textureImage:Class;
		
		public function TestTexturedText() 
		{
			this._createText( "GL-Nummernschild-Eng", 50.0 );   // create our textfield
			this._getTexture();                         // get our texture
			
			// create textured text 1
			var bmd:BitmapData = this.getTexturedText( "hello world" );
			var b:Bitmap = new Bitmap( bmd );
			b.x = 250.0;
			b.y = 100.0;
			this.addChild( b );
			
			// create textured text 2
			bmd = this.getTexturedText( "testing" );
			b = new Bitmap( bmd );
			b.x = 250.0;
			b.y = 150.0;
			this.addChild( b );
		}
		
		/**
		 * Get a BitmapData of the text we want, textured
		 * @param text The text we're looking at
		 * @param randomPos Should we take a random position from our text, or just start at (0,0)?
		 * @return A BitmapData object containing our textured text
		 */
		public function getTexturedText( text:String, randomPos:Boolean = true ):BitmapData
		{
			// set the text
			this.m_text.text    = text;
			var tw:int          = int( this.m_text.width + 0.5 ); // quick conver to int without clipping
			var th:int          = int( this.m_text.height + 0.5 );
			
			// reuse our previous BitmapData if we can, rather than always creating a new one
			if ( this.m_textBMD == null || this.m_textBMD.width < tw || this.m_textBMD.height < th )
				this.m_textBMD = new BitmapData( tw, th, true, 0x00000000 );
			else
				this.m_textBMD.fillRect( this.m_textBMD.rect, 0x00000000 ); // clear the bitmapdata of the old rendering
			
			// draw our text
			this.m_textBMD.draw( this.m_text, null, null, null, null, true );
			
			// set our draw rect position
			this.m_drawRect.x       = ( randomPos ) ? Math.random() * ( this.m_texture.width - tw ) : 0.0;
			this.m_drawRect.y       = ( randomPos ) ? Math.random() * ( this.m_texture.height - tw ) : 0.0;
			this.m_drawRect.width   = tw;
			this.m_drawRect.height  = th;
			
			// get a new bitmap data (that we'll return) and copy our pixels, using the first bmd as an alpha mask
			var ret:BitmapData = new BitmapData( tw, th, true, 0x00000000 );
			ret.copyPixels( this.m_texture, this.m_drawRect, this.m_drawPoint, this.m_textBMD, this.m_drawPoint );
			return ret;
		}
		
		// creates the TextField that we'll use to write our text
		private function _createText( font:String, size:Number ):void
		{
			var tf:TextFormat               = new TextFormat( font, size );
			this.m_text                     = new TextField;
			this.m_text.defaultTextFormat   = tf;
			this.m_text.autoSize            = TextFieldAutoSize.LEFT;
			
			// debug add it to the stage
			this.m_text.x = 250.0;
			this.addChild( this.m_text );
		}
		
		// gets the texture that we'll use to create our text
		private function _getTexture():void
		{
			this.m_texture = ( ( new this.m_textureImage ) as Bitmap ).bitmapData;
			
			// debug add it to the stage
			var debug:Bitmap = new Bitmap( this.m_texture );
			debug.scaleX = debug.scaleY = 0.2;
			this.addChild( debug );
		}
	}
}