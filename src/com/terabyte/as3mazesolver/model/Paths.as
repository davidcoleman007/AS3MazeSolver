package com.terabyte.as3mazesolver.model {
	import com.terabyte.as3mazesolver.Utils.Direction;
	import com.terabyte.as3mazesolver.view.Avatar;

	public class Paths {
		private var _data:Array = new Array();
		private var _north:Cell = null;
		private var _south:Cell = null;
		private var _east:Cell = null;
		private var _west:Cell = null;
		public function Paths() {
		}
		
		public function get north():Cell {
			if(!_north) {
				_north = findByDirection(Direction.NORTH);
			}
			return _north;
		}
		
		public function get south():Cell {
			if(!_south) {
				_south = findByDirection(Direction.SOUTH);
			}
			return _south;
		}
		
		public function get east():Cell {
			if(!_east) {
				_east = findByDirection(Direction.EAST);
			}
			return _east;
		}
		
		public function get west():Cell {
			if(!_west) {
				_west = findByDirection(Direction.WEST);
			}
			return _west;
		}
		
		private function findByDirection(direction:uint):Cell {
			var retVal:Cell = null;
			var i:int;
			for(i = 0;
				i < _data.length;
				i++) {
				var cell:Cell = _data[i];
				if(cell.orientationRelativeTo(
					Avatar.getInstance().getCurrentCell()
				) == direction) {
					retVal = _data[i] as Cell;
					break;
				}
			}
			return retVal;
		}
		
		public function push(value:Cell):void {
			_data.push(value);
		}
	}
	
}