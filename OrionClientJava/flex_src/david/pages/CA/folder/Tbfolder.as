package  david.pages.CA.folder
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Tbfolder
	{
		
		
		private var _dfidx:int;
		private var _dfparentid:int;
		private var _dfname:String;
		private var _dfcheck:String;
		private var _dfstate:String;
		private var _dflabel:String;
		private var _dfchildren:ArrayCollection = new ArrayCollection();  // list<Tbfolder>
		private var _dfisBranch:String;
		private var _dfisChange:Boolean = false;
		
		
		
		public function get check():String
		{
			return _dfcheck;
		}

		public function set check(value:String):void
		{
			_dfcheck = value;
			change();
		}

		public function get name():String
		{
			return _dfname;
		}

		public function set name(value:String):void
		{
			_dfname = value;
			_dflabel = value;
			change();
		}

		public function get parentid():String
		{
			return _dfparentid.toString();
		}

		public function set parentid(value:String):void
		{
			_dfparentid = parseInt(value);
			change();
		}

		public function get idx():String
		{
			return _dfidx.toString();
		}

		public function set idx(value:String):void
		{
			_dfidx = parseInt(value);
			change();
		}

		public function get state():String
		{
			return _dfstate;
		}

		public function set state(value:String):void
		{
			_dfstate = value;
			change();
		}

		public function get isBranch():String
		{
			return _dfisBranch;
		}

		public function set isBranch(value:String):void
		{
			_dfisBranch = value;
			change();
		}

		public function get description():String
		{
			return _dflabel;
		}

		public function set description(value:String):void
		{
			_dflabel = value;
			change();
		}

		public function get children():ArrayCollection
		{
			return _dfchildren;
		}

		public function set children(value:ArrayCollection):void
		{
			_dfchildren = value;
			
			change();
		}

		
		private function change():void {
			if(_dfchildren){
				if(_dfchildren.length > 0 ){
					_dfisBranch = 'true';	
				} else {
					_dfisBranch = 'false';
				}
			}
		}

		public function get isChange():Boolean
		{
			return _dfisChange;
		}

		public function set isChange(value:Boolean):void
		{
			_dfisChange = value;
		}


	}
}