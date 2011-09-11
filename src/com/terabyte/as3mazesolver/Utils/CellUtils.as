package com.terabyte.as3mazesolver.Utils {
	import com.terabyte.as3mazesolver.model.Cell;
	import com.terabyte.as3mazesolver.model.Model;

	public class CellUtils {
		public function CellUtils() {
			super();
		}
		public static function cellAt(rowNum:int, colNum:int):Cell {
			var rows:Array = Model.getInstance().rows;
			var row:Array;
			var cell:Cell = null;
			if(rows.length >= rowNum) {
				row = rows[rowNum-1] as Array;
				if(row.length >= colNum) {
					cell = row[colNum-1] as Cell;
				}
			} else {
				throw(new Error("row "+rowNum+" does not exist"));
			}
			return cell;
		}
	}
}