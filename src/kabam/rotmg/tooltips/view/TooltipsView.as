﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.tooltips.view.TooltipsView

package kabam.rotmg.tooltips.view
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;

    public class TooltipsView extends Sprite 
    {

        private var toolTip:DisplayObject;


        public function show(_arg_1:DisplayObject):void
        {
            this.hide();
            this.toolTip = _arg_1;
            if (_arg_1)
            {
                addChild(_arg_1);
            }
        }

        public function hide():void
        {
            if (((this.toolTip) && (this.toolTip.parent)))
            {
                this.toolTip.parent.removeChild(this.toolTip);
            }
            this.toolTip = null;
        }


    }
}//package kabam.rotmg.tooltips.view

