package br.com.img.switchblade.linq
{
		internal class SelectIterator implements Iterator
		{
			private var iterator:Iterator;
			private var selector:Function;
			private var itemCurrent:*;
			
			public function SelectIterator(queryable:Queryable, selector:Function)
			{
				this.iterator = queryable.iterator;
				this.selector = selector;
			}
			
			public function moveNext():Boolean
			{
				if(iterator.moveNext())
				{
					itemCurrent = selector(iterator.current());
					return true;
				}
				
				return false;
			}
			
			public function current():*
			{
				return itemCurrent;
			}
			
			public function reset():void
			{
				iterator.reset();
				itemCurrent = null;
			}
		
	}
}