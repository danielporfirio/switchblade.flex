package br.com.img.switchblade.linq
{

	internal class DistinctIterator implements Iterator
	{
		private var iterator:Iterator;
		private var compareSelector:Function;
		private var selected:Array = [];
		private var distinctCurrent:*;
		
		public function DistinctIterator(queryable:Queryable, compareSelector:Function)
		{
			this.iterator = queryable.iterator; 
			this.compareSelector = compareSelector;
		}
		
		public function moveNext():Boolean
		{
			while(iterator.moveNext()) {
				var item:* = iterator.current();
				
				if(!hasItem(item)) {
					distinctCurrent = item;
					selected.push(distinctCurrent);
					return true;
				}
			}
			
			selected = [];
			return false;
		}
		
		private function hasItem(item:*):Boolean {
			if(compareSelector == null)
				return selected.indexOf(item) >= 0;
			
			for each(var visitedItem:* in selected){
				if(compareSelector(visitedItem, item))
					return true;
			}
			
			return false;
		}
		
		public function current():*
		{
			return distinctCurrent;
		}
		
		public function reset():void
		{
			iterator.reset();
			selected = [];
			distinctCurrent = null;
		}
		
		
	}
}