// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.util.SpriteUtil

package com.company.util
{
    import flash.display.DisplayObjectContainer;
    import flash.display.DisplayObject;

    public class SpriteUtil 
    {


        public static function safeAddChild(_arg_1:DisplayObjectContainer, _arg_2:DisplayObject):void
        {
            if ((((!(_arg_1 == null)) && (!(_arg_2 == null))) && (!(_arg_1.contains(_arg_2)))))
            {
                _arg_1.addChild(_arg_2);
            };
        }

        public static function safeRemoveChild(_arg_1:DisplayObjectContainer, _arg_2:DisplayObject):void
        {
            if ((((!(_arg_1 == null)) && (!(_arg_2 == null))) && (_arg_1.contains(_arg_2))))
            {
                _arg_1.removeChild(_arg_2);
            };
        }


    }
}//package com.company.util

