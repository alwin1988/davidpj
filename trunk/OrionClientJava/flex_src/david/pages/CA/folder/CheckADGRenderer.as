package david.pages.CA.folder
{
	import flash.events.MouseEvent;
	import flash.xml.*;
	
	import mx.collections.*;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.Alert;
	import mx.controls.CheckBox;
	import mx.controls.Image;
	import mx.controls.VRule;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridGroupItemRenderer;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.listClasses.*;
	import mx.core.mx_internal;
	import mx.states.AddChild;
	import mx.utils.ObjectUtil;

	use namespace mx_internal; 
	

	public class CheckADGRenderer extends AdvancedDataGridGroupItemRenderer
	{
		
		
		[Embed(source="assets/iconinfo.png")]
		[Bindable]public var iconinfo:Class;

		[Embed(source="assets/inner.png")]
		[Bindable]public var inner:Class;
		
        protected var myImage:Image;
        protected var myinfoImg:Image;
		protected var vr:VRule;
        // set image properties
        private var imageWidth:Number 	= 6;
	    private var imageHeight:Number 	= 6;
//        private var inner:String 	= "inner.png";
//		private var iconinfo:String = "iconinfo.png";
		protected var myCheckBox:CheckBox;
		static private var STATE_SCHRODINGER:String = "schrodinger";
		static private var STATE_CHECKED:String = "checked";
		static private var STATE_UNCHECKED:String = "unchecked";
	    
        public function CheckADGRenderer () 
		{
			super();
			mouseEnabled = false;
		}
		private function toggleParents (item:Object, adg:AdvancedDataGrid, state:String):void
		{
			if (item == null)
			{
				return;
			}
			else
			{
				item.state = state;
				toggleParents(adg.getParentItem(item), adg, getState (adg, adg.getParentItem(item)));
			}
		}
		
		private function toggleChildren (item:Object, adg:AdvancedDataGrid, state:String):void
		{
			if (item == null)
			{
				return;
			}
			else
			{
				item.state = state;
				var adgCollection:IHierarchicalCollectionView = adg.dataProvider as IHierarchicalCollectionView;
				var adgHD:IHierarchicalData = adgCollection.source; 
				if (adgHD.hasChildren(item))
				{
					var children:ICollectionView = adgCollection.getChildren (item);
					var cursor:IViewCursor = children.createCursor();
					while (!cursor.afterLast)
					{
						toggleChildren(cursor.current, adg, state);
						cursor.moveNext();
					}
				}
			}
		}
		
		private function getState(adg:AdvancedDataGrid, parent:Object):String
		{
			var noChecks:int = 0;
			var noCats:int = 0;
			var noUnChecks:int = 0;
			if (parent != null)
			{
				var adgCollection:IHierarchicalCollectionView = adg.dataProvider as IHierarchicalCollectionView;
				var cursor:IViewCursor = adgCollection.getChildren(parent).createCursor();
				while (!cursor.afterLast)
				{
					if (cursor.current.state == STATE_CHECKED)
					{
						noChecks++;
					}
					else if (cursor.current.state == STATE_UNCHECKED)
					{
						noUnChecks++
					}
					else
					{
						noCats++;
					}
					cursor.moveNext();
				}
			}
			if ((noChecks > 0 && noUnChecks > 0) || (noCats > 0))
			{
				return STATE_SCHRODINGER;
			}
			else if (noChecks > 0)
			{
				return STATE_CHECKED;
			}
			else
			{
				return STATE_UNCHECKED;
			}
		}
		private function imageToggleHandler(event:MouseEvent):void
		{
			myCheckBox.selected = !myCheckBox.selected;
			checkBoxToggleHandler(event);
		}
		private function checkBoxToggleHandler(event:MouseEvent):void
		{
			if (data)
			{
				var myListData:AdvancedDataGridListData = AdvancedDataGridListData(this.listData);
				var selectedNode:Object = myListData.item;
				var adg:AdvancedDataGrid = AdvancedDataGrid(myListData.owner);
				var toggle:Boolean = myCheckBox.selected;
				if (toggle)
				{
//					toggleChildren(data, adg, STATE_CHECKED);
				}
				else
				{
//					toggleChildren(data, adg, STATE_UNCHECKED);
				}
				var parent:Object = adg.getParentItem (data);
//				toggleParents (parent, adg, getState (adg, parent));
			}
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			myCheckBox = new CheckBox();
			myCheckBox.setStyle( "verticalAlign", "middle" );
			myCheckBox.addEventListener( MouseEvent.CLICK, checkBoxToggleHandler );
			addChild(myCheckBox);
			myImage = new Image();
	    	myImage.source = inner;
			myImage.addEventListener( MouseEvent.CLICK, imageToggleHandler );
			myImage.setStyle( "verticalAlign", "middle" );
			addChild(myImage);
			myinfoImg = new Image();
			myinfoImg.source = iconinfo;
			myinfoImg.addEventListener(MouseEvent.CLICK,function():void {Alert.show('Info Click');});
			addChild(myinfoImg);
			vr = new VRule();
			addChild(vr);
	    }	

		private function setCheckState (checkBox:CheckBox, value:Object, state:String):void
		{
			if (state == STATE_CHECKED)
			{
				checkBox.selected = true;
			}
			else if (state == STATE_UNCHECKED)
			{
				checkBox.selected = false;
			}
			else if (state == STATE_SCHRODINGER)
			{
				checkBox.selected = false;
			}
		}	    
		override public function set data(value:Object):void
		{
			super.data = value;
			if(value != null ){
//				setCheckState (myCheckBox, value, value.state);
				setCheckState (myCheckBox, super.data, super.data.state);
				if(value.children && value.children.length > 0 ){
					value.isBranch = 'true';
				}
				if(AdvancedDataGridListData(this.listData).item.isBranch == 'false')
				{      
					var myListData:AdvancedDataGridListData = AdvancedDataGridListData(this.listData);
//					myListData.icon = icn;
				} else {
					if (this.parent != null)
					{
						var _adg:AdvancedDataGrid = AdvancedDataGrid(this.owner);
					}
				}
			}

			
//			if(value){
//				trace('value.state',value.state);
//				setCheckState (myCheckBox, value, value.state);
//			}
//			if(AdvancedDataGridListData(super.listData).item.@type == 'dimension')
//			{
//			    setStyle("fontStyle", 'italic');
//			}
//			else
//			{
//				if (this.parent != null)
//				{
//					var _adg:AdvancedDataGrid = AdvancedDataGrid(this.owner);
//		    		_adg.setStyle("defaultLeafIcon", null);
//		  		}
//				setStyle("fontStyle", 'normal');
//			}
	    }
	    
	   override protected function commitProperties():void
	   {
	   	   super.commitProperties();
		   if(listData) {
			   
           var dg:AdvancedDataGrid = AdvancedDataGrid(listData.owner);

           var column:AdvancedDataGridColumn =
               dg.columns[listData.columnIndex];

           label.wordWrap = dg.columnWordWrap(column);
		   }
	   }
	   
	    /**
	     *  @private
	     */
	    override protected function measure():void
	    {
	        super.measure();
	
	        var w:Number = data ? AdvancedDataGridListData(listData).indent :0;
	
	        if (disclosureIcon)
	            w += disclosureIcon.width;
	
	        if (icon)
	            w += icon.measuredWidth;

	        if (myCheckBox)
	            w += myCheckBox.measuredWidth;
	
	        // guarantee that label width isn't zero because it messes up ability to measure
	        if (label.width < 4 || label.height < 4)
	        {
	            label.width = 4;
	            label.height = 16;
	        }
	
	        if (isNaN(explicitWidth))
	        {
	            w += label.getExplicitOrMeasuredWidth();    
	            measuredWidth = w;
	        }
	        else
	        {
	            label.width = Math.max(explicitWidth - w, 4);
	        }
	        
	        measuredHeight = label.getExplicitOrMeasuredHeight();
	        if (icon && icon.measuredHeight > measuredHeight)
	            measuredHeight = icon.measuredHeight;
	        if (myCheckBox && myCheckBox.measuredHeight > measuredHeight)
	            measuredHeight = myCheckBox.measuredHeight;
	    }
	   

	   override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
	   {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
	        if(super.data)
	        {
			    if (super.icon != null)
			    {
//					super.disclosureIcon.x = 40;
				    myCheckBox.y = (unscaledHeight - myCheckBox.height) / 2;
				    super.icon.x = super.icon.x + 20+17;
				    if (icon.x + icon.width > unscaledWidth)
				    	icon.setActualSize(0, unscaledHeight);
					super.disclosureIcon.x = super.icon.x - 15;
				    super.label.x = super.icon.x + super.icon.width + 3;
				    super.label.setActualSize(Math.max(unscaledWidth - super.label.x, 4), unscaledHeight);
				}
				else
			    {
					super.disclosureIcon.x =  super.disclosureIcon.x + super.disclosureIcon.width + 17;
				    myCheckBox.x = super.label.x;
				    myCheckBox.y = (unscaledHeight - myCheckBox.height) / 2;
				    super.label.x = myCheckBox.x + 5;
				    super.label.setActualSize(Math.max(unscaledWidth - super.label.x, 4), unscaledHeight);
				}
				
				if (myCheckBox.x + myCheckBox.width > unscaledWidth)
					myCheckBox.visible = false;
				
			    if (data.state == STATE_SCHRODINGER)
			    {
			    	myImage.x = 4;
			    	myImage.y = myCheckBox.y + -2;
					myImage.width = imageWidth;
					myImage.height = imageHeight;
			    }
			    else
			    {
			    	myImage.x = 0;
			    	myImage.y = 0;
					myImage.width = 0;
					myImage.height = 0;
			    }
					myCheckBox.x = 0;
					myinfoImg.x = 19;
					myinfoImg.y =  (unscaledHeight - myinfoImg.height) / 2;
					myinfoImg.width = 16;
					myinfoImg.height =16;
					
					vr.y = 0;
					vr.width = 1;
					vr.height = unscaledHeight;
					vr.x = 16;

			}
	    }
	}
}