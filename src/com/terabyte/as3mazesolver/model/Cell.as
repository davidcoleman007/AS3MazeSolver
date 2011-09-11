/**
 * Written by David Kenneth Coleman
 * Copyright 2011, TeraByte Data Systems Engineering Co.
 * 
 * All Rights Reserved
 * 
 * */
package com.terabyte.as3mazesolver.model
{
	import com.terabyte.as3mazesolver.Utils.CellUtils;
	import com.terabyte.as3mazesolver.Utils.Direction;
	import com.terabyte.as3mazesolver.view.Maze;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Cell extends EventDispatcher
	{
		public var x:int;
		public var y:int;
		public var isWall:Boolean;
		public var timesVisited:int = 0;
		
		public function Cell(target:IEventDispatcher=null) {
			super(target);
		}
		
		public function getPaths():Paths {
			var pathNorth:Cell;
			var pathSouth:Cell;
			var pathEast:Cell;
			var pathWest:Cell;
			var paths:Paths = new Paths();
			var northX:int = x - 1;
			var northY:int = y;
			var southX:int = x + 1;
			var southY:int = y;
			var eastX:int = x;
			var eastY:int = y - 1;
			var westX:int = x;
			var westY:int = y + 1;
			var cell:Cell;
			if(northX > 0) {
				cell = CellUtils.cellAt(northY,northX);
				if(!cell.isWall) {
					paths.push(cell);
				}
			}
			if(southX <= Maze.getInstance().width) {
				cell = CellUtils.cellAt(southY,southX);
				if(!cell.isWall) {
					paths.push(cell);
				}
			}
			if(eastY > 0) {
				cell = CellUtils.cellAt(eastY,eastX);
				if(!cell.isWall) {
					paths.push(cell);
				}
			}
			if(westY <= Maze.getInstance().height) {
				cell = CellUtils.cellAt(westY,westX);
				if(!cell.isWall) {
					paths.push(cell);
				}
			}
			return paths;
		}
		
		public function orientationRelativeTo(cell:Cell):uint {
			var retVal:uint;
			if(cell.x == x) {
				//	East or West
				if(cell.y < y) {
					retVal = Direction.WEST;
				} else {
					retVal = Direction.EAST;
				}
			} else {
				// North or South
				if(cell.y == y) {
					if(cell.x < x) {
						retVal = Direction.SOUTH;
					} else {
						retVal = Direction.NORTH;
					}
				} else {
					throw(new Error("cell is not orthagonally oriented, this is not a valid path"));
				}
			}
			return retVal;
		} 
	}
}