package com.wbarra.controller.EnemyShips
{
	import com.wbarra.controller.allMyStuff.AllMyParticles;
	import com.wbarra.controller.allMyStuff.AllMyTexturePackerTextures;
	
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.deg2rad;
	
	public class EnemyThree extends Sprite
	{
		private var _speedX:Number = 3;
		private var _speedY:Number = 3;
		private var _alive:Boolean;
		private var _newX:Number;
		private var _newY:Number;
		private var _changeX:Number;
		private var _changeY:Number;
		private var _angle:Number;
		private var _rads:Number;
		private var _timer:Timer;
		private var _placementVar:Boolean;
		private var _mc:MovieClip;
		private var _psUp:PDParticleSystem;
		private var _psDown:PDParticleSystem;
	
		
		public function EnemyThree()
		{
			// I tracel in a line
			super();
			// test 
			var texture:Texture = Texture.fromBitmap(new AllMyTexturePackerTextures.enemiesImage());
			var xml:XML = XML(new AllMyTexturePackerTextures.enemiesXML());
			var atlas:TextureAtlas = new TextureAtlas(texture, xml);
			_mc= new MovieClip(atlas.getTextures("enemy3"), 30);
			addChild(_mc);
			Starling.juggler.add(_mc);
			_mc.pivotX = _mc.width  / 2.0;
			_mc.pivotY =  _mc.height / 2.0;
			_mc.rotation = deg2rad(180); // -> rotate around center
			
			// adding the particle effects
			// 1
			var psConfig:XML = XML(new AllMyParticles.PE3Down());
			var psTexture:Texture = Texture.fromBitmap(new AllMyParticles.PIE3Down());
			_psUp = new PDParticleSystem(psConfig, psTexture);
			_psUp.x = 0;
			_psUp.y = 0;
			_psUp.emitterX = 0;
			_psUp.emitterY = 0;
			addChild( _psUp );
			Starling.juggler.add( _psUp );
//			_psUp.start();
			
			//2
			var psConfigTwo:XML = XML(new AllMyParticles.PE3Up());
			_psDown = new PDParticleSystem(psConfigTwo, psTexture);
			_psDown.x = 0;
			_psDown.y = 0;
			_psDown.emitterX = 0;
			_psUp.emitterY = 0;
			addChild( _psDown );
			Starling.juggler.add( _psDown );
			
			_psUp.start();
			_alive = true;	
			spawnPoint();
		}
		private function spawnPoint():void
		{
			// spawn point on the bottom of the stage 
			var tempVar:Number;
			_placementVar = Math.random() < 0.5;
			y =  740;
		}
		public function enemyMove():void
		{
			y += _speedY;
			if (y >= 750)
			{
				_speedY *= -1;
				_mc.rotation += deg2rad(180); 
//				_psDown.stop();
//				_psUp.start();
			}
			if (y <= 0)
			{
				_speedY *= -1;
				_mc.rotation += deg2rad(180); 
//				_psDown.start();
//				_psUp.stop();
			}
			
			
		}
	}
}