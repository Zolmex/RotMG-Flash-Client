// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.StatusFlashDescription

package com.company.assembleegameclient.objects
{
    import flash.display.BitmapData;
    import flash.geom.ColorTransform;
    import kabam.rotmg.stage3D.GraphicsFillExtra;

    public class StatusFlashDescription 
    {

        public var startTime_:int;
        public var color_:uint;
        public var periodMS_:int;
        public var repeats_:int;
        public var duration_:int;
        public var percentDone:Number;
        public var curTime:Number;
        public var targetR:int;
        public var targetG:int;
        public var targetB:int;

        public function StatusFlashDescription(_arg_1:int, _arg_2:uint, _arg_3:int)
        {
            this.startTime_ = _arg_1;
            this.color_ = _arg_2;
            this.duration_ = (_arg_3 * 1000);
            this.targetR = ((_arg_2 >> 16) & 0xFF);
            this.targetG = ((_arg_2 >> 8) & 0xFF);
            this.targetB = (_arg_2 & 0xFF);
            this.curTime = 0;
        }

        public function apply(_arg_1:BitmapData, _arg_2:int):BitmapData
        {
            var _local_3:BitmapData = _arg_1.clone();
            var _local_4:int = ((_arg_2 - this.startTime_) % this.duration_);
            var _local_5:Number = Math.abs(Math.sin((((_local_4 / this.duration_) * Math.PI) * (this.percentDone * 10))));
            var _local_6:Number = (_local_5 * 0.5);
            var _local_7:ColorTransform = new ColorTransform((1 - _local_6), (1 - _local_6), (1 - _local_6), 1, (_local_6 * this.targetR), (_local_6 * this.targetG), (_local_6 * this.targetB), 0);
            _local_3.colorTransform(_local_3.rect, _local_7);
            return (_local_3);
        }

        public function applyGPUTextureColorTransform(_arg_1:BitmapData, _arg_2:int):void
        {
            var _local_3:int = ((_arg_2 - this.startTime_) % this.duration_);
            var _local_4:Number = Math.abs(Math.sin((((_local_3 / this.duration_) * Math.PI) * (this.percentDone * 10))));
            var _local_5:Number = (_local_4 * 0.5);
            var _local_6:ColorTransform = new ColorTransform((1 - _local_5), (1 - _local_5), (1 - _local_5), 1, (_local_5 * this.targetR), (_local_5 * this.targetG), (_local_5 * this.targetB), 0);
            GraphicsFillExtra.setColorTransform(_arg_1, _local_6);
        }

        public function doneAt(_arg_1:int):Boolean
        {
            this.percentDone = (this.curTime / this.duration_);
            this.curTime = (_arg_1 - this.startTime_);
            return (this.percentDone > 1);
        }


    }
}//package com.company.assembleegameclient.objects

