package th.co.shopsthai.Utils
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class TlenMoveEvent extends Event
	{
		
		public static const DRAG_START:String = "dragStart";
		public static const DRAGGING:String = "dragging";
		public static const DRAG_END:String = "dragEnd";
		
		public var targetObject:DisplayObject;
		public var x:Number;
		public var y:Number;
		public var _rotation:Number;
		public var scale:Number;

		
		
		public function TlenMoveEvent(type:String, targetObject:DisplayObject, x:Number=0, y:Number=0, rotation:Number=0, scale:Number=0, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this.targetObject = targetObject;
			this.x = x;
			this.y = y;
			this._rotation = rotation;
			this.scale = scale;
		}
		
		public function get rotation():Number {
			return _rotation;
		}
		
		public function get rotationInDeg():Number {
			return _rotation / (Math.PI / 180);
		}
		
		/*
		public override function clone():FreeTransformEvent {
		return new FreeTransformEvent(_targetObject, _x, _y, _rotation, _scale);
		}
		*/

	}
}

