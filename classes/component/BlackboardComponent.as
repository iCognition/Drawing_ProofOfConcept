package component
{
   

    import starling.display.Sprite;
    import starling.events.TouchEvent;
    
    import starling.display.Quad;
    import starling.core.Starling;
    
    import flash.geom.Point;
    import starling.events.Touch;
    import starling.events.TouchPhase;
    import flash.net.registerClassAlias;
    import flash.utils.getDefinitionByName;
    import flash.filesystem.File;
    import flash.filesystem.FileStream;
    import flash.filesystem.FileMode;
    import flash.geom.Rectangle;
    import starling.display.DisplayObject;

    public class BlackboardComponent extends Sprite
    {
        public var boardContainer:Sprite;
        public var boardLayer:Quad;
        public var brush:Quad;
        private var prevPt:Point = new Point();
        private var movePt:Point = new Point();
        private var currPt:Point = new Point();
        private var startPt:Point = new Point();
        
        public function BlackboardComponent()
        {
            
        }

        public function initialize():void
        {
            trace("blackboard initialized");
            boardContainer = new Sprite();
            boardLayer = new Quad(Config.appWidth, Config.appHeight, 0x333333);
            brush = new Quad(10, 10, 0xffffff);

            this.addChild(boardContainer);
            boardContainer.addChild(boardLayer);
            boardContainer.addEventListener(TouchEvent.TOUCH, onTouch);

            
            trace("check bounds:" + this.bounds, boardContainer.bounds);
            trace("viewport:" + Starling.current.viewPort);
        
        }

        public function onTouch(e:TouchEvent):void
        {
            var t:Touch = e.getTouch(boardContainer);
            brush = new Quad(10, 10, 0xffffff);
            
            if(t==null) return;
            if(t.phase == TouchPhase.BEGAN)
            {
                trace("ontouchbegan:" + prevPt, movePt, currPt, startPt, t.globalX, t.globalY);
                prevPt.x = movePt.x = currPt.x = startPt.x = t.globalX;
				prevPt.y = movePt.y = currPt.y = startPt.y = t.globalY;
                brush.x = currPt.x;
                brush.y = currPt.y;
                addChild(brush);
            }
            if(t.phase == TouchPhase.MOVED)
            {
                trace("ontouchmoved");
                prevPt.x = currPt.x;
				prevPt.y = currPt.y;
				currPt.x = movePt.x;
				currPt.y = movePt.y;
                movePt.x = t.globalX;
                movePt.y = t.globalY;
                brush.x = currPt.x;
                brush.y = currPt.y;
                addChild(brush);
            }
            if(t.phase == TouchPhase.ENDED)
            {
                saveBoard();
            }
        }
        
        public function saveBoard():void
        {
            //this will hold all your data
            //a vector is the same as an array only all members must be of the specified type
            var itemList:Vector.<SaveData> = new Vector.<SaveData>();

            //populate the array/vector with all the children of itemContainer
            var tmpItem:SaveData;
            //loop through all children of item container
            for (var i:int = 0; i < boardContainer.numChildren; i++) 
            {
                trace("board:" + boardContainer.getChildAt(i).bounds)
                tmpItem = new SaveData(); //create a new save record for this object
                tmpItem.bounds = boardContainer.getChildAt(i).getBounds(boardContainer); //save it's bounds
                tmpItem.classType = getDefinitionByName(boardContainer.getChildAt(i)) as Class; //save it's type
                itemList.push(tmpItem);  //add it to the array
            }
            throw new Error();

            //Now you have an array describing all the item on screen

            //to automatically serialize/unserialize, you need this line (and you need to register every class nested in SaveData that isn't a primitive type - which would just be Rectangle in this case
            registerClassAlias("SaveData", SaveData);
            registerClassAlias("flash.geom.Rectangle", Rectangle);

            //create a new File to work with
            var file:File = File.applicationStorageDirectory; //or whatever directory you want
            file.resolvePath("saveData.data"); //or whatever you want to call it
            var fileStream:FileStream = new FileStream();
            fileStream.open(file, FileMode.WRITE);
            fileStream.writeObject(itemList); //write the array to this file
            fileStream.close();
        }

        public function loadBoard():void
        {
            boardContainer = new Sprite(); //however you initialize this
            this.addChild(boardContainer);

            var file:File = File.applicationStorageDirectory;
            file.resolvePath("saveData.data");
            var fileStream:FileStream = new FileStream();
            fileStream.open(file, FileMode.READ);
            var itemList:Vector.<SaveData> = fileStream.readObject() as Vector.<SaveData>;
            fileStream.close();

            //now that you've read in the array of all items from before, you need to recreate them:
            var tmpItem:DisplayObject;
            var tmpClass:Class;
            //loop through all items in the array, and create a object
            for (var i:int = 0; i < itemList.length; i++) 
            {
                tmpClass = itemList[i].classType; //The type of item
                tmpItem = new tmpClass() as DisplayObject; //create the item

                //now move the item to it's former position and scale
                tmpItem.x = (itemList[i] as Quad).x;
                tmpItem.y = (itemList[i] as Quad).y;
                tmpItem.width = (itemList[i] as Quad).width;
                tmpItem.height = (itemList[i] as Quad).height;

                //add the item back to the parent
                boardContainer.addChild(tmpItem);
            }
        }
        
        
    }
}