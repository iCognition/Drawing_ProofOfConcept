package component
{
    import starling.display.Sprite;
    import starling.display.MeshBatch;
    import starling.events.Event;
    import starling.core.Starling;
    import starling.events.TouchEvent;
    import starling.events.Touch;
    import starling.events.TouchPhase;
    import starling.display.Image;
    import starling.assets.AssetManager;
    import starling.textures.Texture;
    import flash.geom.Point;
    import starling.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.display.BitmapData;
    import flash.net.SharedObject;
    import flash.utils.ByteArray;
    import flash.geom.Rectangle;

    public class NewComponent extends Sprite
    {
        [Embed(source = "../assets/eyeball.png")]
		public static const Brush:Class;

        private var mesh:MeshBatch;
        private var isPressed:Boolean = false;
        private var image:Image;
        private var point:Point;
        private var so:SharedObject;

        public function NewComponent()
        {
            so = SharedObject.getLocal("board");

        }

        public function initialize():void
        {
            var texture:Texture = Texture.fromBitmap(new Brush());
            image = new Image(texture);
            //this.addChild(image);
            this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            Starling.current.stage.addEventListener(TouchEvent.TOUCH, onTouch);
            mesh = new MeshBatch();
            this.addChild(mesh);
            Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onTrigger);
        }

        public function onEnterFrame(e:Event):void
        {
            //trace("isPressed?:" + isPressed)
            if(isPressed) draw();
            
        }

        public function onTouch(e:TouchEvent):void
        {

           //trace("onTouch")
           var t:Touch = e.getTouch(Starling.current.stage);
           if(t == null) return;

           if(t.phase == TouchPhase.BEGAN)
           {
               isPressed = true;
               point = t.getLocation(this);
           } else
           if(t.phase == TouchPhase.MOVED)
           {
               
               point = t.getLocation(this);
               //trace("point on move:" + point)
           } else
           if(t.phase == TouchPhase.ENDED)
           {
               isPressed = false;
           }
        }

        private function draw():void//(imageName:String, meshIndex:int, x:Number, y:Number, alpha:Number = 1, rotation:Number = 0, width:Number = 0, height:Number = 0, scaleX:Number = 0, scaleY:Number = 0, color:uint = 0xffffff):void
        {
           //trace("draw")
		
			//trace("image name: ", imageName, " meshIndex: ", meshIndex);
			/*
			trace("meshIndex: ", meshIndex);
			trace("scaleX: " + scaleX);
			trace("scaleY: " + scaleY);
			trace("height: " + height);
			trace("width: " + width);*/
			
			image.x = point.x;
			image.y = point.y;
			//dic[imageName].color = color;
			
			// if(scaleX!=0) dic[imageName].image.scaleX = scaleX;
			// if(scaleY!=0) dic[imageName].image.scaleY = scaleY;
			
			/*if(width!=0) dic[imageName].image.width = width;
			if(height!=0) dic[imageName].image.height = height;
			if(scaleX!=0) dic[imageName].image.scaleX = scaleX;
			if(scaleY!=0) dic[imageName].image.scaleY = scaleY;
			if(rotation!=0) dic[imageName].image.rotation = rotation;*/
			
			/*dic[imageName].image.x = 0;
			dic[imageName].image.y = 0;*/
			
			mesh.addMesh(image, null, 1);
		
        }

        private function saveBoard():void
        {
            trace("SAVING!");
            var bmd:BitmapData = new BitmapData(500, 375, true, 0x000000);
            mesh.drawToBitmapData(bmd, 0, 1);

            var bA:ByteArray = bmd.getPixels(new Rectangle(0, 0, 500, 375));

            so.data["i"] = bA;
			so.flush();
			so.close();
            //trace(so.data["i"]);
        }

        private function loadBoard():void
        {
            trace("LOADING!");
            var bA:ByteArray = so.data["i"];
            var bmd:BitmapData = new BitmapData(500, 375, true, 0x000000)
            bmd.setPixels(new Rectangle(0, 0, 500, 375), bA);

            if(bmd!=null)
            {
                var t:Texture = Texture.fromBitmapData(bmd);
                mesh.addMesh(new Image(t), null, 1);
                //mesh.addMeshAt(new Image(t))
                //mesh.addMesh(image, null, 1);
            }
            else
            {
                throw new Error();
            }

        }

        private function onTrigger(e:KeyboardEvent):void
        {
            trace("keyboard:" + e.keyCode);
            if(e.keyCode==Keyboard.SPACE) saveBoard();
            if(e.keyCode==Keyboard.ENTER) loadBoard();
        }

    }
}