package com.terabyte.as3mazesolver.view
{
	import away3d.cameras.HoverCamera3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Engine extends EventDispatcher
	{
		private static var instance:Engine;
		
		private var app:AS3MazeSolver = AS3MazeSolver.app
		
		private var _scene:Scene3D;
		private var _camera:HoverCamera3D;
		private var _view:View3D;
		
		public function Engine(target:IEventDispatcher=null) {
			super(target);
			
			init();
		}
		
		public static function getInstance():Engine {
			if(!instance) {
				instance = new Engine();
			}
			return instance;
		}
		
		private function init():void {
			_scene = new Scene3D();
			
			_camera = new HoverCamera3D();
			_camera.panAngle = 45;
			_camera.tiltAngle = 60
			_camera.distance = 3000;
			_camera.hover(true);
			
			_view = new View3D();
			_view.scene = scene;
			_view.camera = camera;
			_camera.y = 100;
			_camera.x = -500;
			
			_view.addSourceURL("srcview/index.html");
			app.addChild(_view);
		}

		public function get scene():Scene3D
		{
			return _scene;
		}

		public function get camera():HoverCamera3D
		{
			return _camera;
		}

		public function get view():View3D
		{
			return _view;
		}


	}
}