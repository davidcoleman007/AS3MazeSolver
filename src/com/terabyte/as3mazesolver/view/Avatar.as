/**
 * Written by David Kenneth Coleman
 * Copyright 2011, TeraByte Data Systems Engineering Co.
 * 
 * All Rights Reserved
 * 
 * */
package com.terabyte.as3mazesolver.view
{
	import assets.Assets;
	
	import away3d.core.math.Vector3DUtils;
	import away3d.core.utils.Cast;
	import away3d.materials.BitmapMaterial;
	import away3d.primitives.Sphere;
	
	import com.terabyte.as3mazesolver.Utils.CellUtils;
	import com.terabyte.as3mazesolver.Utils.Direction;
	import com.terabyte.as3mazesolver.events.AvatarEvent;
	import com.terabyte.as3mazesolver.model.Cell;
	import com.terabyte.as3mazesolver.model.Model;
	import com.terabyte.as3mazesolver.model.Paths;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Vector3D;
	import flash.utils.setTimeout;
	
	[Event(name="moveDone", type="com.terabyte.as3mazesolver.events.AvatarEvent")]
	public class Avatar extends EventDispatcher
	{
		private var app:AS3MazeSolver = AS3MazeSolver.app;
		
		//material objects
		private var _material:BitmapMaterial;

		private var _avatar:Sphere;
		
		private static var instance:Avatar;
		
		private var _numStepsRemaining:int = -1;
		private var _numCellsMoved:int = -1;
		
		private var _row:int;
		private var _col:int;
		
		/**
		 * 
		 * @param target
		 * 
		 */
		public function Avatar(target:IEventDispatcher=null) {
			super(target);
			init();
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public static function getInstance():Avatar {
			if(!instance) {
				instance = new Avatar();
			}
			return instance;
		}

		/**
		 * 
		 * 
		 */
		protected function init():void {
			_material = new BitmapMaterial(Cast.bitmap(Assets.AvatarMaterial));
			_avatar = new Sphere();
			_avatar.radius = (Maze.getInstance().cellWidth*0.90)/2;
			y = 40;
			_avatar.material = _material;
			_avatar.rotationY = Direction.WEST;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get model3D():Sphere {
			return _avatar;
		}
		
		/**
		 * 
		 * @param val
		 * 
		 */
		public function set x(val:Number):void {
			_avatar.x = val;
			updateCameraCenter();
		}
		
		/**
		 * 
		 * @param val
		 * 
		 */
		public function set y(val:Number):void {
			_avatar.y = val;
			updateCameraCenter();
		}
		
		/**
		 * 
		 * @param val
		 * 
		 */
		public function set z(val:Number):void {
			_avatar.z = val;
			updateCameraCenter();
		}
		
		/**
		 * sets the current direction of the avatar 
		 * @param val:uint
		 * 
		 */
		public function set direction(val:int):void {
			_avatar.rotationY = val;
		}
		
		/**
		 * gets the current direction of the avatar 
		 * @return direction:uint
		 * 
		 */
		public function get direction():int {
			return _avatar.rotationY;
		}
		
		/**
		 * updates the camera to point at the current position of the avatar
		 * 
		 */
		private function updateCameraCenter():void {
			var avatarVector:Vector3D = new Vector3D(_avatar.x, _avatar.y, _avatar.z);
			Engine.getInstance().camera.pivotPoint = avatarVector;
			Engine.getInstance().camera.lookAt(avatarVector);
		}
		
		/**
		 * initiates a move of the avatar forward numCells cells
		 * @param numCells
		 * 
		 */
		public function moveForward(numCells:int):void {
			trace("moving forward "+numCells+" cell(s)");
			_numStepsRemaining = 5 * numCells;
			_numCellsMoved = numCells;
			setTimeout(_moveForward, 10);
		}
		
		/**
		 * incremental move function
		 * 
		 */
		private function _moveForward():void {
			var step:Number;
			step = Maze.getInstance().cellWidth / 5;
			switch(direction) {
				case Direction.NORTH: {
					x = _avatar.x - step;
					break;
				}
				case Direction.SOUTH: {
					x = _avatar.x + step;
					break;
				}
				case Direction.EAST: {
					z = _avatar.z + step; 
					break;
				}
				case Direction.WEST: {
					z = _avatar.z - step; 
					break;
				}
			}
			_numStepsRemaining--;
			if(_numStepsRemaining) {
				setTimeout(_moveForward, 50);
			} else {
				_numStepsRemaining = -1;
				switch(direction) {
					case Direction.NORTH: {
						col -= _numCellsMoved;
						break;
					}
					case Direction.SOUTH: {
						col += _numCellsMoved;
						break;
					}
					case Direction.EAST: {
						row -= _numCellsMoved; 
						break;
					}
					case Direction.WEST: {
						row += _numCellsMoved; 
						break;
					}
				}
				_numCellsMoved = 0;
				getCurrentCell().timesVisited++;
				dispatchEvent(
					new AvatarEvent(
						AvatarEvent.MOVE_DONE
					)
				);
			}
		}
		
		/**
		 * places the avatar in a specific cell 
		 * @param target
		 * 
		 */
		public function jumpTo(target:Cell):void {
			row = target.y;
			col = target.x;
			getCurrentCell().timesVisited++;
		}

		/**
		 * gets the current row of the avatar
		 * @return int
		 * 
		 */
		public function get row():int {
			return _row;
		}

		/**
		 * sets the current row of the avatar 
		 * @param value:int
		 * 
		 */
		public function set row(value:int):void {
			z = 500 - ((value -1) * Maze.getInstance().cellWidth);
			_row = value;
		}

		/**
		 * returns the current column of the avatar
		 * @return column:int  
		 * 
		 */
		public function get col():int {
			return _col;
		}

		/**
		 * sets the current column of the avatar
		 * @param value:int
		 * 
		 */
		public function set col(value:int):void {
			x = -500 + ((value - 1) * Maze.getInstance().cellWidth);
			_col = value;
		}

		/**
		 * returns the cell of the avatar's current position 
		 * @return cell:Cell
		 * 
		 */
		public function getCurrentCell():Cell {
			return (CellUtils.cellAt(row,col) as Cell);
		}
		
		/**
		 * Turns the avatar to face the cell passed
		 * @param cell:Cell
		 * 
		 */
		public function faceTowards(cell:Cell):void {
			_avatar.rotationY = cell.orientationRelativeTo(getCurrentCell());
			trace("facing in direction "+_avatar.rotationY);
		}
		
		/**
		 * returns the cell that follows the Right-Hand-Rule in relation to the current cell
		 * @return destination:Cell
		 * 
		 */
		public function rightHandPath():Cell {
			var paths:Paths = getCurrentCell().getPaths();
			var path:Cell;
			switch(direction) {
				case Direction.NORTH: {
					if(paths.east) {
						path = paths.east;
						break;
					}
					if(paths.north) {
						path = paths.north;
						break;
					}
					if(paths.west) {
						path = paths.west;
						break;
					}
					if(paths.south) {
						path = paths.south;
						break;
					}
					break;
				}
				case Direction.EAST: {
					if(paths.south) {
						path = paths.south;
						break;
					}
					if(paths.east) {
						path = paths.east;
						break;
					}
					if(paths.north) { 
						path = paths.north;
						break;
					}
					if(paths.west) {
						path = paths.west;
						break;
					}
					break;
				}
				case Direction.SOUTH: {
					if(paths.west) {
						path = paths.west;
						break;
					}
					if(paths.south) {
						path = paths.south;
						break;
					}
					if(paths.east) {
						path = paths.east;
						break;
					}
					if(paths.north) { 
						path = paths.north;
						break;
					}
					break;
				}
				case Direction.WEST: {
					if(paths.north) { 
						path = paths.north;
						break;
					}
					if(paths.west) {
						path = paths.west;
						break;
					}
					if(paths.south) {
						path = paths.south;
						break;
					}
					if(paths.east) {
						path = paths.east;
						break;
					}
					break;
				}
			}
			return path;
		}
	}
}