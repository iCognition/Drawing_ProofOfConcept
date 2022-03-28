package component
{
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.RenderTexture;
    import starling.display.Image;
    
    import starling.events.TouchEvent;
    import starling.events.KeyboardEvent;
    import starling.events.Touch;
    import starling.events.TouchPhase;
    import flash.geom.Point;
    
    import flash.ui.Keyboard;
    import starling.display.Quad;
    
    import starling.core.Starling;
    
    import flash.utils.ByteArray;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import starling.textures.Texture;
    import starling.assets.AssetManager;
    import flash.net.SharedObject;
    import flash.ui.Mouse;

    public class NewComponent extends Sprite
    {
        [Embed(source = "../assets/brushstroke2.png")]
		public static const Brush:Class;

        private var canvas:Image;
        private var brush:Image;
        private var pt:Point = new Point();
        private var isPressed:Boolean = false;
        private var r:RenderTexture;
        private var so:SharedObject;
        private var bgColor:uint = 0xff0000;

        public function NewComponent()
        {
            so = SharedObject.getLocal("board");
            //this.addEventListener(Event.ADDED_TO_STAGE, onInit);          
        }
        // protected function onInit(e:Event):void
        // {
        //     //this.addEventListener(Event.ADDED_TO_STAGE, onInit);
        //    // initialize();
        // }
        public function initialize():void
        {
            var bg:Quad = new Quad(Config.appWidth, Config.appHeight, bgColor);
            this.addChild(bg);

            var bg2:Quad = new Quad(20, 20, 0x33ff33);
            var bg3:Quad = new Quad(20, 20, 0x3333ff);
            // var bg4:Quad = new Quad(20, 20, 0x33ff33);
            // var bg5:Quad = new Quad(20, 20, 0x33ff33);
            

            bg2.addEventListener(TouchEvent.TOUCH, onTrigger1);
            bg3.addEventListener(TouchEvent.TOUCH, onTrigger2);

 
            r = new RenderTexture(Config.appWidth, Config.appHeight);
            canvas = new Image(r);
            this.addChild(canvas);

           
            var texture:Texture = Texture.fromBitmap(new Brush());
            brush = new Image(texture);
            brush.alignPivot();
            brush.scaleX = 0.1;
            brush.scaleY = 0.1;
            brush.color = 0x000000;

            this.addEventListener(TouchEvent.TOUCH, onTouch);
            Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
            this.addEventListener(Event.ENTER_FRAME, update);

            this.addChild(bg2);
            this.addChild(bg3);
            bg3.x += 30;
        }

        private function onTrigger1(e:TouchEvent):void
        {
            var t:Touch = e.getTouch(e.currentTarget as Quad)
            if(t==null) return
            if(t.phase==TouchPhase.BEGAN)
            {
                trace("ontrigger1");
                brush.color = 0x000000;
            }
            

        }

        private function onTrigger2(e:TouchEvent):void
        {
            var t:Touch = e.getTouch(e.currentTarget as Quad)
            if(t==null) return
            if(t.phase==TouchPhase.BEGAN)
            {
                trace("ontrigger2");
                brush.color = bgColor;
            }
            
        }
        private function update(e:Event):void
        {
            trace("isPressed: " + isPressed);
            if(isPressed==true) 
            {
                
                onDraw();
            }
        }
        private function onKey(e:KeyboardEvent):void
        {
            trace("onkey: " + e.keyCode);
            if(e.keyCode == Keyboard.SPACE)
            {
                saveImage();
            }
            if(e.keyCode == Keyboard.ENTER)
            {
                loadImage();
            }
        }
        private function onTouch(e:TouchEvent):void
        {
            
            var t:Touch = e.getTouch(this);
            if(t==null) return;
            //t.getLocation(canvas, pt);
            if(t.phase == TouchPhase.BEGAN)
            {
                trace("onTouch began");
                isPressed = true;
                t.getLocation(canvas, pt);
            }
            else if(t.phase == TouchPhase.MOVED)
            {
                t.getLocation(canvas, pt);
            }
            else if(t.phase == TouchPhase.ENDED)
            {
                trace("onTouch ended");
                isPressed = false;
            }
        }
        private function onDraw():void
        {
            brush.x = pt.x;
            brush.y = pt.y;
            r.draw(brush);
            trace("should draw!");
        }
        private function saveImage():void
        {
            var bA:ByteArray = new ByteArray();
            var bmd:BitmapData = new BitmapData(canvas.width, canvas.height, true, 0x000000);
            canvas.drawToBitmapData(bmd);
            bA = bmd.getPixels(new Rectangle(0,0,bmd.width, bmd.height));
            
            so.data["i"] = bA;
			so.flush();
			so.close();

           
            //SettingsManager.getInstance().setProperty("drawingRec", obj);
        }
        private function loadImage():void
        {
            //var bA:ByteArray = SettingsManager.getInstance().getProperty("drawing", null);
            var bA:ByteArray = so.data["i"];

           // var obj:Object = SettingsManager.getInstance().getProperty("drawingRec", null);
            //var rec:Rectangle = new Rectangle(0,0,obj.width, obj.height);
           
            var bmd:BitmapData = new BitmapData(Config.appWidth, Config.appHeight, true, 0x000000);
            bmd.setPixels(new Rectangle(0,0,bmd.width, bmd.height), bA);

            var t:Texture = Texture.fromBitmapData(bmd);
            var img:Image = new Image(t);
            
            r.draw(img);
        }
    }
}