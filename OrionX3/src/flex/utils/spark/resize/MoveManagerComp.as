package flex.utils.spark.resize {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.controls.Button;
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.FlexGlobals;
	import mx.core.ILayoutElement;
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	import mx.core.UIComponent;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.utils.ObjectUtil;
	import mx.validators.IValidatorListener;
	
	import org.osmf.utils.Version;
	
	import spark.components.BorderContainer;
	import spark.components.Group;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.TileLayout;
	import spark.layouts.VerticalLayout;
	import spark.layouts.supportClasses.LayoutBase;
	
	import th.co.shopsthai.ascomponent.rzmvasBroderContainer;
	import th.co.shopsthai.resize.rzmvasBroderContainerSkin;

	/**
	 * Similar to the ResizeManager, this class adds support for moving a component by dragging it
	 * with the mouse. It also supports showing a custom cursor while dragging.
	 *
	 * @author Chris Callendar
	 * @date March 17th, 2009
	 */
	public class MoveManagerComp {

		public static const DRAG_START:String = "dragStart";

		public static const DRAGGING:String = "dragging";

		public static const DRAG_END:String = "dragEnd";

		// the component that is being moved
		private var moveComponent:UIComponent;
        private var ownerComponent:UIComponent;
		// the component that when dragged causes the above component to move
		private var dragComponent:UIComponent;

		private var dragging:Boolean;

		private var _enabled:Boolean;

		private var _bringToFrontOnMove:Boolean;

		private var _constrainToParentBounds:Boolean;

		private var _constrainToBounds:Rectangle;

		[Embed(source="/assets/cursor_move.gif")]
		public var moveIcon:Class;

		private var moveCursorID:int;

		public function MoveManagerComp(moveComponent:UIComponent = null, dragComponent:UIComponent = null) {
			dragging = false;
			_enabled = true;
			_bringToFrontOnMove = false;
			_constrainToParentBounds = false;
			_constrainToBounds = null;
			moveCursorID = 0;
			addMoveSupport(moveComponent, dragComponent);
		}

		public function get enabled():Boolean {
			return _enabled;
		}

		public function set enabled(en:Boolean):void {
			if (en != _enabled) {
				_enabled = en;
			}
		}

		public function get bringToFrontOnMove():Boolean {
			return _bringToFrontOnMove;
		}

		public function set bringToFrontOnMove(value:Boolean):void {
			_bringToFrontOnMove = value;
		}

		/**
		 * Returns true if the component's movement is constrained to within
		 * the parent's bounds.
		 */
		public function get constrainToParentBounds():Boolean {
			return _constrainToParentBounds;
		}

		/**
		 * Set to true if the component's movement is to be constrained to within
		 * the parent's bounds.
		 */
		public function set constrainToParentBounds(value:Boolean):void {
			_constrainToParentBounds = value;
		}

		/**
		 * Returns the bounds used to constrain the component's movement.
		 */
		public function get constrainToBounds():Rectangle {
			return _constrainToBounds;
		}

		/**
		 * Sets the bounds used to constrain the component's movement.
		 */
		public function set constrainToBounds(value:Rectangle):void {
			_constrainToBounds = value;
		}

		/**
		 * Adds support for moving a component.
		 * @param moveComponent the component that will have its x and y values changed
		 * @param dragComponent the component that will have a mouse_down listener added to listen
		 *  for when the user drags it.  If null then the moveComponent is used instead.
		 */
		public function addMoveSupport(moveComponent:UIComponent, dragComponent:UIComponent = null):void {
			this.moveComponent = moveComponent;
			this.dragComponent = dragComponent;
			if (dragComponent) {
				dragComponent.addEventListener(MouseEvent.MOUSE_DOWN, dragComponentMouseDown);
			} else if (moveComponent) {
				moveComponent.addEventListener(MouseEvent.MOUSE_DOWN, dragComponentMouseDown);
			}
		}

		/**
		 * Removes move support, removes the mouse listener and the move handle.
		 */
		public function removeMoveSupport():void {
			if (dragComponent) {
				dragComponent.removeEventListener(MouseEvent.MOUSE_DOWN, dragComponentMouseDown);
			} else if (moveComponent) {
				moveComponent.removeEventListener(MouseEvent.MOUSE_DOWN, dragComponentMouseDown);
			}
		}

		/**
		 * This function gets called when the user presses down the mouse button on the
		 * dragComponent (or if not specified then the moveComponent).
		 * It starts the drag process.
		 */
		private function dragComponentMouseDown(event:MouseEvent):void {
			if (!enabled) {
				return;
			}

			// Constain the movement by the parent's bounds?
			var bounds:Rectangle = null;
//			if (constrainToBounds != null) {
//				bounds = constrainToBounds;
//			} else if (constrainToParentBounds && moveComponent.parent.owner.owner) {
//				bounds = new Rectangle(0, 0, moveComponent.parent.owner.owner.width, moveComponent.parent.owner.owner.height);
//				// need to reduce the size by the component's width/height
//				bounds.width = Math.max(0, bounds.width - moveComponent.width);
//				bounds.height = Math.max(0, bounds.height - moveComponent.height);
//			}
			
			moveComponent.startDrag(false, bounds);
			setMoveCursor();
			PopUpManager.bringToFront(moveComponent);
			moveComponent.systemManager.addEventListener(MouseEvent.MOUSE_MOVE, dragComponentMove);
			moveComponent.systemManager.addEventListener(MouseEvent.MOUSE_UP, dragComponentMouseUp);
			moveComponent.systemManager.stage.addEventListener(Event.MOUSE_LEAVE, dragComponentMouseUp);
		}

		private function dragComponentMove(event:MouseEvent):void {
			if (!dragging) {
				dragging = true;
				moveComponent.clearStyle("top");
				moveComponent.clearStyle("right");
				moveComponent.clearStyle("bottom");
				moveComponent.clearStyle("left");
				moveComponent.dispatchEvent(new Event(DRAG_START));
				//----------------
				// move above all others bug ถ้าทำเลยจะใช้ไม่ได้กับ vgroup ตำหน่องเปลี่ยนไป
				if (bringToFrontOnMove && moveComponent.parent) {  //brind MoveComponent 
					var index:int = moveComponent.parent.getChildIndex(moveComponent);
					var last:int = moveComponent.parent.numChildren - 1;
					if (index != last) {
						if(moveComponent.parent is Group){
							IVisualElementContainer(moveComponent.parent).setElementIndex(moveComponent,IVisualElementContainer(moveComponent.parent).numElements-1);
						} else {
							//event.target.parent.addChild(event.target);
							moveComponent.parent.setChildIndex(moveComponent, last);
						}
					}
				}
				//Brind Containner
					trace('owner',flash.utils.getQualifiedClassName(moveComponent.owner));
					trace('parent',flash.utils.getQualifiedClassName(moveComponent.parent));
					var uic:UIComponent = UIComponent(moveComponent.owner).owner  as UIComponent;
					trace( uic.id,UIComponent(moveComponent.owner).id);
					for(var i:int=0;i<FlexGlobals.topLevelApplication.acContainer.length;i++) {
						trace('move com',flash.utils.getQualifiedClassName(moveComponent.parent));
						trace('ac container', flash.utils.getQualifiedClassName(FlexGlobals.topLevelApplication.acContainer[i]));
						if(flash.utils.getQualifiedClassName(moveComponent.owner) == flash.utils.getQualifiedClassName(FlexGlobals.topLevelApplication.acContainer[i])){
							IVisualElementContainer(uic).setElementIndex(moveComponent.owner as IVisualElement,IVisualElementContainer(uic).numElements-1);
							break;
						}
						
					}
				//----------------------------

			}
			moveComponent.dispatchEvent(new Event(DRAGGING));
			trace('x:y',event.stageX,event.stageY);
		}

		private function dragComponentMouseUp(event:MouseEvent):void {
			moveComponent.stopDrag();
			removeMoveCursor();
			if (dragging) {
				dragging = false;
				moveComponent.dispatchEvent(new Event(DRAG_END));
					var arr:Array = FlexGlobals.topLevelApplication.getObjectsUnderPoint(new Point( event.stageX,event.stageY));
					for(var i:int=0;i<arr.length;i++){
						if(arr[i] is th.co.shopsthai.resize.rzmvasBroderContainerSkin){
							var rzskin:rzmvasBroderContainerSkin = arr[i] as rzmvasBroderContainerSkin;
							FlexGlobals.topLevelApplication.ta.text += 'id=' + rzskin.hostComponent.id + "\n";
	//						trace('owner=',UIComponent(moveComponent.owner).id + ": hostcomponet id"+arr[i].hostComponent.id);
							for(var j:int=0;j<FlexGlobals.topLevelApplication.acContainer.length;j++){
								
								if( UIComponent(moveComponent.owner).id != arr[i].hostComponent.id && UIComponent(moveComponent.owner).id == FlexGlobals.topLevelApplication.acContainer[j].id ) {
									IVisualElementContainer(arr[i].hostComponent).addElement(moveComponent);
									break;
								} else {
									
									setlayout(arr[i].hostComponent,new Point(event.stageX,event.stageY),moveComponent.id);									
									
								}
							}
						
						}						
					}
			}		
			moveComponent.systemManager.removeEventListener(MouseEvent.MOUSE_MOVE, dragComponentMove);
			moveComponent.systemManager.removeEventListener(MouseEvent.MOUSE_UP, dragComponentMouseUp);
			moveComponent.systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, dragComponentMouseUp);
			trace(moveComponent.systemManager.stage);
		}
		
		
		private function moveToNewContainer(obj:DisplayObject, newParent:DisplayObjectContainer):void {
			var pos:Point = new Point(obj.x, obj.y);
			var currentParent:DisplayObjectContainer = obj.parent;
			pos = currentParent.localToGlobal(pos);
			currentParent.removeChild(obj);
			newParent.addChild(obj);
			pos = newParent.globalToLocal(pos);
			obj.x = pos.x;
			obj.y = pos.y;
		}
		
		private function setlayout(ivh:IVisualElementContainer,p:Point,id:String = null):void {

			var rzmv:rzmvasBroderContainer = ivh as rzmvasBroderContainer;
			if(rzmv.numElements > 1 && rzmv.layout is VerticalLayout ){
				trace('vertical layout');
				var localPoint:Point = rzmv.globalToLocal(p);
				trace('local point',localPoint.x,localPoint.y);
				var i:int=0;
				var arr:Array = new Array();
				var o:Object;
				for(i=0;i<rzmv.numElements;i++ ){
					o = new Object();
					trace('element at ',i,rzmv.getElementAt(i).x,rzmv.getElementAt(i).y);
					o.idx = i;
					o.x = rzmv.getElementAt(i).x;
					o.y = rzmv.getElementAt(i).y;
					o.id = Object(rzmv.getElementAt(i)).id;
					arr.push(o);
				}
				
				arr.sortOn(['y'],Array.NUMERIC);
				trace('arr',ObjectUtil.toString(arr));
				
				var n:uint = 0;
				for each (var item:Object in arr) 
				{
					if(item.id == id ){
						trace(n,item.id);
						rzmv.setElementIndex(rzmv.getElementAt(item.idx),n);
						break;
					}
					n++;
				}
				rzmv.layout = new VerticalLayout();
			} else if(rzmv.numElements > 1 && rzmv.layout is HorizontalLayout) {
				trace('horizontallayout');
				var localPoint:Point = rzmv.globalToLocal(p);
				trace('local point',localPoint.x,localPoint.y);
				var i:int=0;
				var arr:Array = new Array();
				var o:Object;
				for(i=0;i<rzmv.numElements;i++ ){
					o = new Object();
					trace('element at ',i,rzmv.getElementAt(i).x,rzmv.getElementAt(i).y);
					o.idx = i;
					o.x = rzmv.getElementAt(i).x;
					o.y = rzmv.getElementAt(i).y;
					o.id = Object(rzmv.getElementAt(i)).id;
					arr.push(o);
				}
				
				arr.sortOn(['x'],Array.NUMERIC);
				trace('arr',ObjectUtil.toString(arr));
				
				var n:uint = 0;
				for each (var item:Object in arr) 
				{
					if(item.id == id ){
						trace(n,item.id);
						rzmv.setElementIndex(rzmv.getElementAt(item.idx),n);
						break;
					}
					n++;
				}
				rzmv.layout = new HorizontalLayout();
			} else if(rzmv.numElements > 1 && rzmv.layout is TileLayout) {
				
//				var x:Number = 0;
//				var y:Number = 0;
//				
//				// loop through the elements
//				var count:int = rzmv.numElements;
//				for (var i:int = 0; i < count; i++)
//				{
//					// get the current element, we're going to work with the
//					// ILayoutElement interface
//					var element:ILayoutElement = rzmv.getElementAt(i);
//					
//					// Resize the element to its preferred size by passing
//					// NaN for the width and height constraints
//					element.setLayoutBoundsSize(NaN, NaN);
//					
//					// Find out the element's dimensions sizes.
//					// We do this after the element has been already resized
//					// to its preferred size.
//					var elementWidth:Number = element.getLayoutBoundsWidth();
//					var elementHeight:Number = element.getLayoutBoundsHeight();
//					
//					// Would the element fit on this line, or should we move
//					// to the next line?
//					if (x + elementWidth > rzmv.width)
//					{
//						// Start from the left side
//						x = 0;
//						
//						// Move down by elementHeight, we're assuming all 
//						// elements are of equal height
//						y += elementHeight;
//					}
//					
//					// Position the element
//					element.setLayoutBoundsPosition(x, y);
//				}
				trace('Tilelayout');
				var localPoint:Point = rzmv.globalToLocal(p);
				trace('local point',localPoint.x,localPoint.y);
				var i:int=0;
				var arr:Array = new Array();
				var o:Object;
				for(i=0;i<rzmv.numElements;i++ ){
					o = new Object();
					trace('element at ',i,rzmv.getElementAt(i).x,rzmv.getElementAt(i).y);
					o.idx = i;
					o.x = rzmv.getElementAt(i).x;
					o.y = rzmv.getElementAt(i).y;
					o.id = Object(rzmv.getElementAt(i)).id;
					arr.push(o);
				}
				
				arr.sortOn(['x'],Array.NUMERIC);
				trace('sort x',ObjectUtil.toString(arr));
				arr.sortOn(['y'],Array.NUMERIC);
				trace('sort y ',ObjectUtil.toString(arr));
				arr.sortOn(['x','y'],Array.NUMERIC);
				trace('sort y ',ObjectUtil.toString(arr));

				
				var n:uint = 0;
				for each (var item:Object in arr) 
				{
					if(item.id == id ){
						trace(n,item.id);
						rzmv.setElementIndex(rzmv.getElementAt(item.idx),n);
						break;
					}
					n++;
				}
				rzmv.layout = new TileLayout();
			} else {
				
			}
			
//			rzmv.invalidateDisplayList();
//			rzmv.validateNow();
			rzmv.invalidateDisplayList();
			FlexGlobals.topLevelApplication.validateNow();
			
		}
		
		private function setMoveCursor():void {
			if ((moveCursorID == 0) && (moveIcon != null)) {
				moveCursorID = CursorManager.setCursor(moveIcon, 2, -12, -10);
			}
		}

		private function removeMoveCursor():void {
			if (moveCursorID != 0) {
				CursorManager.removeCursor(moveCursorID);
				moveCursorID = 0;
			}
		}

	}
}