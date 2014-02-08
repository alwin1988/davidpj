package headerRenderer
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.advancedDataGridClasses.MXAdvancedDataGridItemRenderer;
	
	import spark.components.ToggleButton;
	
	public class DispositionToggleButtonHeaderRenderer extends MXAdvancedDataGridItemRenderer
	{
		protected var toggleBtn:ToggleButton;
		public var type:String = "1";
		public var myWidth:Number =8;
		public var myHeight:Number =14;
		public function DispositionToggleButtonHeaderRenderer()
		{
			super();
			//prevent to draw black color background
			super.autoDrawBackground = false;
		}
	
		override public function set data(value:Object):void
		{
			if (value != null)
			{
				super.data=value;
			}
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			toggleBtn = new ToggleButton();
			toggleBtn.width = myWidth;
			toggleBtn.height = myHeight;
			//toggleBtn.setStyle('chromeColor',"green");
			toggleBtn.setStyle("horizontalCenter", "0");
			toggleBtn.setStyle("horizontalAlign", "center");
			toggleBtn.setStyle("verticalCenter", "0");
			toggleBtn.setStyle("verticalAlign", "middle");
			toggleBtn.addEventListener(Event.CHANGE, toggleBtnChangeHandler);
			//toggleBtn
			addElement(toggleBtn);
		}
		
		private function toggleBtnChangeHandler(event:MouseEvent):void
		{
			if (type == "1"){
				if (!toggleBtn.selected){
					//red
					toggleBtn.setStyle('chromeColor',"green");
				}else{
					//green
					toggleBtn.setStyle('chromeColor',"red");
				}
			} else if (type == "2"){
				if (!toggleBtn.selected){
					//yellow
					toggleBtn.setStyle('chromeColor',"yellow");
				}else{
					toggleBtn.setStyle('chromeColor',"orange");
				}				
			} else if (type == "3"){
				if (!toggleBtn.selected){
					toggleBtn.setStyle('chromeColor',"orange");
				}else{
					toggleBtn.setStyle('chromeColor',"purple");
				}				
			} else if (type == "4"){
				if (!toggleBtn.selected){
					toggleBtn.setStyle('chromeColor',"purple");
				}else{
					toggleBtn.setStyle('chromeColor',"green");
				}				
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			//var adgld:AdvancedDataGridListData = listData as AdvancedDataGridListData;
			//trace(AdvancedDataGrid(listData.owner).getStyle("verticalAlign"));
			//trace(adgld.dataField);
			//myImage.verticalAlign = AdvancedDataGrid(listData.owner).getStyle("verticalAlign");
			//myImage.x = 2;
			//myImage.y = 10;
		}
	}
}