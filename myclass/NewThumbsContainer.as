package myclass {
	
	import fl.containers.UILoader;
	import flash.display.MovieClip;
	import flash.events.MouseEvent
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import com.greensock.TweenLite
	import flash.filters.DropShadowFilter
	
	public class NewThumbsContainer extends MovieClip {
		
		var urls:Array
		var  _lastTime:Number
		var boo:Boolean = false
		var container_lastTime:Number
		var container_currentTime:Number
		var lastPos:Number
		public function NewThumbsContainer() 
		{
			urls = ["test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg","test.jpg"]
			init()
		}
		
		private function sdrag(e:MouseEvent):void 
		{
			stopDrag()
			container_currentTime = getTimer()
			var pastTime:int = container_currentTime - container_lastTime;
			
			var currentPos:Number = x
			var dist:Number = currentPos - lastPos
			
			if(boo == false&&dist!=0)
			{
				if(dist>0)
				{
					TweenLite.to(this,pastTime/100,{x:x+50000/pastTime})
				}
				else
				{
					TweenLite.to(this,pastTime/100,{x:x-50000/pastTime})
				}
				
			}
		}
		
		private function drag(e:MouseEvent):void 
		{
			boo = false
			lastPos = x
			container_lastTime = getTimer()
			TweenLite.killTweensOf(this)
			startDrag(false, new Rectangle( -width, y, width, 0))
			MovieClip(parent).bigPic.visible = false
		}
		public function init()
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, drag)
			removeEventListener(MouseEvent.MOUSE_UP, sdrag)
			addEventListener(MouseEvent.MOUSE_DOWN, drag)
			addEventListener(MouseEvent.MOUSE_UP, sdrag)
			while (numChildren > 0) 
			{
				removeChildAt(0)
			}
			if (Boolean(urls.length))
			{
			for (var i:int = 0; i < urls.length; i++)
				{
					var tile:Thumbs = new Thumbs
					addChild(tile);
					tile.filters = []
					tile.filters = [new DropShadowFilter(4,45,0,.5,4,4)]
					tile.uiloader.unload()
					tile.uiloader.source = urls[i]
					tile.uiloader.removeEventListener(MouseEvent.MOUSE_UP, showBigPic)
					tile.uiloader.removeEventListener(MouseEvent.MOUSE_DOWN, setLastTime)
					tile.uiloader.addEventListener(MouseEvent.MOUSE_DOWN, setLastTime)
					tile.uiloader.addEventListener(MouseEvent.MOUSE_UP, showBigPic)
					tile.x = i * tile.width/2
					if (i & 1)
					{
						tile.y = tile.height
						tile.x -= tile.width/2
					}
				}
			}
		}
		
		public function showBigPic(e:MouseEvent):void 
		{
			var _currentTime:uint = getTimer();
			var pastTime:int = _currentTime - _lastTime;
			if(pastTime>100)
			{
				trace(pastTime)
				UILoader(e.currentTarget).removeEventListener(MouseEvent.MOUSE_UP, showBigPic)
				UILoader(e.currentTarget).addEventListener(MouseEvent.MOUSE_UP, showBigPic)
			}
			else
			{
			boo = true
			trace("show big pic")
			MovieClip(parent).bigPic.visible = true
			}
		}
		function setLastTime (e:MouseEvent)
		{
			_lastTime = getTimer()
		}
	}
	
}

