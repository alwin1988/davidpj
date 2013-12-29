package component
{
	
	/*
	* @Developer : Sutthikit Phunthanasap (Praem)
	* 
	* @Designer, Project manager, Business Analyst :  David Merit
	*
	* @Reference : http://www.adobe.com/devnet/flex/articles/itemrenderers_pt5.html
	*/	
	
	import mx.controls.AdvancedDataGrid;
	import mx.controls.Label;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.advancedDataGridClasses.MXAdvancedDataGridItemRenderer;
	import mx.core.UIComponent;
	import mx.utils.ColorUtil;
	
	public class CustomProgressItemRenderer extends MXAdvancedDataGridItemRenderer
	{

		private var uic:UIComponent;
		private var lb:Label;
		
		// Range between 0 - 100, if more than 100 set to 100
		private var _progressBarPercent:Number = 0;
		private var _progressBarColor:Number = 0x33FF00;
		private var _rowPadding:Number = 4;
		private var _labelFontColor:Number;
		
		//need to set value to progressBarPercent property
		override public function set data(value:Object):void
		{	
			super.data = value;	
			//progressBarPercent = value.progressBarPercent;
			//progressBarColor = value.progressBarColor;
			
			//after execute invalidateProperties() call commitProperties()
			invalidateProperties();
		}
		
		public function CustomProgressItemRenderer()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			uic = new UIComponent();
			this.addElement(uic);
			
			lb = new Label();
			lb.text = progressBarPercent.toString() + "%";
			this.addElement(lb);			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			uic.move(0,0); 
			uic.setActualSize(unscaledWidth,unscaledHeight); 
			lb.move(0,0); 
			lb.setActualSize(unscaledWidth, unscaledHeight); 
		}	
		
		//update position, label text
		override protected function commitProperties():void 
		{ 
			super.commitProperties();
			
			uic.graphics.clear();
			
			//get dataField that use with ItemRenderer
			var adgld:AdvancedDataGridListData = listData as AdvancedDataGridListData;
			progressBarPercent = data[adgld.dataField];
			
			//get column width
			var index:int = listData.columnIndex;
			var adg:AdvancedDataGrid =listData.owner as AdvancedDataGrid;
			var adgc:AdvancedDataGridColumn = adg.columns[index] as AdvancedDataGridColumn;
			
			trace("before round : ",adgc.width*progressBarPercent/100);
			trace("after round : ",Math.round(adgc.width*progressBarPercent/100));
			trace("percent : ",progressBarPercent.toString() + "%");
			//trace(adgc.width*progressBarPercent/100);
			
			uic.graphics.beginFill(progressBarColor);
			//hide border line
			//uic.graphics.lineStyle(1,0x000000);
			uic.graphics.drawRect(0,0,Math.round(adgc.width*progressBarPercent/100), adg.rowHeight - rowPadding);
			
			lb.text = progressBarPercent.toString() + "%";
		}		

		[Bindable]
		public function get progressBarPercent():Number
		{
			return _progressBarPercent;
		}

		public function set progressBarPercent(value:Number):void
		{
			if (value <= 100)
				_progressBarPercent = value;
			else
				_progressBarPercent = 100;
		}

		[Bindable]
		public function get progressBarColor():Number
		{
			return _progressBarColor;
		}

		public function set progressBarColor(value:Number):void
		{
			_progressBarColor = value;
		}

		[Bindable]
		public function get rowPadding():Number
		{
			return _rowPadding;
		}

		public function set rowPadding(value:Number):void
		{
			_rowPadding = value;
		}

		[Bindable]
		public function get labelFontColor():Number
		{
			return _labelFontColor;
		}

		public function set labelFontColor(value:Number):void
		{
			_labelFontColor = value;
		}

	}
}