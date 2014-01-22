package itemRenderer
{
	import avmplus.getQualifiedClassName;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.HierarchicalCollectionView;
	import mx.containers.Box;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.advancedDataGridClasses.MXAdvancedDataGridItemRenderer;
	
	import spark.components.ToggleButton;
	
	public class ToggleButtonItemRenderer extends MXAdvancedDataGridItemRenderer
	{
		private static const ARRAY_C:String = "mx.collections::ArrayCollection";
		private static const HIERARCHICAL_C:String = "mx.collections::HierarchicalCollectionView";
		
		protected var toggleBtn:ToggleButton;
		protected var box:Box;
		public var type:String = "1";
		public var myWidth:Number =8;
		public var myHeight:Number =14;
		
		public function ToggleButtonItemRenderer()
		{
			super();
		}
		
		override public function set data(value:Object):void
		{
			if (value != null)
			{
				super.data=value;
				setColor(data);
			}
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			toggleBtn = new ToggleButton();
			toggleBtn.width = myWidth;
			toggleBtn.height = myHeight;
			
			toggleBtn.setStyle("horizontalCenter", "0");
			toggleBtn.setStyle("horizontalAlign", "center");
			toggleBtn.setStyle("verticalCenter", "0");
			toggleBtn.setStyle("verticalAlign", "middle");
			
			toggleBtn.addEventListener(Event.CHANGE, toggleBtnChangeHandler);
			//toggleBtn
			addElement(toggleBtn);
		}
		
		private function toggleBtnChangeHandler(event:Event=null):void
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
		
		private function setColor(obj:Object):void
		{
			var adgld:AdvancedDataGridListData = listData as AdvancedDataGridListData;
			trace(adgld.dataField);
			trace(obj[adgld.dataField])
			
			if (type == "1"){
				if (String(obj[adgld.dataField]).toLowerCase() == "enabled"){
					//red
					toggleBtn.setStyle('chromeColor',"green");
				}else if (String(obj[adgld.dataField]).toLowerCase() == "disabled"){
					//red
					toggleBtn.setStyle('chromeColor',"red");
				}else{
					//green
					toggleBtn.setStyle('chromeColor',"green");
				}
			} else if (type == "2"){
				if (String(obj[adgld.dataField]).toLowerCase() == "changed"){
					//yellow
					toggleBtn.setStyle('chromeColor',"yellow");
				}else if (String(obj[adgld.dataField]).toLowerCase() == "saved"){
					//yellow
					toggleBtn.setStyle('chromeColor',"orange");
				}else{
					toggleBtn.setStyle('chromeColor',"yellow");
				}				
			} else if (type == "3"){
				if (String(obj[adgld.dataField]).toLowerCase()== "saved"){
					toggleBtn.setStyle('chromeColor',"orange");
				}else if (String(obj[adgld.dataField]).toLowerCase()== "publish"){
					toggleBtn.setStyle('chromeColor',"purple");
				}else{
					toggleBtn.setStyle('chromeColor',"orange");
				}				
			} else if (type == "4"){
				if (String(obj[adgld.dataField]).toLowerCase() == "publish"){
					toggleBtn.setStyle('chromeColor',"purple");
				}else if (String(obj[adgld.dataField]).toLowerCase() == "enabled"){
					toggleBtn.setStyle('chromeColor',"green");
				}else{
					toggleBtn.setStyle('chromeColor',"purple");
				}				
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			toggleBtnChangeHandler();
			//var adgld:AdvancedDataGridListData = listData as AdvancedDataGridListData;
			//trace(AdvancedDataGrid(listData.owner).getStyle("verticalAlign"));
			//trace(adgld.dataField);
			//myImage.verticalAlign = AdvancedDataGrid(listData.owner).getStyle("verticalAlign");
			//myImage.x = 2;
			//myImage.y = 10;
		}
	}
}