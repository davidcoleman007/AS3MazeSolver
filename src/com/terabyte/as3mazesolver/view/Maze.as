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
		
		//material objects
		private var material:BitmapMaterial;
		
		//scene objects
		private var floor:Plane;

		private var app:AS3MazeSolver = AS3MazeSolver.app
		
		public function Maze() {
			init();
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
			Engine.getInstance().scene.addChild(obj);
		}
		
		private function initEngine():void {
		}
		private var avatarMaterial:BitmapMaterial;
		
		/**
		 * Initialise the materials
		 */
		private function initMaterials():void {
			material = new BitmapMaterial(Cast.bitmap(Assets.MazeMaterial));
			avatarMaterial = new BitmapMaterial(Cast.bitmap(Assets.AvatarMaterial));
		}
		
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
			Engine.getInstance().scene.addChild(floor);
			parseWalls();
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
			Engine.getInstance().view.render();
		}
	}
}