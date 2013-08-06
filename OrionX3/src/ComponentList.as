package
{
	import component.vDataGrid;
	
	import mx.accessibility.AccConst;
	import mx.collections.ArrayCollection;
	
	import th.co.shopsthai.Utils.ComponentData;

	public  class ComponentList
	{
		
		public static const Accomp:ArrayCollection = new ArrayCollection();
		
		
		public static function  getcomponent(cid:String):ComponentData {
			for (var i:int = 0; i < Accomp.length; i++) 
			{
			     if(Accomp[i].cid == cid ){
					 return Accomp[i] as ComponentData;
					 break;
				 } 
			}
			return null;
		}
		
		public function ComponentList()
		{
		}
		
		public static function disableCombobox(idx:String):void {
			for(var i:int=0;i<Accomp.length;i++ ){
				if(Accomp[i].className == 'vComboBox' && Accomp[i].id == idx ){
					Accomp[i].vEanble = false; 
				}
			}
		}

		public static function disablevDataGrid(idx:String):void {
			for(var i:int=0;i<Accomp.length;i++ ){
				if(Accomp[i].className == 'vDataGrid' && Accomp[i].id == idx ){
					Accomp[i].vEanble = false;
				}
			}
		}
		
		public static function enableCoponent(idx:String):void {
			for(var i:int=0;i<Accomp.length;i++ ){
				if(Accomp[i].className == 'vComboBox'){
					Accomp[i].vEanble = true;
				} else if(Accomp[i].className == 'vDataGrid'){
					Accomp[i].vEanble = true;
				}
			}
			
		}
		
		
	}
}