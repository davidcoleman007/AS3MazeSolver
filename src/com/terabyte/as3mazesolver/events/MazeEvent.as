/**
 * Written by David Kenneth Coleman
 * Copyright 2011, TeraByte Data Systems Engineering Co.
 * 
 * All Rights Reserved
 * 
 * */
package com.terabyte.as3mazesolver.events {
	import flash.events.Event;
	
	public class MazeEvent extends Event {
		public static const MAZE_SOLVED:String = "mazeSolved";
		public function MazeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}