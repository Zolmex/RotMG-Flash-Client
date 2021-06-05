﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.lib.resizing.view.ResizableMediator

package kabam.lib.resizing.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.lib.resizing.signals.Resize;
    import flash.display.DisplayObject;
    import flash.display.Stage;
    import flash.geom.Rectangle;

    public class ResizableMediator extends Mediator 
    {

        [Inject]
        public var view:Resizable;
        [Inject]
        public var resize:Resize;


        override public function initialize():void
        {
            var _local_1:Stage = (this.view as DisplayObject).stage;
            var _local_2:Rectangle = new Rectangle(0, 0, _local_1.stageWidth, _local_1.stageHeight);
            this.resize.add(this.onResize);
            this.view.resize(_local_2);
        }

        override public function destroy():void
        {
            this.resize.remove(this.onResize);
        }

        private function onResize(_arg_1:Rectangle):void
        {
            this.view.resize(_arg_1);
        }


    }
}//package kabam.lib.resizing.view

