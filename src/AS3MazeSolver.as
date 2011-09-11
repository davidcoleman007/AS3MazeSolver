package
{
	import assets.Assets;
	
	import away3d.cameras.*;
	import away3d.containers.*;
	import away3d.core.traverse.Traverser;
	import away3d.core.utils.Cast;
	import away3d.events.MouseEvent3D;
	import away3d.events.Object3DEvent;
	import away3d.loaders.Collada;
	import away3d.loaders.Loader3D;
	import away3d.loaders.LoaderCube;
	import away3d.materials.*;
	import away3d.primitives.*;
	
	import com.terabyte.as3mazesolver.controller.MazeController;
	import com.terabyte.as3mazesolver.model.Cell;
	import com.terabyte.as3mazesolver.model.Model;
	import com.terabyte.as3mazesolver.view.Avatar;
	import com.terabyte.as3mazesolver.view.Engine;
	import com.terabyte.as3mazesolver.view.Maze;
	
	import flash.display.*;
	import flash.events.*;
	
	[SWF(backgroundColor="#000000", frameRate="24", quality="HIGH", width="800", height="600")]
	public class AS3MazeSolver extends Sprite
	{
		//signature swf
		[Embed(source="assets/signature.swf", symbol="Signature")]
		public static var SignatureSwf:Class;
		
		//signature variables
		private var Signature:Sprite;
		private var SignatureBitmap:Bitmap;
		
		private var engine:Engine;
		private var maze:Maze;
		private var avatar:Avatar;
		
		private var collada:Collada;
		
		private var loader:LoaderCube;
		
		private var duck:ObjectContainer3D;
		
		public var model:Model;
		
		public static var app:AS3MazeSolver;
		
		/**
		 * Constructor
		 */
		public function AS3MazeSolver() {	
			app = this;
			model = Model.getInstance();
			init();
			Avatar.getInstance().jumpTo(
				Maze.getInstance().entrances[0] as Cell
			);
//			MazeController.getInstance().addEventListener(
//				MazeEvent.MAZE_SOLVED,
//				onMazeSolved
//			);
			MazeController.getInstance().solveMaze();
		}
		
		/**
		 * Global initialise function
		 */
		private function init():void
		{
			engine = Engine.getInstance();
			initSignature();
			initView();
			initControllers();
			initListeners();
		}
		
		private function initSignature():void
		{
			//add signature
			Signature = Sprite(new SignatureSwf());
			SignatureBitmap = new Bitmap(new BitmapData(Signature.width, Signature.height, true, 0));
			stage.quality = StageQuality.HIGH;
			SignatureBitmap.bitmapData.draw(Signature);
			stage.quality = StageQuality.LOW;
			addChild(SignatureBitmap);
		}
		
		private function initView():void {
			maze = Maze.getInstance();
			avatar = Avatar.getInstance();
			Engine.getInstance().scene.addChild(avatar.model3D);
		}
		
		private function initControllers():void {
			
		}
		
		private function initListeners():void
		{
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}
		
		/**
		 * stage listener for resize events
		 */
		private function onResize(event:Event = null):void
		{
			engine.view.x = stage.stageWidth / 2;
			engine.view.y = stage.stageHeight / 2;
			SignatureBitmap.y = stage.stageHeight - Signature.height;
		}
	}
}
