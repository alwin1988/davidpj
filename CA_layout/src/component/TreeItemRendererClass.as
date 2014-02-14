/*
 * Original source from : http://remwebdevelopment.com/dev/a31/Flex-Checkbox-TreeItemRenderer.html  
 * Modify By Cmee V.1
*/

package component {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.controls.CheckBox;
	import mx.controls.treeClasses.*;
	import mx.controls.treeClasses.TreeItemRenderer;
	import mx.utils.ObjectUtil;
	
	public class TreeItemRendererClass extends TreeItemRenderer {
		public var chk:CheckBox;
		public var itemXml:XML;
		
		public function TreeItemRendererClass(){
			super();
			mouseEnabled = false;
		}
		
		override public function set data(value:Object):void{
			if(value != null){
				super.data = value;
				this.itemXml = XML(value);
				if(this.itemXml.@checked == "1"){
					this.chk.selected = true;
				}else{
					this.chk.selected = false;
				}
			}
		}
		
		override protected function createChildren():void{
			super.createChildren();
			chk = new CheckBox();
			chk.addEventListener(MouseEvent.CLICK, handleChkClick);
			addChild(chk);
		}

		private function handleChkClick(evt:MouseEvent):void {
			var i:int=0;
			if ( this.itemXml.childIndex() == -1 ) { //Root 
				if (this.itemXml.children().length() > 0) {
					if ( this.chk.selected ) {
						this.itemXml.@checked = "1";
						for(i=0;i<this.itemXml.children().length();i++) {
							var j:int=0;
							if (this.itemXml.children()[i].children().length() > 0) {
								this.itemXml.children()[i].@checked = "1";
								for(j=0;j<this.itemXml.children()[i].children().length();j++) {
									this.itemXml.children()[i].children()[j].@checked = "1";
								}
							} else {
								this.itemXml.children()[i].@checked = "1";
							}
						}
					} else {
						this.itemXml.@checked = "0";
						for(i=0;i<this.itemXml.children().length();i++) {
							var j:int=0;
							if (this.itemXml.children()[i].children().length() > 0) {
								this.itemXml.children()[i].@checked = "0";
								for(j=0;j<this.itemXml.children()[i].children().length();j++) {
									this.itemXml.children()[i].children()[j].@checked = "0";
								}
							} else {
								this.itemXml.children()[i].@checked = "0";
							}
						}
					}
				} else {
					if ( this.chk.selected ) {
						this.itemXml.@checked = "1";
					} else {
						this.itemXml.@checked = "0";
					}
				}
				
			} else {
				if (this.itemXml.children().length() > 0) { //Mother of child
					if ( this.chk.selected ) {
						this.itemXml.@checked = "1";
						for(i=0;i<this.itemXml.children().length();i++) {
							this.itemXml.children()[i].@checked = "1";
						}
						
					} else {
						this.itemXml.@checked = "0";
						for(i=0;i<this.itemXml.children().length();i++) {
							this.itemXml.children()[i].@checked = "0";
						}
					}
				} else { //Child
					if ( this.chk.selected ) {
						this.itemXml.@checked = "1";
						this.itemXml.parent().@checked = "1";
					} else {
						this.itemXml.@checked = "0";
						this.itemXml.parent().@checked = "0";
					}
				}
			}
		}
		
		private function selectdAllChilds(checkedXML:XML):void {
			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			if(super.data){
				this.chk.visible = true;
				this.chk.x = super.icon.x + 3;
				super.icon.x = this.chk.x + 14;
				super.label.x = super.icon.x + 15;
				this.chk.y = super.label.y+9;
			}
		}
		
	}
}