// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.greensock.plugins.BlurFilterPlugin

package com.greensock.plugins
{
    import flash.filters.BlurFilter;
    import com.greensock.TweenLite;

    public class BlurFilterPlugin extends FilterPlugin 
    {

        public static const API:Number = 2;
        private static var _propNames:Array = ["blurX", "blurY", "quality"];

        public function BlurFilterPlugin()
        {
            super("blurFilter");
        }

        override public function _onInitTween(_arg_1:Object, _arg_2:*, _arg_3:TweenLite):Boolean
        {
            return (_initFilter(_arg_1, _arg_2, _arg_3, BlurFilter, new BlurFilter(0, 0, ((_arg_2.quality) || (2))), _propNames));
        }


    }
}//package com.greensock.plugins

