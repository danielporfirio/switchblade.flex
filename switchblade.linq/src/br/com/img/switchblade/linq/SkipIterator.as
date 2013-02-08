package br.com.img.switchblade.linq
{
	internal class SkipIterator implements Iterator
	{
		private var iterator:Iterator;
		private var count:int;
		private var index:int = -1;
		private var itemCurrent:*;
		
		public function SkipIterator(queryable:Queryable, count:int) {
			this.iterator = queryable.iterator;
			this.count = count;
		}
		
		public function moveNext():Boolean {
			while(iterator.moveNext()) {
				index++;
				if(index >= count) {
					itemCurrent = iterator.current();
					return true;
				}
			}
			return false;
		}
		
		public function current():* {
			return itemCurrent;
		}
		
		public function reset():void {
			iterator.reset();
			itemCurrent = null;
		}
	}
}