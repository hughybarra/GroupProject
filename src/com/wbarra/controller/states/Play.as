package com.wbarra.controller.states
{
	import com.wbarra.controller.EnemyShips.EnemyOne;
	import com.wbarra.controller.EnemyShips.EnemyThree;
	import com.wbarra.controller.EnemyShips.EnemyTwo;
	import com.wbarra.controller.core.Game;
	import com.wbarra.controller.hero.Hero;
	import com.wbarra.controller.interfaces.IState;
	import com.wbarra.controller.states.Play;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	
	public class Play extends Sprite implements IState
	{
		/***************************/
		// This variable will take us back to the Play State
		// so we can switch back to Menu or Over states
		private var _game:Game;
		/***************************/
		
		private var _hero:Hero;
		private var _enemyOne:EnemyOne;
		private var _enemyTwo:EnemyTwo;
		private var _enemyThree:EnemyThree;
		private var _enemyOneHolder:Array = [];
		private var _enemyTwoHolder:Array = [];
		private var _enemyThreeHolder:Array = [];
		
		// getting the hero's X/Y position to pass into the Enemy One for Targeting.
		private var _heroX:Number; 
		private var _heroY:Number;
		
		//getting the distance between our moving circles
		private var _distX:Number;
		private var _distY:Number;
		private var _distanceEnemyOne:Number;
		private var _distanceEnemyTwo:Number;
		private var _distanceEnemyThree:Number;
		
		// collision detection 
		private var _pHero:Point;
		private var _pEnemyOne:Point;
		private var _pEnemyTwo:Point;
		private var _pEnemyThree:Point;
		private var _radHero:Number;
		private var _radEnemyOne:Number;
		private var _radEnemyTwo:Number;
		private var _radEnemyThree:Number;
		
		public function Play(game:Game)
		{
			this._game = game;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(event:TouchEvent):void
		{
			Hero.click = event;
		}		
		
		private function onEnterFrame():void
		{
			// moving the Hero
			//=======================================================
			_hero.update();
			//=======================================================
			
			// testing the collisions
			_pHero = new Point( (_hero.x) , (_hero.y) );// breaking when we add the height and the width 
			_radHero= _hero.width / 2;
			
			
			//Moving EnemyOne on the stage. 
			//=======================================================
			for each (var e:EnemyOne in _enemyOneHolder) 
			{
				e.enemyMove( (_hero.x  ), (_hero.y ));// breaks when i account for the height and the width 
				// somethingto do with the mouse coming onto the stage. 
				// collision detection for enemy One
				_radEnemyOne = e.width / 2;
				_pEnemyOne = new Point(e.x, e.y);
				_distanceEnemyOne = Point.distance(_pHero, _pEnemyOne);
				if (_distanceEnemyOne < _radHero + _radEnemyOne)
				{
					shipHit();
					break;
				}
			}
			//=======================================================
			
			//Moving EnemyTwo on the stage. 
			//=======================================================
			for each (var d:EnemyTwo in _enemyTwoHolder)
			{
				d.enemyMove();
				_radEnemyTwo = d.width/2;
				_pEnemyTwo = new Point(d.x, d.y);
				_distanceEnemyTwo = Point.distance(_pHero, _pEnemyTwo);
				
				if (_distanceEnemyTwo < _radHero + _radEnemyTwo)
				{
					shipHit();
					break;
				}
			}
			
			
			//Moving EnemyThree on the stage. 
			//=======================================================
			for each (var f:EnemyThree in _enemyThreeHolder)
			{
				f.enemyMove();	
				_radEnemyThree = f.width/2;
				_pEnemyThree = new Point(f.x, f.y);
				
				_distanceEnemyThree = Point.distance(_pHero, _pEnemyThree);
				if (_distanceEnemyThree < _radHero + _radEnemyThree)
				{
					shipHit();
					break;
				}
			}
		}
		private function shipHit():void
		{
			trace("hit");
			killGame();
			destroy();
		}
		
		private function killGame():void
		{
			_game.changeState(Game.GAME_OVER_STATE);
		}
		
		private function onAdded():void
		{
			_hero = new Hero();
			_hero.x = stage.stageWidth/2
			_hero.y = stage.stageHeight/2;
			addChild( _hero);
			
			//building a bunch of test enemies of class Enemy one
			var spacer:Number = 10;
			// ENEMY 1 
			for (var e1:int = 0; e1 < 10; e1++)
			{
				// spawning enemy One
				_enemyOne = new EnemyOne();
				_enemyOne.scaleX = _enemyOne.scaleY = .5;
				addChild( _enemyOne );
				
				// pushing into enemy array 
				_enemyOneHolder.push(_enemyOne);
				trace(_enemyOneHolder.length);
			}
			// ENEMY 2 
			for (var e2:int = 0; e2 < 10; e2++)
			{
				// spawning enemy two
				_enemyTwo = new EnemyTwo();
				_enemyTwo.scaleX = _enemyTwo.scaleY = .5;
				addChild( _enemyTwo);
				
				// pushing into enemy array 
				_enemyTwoHolder.push(_enemyTwo);
				trace(_enemyTwoHolder.length);
			}
			// ENEMY 3 
			for (var e3:int = 0; e3 < 30; e3 ++ )
			{
				// spawning enemy three
				_enemyThree = new EnemyThree();
				_enemyThree.scaleX = _enemyThree.scaleY = .5;
				_enemyThree.x = spacer;
				addChild( _enemyThree);
				
				// pushing into enemy array 
				_enemyThreeHolder.push(_enemyThree);
				spacer += _enemyThree.width + 10;
				trace(_enemyThreeHolder.length);
			}
			
			// building the bullets 
			for (var f:int = 0; f < 100; f++)
			{
				
			}
		}

		public function update():void
		{
		}
		
		public function destroy():void
		{
			if(this.numChildren > 0)
			{
				trace('test');
				this.removeChildAt(0);				
				trace(this.numChildren);
			}
		}
	}
}