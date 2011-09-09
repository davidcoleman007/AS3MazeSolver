package com.terabyte.as3mazesolver.view
{
	import assets.Assets;
	
	import away3d.core.utils.Cast;
	import away3d.materials.BitmapMaterial;
	import away3d.primitives.Sphere;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
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
			_avatar.x = -425;
			_avatar.y = 25;
			_avatar.z = 500;
			_avatar.material = _material;
			_avatar.rotationY = 90;
		}
		
		public function get model3D():Sphere {
			return _avatar;
		}
	}
}