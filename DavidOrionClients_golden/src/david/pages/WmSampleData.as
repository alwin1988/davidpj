package david.pages.CA.WM
{
	import mx.collections.ArrayCollection;

	public class WmSampleData
	{
		public var Acc:ArrayCollection = new ArrayCollection();
		public var wm:WmModel = new WmModel();

		//CUDR(All,byID) ------------------ Start --------
		//C
		public function CreateWm(wm:WmModel):int  {
			Acc.addItem(wm);		
			return 1;
		}		
		//U
		public function UpdateWm(wm:WmModel):int {
			//	Acc[i].ID:String - wm.ID;
			var i:int = 0;
			for (var i:int = 0; i < Acc.length; i++) 
			{
				if(Acc[i].ID == wm.ID){
					Acc[i].EntityType = wm.EntityType;
					Acc[i].Priority = wm.Priority;
					Acc[i].Type= wm.Type;
					Acc[i].Pages = wm.Pages;
					Acc[i].Docs = wm.Docs;
					Acc[i].Source = wm.Source;
					Acc[i].Filename  = wm.Filename;
					Acc[i].Status = wm.Status;
					Acc[i].Started = wm.Started;
					Acc[i].Completed  = wm.Completed;
					Acc[i].Estimate = wm.Estimate;
					Acc[i].Deadline  = wm.Deadline;
					Acc[i].checked  = wm.checked;
					Acc[i].children = wm.children;
					i=1;
					break;
				}
			}
			return i;	
		}
		
		//D
		public function Deletewm(wm:WmModel):int {
			var i:int = 0;
			for (var i:int = 0; i < Acc.length; i++) 
			{
				if(Acc[i].ID == wm.ID){
					Acc.removeItemAt(i);
					i = 1;
					break;
				}
			}
			return i;
		}
		
		//ALL
		public function SelectAll():ArrayCollection {
			return Acc;
		}
		
		//byid
		public function getByid(wm:WmModel):WmModel {
			var _wm:WmModel = new WmModel();
			for (var i:int = 0; i < Acc.length; i++)  
			{
				if(Acc[i].ID == wm.ID){
					_wm = Acc[i];
					break;
				}
			}
			return _wm;
		}
		
		private function genData():void {
			var ac:ArrayCollection = new ArrayCollection();
			var wm:WmModel = new WmModel();
			var wm1:WmModel = new WmModel();
			var wm2:WmModel = new WmModel();
			var wm3:WmModel = new WmModel();
			var wm4:WmModel = new WmModel();
			var wm5:WmModel = new WmModel();
			var wm6:WmModel = new WmModel();
			
				wm.EntityType= "A";
				wm.Priority="1";
				wm.ID = "test";
				wm.checked = "false";
				ac.addItem(wm);
				
			
				wm = new WmModel();
				wm.EntityType="B"; 
				wm.Priority="1"; 
				wm.ID="Batch1ID"; 
				wm.Type="Batch1Type"; 
				wm.Pages="nnnnn"; 
				wm.Docs="nnnn"; 
				wm.Source="Source"; 
				wm.Filename="Filename"; 
				wm.Status="StatusValue"; 
				wm.Started="dd/mm/yyyy hh:mm"; 
				wm.Completed="nnn"; 
				wm.Estimate="dd/mm/yyyy hh:mm"; 
				wm.Deadline="dd/mm/yyyy"; 
				wm.checked="false"; 
				wm.children = new ArrayCollection();
				
				
				wm1.EntityType="S"; 
				wm1.Priority="1"; 
				wm1.ID="Subbatch1ID"; 
				wm1.Type="Batch1Type"; 
				wm1.Pages="nnnnn"; 
				wm1.Docs="nnnn"; 
				wm1.Source="Source"; 
				wm1.Filename="Filename"; 
				wm1.Status="StatusValue"; 
				wm1.Started="dd/mm/yyyy hh:mm"; 
				wm1.Completed="nnn"; 
				wm1.Estimate="dd/mm/yyyy hh:mm"; 
				wm1.Deadline="dd/mm/yyyy"; 
				wm1.checked="false"; 
				wm1.children= new ArrayCollection();
				
				wm2.EntityType="O"; 
				wm2.Priority="1"; 
				wm2.ID="Obj1ID"; 
				wm2.Type="Doc1Type"; 
				wm2.Pages="nnnnn"; 
				wm2.Docs="icon"; 
				wm2.Source="Source"; 
				wm2.Filename="Filename"; 
				wm2.Status="StatusValue"; 
				wm2.Started="dd/mm/yyyy hh:mm"; 
				wm2.Completed="nnn"; 
				wm2.Estimate="dd/mm/yyyy hh:mm"; 
				wm2.Deadline="dd/mm/yyyy"; 
				wm2.checked="false";
				wm2.children=  new ArrayCollection();
				
				wm3.EntityType="O"; 
				wm3.Priority="1"; 
				wm3.ID="Obj2ID"; 
				wm3.Type="Doc2Type"; 
				wm3.Pages="nnnnn"; 
				wm3.Docs="icon"; 
				wm3.Source="Source"; 
				wm3.Filename="Filename"; 
				wm3.Status="StatusValue"; 
				wm3.Started="dd/mm/yyyy hh:mm"; 
				wm3.Completed="nnn"; 
				wm3.Estimate="dd/mm/yyyy hh:mm"; 
				wm3.Deadline="dd/mm/yyyy"; 
				wm3.checked="false";
				wm3.children=new ArrayCollection();
				
				wm4.EntityType="B"; 
				wm4.Priority="1"; 
				wm4.ID="Batch2ID"; 
				wm4.Type="Batch2Type"; 
				wm4.Pages="nnnnn"; 
				wm4.Docs="nnnn"; 
				wm4.Source="Source"; 
				wm4.Filename="Filename"; 
				wm4.Status="StatusValue"; 
				wm4.Started="dd/mm/yyyy hh:mm"; 
				wm4.Completed="nnn"; 
				wm4.Estimate="dd/mm/yyyy hh:mm"; 
				wm4.Deadline="dd/mm/yyyy"; 
				wm4.checked="false"; 
				wm4.children= new ArrayCollection();
					
				wm5.EntityType="O"; 
				wm5.Priority="1"; 
				wm5.ID="Obj3ID"; 
				wm5.Type="Doc1Type"; 
				wm5.Pages="nnnnn"; 
				wm5.Docs="icon"; 
				wm5.Source="Source"; 
				wm5.Filename="Filename"; 
				wm5.Status="StatusValue"; 
				wm5.Started="dd/mm/yyyy hh:mm"; 
				wm5.Completed="nnn"; 
				wm5.Estimate="dd/mm/yyyy hh:mm"; 
				wm5.Deadline="dd/mm/yyyy"; 
				wm5.checked="false";
				wm5.children=new ArrayCollection();
				
				wm6.EntityType= "O"; 
				wm6.Priority="1"; 
				wm6.ID="Obj4ID"; 
				wm6.Type="Doc2Type"; 
				wm6.Pages="nnnnn"; 
				wm6.Docs="icon"; 
				wm6.Source="Source"; 
				wm6.Filename="Filename"; 
				wm6.Status="StatusValue"; 
				wm6.Started="dd/mm/yyyy hh:mm"; 
				wm6.Completed="nnn"; 
				wm6.Estimate="dd/mm/yyyy hh:mm"; 
				wm6.Deadline="dd/mm/yyyy"; 
				wm6.checked="false";
				wm6.children=new ArrayCollection();
			
				wm1.children.addItem(wm2);
				wm1.children.addItem(wm3);
				wm4.children.addItem(wm5); 
				wm4.children.addItem(wm6); 
				wm.children.addItem(wm1);
				wm.children.addItem(wm4);
				ac.addItem(wm);
			Acc = ac;
		}
		
		//------------------- Singaton----------------------------start
		private static var  _instance:WmSampleData =  new  WmSampleData();
		
		public function WmSampleData()
		{
			super();
			genData();
			if (_instance != null)
			{
				throw new Error("Singleton can only be accessed through Singleton.instance");
			}
		}
		
		public static function get getInstance(): WmSampleData {
			return _instance;
			
		}
		//------------------- Singaton----------------------------end
		
	}
}