// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.panels.Panel

package com.company.assembleegameclient.ui.panels
{
    import flash.display.Sprite;
    import com.company.assembleegameclient.game.AGameSprite;

    public class Panel extends Sprite 
    {

        public static const WIDTH:int = (200 - 12);//188
        public static const HEIGHT:int = (100 - 16);//84

        public var gs_:AGameSprite;

        public function Panel(_arg_1:AGameSprite)
        {
            this.gs_ = _arg_1;
        }

        public function draw():void
        {
        }


    }
}//package com.company.assembleegameclient.ui.panels

