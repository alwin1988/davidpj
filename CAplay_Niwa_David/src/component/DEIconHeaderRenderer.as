package component {
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.Alert;
	import mx.controls.Image;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.advancedDataGridClasses.MXAdvancedDataGridItemRenderer;
	
	import spark.components.CheckBox;
	
	/**
	 * HeaderRender with a Three State Checkbox. 
	 * <p>Functionality:<br>
	 *  <li>Selecting the checkbox will select all the rows in the datagrid</li> 
	 *  <li>Unselecting the checkbox will unselect all the rows in the datagrid</li>
	 * 
	 * <p>The checkbox can be three states at any point:<br>
	 *    <li>select: This would mean that all the rows are selected</li>
	 *  <li>unselect: This would mean that none of the rows are selected</li>
	 *    <li>undecided: This would mean that one or more (but not all) of the rows are selected</li>
	 *  
	 * @author Srinivas Chekuri
	 * 
	 * @Code from : http://cookbooks.adobe.com/post_3_state_checkbox_for_header_renderer_in_datagrid-18900.html
	 * @Modify by Cmee 06-15-2013
	 */
	
	public class DEIconHeaderRenderer extends MXAdvancedDataGridItemRenderer {
		protected var myImage:Image;
		private var imageWidth:Number = 12;
		private var imageHeight:Number = 12;
		//private var inner:String = "@Embed('../assets/inner.png')";
		
		[Bindable] [Embed(source="../assets/iconinfo.png")]
		public var ICON_INNER:Class;
		
		//Constuctor 
		public function DEIconHeaderRenderer() {
			super();
			super.autoDrawBackground = false;
		}
		
		/**
		 * overides the function <code>createChildren</code> in the component lifecyle. This instantiates 
		 * <code>myCheckBox</code> and <code>myImage</code>. 
		 */
		override protected function createChildren():void{
			super.createChildren();
			myImage = new Image();
			myImage.source = ICON_INNER;
			myImage.setStyle("horizontalCenter", "0");
			myImage.setStyle("verticalCenter", "0");
			addElement(myImage);
		}
		
		/**
		 * overides the function <code>updateDisplayList</code> in the component lifecyle. This sets the
		 * display settings of <code>myCheckBox</code> and <code>myImage</code>. This also updates the state
		 * according to the selections made in the datagrid.
		 *  
		 * @param unscaledWidth
		 * @param unscaledHeight
		 * 
		 */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			myImage.width = imageWidth;
			myImage.height = imageHeight;
			myImage.x
		}

	}
}

