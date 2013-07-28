package
{
	import com.maclema.mysql.MySqlResponse;
	import com.maclema.mysql.MySqlToken;
	
	import mx.rpc.AsyncResponder;

	public class BaseEvent {
		
		public function getAsyncResponder(asyncToken:MySqlToken, resultFunction:Function, faultFunction:Function, token:Object):MySqlToken {
				asyncToken.addResponder(new AsyncResponder(resultFunction,faultFunction, token));
				return asyncToken;
		}
	}
}