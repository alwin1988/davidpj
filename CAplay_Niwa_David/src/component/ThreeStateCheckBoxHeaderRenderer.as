package component {
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.HierarchicalCollectionView;
	import mx.collections.HierarchicalData;
	import mx.collections.IViewCursor;
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
	
	public class ThreeStateCheckBoxHeaderRenderer extends MXAdvancedDataGridItemRenderer {
		protected var myCheckBox:CheckBox;
		protected var myImage:Image;
		private var imageWidth:Number = 7;
		private var imageHeight:Number = 7;
		//private var inner:String = "@Embed('../assets/inner.png')";
		
		[Bindable] [Embed(source="../assets/inner.png")]
		public var ICON_INNER:Class;
		
		private const SELECT_STATE:String="select";
		private const UNSELECT_STATE:String="unselect";
		private const UNDECIDED_STATE:String="undecided";
		
		private var STATE:String = UNSELECT_STATE;
		[Bindable] private var checkBoxClick:Boolean = false;
		[Bindable] private var imageClick:Boolean = false;
		
		//Constuctor 
		public function ThreeStateCheckBoxHeaderRenderer() {
			super();
			super.autoDrawBackground = false;
		}
		
		/**
		 * overides the function <code>createChildren</code> in the component lifecyle. This instantiates 
		 * <code>myCheckBox</code> and <code>myImage</code>. 
		 */
		override protected function createChildren():void{
			super.createChildren();
			
			myCheckBox = new CheckBox();
			myCheckBox.height = 8;
			myCheckBox.width = 8;
			myCheckBox.setStyle("horizontalCenter", "-2");
			myCheckBox.setStyle("horizontalAlign", "center");
			myCheckBox.setStyle("verticalCenter", "0");
			myCheckBox.setStyle("verticalAlign", "middle");
			myCheckBox.setStyle("chromeColor", "white");
			myCheckBox.addEventListener( MouseEvent.CLICK, checkBoxClickHandler );
			addElement(myCheckBox);
			myImage = new Image();
			myImage.source = ICON_INNER;
			myImage.addEventListener( MouseEvent.CLICK, imageClickHandler );
			myImage.visible = false;
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
			
			myImage.x = myCheckBox.x+2;
			myImage.y = myCheckBox.y+4;
			
			myImage.width = imageWidth;
			myImage.height = imageHeight;
			
			checkState();
		}
		
		/**
		 * Makes adjustments to the <code>visible</code> property of <code>myImage</code> and 
		 * <code>selected</code> of <code>myCheckBox</code> according to the state.
		 * 
		 * @private 
		 * 
		 */
		private function checkState():void{
			if ( checkBoxClick ) {
				if( !isAnyColumnSelected() ) {
					STATE = SELECT_STATE;
					myImage.visible = false;
					myCheckBox.selected = true;
					selectAll();
			
				} else {
					STATE = UNSELECT_STATE;
					myImage.visible = false;
					myCheckBox.selected = false;
					unSelectAll();
				}
			
			} else if ( imageClick ) {
				STATE = SELECT_STATE;
				myImage.visible = false;
				myCheckBox.selected = true;
				selectAll();
			
			} else {
				if ( areAllSelected() ) {
					STATE = SELECT_STATE;
					myImage.visible = false;
					myCheckBox.selected = true;
					
				} else if ( isAnyColumnSelected() ) {
					STATE = UNDECIDED_STATE;
					myImage.visible = true;
					myCheckBox.selected = false
					
				} else if( !isAnyColumnSelected() ) {
					STATE = UNSELECT_STATE;
					myImage.visible = false;
					myCheckBox.selected = false;
				}
			}
			
			checkBoxClick = false;
			imageClick = false;
		}
		
		/**
		 * Handler method for <code>MouseEvent.CLICK</code> event on <code>myImage</code>.
		 *  
		 * @param event
		 * 
		 */
		protected function imageClickHandler(event:MouseEvent):void{
			checkBoxClick = false;
			imageClick = true;
			checkState();
		}
		
		/**
		 * Handler method for <code>MouseEvent.CLICK</code> event on <code>myCheckBox</code>.
		 *  
		 * @param event
		 * 
		 */
		protected function checkBoxClickHandler(event:MouseEvent):void {
			checkBoxClick = true;
			imageClick = false;
			checkState();
		}
		
		/**
		 * Selects all the rows in the datagrid.  
		 * 
		 */
		private function selectAll():void{
			var ac:ArrayCollection = AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider as ArrayCollection;
			/*var ac:HierarchicalCollectionView = AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider as HierarchicalCollectionView;*/
			
			/*var iv:IViewCursor = ac.createCursor();
			iv.current;
			iv.
			iv.moveNext();
			iv.current;
			iv.moveNext();
			iv.current;
			iv.moveNext();
			iv.current;
			iv.moveNext();
			iv.current;
			iv.moveNext();
			iv.current;
			iv.moveNext();
			iv.current;*/
			for each (var o:Object in ac){
				o.checked = myCheckBox.selected;
			}
			AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider = ac;
		}
		
		/**
		 * Un selects all the rows in the datagrid.  
		 * 
		 */
		private function unSelectAll():void{
			var ac:ArrayCollection = AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider as ArrayCollection;
			myCheckBox.selected = false;
			for each (var o:Object in ac){
				o.checked = myCheckBox.selected;
			}
			myCheckBox.selected
			AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider = ac;
		}
		
		/**
		 * Checks if all the rows are selected in the datagrid.
		 * 
		 * @return Boolean: returns <code>true</code> if all rows are selected else returns 
		 * <code>false</code>.  
		 * 
		 */
		private function areAllSelected():Boolean{
			var ac:ArrayCollection = AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider as ArrayCollection;
			var b:Boolean=true;
			for each (var o:Object in ac){
				if(!o.checked){
					b=false;
					break;
				}
			}
			return b;
		}
		
		/**
		 * Checks to see if any one of the rows are selected.
		 *  
		 * @return Boolean: return <code>true</code> if any one the rows are selected.
		 * 
		 */
		private function isAnyColumnSelected():Boolean{
			var ac:ArrayCollection = AdvancedDataGrid(AdvancedDataGridListData(listData).owner).dataProvider as ArrayCollection;
			var b:Boolean=false;
			for each (var o:Object in ac){
				if(o.checked){
					b=true;
					break;
				}
			}
			return b;
		}
	}
}