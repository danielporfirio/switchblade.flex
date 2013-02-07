package br.com.img.switchblade.linq
{

	public class Queryable 
	{
		private var source:*;
		private var iteratorFactory:Function;
		
		public function Queryable(source:*, iteratorFactory:Function=null) {
			
			this.source = source;
			if(iteratorFactory != null){
				this.iteratorFactory = iteratorFactory;  
			}
			else{
				
				if(source is Array)
					this.iteratorFactory = function(source:*):Iterator { return new ArrayIterator(source as Array) };
			}
		}
		
		public function get iterator():Iterator { 
			return iteratorFactory(source);
		}
		
		public function where(predicate:Function):Queryable {
			return new Queryable(this,
				function(source:*):Iterator {
					return new WhereIterator(source, predicate) });
		}
		
		public function distinct(comparer:Function=null):Queryable {
			return new Queryable(this,
				function(source:*):Iterator {
					return new DistinctIterator(source, comparer) });
		}
		
		public function select(selector:Function):Queryable {
			return new Queryable(this,
				function(source:*):Iterator {
					return new SelectIterator(source, selector) });
		}
		
		public function skip(count:int):Queryable {
			return new Queryable(this,
				function(source:*):Iterator {
					return new SkipIterator(source, count)});
		}
		
		public function take(count:int):Queryable {
			return new Queryable(this,
				function(source:*):Iterator {
					return new TakeIterator(source, count)});
		}
		
		public function union(otherSource:*, comparer:Function = null):Queryable {
			return new Queryable(this,
				function(source:*):Iterator {
					return new UnionIterator(source, otherSource, comparer)});
		}
		
		public function toArray():Array {
			return parseTo(new Array(), function(array:*, item:*):* { array.push(item) });
		}
		
		private function parseTo(collection:*, add:Function):* {
			var _iterator:Iterator = iterator;
			while(_iterator.moveNext())
				add(collection, _iterator.current());
			
			return collection;       
		}
		
	}
}