package
{
	import flash.events.MouseEvent;
	
	import mx.containers.HBox;
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.controls.dataGridClasses.*;
	import mx.core.DragSource;
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	import mx.managers.DragManager;
	import mx.utils.ObjectUtil;
	
	public class DetailImageRenderer extends HBox
	{
		//private var imageReference:Image = null;
		private var img:Image = new Image();
		private var lbl:Label = new Label();
		
		public static var selected:String="";

		override public function set data(value:Object):void
		{
			if(value.detail != null)
			{
				img.source = value.icon2;
				addChild(img);
				img.addEventListener(MouseEvent.MOUSE_DOWN, doDrag);
				lbl.text = "(" + value.detail + ")";
				addChild(lbl);
				lbl.addEventListener(MouseEvent.MOUSE_DOWN, doDrag);
				img.toolTip = value.detail;
			}
			
			
		}
		
		private function doDrag(event:MouseEvent):void
		{
			var target:UIComponent = event.currentTarget as UIComponent;
			if( target.toolTip == "ButtonIR" ) {
				
				selected = "ButtonIR";
	 	
			}else if (img.toolTip == "ComboBoxIR")	{
				
				selected = "ComboBoxIR";
				
			} else if (img.toolTip == "TextInputIR") {
				
				selected = "TextInputIR";
				
			}
			
			target.move(target.mouseX,target.mouseY);
			
			var 
			dsource:DragSource = new DragSource();
			dsource.addData(target, "itemrender");
			dsource.addData(target, "ComboBox");
			
			DragManager.doDrag(target, dsource , event, target);
		}		
	
		
		
	}
}
