package david.pages.CA.WM {
	
	import flash.utils.setTimeout;
	
	import mx.core.mx_internal;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;

	public class BaseEvent {
		public function getAsyncResponder(asyncToken:AsyncToken, resultFunction:Function, faultFunction:Function, token:Object):AsyncToken {
			asyncToken.addResponder(new AsyncResponder(resultFunction, faultFunction, token));
			return asyncToken;
		}
		
		public function createToken(result:Object):AsyncToken
		{
			var token:AsyncToken = new AsyncToken(null);
			setTimeout(
				function(e:ResultEvent = null):void 
				{
					token.mx_internal::applyResult(new ResultEvent(ResultEvent.RESULT, false, true, result,token));
				}, 100);
			return token;
		}
	}
}