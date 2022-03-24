package
{
    import starling.display.Sprite;
    
    
    import starling.events.TouchEvent;
    import starling.events.Touch;
    import starling.events.Event;
    import starling.core.Starling;
    import flash.geom.Rectangle;
    import starling.display.Quad;
    import starling.events.TouchPhase;
    import flash.geom.Point;
    import component.BlackboardComponent;
    import component.NewComponent;
    
    
    
    public class MyApp extends Sprite
    {

        private var container:Quad;
        private var blackboard:BlackboardComponent;
        private var newComp:NewComponent;
        

        public function MyApp()
        {
            super();
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        public function initialize():void
        {
            // container = new Sprite();
            // this.addChild(container);

            // this.width = Config.appWidth;
            // this.height = Config.appHeight;

            // container.addEventListener(TouchEvent.TOUCH, onTouch);
            // trace("check bounds:" + this.bounds, container.bounds);
            // trace("viewport:" + Starling.current.viewPort);
        }

        

        private function onAddedToStage(event:Event):void
        {
            // trace("on added to stage")
            // blackboard = new BlackboardComponent();
            // blackboard.initialize();
            // this.addChild(blackboard);
            newComp = new NewComponent();
            newComp.initialize();
            this.addChild(newComp)
        
        }

        

    }
}