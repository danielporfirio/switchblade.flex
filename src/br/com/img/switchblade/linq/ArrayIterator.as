package br.com.img.switchblade.linq
{
	internal class ArrayIterator implements Iterator
	{
		private var array:Array;
		private var index:int;
		
		public function ArrayIterator(array:Array)
		{
			this.array = array;
			reset();
		}
		
		public function moveNext():Boolean
		{
			return ++index < array.length;
		}
		
		public function current():*
		{
			return array[index];
		}
		
		public function reset():void
		{
			index = -1;
		}
		
		public function get internalCount():int {
			return array.length;
		}
	}
}
	
