package com.terabyte.as3mazesolver.view
{
	import assets.Assets;
	
	import away3d.core.math.Vector3DUtils;
	import away3d.core.utils.Cast;
	import away3d.materials.BitmapMaterial;
	import away3d.primitives.Sphere;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Vector3D;
	
	public class Avatar extends EventDispatcher
	{
		//material objects
		private var _material:BitmapMaterial;

		private var _avatar:Sphere;
		
		private static var instance:Avatar;
		
		//event MOVE_DONE
		public function Avatar(target:IEventDispatcher=null) {
			super(target);
			init();
		}
		
		public static function getInstance():Avatar {
			if(!instance) {
				instance = new Avatar();
			}
			return instance;
		}

		protected function init():void {
			_material = new BitmapMaterial(Cast.bitmap(Assets.AvatarMaterial));
			_avatar = new Sphere();
			_avatar.radius = 20;
			x = -425;
			y = 25;
			z = 500;
			_avatar.material = _material;
			_avatar.rotationY = 180;
		}
		
		public function get model3D():Sphere {
			return _avatar;
		}
		
		public function set x(val:Number):void {
			_avatar.x = val;
			updateCameraCenter();
		}
		public function set y(val:Number):void {
			_avatar.y = val;
			updateCameraCenter();
		}
		public function set z(val:Number):void {
			_avatar.z = val;
			updateCameraCenter();
		}
		
		private function updateCameraCenter():void {
			Engine.getInstance().camera.pivotPoint = new Vector3D(_avatar.x, _avatar.y, _avatar.z);
		}
	}
}