/**
 * Written by David Kenneth Coleman
 * Copyright 2011, TeraByte Data Systems Engineering Co.
 * 
 * All Rights Reserved
 * 
 * */
package com.terabyte.as3mazesolver.controller {
	import com.terabyte.as3mazesolver.events.AvatarEvent;
	import com.terabyte.as3mazesolver.events.MazeEvent;
	import com.terabyte.as3mazesolver.model.Cell;
	import com.terabyte.as3mazesolver.view.Avatar;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="mazeSolved", type="com.terabyte.as3mazesolver.events.MazeEvent")]
	public class MazeController extends EventDispatcher {
		
		private static var instance:MazeController;
		
		private var solved:Boolean = false;
		public function MazeController(target:IEventDispatcher=null) {
			super(target);
		}
		
		public static function getInstance():MazeController {
			if(!instance) {
				instance = new MazeController();
			}
			return instance;
		}
		
		public function solveMaze(event:AvatarEvent = null):void {
			var currentPos:Cell = Avatar.getInstance().getCurrentCell();
			var nextCell:Cell = Avatar.getInstance().rightHandPath();
			Avatar.getInstance().faceTowards(nextCell);
			if(!Avatar.getInstance().hasEventListener(AvatarEvent.MOVE_DONE)) {
				Avatar.getInstance().addEventListener(
					AvatarEvent.MOVE_DONE,
					solveMaze
				);
			}
			Avatar.getInstance().moveForward(1);
		}
	}
}