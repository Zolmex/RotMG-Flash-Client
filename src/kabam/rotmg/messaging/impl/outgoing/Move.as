// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.outgoing.Move

package kabam.rotmg.messaging.impl.outgoing
{
    import kabam.rotmg.messaging.impl.data.WorldPosData;
    
    import kabam.rotmg.messaging.impl.data.MoveRecord;
    import flash.utils.IDataOutput;
    

    public class Move extends OutgoingMessage 
    {

        public var tickId_:int;
        public var time_:int;
        public var serverRealTimeMSofLastNewTick_:uint;
        public var newPosition_:WorldPosData = new WorldPosData();
        public var records_:Vector.<MoveRecord> = new Vector.<MoveRecord>();

        public function Move(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function writeToOutput(_arg_1:IDataOutput):void
        {
            _arg_1.writeInt(this.tickId_);
            _arg_1.writeInt(this.time_);
            _arg_1.writeUnsignedInt(this.serverRealTimeMSofLastNewTick_);
            this.newPosition_.writeToOutput(_arg_1);
            _arg_1.writeShort(this.records_.length);
            var _local_2:int;
            while (_local_2 < this.records_.length)
            {
                this.records_[_local_2].writeToOutput(_arg_1);
                _local_2++;
            }
        }

        override public function toString():String
        {
            return (formatToString("MOVE", "tickId_", "time_", "newPosition_", "records_"));
        }


    }
}//package kabam.rotmg.messaging.impl.outgoing

