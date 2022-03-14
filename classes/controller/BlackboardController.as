package controller
{
    import flash.geom.Point;
    import component.BlackboardComponent;
    import starling.display.Quad;
    import starling.events.TouchEvent;
    import starling.events.Touch;
    import starling.events.TouchPhase;

    public class BlackboardController
    {

        private var prevPt:Point;
        private var movePt:Point;
        private var currPt:Point;
        private var startPt:Point;
        private var _view:BlackboardComponent;
        private var boardContainer:Quad;
        private var brush:Quad;

        public function BlackboardController()
        {

        }

        public function initialize():void
        {
            
        }

        public function onTouch(e:TouchEvent):void
        {
           
        }

        
    }
}