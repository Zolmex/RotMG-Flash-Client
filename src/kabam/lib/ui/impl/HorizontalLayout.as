// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.lib.ui.impl.HorizontalLayout

package kabam.lib.ui.impl
{
    import kabam.lib.ui.api.Layout;
    import flash.display.DisplayObject;
    

    public class HorizontalLayout implements Layout 
    {

        private var padding:int = 0;


        public function getPadding():int
        {
            return (this.padding);
        }

        public function setPadding(_arg_1:int):void
        {
            this.padding = _arg_1;
        }

        public function layout(_arg_1:Vector.<DisplayObject>, _arg_2:int=0):void
        {
            var _local_6:DisplayObject;
            var _local_3:int = _arg_2;
            var _local_4:int = _arg_1.length;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_6 = _arg_1[_local_5];
                _local_6.x = _local_3;
                _local_3 = (_local_3 + (_local_6.width + this.padding));
                _local_5++;
            }
        }


    }
}//package kabam.lib.ui.impl

