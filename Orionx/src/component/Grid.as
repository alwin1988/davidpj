package component
{
	import david.view.configs.Constants;
	
	import flash.display.Graphics;
	
	import spark.primitives.supportClasses.FilledElement;
	import spark.primitives.supportClasses.StrokedElement;
	
	public class Grid extends FilledElement
	{
		public function Grid()
		{
			super();
		}
		
		//ช่องห่าง
		private var _step:Number=20;
		
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
			g.lineStyle(Constants.gridLineThickness,Constants.gridLineColor,Constants.gridLineApha);
			for (var i:int = 0; i <= rowCount; i++) 
			{
				for (var j:int = 0; j <= columnCount; j++) 
				{
//					g.drawCircle(drawX + j*_step, drawY + i*_step, 0.5);
				}
			}
			
			for (j = 0; j <= columnCount; j++) 
			{
				g.moveTo(this.x+j*_step,this.y);
				g.lineTo(this.x+j*_step,this.y+height)
			}
			
			for( i = 0; i <= rowCount;  i++ ) {

				g.moveTo(this.x,this.y+i*_step);
				g.lineTo(this.x+width,this.y+i*_step)
				
			}
			
			
			
			g.lineStyle(0.4,Constants.colDivColor,Constants.colDivAlpha);
			g.drawRect(this.x,this.y,width,height);
			
		}
	}
}