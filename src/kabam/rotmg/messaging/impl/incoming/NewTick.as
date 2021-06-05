﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.incoming.NewTick

package kabam.rotmg.messaging.impl.incoming
{
    import __AS3__.vec.Vector;
    import kabam.rotmg.messaging.impl.data.ObjectStatusData;
    import com.company.assembleegameclient.util.FreeList;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    public class NewTick extends IncomingMessage 
    {

        public var tickId_:int;
        public var tickTime_:int;
        public var serverRealTimeMS_:uint;
        public var serverLastRTTMS_:uint;
        public var statuses_:Vector.<ObjectStatusData> = new Vector.<ObjectStatusData>();

        public function NewTick(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            var _local_3:int;
            this.tickId_ = _arg_1.readInt();
            this.tickTime_ = _arg_1.readInt();
            this.serverRealTimeMS_ = _arg_1.readUnsignedInt();
            this.serverLastRTTMS_ = _arg_1.readUnsignedShort();
            var _local_2:int = _arg_1.readShort();
            _local_3 = _local_2;
            while (_local_3 < this.statuses_.length)
            {
                FreeList.deleteObject(this.statuses_[_local_3]);
                _local_3++;
            };
            this.statuses_.length = Math.min(_local_2, this.statuses_.length);
            while (this.statuses_.length < _local_2)
            {
                this.statuses_.push((FreeList.newObject(ObjectStatusData) as ObjectStatusData));
            };
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                this.statuses_[_local_3].parseFromInput(_arg_1);
                _local_3++;
            };
        }

        override public function toString():String
        {
            return (formatToString("NEW_TICK", "tickId_", "tickTime_", "statuses_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

