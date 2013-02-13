package
{
	import mx.collections.ArrayCollection;

	public  class ComponentList
	{
		
		public static const Accomp:ArrayCollection = new ArrayCollection();
		
		
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
		
		public static function enableCombobox(idx:String):void {
			for(var i:int=0;i<Accomp.length;i++ ){
				if(Accomp[i].className == 'vComboBox'){
					Accomp[i].vEanble = true;
				}
			}
			
		}
		
		
	}
}