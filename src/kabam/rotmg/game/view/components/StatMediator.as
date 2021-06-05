﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.view.components.StatMediator

package kabam.rotmg.game.view.components
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import flash.events.MouseEvent;

    public class StatMediator extends Mediator 
    {

        [Inject]
        public var view:StatView;


        override public function initialize():void
        {
            this.view.mouseOut.add(this.onMouseOut);
            this.view.mouseOver.add(this.onMouseOver);
        }

        override public function destroy():void
        {
            this.view.mouseOut.remove(this.onMouseOut);
            this.view.mouseOver.remove(this.onMouseOver);
            this.view.removeTooltip();
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            this.view.addTooltip();
        }

        private function onMouseOut(_arg_1:MouseEvent):void
        {
            this.view.removeTooltip();
        }


    }
}//package kabam.rotmg.game.view.components

