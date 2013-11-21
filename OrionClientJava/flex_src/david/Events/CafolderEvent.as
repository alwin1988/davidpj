package david.Events
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.URLUtil;
	
	import spark.components.Application;
	
	import david.pages.CA.services.CafolderService;
	import david.pages.CA.valueObjects.Cafolder;

	public class CafolderEvent extends BaseEvent
	{
		
		[Bindable] public var aC:ArrayCollection = new ArrayCollection();
		private static var _instance:CafolderEvent = new CafolderEvent();
		private var service:CafolderService;
		public var action:String = null;
		
		
		
		public function CafolderEvent()
		{
			if (_instance != null)
			{
				throw new Error("Singleton can only be accessed through Singleton.instance");
			}
//			service.endpoint = 'http://sutthikit.dyndns-server.com:8080/OrionClientJava/messagebroker/amf';
			service = new CafolderService();
			service.endpoint = getEnpoint();
			
//			//---------- service for java -----------------------------------------				
//			service = new RemoteObject();
//			service.destination = 'CafolderService';
//			var url:String = (FlexGlobals.topLevelApplication as Application).url;
//			var serverName:String = mx.utils.URLUtil.getServerNameWithPort(url);
//			service.endpoint = mx.utils.URLUtil.getProtocol(url)+"://"+serverName+"/OrionClientJava/messagebroker/amf";
//			var caf:CafloderModel = new CafloderModel();
////			service.endpoint = 'http://localhost:8080/OrionClientJava/messagebroker/amf';
////			var pd:ProductJavaModel = new ProductJavaModel();
//			//---------- end service for java 
			
		}
		
		private function getEnpoint():String {
			var o:Object = FlexGlobals.topLevelApplication;
			var url:String = o.url;	
			var serverName:String = mx.utils.URLUtil.getServerNameWithPort(url);
			var endpoint:String	= mx.utils.URLUtil.getProtocol(url)+"://"+serverName+"/OrionClientJava/messagebroker/amf";
//			Alert.show(endpoint,'Enpoint');
			return endpoint;
		}
		
		public static function get instance():CafolderEvent
		{
			return _instance;
		}	
		
		
		public function selectAll(page:Object=null):AsyncToken { 
			var asyncToken:AsyncToken = service.getAllCafolder();
			return getAsyncResponder(asyncToken, result_selectAll, fault_selectAll,page);
		}
		
		private function result_selectAll(event:ResultEvent, token:Object):void {
			aC =  new ArrayCollection(event.result.source);
			if(token != null ){
				token.selectAllFolderSuccess(aC);
			}
			
			if( action == 'DEL' ){
				Alert.show('Delete success!');
			} else if(action == 'EDIT') {
				Alert.show('Update Scuuess');
			} else {
				Alert.show('getall success');
			}
			action = null;
			
		}
		
		private function fault_selectAll(event:FaultEvent, token:Object):void {
			Alert.show('Fault!!!! getall');
		}
		
		public function editFolder(value:Cafolder,page:Object):AsyncToken { 
			var asyncToken:AsyncToken = service.merge(value);
			return getAsyncResponder(asyncToken, result_editFolder, fault_editFolder,page);
		}
		
		private function result_editFolder(event:ResultEvent, token:Object):void {
//			if(token != null){
//				token.editFolderuccessed();
//			}
			
			action = 'EDIT';
			selectAll(token);
		}
		
		private function fault_editFolder(event:FaultEvent, token:Object):void {
			Alert.show('Fault!!!!');
		}

		public function persist(value:Cafolder,page:Object):AsyncToken { 
			var asyncToken:AsyncToken = service.persist(value);
			return getAsyncResponder(asyncToken, result_persist, fault_persist,page);
		}
		
		private function result_persist(event:ResultEvent, token:Object):void {
			if(token != null){
//				token.persistuccessed();
			}
				Alert.show('Insert Success');
		}
		
		private function fault_persist(event:FaultEvent, token:Object):void {
			Alert.show('Fault!!!! insert ');
		}
		
		public function delete_method(value:Cafolder,page:Object):AsyncToken { 
			var asyncToken:AsyncToken = service.delete_method(value);
			return getAsyncResponder(asyncToken, result_delete_method, fault_delete_method,page);
		}
		
		private function result_delete_method(event:ResultEvent, token:Object):void {
			selectAll(token);
			action = 'DEL';
		}
		
		private function fault_delete_method(event:FaultEvent, token:Object):void {
			Alert.show('Fault!!!!');		
		}
		

		public function findByidFolder(value:int,page:Object):AsyncToken { 
			var asyncToken:AsyncToken = service.findById(value);
			return getAsyncResponder(asyncToken, result_findByidFolder, fault_findByidFolder,page);
		}
		
		private function result_findByidFolder(event:ResultEvent, token:Object):void {
			if(token != null){
				token.findByidFolderuccessed();
			}
		}
		
		private function fault_findByidFolder(event:FaultEvent, token:Object):void {
			Alert.show('Fault!!!!');
		}
	
	
	
	
	}
}