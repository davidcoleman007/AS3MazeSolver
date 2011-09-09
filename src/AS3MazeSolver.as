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
	
	import com.terabyte.as3mazesolver.view.Maze;
	
	import flash.display.*;
	import flash.events.*;
	
	[SWF(backgroundColor="#000000", frameRate="30", quality="LOW", width="800", height="600")]
	public class AS3MazeSolver extends Sprite
	{
		//signature swf
		[Embed(source="assets/signature.swf", symbol="Signature")]
		public static var SignatureSwf:Class;
		
		//signature variables
		private var Signature:Sprite;
		private var SignatureBitmap:Bitmap;
		
		private var maze:Maze;
		
		private var collada:Collada;
		
		private var loader:LoaderCube;
		
		private var duck:ObjectContainer3D;
		
		public static var app:AS3MazeSolver;
		
		/**
		 * Constructor
		 */
		public function AS3MazeSolver() 
		{	
			app = this;
			init();
		}
		
		/**
		 * Global initialise function
		 */
		private function init():void
		{
//			initEngine();
			initSignature();
			initView();
			initControllers();
			initListeners();
		}
		
		//engine variables
//		private var scene:Scene3D;
//		private var camera:HoverCamera3D;
//		private var _view:View3D;
		
		/**
		 * Initialise the engine
		 */
//		private function initEngine():void {
//			scene = new Scene3D();
			
			//camera = new Camera3D({z:-1000});
//			camera = new Camera3D();
//			camera.panAngle = 90;
//			camera.tiltAngle = 37.5;
//			camera.distance = 100;
//			camera.hover(true);
			//			camera = new Camera3D();
			//			camera.z = -1000;
			
//			_view = new View3D();
//			_view.scene = scene;
//			_view.camera = camera;
//			camera.y = 100;
//			camera.x = 0;
			
//			_view.addSourceURL("srcview/index.html");
//			addChild(_view);
//		}

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
			maze = new Maze();
//			collada = new Collada();
//			collada.material = Cast.material(Assets.DuckSkin);
////			
//			loader = new LoaderCube();
//////			loader.loaderSize = 600;
//			loader.addOnSuccess(onSuccess);
//			loader.loadGeometry("assets/duck_triangulate.dae", collada);
//			
		}
		
		/**
		 * Listener function for loading complete event on loader
		 */
		private function onSuccess(event:Event):void
		{
			duck = loader.handle as ObjectContainer3D;
			duck.scale(2);
//			duck.x = 0;
//			duck.z = 0;
//			duck.y = 0;
			
			duck.rotationX = 90;
			
//			scene.addChild(loader);
//			camera.hover();
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
			maze.view.x = stage.stageWidth / 2;
			maze.view.y = stage.stageHeight / 2;
			SignatureBitmap.y = stage.stageHeight - Signature.height;
		}
	}
}
