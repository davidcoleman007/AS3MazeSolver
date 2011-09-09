package com.terabyte.as3mazesolver.controller {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class MazeController extends EventDispatcher {
		
		private static var instance:MazeController;
		
		public function MazeController(target:IEventDispatcher=null) {
			super(target);
		}
		
		public function getInstance():MazeController {
			if(!instance) {
				instance = new MazeController();
			}
			return instance;
		}
	}
}