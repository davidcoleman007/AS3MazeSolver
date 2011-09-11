package com.terabyte.as3mazesolver.model {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Model extends EventDispatcher {
		private static var instance:Model;
		
		public var rows:Array = new Array();
		
		public function Model(target:IEventDispatcher=null) {
			super(target);
		}
		
		public static function getInstance():Model {
			if(!instance) {
				instance = new Model();
			}
			return instance;
		}
	}
}