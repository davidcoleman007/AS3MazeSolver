package com.terabyte.as3mazesolver.view
{
	import assets.Assets;
	
	import away3d.cameras.Camera3D;
	import away3d.cameras.HoverCamera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.core.utils.Cast;
	import away3d.materials.BitmapMaterial;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.Plane;
	import away3d.primitives.Sphere;
	
	import flash.events.Event;
	
	import mx.events.ResizeEvent;

	public class Maze
	{
		//engine variables
		private var scene:Scene3D;
		private var camera:HoverCamera3D;
		private var _view:View3D;
		
		//material objects
		private var material:BitmapMaterial;
		
		//scene objects
		private var floor:Plane;

		private var app:AS3MazeSolver = AS3MazeSolver.app
		
		public function Maze()
		{
			init();
		}
		
		public function get view():View3D {
			return _view;
		}
		/**
		 * Initialize maze
		 */
		private function init():void
		{
			initEngine();
			initMaterials();
			initObjects();
			initListeners();
		}
		
		public function addChild(obj:Object3D):void {
			scene.addChild(obj);
		}
		
		private function initEngine():void {
			scene = new Scene3D();
			
			//camera = new Camera3D({z:-1000});
			camera = new HoverCamera3D();
			camera.panAngle = 45;
			camera.tiltAngle = 60
			camera.distance = 3000;
			camera.hover(true);
//			camera = new Camera3D();
//			camera.z = -1000;
			
			_view = new View3D();
			_view.scene = scene;
			_view.camera = camera;
			camera.y = 100;
			camera.x = -500;
			
			_view.addSourceURL("srcview/index.html");
			app.addChild(_view);
		}
		private var avatarMaterial:BitmapMaterial;
		
		/**
		 * Initialise the materials
		 */
		private function initMaterials():void {
			material = new BitmapMaterial(Cast.bitmap(Assets.MazeMaterial));
			avatarMaterial = new BitmapMaterial(Cast.bitmap(Assets.AvatarMaterial));
		}
		
		public var avatar:Sphere;
		
		/**
		 * Initialise the scene objects
		 */
		private function initObjects():void {
			//plane = new Plane({material:material, width:500, height:500, yUp:false, bothsides:true});
			floor = new Plane();
			floor.material = material;
			floor.width = 1000;
			floor.height = 1000;
			floor.yUp = true;
			floor.bothsides = true;
			floor.y = 0;
			scene.addChild(floor);
			parseWalls();
			addAvatar();
		}
		
		private function addAvatar():void {
			avatar = new Sphere();
			avatar.radius = 20;
			avatar.x = -425;
			avatar.y = 25;
			avatar.z = 500;
			avatar.material = avatarMaterial;
			avatar.rotationY = 90;
			scene.addChild(avatar);
		}
		
		private function parseWalls():void {
			
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
			view.render();
		}
	}
}