package itemRenderer
{
	import components.WmTitleWindows;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.advancedDataGridClasses.MXAdvancedDataGridItemRenderer;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.Image;
	
	public class InfoButtonItemRenderer extends MXAdvancedDataGridItemRenderer
	{
		protected var myImage:Image;
		[Bindable] [Embed("assets/iconinfo.png")]
		public var ICON_INFO:Class;
		private var ttw:WmTitleWindows;
		
		public function InfoButtonItemRenderer()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			myImage = new Image();
			myImage.source = ICON_INFO;
			myImage.addEventListener( MouseEvent.CLICK, img_clickHandler );
			myImage.visible = true;
			addElement(myImage);
		}
		
		protected function img_clickHandler(event:MouseEvent):void
		{
			ttw = new WmTitleWindows();
			ttw.addEventListener(CloseEvent.CLOSE,closePopup);
			ttw.ld = data;
			PopUpManager.addPopUp(ttw,DisplayObject(FlexGlobals.topLevelApplication),true);
			PopUpManager.centerPopUp(ttw);
			//ttw.setData();
		}

		protected function closePopup(event:Event):void
		{
			PopUpManager.removePopUp(ttw);										
		}
		
		override public function set data(value:Object):void
		{
			if (value != null)
			{
				super.data=value;
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
		}
	}
}