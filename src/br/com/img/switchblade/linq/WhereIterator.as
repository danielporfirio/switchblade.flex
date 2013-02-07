package br.com.img.switchblade.linq
{
	
	internal class WhereIterator implements Iterator
	{
		private var iterator:Iterator;
		private var predicate:Function;
		
		public function WhereIterator(queryable:Queryable, predicate:Function)
		{
			this.iterator = queryable.iterator;
			this.predicate = predicate;
		}
		
		public function moveNext():Boolean
		{
			while(iterator.moveNext())
			{
				var isSatisfied:Boolean = predicate(iterator.current());
				
				if(isSatisfied)
					return true;
			}
			
			return false;
		}
		
		public function current():*
		{
			return iterator.current();
		}
		
		public function reset():void
		{
			iterator.reset();
		}
	}
}