// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.data.ObjectStatusData

package kabam.rotmg.messaging.impl.data
{
    import __AS3__.vec.Vector;
    import com.company.assembleegameclient.util.FreeList;
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;
    import __AS3__.vec.*;

    public class ObjectStatusData 
    {

        public var objectId_:int;
        public var pos_:WorldPosData = new WorldPosData();
        public var stats_:Vector.<StatData> = new Vector.<StatData>();


        public function parseFromInput(_arg_1:IDataInput):void
        {
            var _local_3:int;
            this.objectId_ = CompressedInt.Read(_arg_1);
            this.pos_.parseFromInput(_arg_1);
            var _local_2:int = CompressedInt.Read(_arg_1);
            _local_3 = _local_2;
            while (_local_3 < this.stats_.length)
            {
                FreeList.deleteObject(this.stats_[_local_3]);
                _local_3++;
            };
            this.stats_.length = Math.min(_local_2, this.stats_.length);
            while (this.stats_.length < _local_2)
            {
                this.stats_.push((FreeList.newObject(StatData) as StatData));
            };
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                this.stats_[_local_3].parseFromInput(_arg_1);
                _local_3++;
            };
        }

        public function writeToOutput(_arg_1:IDataOutput):void
        {
            _arg_1.writeInt(this.objectId_);
            this.pos_.writeToOutput(_arg_1);
            _arg_1.writeShort(this.stats_.length);
            var _local_2:int;
            while (_local_2 < this.stats_.length)
            {
                this.stats_[_local_2].writeToOutput(_arg_1);
                _local_2++;
            };
        }

        public function toString():String
        {
            return ((((("objectId_: " + this.objectId_) + " pos_: ") + this.pos_) + " stats_: ") + this.stats_);
        }


    }
}//package kabam.rotmg.messaging.impl.data

