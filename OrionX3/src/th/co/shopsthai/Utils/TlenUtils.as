package th.co.shopsthai.Utils
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;

	public class TlenUtils
	{

	
	public static function getObjectbyPix(e:FlexEvent):Object {
	//	var arr:Array = FlexGlobals.topLevelApplication.getObjectsUnderPoint(new Point( e.stageX,e.stageY));
			var o:Object = new Object();
			o.a = 'test';
			trace(o);
			return o;		
	}
		
		
		
	}
}