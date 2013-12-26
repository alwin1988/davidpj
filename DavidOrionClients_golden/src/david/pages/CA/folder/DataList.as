package david.pages.CA.folder
{
	import mx.collections.ArrayCollection;

	public class DataList
	{
		public function DataList()
		{
		}
		
		public function genData():ArrayCollection {
			var ac:ArrayCollection = new ArrayCollection();
			var tb:Tbfolder;
			var tbf:Tbfolder;
			var tbc:Tbfolder;
			for (var i:int = 1; i < 5; i++) 
			{
				tbf = new Tbfolder();
				tbf.idx = i.toString();
				tbf.name ='namei'+i.toString();
				tbf.parentid = '0';
				tbf.description ='namei'+i.toString();
				tbf.check = 'true';
				tbf.state = 'checked';

				for (var j:int = 1; j < 4; j++) 
				{
					if(i != 2){
						
						tb = new Tbfolder();
						tb.idx = i.toString() + j.toString();
						tb.parentid = i.toString();
						tb.name = 'nameij'+i.toString()+'-'+ j.toString();
						tb.description ='namei'+i.toString();
						tb.check = 'true';
						tb.state = 'checked';
	
						for (var k:int = 1; k < 5; k++) 
						{
							tbc = new Tbfolder();
							tbc.idx = i.toString() + j.toString()+ k.toString();
							tbc.name = 'nameijk'+i.toString()+"-"+j.toString()+'-'+ k.toString();
							tbc.parentid = j.toString();
							tb.children.addItem(tbc);
							tbc.description ='namei'+i.toString();
							tbc.check = 'true';
							tbc.state = 'checked';
						}
						tbf.children.addItem(tb);
					}
				}
				ac.addItem(tbf);
			}
			return ac;
		}
		
		
		
	}
}