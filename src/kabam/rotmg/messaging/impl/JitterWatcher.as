﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.JitterWatcher

package kabam.rotmg.messaging.impl
{
    import flash.display.Sprite;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import __AS3__.vec.Vector;
    import flash.text.TextFieldAutoSize;
    import flash.filters.DropShadowFilter;
    import flash.events.Event;
    import flash.utils.getTimer;
    import kabam.rotmg.text.model.TextKey;
    import __AS3__.vec.*;

    public class JitterWatcher extends Sprite 
    {

        private static const lineBuilder:LineBuilder = new LineBuilder();

        private var text_:TextFieldDisplayConcrete = null;
        private var lastRecord_:int = -1;
        private var ticks_:Vector.<int> = new Vector.<int>();
        private var sum_:int;

        public function JitterWatcher()
        {
            this.text_ = new TextFieldDisplayConcrete().setSize(14).setColor(0xFFFFFF);
            this.text_.setAutoSize(TextFieldAutoSize.LEFT);
            this.text_.filters = [new DropShadowFilter(0, 0, 0)];
            addChild(this.text_);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        }

        public function record():void
        {
            var _local_3:int;
            var _local_1:int = getTimer();
            if (this.lastRecord_ == -1)
            {
                this.lastRecord_ = _local_1;
                return;
            };
            var _local_2:int = (_local_1 - this.lastRecord_);
            this.ticks_.push(_local_2);
            this.sum_ = (this.sum_ + _local_2);
            if (this.ticks_.length > 50)
            {
                _local_3 = this.ticks_.shift();
                this.sum_ = (this.sum_ - _local_3);
            };
            this.lastRecord_ = _local_1;
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            stage.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }

        private function onEnterFrame(_arg_1:Event):void
        {
            this.text_.setStringBuilder(lineBuilder.setParams(TextKey.JITTERWATCHER_DESC, {"jitter":this.jitter()}));
        }

        private function jitter():Number
        {
            var _local_4:int;
            var _local_1:int = this.ticks_.length;
            if (_local_1 == 0)
            {
                return (0);
            };
            var _local_2:Number = (this.sum_ / _local_1);
            var _local_3:Number = 0;
            for each (_local_4 in this.ticks_)
            {
                _local_3 = (_local_3 + ((_local_4 - _local_2) * (_local_4 - _local_2)));
            };
            return (Math.sqrt((_local_3 / _local_1)));
        }


    }
}//package kabam.rotmg.messaging.impl

