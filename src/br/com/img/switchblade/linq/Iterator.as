package br.com.img.switchblade.linq
{
	internal interface Iterator
	{
		function moveNext():Boolean;
		function current():*;
		function reset():void;
	}
}