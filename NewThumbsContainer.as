package  {
	
	import fl.containers.UILoader;
	import flash.display.MovieClip;
	import flash.events.MouseEvent
	import flash.geom.Rectangle;
	import flash.net.SharedObject
	
	public class NewThumbsContainer extends MovieClip {
		
		var urls:Array
		private var myso:SharedObject
		public function NewThumbsContainer() 
		{
			urls = ["test.jpg","test.jpg","test.jpg""test.jpg""test.jpg""test.jpg""test.jpg""test.jpg""test.jpg"]
			init()
		}
		
		private function sdrag(e:MouseEvent):void 
		{
			stopDrag()
			Main(parent.parent).screenSaver()
		}
		
		private function drag(e:MouseEvent):void 
		{
			startDrag(false, new Rectangle( -width, y, width, 0))
			Main(parent.parent).screenSaver()
		}
		public function init()
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, drag)
			removeEventListener(MouseEvent.MOUSE_UP, sdrag)
			addEventListener(MouseEvent.MOUSE_DOWN, drag)
			addEventListener(MouseEvent.MOUSE_UP, sdrag)
			while (numChildren > 0) 
			{
				//getChildAt(0).uiloader.removeEventListener(MouseEvent.MOUSE_DOWN, showBigPic)
				removeChildAt(0)
			}
			if (Boolean(urls.length))
			{
			for (var i:int = 0; i < urls.length; i++)
				{
					var tile:Thumbs = new Thumbs
					addChild(tile);
					tile.uiloader.unload()
					tile.uiloader.source = urls[i]
					tile.uiloader.removeEventListener(MouseEvent.MOUSE_DOWN, showBigPic)
					tile.uiloader.addEventListener(MouseEvent.MOUSE_DOWN, showBigPic)
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
			Level2(parent).bigPicContainer.visible = true
			Level2(parent).bigPicContainer.source = UILoader(e.currentTarget).source
		}
	}
	
}
