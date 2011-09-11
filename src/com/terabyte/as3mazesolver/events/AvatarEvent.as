package com.terabyte.as3mazesolver.events
{
	import flash.events.Event;
	
	public class AvatarEvent extends Event {
		public static const MOVE_DONE:String = "moveDone";
		public function AvatarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}