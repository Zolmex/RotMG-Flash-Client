// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.lib.ui.api.Layout

package kabam.lib.ui.api
{
    import __AS3__.vec.Vector;
    import flash.display.DisplayObject;

    public interface Layout 
    {

        function getPadding():int;
        function setPadding(_arg_1:int):void;
        function layout(_arg_1:Vector.<DisplayObject>, _arg_2:int=0):void;

    }
}//package kabam.lib.ui.api

