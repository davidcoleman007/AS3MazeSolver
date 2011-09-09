package com.terabyte.as3mazesolver.view
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Engine extends EventDispatcher
	{
		public function Engine(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}