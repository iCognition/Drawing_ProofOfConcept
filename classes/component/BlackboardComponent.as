package component
{
   

    import starling.display.Sprite;
    import starling.events.TouchEvent;
    
    import starling.display.Quad;
    import starling.core.Starling;
    
    import flash.geom.Point;
    import starling.events.Touch;
    import starling.events.TouchPhase;

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
            for (var i:int = 0; i < itemContainer.numChildren; i++) {
            tmpItem = new SaveData(); //create a new save record for this object
            tmpItem.bounds = itemContainer.getChildAt(i).getBounds(itemContainer); //save it's bounds
            tmpItem.classType = getDefinitionByName(itemContainer.getChildAt(i)) as Class; //save it's type
            itemList.push(tmpItem);  //add it to the array
        }
        
    }
}