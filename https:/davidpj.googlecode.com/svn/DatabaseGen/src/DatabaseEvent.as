package
{
	import com.maclema.mysql.MySqlToken;
	import com.maclema.mysql.ResultSet;
	import com.maclema.mysql.mxml.MySqlService;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.utils.ObjectUtil;

	public class DatabaseEvent extends BaseEvent
	{
				private var service:MySqlService = FlexGlobals.topLevelApplication.myservice;
		
				public function ShowDatabase(page:Object):MySqlToken {
				var asyncToken:MySqlToken = service.send('show databases');
					return getAsyncResponder(asyncToken, result_ShowDatabase, fault_ShowDatabase,page);
				}
				
				private function result_ShowDatabase(data:*, token:Object):void {
					if ( data is ResultSet ) {
						FlexGlobals.topLevelApplication.aCDb = ResultSet(data).getRows() as ArrayCollection;
					}
				}
				
				private function fault_ShowDatabase(error:*, token:Object):void {
					trace(error);
				}
		

				
				public function ShowTable(db:String,page:Object):MySqlToken {
					var asyncToken:MySqlToken = service.send('show tables from '+ db);
					return getAsyncResponder(asyncToken, result_ShowTable, fault_ShowTable,page);
				}
				
				private function result_ShowTable(data:*, token:Object):void {
						FlexGlobals.topLevelApplication.aCTb = ResultSet(data).getRows() as ArrayCollection;
				}
				
				private function fault_ShowTable(error:*, token:Object):void {
					trace(error);
				}

				
				public function ShowColum(tb:String,page:Object):MySqlToken {
					var asyncToken:MySqlToken = service.send('show COLUMNS from ' + tb);
					return getAsyncResponder(asyncToken, result_ShowColum, fault_ShowColum,page);
				}
				
				private function result_ShowColum(data:*, token:Object):void {
					if(token != null){
						if(token == 0 ){
							FlexGlobals.topLevelApplication.acMaster = ResultSet(data).getRows() as ArrayCollection;
							
						} else if(token == 1){
							FlexGlobals.topLevelApplication.acDetail = ResultSet(data).getRows() as ArrayCollection;
							
						} else {
							FlexGlobals.topLevelApplication.aCcolumn = ResultSet(data).getRows() as ArrayCollection;
						}

					} else {
						FlexGlobals.topLevelApplication.aCcolumn = ResultSet(data).getRows() as ArrayCollection;
					}
				}
				
				private function fault_ShowColum(error:*, token:Object):void {
					trace(error);
				}

				
					
				public function ShowIndex(tb:String,db:String,page:Object):MySqlToken {
					var asyncToken:MySqlToken = service.send("show INDEX  from "+ tb +" from " + db + "  WHERE Key_name = 'PRIMARY'");
					return getAsyncResponder(asyncToken, result_ShowIndex, fault_ShowIndex,page);
				}
				
				private function result_ShowIndex(data:*, token:Object):void {
					FlexGlobals.topLevelApplication.aCPK = ResultSet(data).getRows() as ArrayCollection;
				}
				
				private function fault_ShowIndex(error:*, token:Object):void {
					trace(error);
				}

				
				public function ExecuteQuery(sql:String,page:Object):MySqlToken {
					var asyncToken:MySqlToken = service.send(sql);
					return getAsyncResponder(asyncToken, result_ExecuteQuery, fault_ExecuteQuery,page);
				}
				
				private function result_ExecuteQuery(data:*, token:Object):void {
						FlexGlobals.topLevelApplication.Acqu = ResultSet(data).getRows();
						if(FlexGlobals.topLevelApplication.Acqu.length == 0 ) {
							Alert.show('error no reault');
							FlexGlobals.topLevelApplication.dgQCollist.dataProvider = new ArrayCollection();
						} else {
							FlexGlobals.topLevelApplication.btnGenerate.enabled = true;
							
							var arCol:Array = new Array();
							for(var i:int=0;i<FlexGlobals.topLevelApplication.dgQuery.columns.length;i++) {
								arCol.push(FlexGlobals.topLevelApplication.dgQuery.columns[i].dataField);
							}
							//					trace(ObjectUtil.toString(arCol));
							FlexGlobals.topLevelApplication.dgQCollist.dataProvider = new ArrayCollection(arCol);
							
						}
				}
				
				private function fault_ExecuteQuery(error:*, token:Object):void {
					trace(error);
				}
					
				
		//		public function xxxx(xx:String,page:Object):MySqlToken {
		//			var asyncToken:MySqlToken = service.send(xx);
		//			return getAsyncResponder(asyncToken, result_xxxx, fault_xxxx,page);
		//		}
		//		
		//		private function result_xxxx(data:*, token:Object):void {
		//			if(token != null){
		//				token.xxxxSuccess(event.result as ArrayCollection	);
		//			}
		//		}
		//		
		//		private function fault_xxxx(error:*, token:Object):void {
		//			trace(error);
		//			FlexGlobals.topLevelApplication.hideProgressBar();
		//			MessageAlert.getErrorAlert(ErrorMsg.getErrorMsg(event));
		//		}
		
	}
}