package
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import flash.display.Sprite;
	import component.BlackboardComponent;
	import starling.display.DisplayObject;
	import flash.display.BitmapData;
	import starling.rendering.Painter;
	import starling.display.Stage;
	import flash.html.script.Package;
   
    [SWF(frameRate = "60", backgroundColor = 0xffffff)]
	
	public class Scribble extends Sprite
	{
		private var myStarling:Starling;
        private var blackboard:BlackboardComponent;
        private var viewPort:Rectangle;
        private var starlingClass:MyApp;
        //private var _starlingStage:Starling;

		
		public function Scribble()
		{
			
            Config.appHeight = stage.stageHeight;
            Config.appWidth = stage.stageWidth;

            viewPort = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            this.stage.align = StageAlign.TOP_LEFT;
            this.stage.scaleMode = StageScaleMode.NO_SCALE;
            
            myStarling = new Starling(MyApp, stage);
            myStarling.viewPort = viewPort;
            myStarling.stage.stageWidth = stage.stageWidth;
            myStarling.stage.stageHeight = stage.stageHeight;
            myStarling.simulateMultitouch = true;
            myStarling.start();
            
            
            trace("stageWidth and stageHeight:" + stage.stageWidth, stage.stageHeight);
		}
		
        // public static function copyToBitmap(starling:Starling, displayObject:DisplayObject):BitmapData
		// {
		//     var bounds:Rectangle = displayObject.getBounds(displayObject);
		//     var result:BitmapData = new BitmapData(bounds.width * Starling.contentScaleFactor, bounds.height * Starling.contentScaleFactor, true);
		//     var stage:Stage = starling.stage;
		//     var painter:Painter = starling.painter;

		//     painter.pushState();
		//     painter.state.renderTarget = null;
		//     painter.state.setProjectionMatrix(bounds.x, bounds.y, stage.stageWidth, stage.stageHeight, stage.stageWidth, stage.stageHeight, stage.cameraPosition);
		//     painter.clear();
		//     displayObject.setRequiresRedraw();
		//     displayObject.render(painter);
		//     painter.finishMeshBatch();
		//     painter.context.drawToBitmapData(result);
		//     painter.context.present();
		//     painter.popState();

		//     return result;
		// }


	}
}