package component
{
	import david.view.configs.Constants;
	
	import flash.display.Graphics;
	
	import spark.primitives.supportClasses.FilledElement;
	
	public class MyGrid extends FilledElement
	{
		
		private var _lineAlpha:Number = 0.4;
		private var _lineThickness:Number = 0.4;
		private var _color:uint = 0xdddddd;
		private var _my_color:uint = 0xdddddd;
//		private var _my_color:uint = 0xff0000;
		public var mylineThickness:Number = 1;
		private var _mysetep:int = 5;
//		public var e:MyGridEvent;
		
		
		public function MyGrid()
		{
			super();
		}
		
		//ช่องห่าง
		private var _step:Number=40;
		
		public function get mysetep():int
		{
			return _mysetep;
		}

		public function set mysetep(value:int):void
		{
			_mysetep = value;
			invalidateSize();
			invalidateDisplayList();
			invalidateParentSizeAndDisplayList();
		}

		public function get my_color():uint
		{
			return _my_color;
		}

		public function set my_color(value:uint):void
		{
			_my_color = value;
			invalidateSize();
			invalidateDisplayList();
			invalidateParentSizeAndDisplayList();
		}

		[Inspectable(category="General", minValue="1.0")]
		
		/**
		 *  Grid step.
		 *  
		 *  @default 20
		 */
		public function get step():Number 
		{
			return _step;
		}
		
		public function set step(value:Number):void
		{        
			if (value != _step)
			{
				_step = value > 0 ? value : 1;
				
				invalidateSize();
				invalidateDisplayList();
				invalidateParentSizeAndDisplayList();
			}
		}
		
		
		override protected function draw(g:Graphics):void
		{
			var columnCount:Number = Math.floor(width/_step);
			var rowCount:Number = Math.floor(height/_step);
			var i:int=0,j:int=0;
//			for (i= 0; i <= rowCount; i++) 
//			{
//				for (j= 0; j <= columnCount; j++) 
//				{
////					g.drawCircle(drawX + j*_step, drawY + i*_step, 0.5);
//				}
//			}
			
			for (j = 0; j <= columnCount; j++) 
			{
				if(j%mysetep==0){
//					g.lineStyle(mylineThickness,my_color,_lineAlpha);
					g.lineStyle(Constants.gridLineThickness,Constants.gridLineColor,Constants.gridLineApha);
					g.moveTo(this.x+j*_step,this.y);
					g.lineTo(this.x+j*_step,this.y+height)
				} else {
//					g.lineStyle(_lineThickness,_color,_lineAlpha);
					g.lineStyle(Constants.gridLineThickness,Constants.gridLineColor,Constants.gridLineApha);
					g.moveTo(this.x+j*_step,this.y);
					g.lineTo(this.x+j*_step,this.y+height)
				}
			}
			
			for( i = 0; i <= rowCount;  i++ ) {
				if(i%mysetep==0){
//					g.lineStyle(mylineThickness,my_color,_lineAlpha);
					g.lineStyle(Constants.gridLineThickness,Constants.gridLineColor,Constants.gridLineApha);
					g.moveTo(this.x,this.y+i*_step);
					g.lineTo(this.x+width,this.y+i*_step)
				} else {
//					g.lineStyle(_lineThickness,_color,_lineAlpha);
					g.lineStyle(Constants.gridLineThickness,Constants.gridLineColor,Constants.gridLineApha);
					g.moveTo(this.x,this.y+i*_step);
					g.lineTo(this.x+width,this.y+i*_step)
				}
				
			}
			
			
//			g.lineStyle(2,0xff0000,1);
//			g.drawRect(this.x,this.y,width,height);
			
			super.draw(g);
			
//			e = new MyGridEvent(MyGridEvent.DRAWGRID);
//			dispatchEvent(e);
		}

		public function get lineAlpha():Number
		{
			return _lineAlpha;
		}

		public function set lineAlpha(value:Number):void
		{
			_lineAlpha = value;
			invalidateSize();
			invalidateDisplayList();
			invalidateParentSizeAndDisplayList();
		}

		public function get lineThickness():Number
		{
			return _lineThickness;
		}

		public function set lineThickness(value:Number):void
		{
			_lineThickness = value;
			invalidateSize();
			invalidateDisplayList();
			invalidateParentSizeAndDisplayList();
		}

		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
			invalidateSize();
			invalidateDisplayList();
			invalidateParentSizeAndDisplayList();
		}

		
	}
}