package br.com.img.switchblade.linq
{
	import mx.utils.ObjectUtil;

	internal final class UnionIterator implements Iterator
	{		
		private var iterator:Iterator;
		private var otherSource:*;
		private var itemCurrent:*;
		private var compareSelector:Function;		
		private var selected:Array = [];
		private var index:int = -1;
		
		public function UnionIterator(queryable:Queryable, otherSource:*, compareSelector:Function = null) {
			this.iterator = queryable.iterator;
			this.otherSource = otherSource;
			
			this.compareSelector = (compareSelector != null) 
				? compareSelector
				: function(x:*,y:*):Boolean{
					var equals:int = ObjectUtil.compare(x,y)
					return  equals == 0
				};
		}
		
		public function moveNext():Boolean {
			while(iterator.moveNext()) {
				itemCurrent = iterator.current();					
				selected.push(itemCurrent);
				return true;
			}
			
			while(otherSource.hasOwnProperty("length") && otherSource.length > ++index){
				var item:* = otherSource[index];
				if(!hasItem(item)) {
					itemCurrent = item;
					return true;
				}
			}
			
			return false;
		}
		
		private function hasItem(item:*):Boolean {
			
			for each(var visitedItem:* in selected){
				if(compareSelector(visitedItem, item))
					return true;
			}
			return false;
		}
		
		public function current():* {
			return itemCurrent;
		}
		
		public function reset():void {
			iterator.reset();
			itemCurrent = null;
			selected = [];
			index = -1;
		}
		
	}
}