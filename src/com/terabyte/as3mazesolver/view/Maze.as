package com.terabyte.as3mazesolver.view
{
	import assets.Assets;
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.HoverCamera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.core.utils.Cast;
	import away3d.materials.BitmapMaskMaterial;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Cube;
	import away3d.primitives.Plane;
	import away3d.primitives.Sphere;
	
	import com.terabyte.as3mazesolver.model.Cell;
	import com.terabyte.as3mazesolver.model.Model;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.events.ResizeEvent;

	public class Maze
	{
		public static var FLOOR_WIDTH:int = 1000;
		private static var instance:Maze;
		
		//material objects
		private var material:BitmapMaterial;
		
		//scene objects
		private var mazeBitmap:BitmapData;

		private var app:AS3MazeSolver = AS3MazeSolver.app;
			
		private var entrance:Point;
		private var exit:Point;
		
		private var _cellWidth:int = 0;
		private var bitmapCellWidth:int = 0;
		private var bitmapCellWidthFound:Boolean = false;
		
		private var wallColor:uint;
		
		public var entrances:Array = new Array();
		
		private var avatarMaterial:BitmapMaterial;
		
		public function Maze() {
			init();
		}
		
		public static function getInstance():Maze {
			if(!instance) {
				instance = new Maze();
			}
			return instance;
		}
		
		/**
		 * Initialize maze
		 */
		private function init():void {
			mazeBitmap = Cast.bitmap(Assets.MazeMaterial);
			initMaterials();
			initObjects();
			initListeners();
		}
		
		public function addChild(obj:Object3D):void {
			Engine.getInstance().scene.addChild(obj);
		}
		
		/**
		 * Initialize the materials
		 */
		private function initMaterials():void {
			avatarMaterial = new BitmapMaterial(Cast.bitmap(Assets.AvatarMaterial));
		}
		
		/**
		 * Initialize the scene objects
		 */
		private function initObjects():void {
			parseWalls();
			drawCells();
		}
		
		private function drawCells():void {
			var x:int;
			var y:int;
			_cellWidth = ((mazeBitmap.height/mazeBitmap.width)*Maze.FLOOR_WIDTH) / app.model.rows.length;
			for(y = 0;
				y < app.model.rows.length;
				y ++ ) {
				var row:Array = (app.model.rows[y] as Array);
				for(x = 0;
					x < row.length;
					x ++) {
					var cell:Cell = row[x] as Cell;
					var x3d:int = -500 + ((cell.x-1) * _cellWidth);
					var z3d:int = 500 - ((cell.y-1) * _cellWidth);
					if(cell.isWall) {
						var cube:Cube = new Cube();
						cube.width =
						cube.height = 
						cube.depth =
							_cellWidth;
						cube.x = x3d;
						cube.z = z3d;
						cube.y = _cellWidth/2;
						cube.material = new BitmapMaterial(Cast.bitmap(Assets.GrassPattern2));
						Engine.getInstance().scene.addChild(cube);
					} else {
						var floor:Plane;
						floor = new Plane();
						floor.material = new BitmapMaterial(Cast.bitmap(Assets.Dirt1));
						floor.width = 
						floor.height = _cellWidth;
						floor.yUp = true;
						floor.bothsides = true;
						floor.x = x3d;
						floor.y = 0;
						floor.z = z3d;
						Engine.getInstance().scene.addChild(floor);
						if( (cell.x == 1) ||
							(cell.x == width) ||
							(cell.y == 1) ||
							(cell.y == height) ) {
							entrances.push(cell);
						}
					}
				}
			}
		}
		
		/**
		 * assumptions: 
		 *    1) the entrance is the same width as the cells of the maze
		 *    2) the cells are square and all the same size
		 *    3) the maze is monochromatic
		 *    4) the walls are non-white
		 *    5) the floor is white
		 *    6) there is one entrance and one exit
		 *    7) entrance/exit are not on a corner
		 * */
		private function parseWalls():void {
			findCellWidth();
			mapCells();
		}
		
		private function mapCells():void {
			var x:int;
			var y:int;
			for(y = 1;
				y < mazeBitmap.height;
				y += bitmapCellWidth ) {
				var row:Array = new Array();
				for(x = 1;
					x < mazeBitmap.width;
					x += bitmapCellWidth) {
					var cell:Cell = new Cell();
					cell.isWall = isWallPixel(x,y);
					cell.x = row.length + 1;
					cell.y = Model.getInstance().rows.length + 1;
					row.push(cell);
				}
				Model.getInstance().rows.push(row);
			}
		}
		
		private function findCellWidth():void {
			var x:int;
			var y:int;
			for(y = 1;
				y <= mazeBitmap.height;
				y += (mazeBitmap.height-1) ) {
				for(x = 1;
					x <= mazeBitmap.width;
					x++) {
					findCellWidthPixelTest(x,y);
					if(bitmapCellWidthFound) {
						break;
					}
				}
				if(bitmapCellWidthFound) {
					break;
				}
			}
			if(!bitmapCellWidthFound) {
				for(y = 1;
					y <= mazeBitmap.height;
					y++ ) {
					for(x = 1;
						x <= mazeBitmap.width;
						x += (mazeBitmap.width - 1) ) {
						findCellWidthPixelTest(x,y);
						if(bitmapCellWidthFound) {
							break;
						}
					}
					if(bitmapCellWidthFound) {
						break;
					}
				}
			}
		}
		
		private function findCellWidthPixelTest(x:int, y:int):void {
			if(!isWallPixel(x,y)) {
				if(!bitmapCellWidthFound) {
					bitmapCellWidth++;
				}
			} else {
				if(bitmapCellWidth && !bitmapCellWidthFound) {
					bitmapCellWidthFound = true;
				}
			}
		}
		
		private function isWallPixel(x:int, y:int):Boolean {
			var color:uint;
			color = mazeBitmap.getPixel(x,y);
			var retVal:Boolean = isWallColor(color);
			if(retVal) {
				wallColor = color;
			}
			return retVal;
		}
		
		private function isWallColor(pixelColor:uint):Boolean {
			return !(pixelColor == 0xFFFFFF);
		}
		
		public function get cellWidth():Number {
			return _cellWidth;
		}
		
		/**
		 * Initialise the listeners
		 */
		private function initListeners():void {
			app.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
//			app.dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));
		}
		
		/**
		 * Navigation and render loop
		 */
		private function onEnterFrame( e:Event ):void {
			//			plane.rotationY += 2;
			Engine.getInstance().view.render();
		}
		
		public function get width():int {
			var retVal:int = 0;
			if(Model.getInstance().rows.length) {
				retVal = (Model.getInstance().rows[0] as Array).length;
			}
			return retVal;
		}
		
		public function get height():int {
			var retVal:int = 0;
			retVal = Model.getInstance().rows.length;
			return retVal;
			
		}
	}
}