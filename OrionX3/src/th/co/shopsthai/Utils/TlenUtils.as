package th.co.shopsthai.Utils
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.core.FlexGlobals;
	import mx.core.IVisualElementContainer;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.utils.ObjectUtil;

	public class TlenUtils
	{

	
		public static function getObjectbyPix(cid:String,x:Number=0, y:Number=0):* {
			var arr:Array = FlexGlobals.topLevelApplication.getObjectsUnderPoint(new Point( x,y));
			var o:* = null;
			for (var i:int = arr.length-1; i >= 0; i--) 
			{  
				if(arr[i].hasOwnProperty('className')){
						if(arr[i].className.indexOf('Skin') > -1 ){
							trace('skin hostComponentid',arr[i].hostComponent.id);
							if(arr[i].hostComponent.id != cid ){
								o = arr[i].hostComponent;
								break;
							}	
							if(arr[i].hostComponent.id == 'mainParent'){
								break;
							}
						} else if(arr[i].hasOwnProperty('rzmv')) {
							trace('rzmv=',arr[i].rzmv,'id=',arr[i].id );
							if(arr[i].rzmv == 1 ){
								if(arr[i].id != cid ){
									o = arr[i];
								}
							}
						} 
					trace('id&name =',arr[i].id,arr[i].name);
				}
			}
			return o;		
		}
		
		
		
	}
}