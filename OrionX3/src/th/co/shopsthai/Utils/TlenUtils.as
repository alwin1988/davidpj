package th.co.shopsthai.Utils
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	import mx.utils.ObjectUtil;

	public class TlenUtils
	{

	
		public static function getObjectbyPix(x:Number=0, y:Number=0):Object {
			var arr:Array = FlexGlobals.topLevelApplication.getObjectsUnderPoint(new Point( x,y));
			var o:Object = new Object();
			for (var i:int = 0; i < arr.length; i++) 
			{
				trace('id&name =',arr[i].id,arr[i].name);
			}
			return o;		
		}
		
		
		
	}
}