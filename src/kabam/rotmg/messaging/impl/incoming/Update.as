// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.incoming.Update

package kabam.rotmg.messaging.impl.incoming
{
    import __AS3__.vec.Vector;
    import kabam.rotmg.messaging.impl.data.GroundTileData;
    import kabam.rotmg.messaging.impl.data.ObjectData;
    import kabam.rotmg.messaging.impl.data.CompressedInt;
    import com.company.assembleegameclient.util.FreeList;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    public class Update extends IncomingMessage 
    {

        public var tiles_:Vector.<GroundTileData> = new Vector.<GroundTileData>();
        public var newObjs_:Vector.<ObjectData> = new Vector.<ObjectData>();
        public var drops_:Vector.<int> = new Vector.<int>();

        public function Update(_arg_1:uint, _arg_2:Function)
        {
            super(_arg_1, _arg_2);
        }

        override public function parseFromInput(_arg_1:IDataInput):void
        {
            var _local_2:int;
            var _local_3:int = CompressedInt.Read(_arg_1);
            _local_2 = _local_3;
            while (_local_2 < this.tiles_.length)
            {
                FreeList.deleteObject(this.tiles_[_local_2]);
                _local_2++;
            };
            this.tiles_.length = Math.min(_local_3, this.tiles_.length);
            while (this.tiles_.length < _local_3)
            {
                this.tiles_.push((FreeList.newObject(GroundTileData) as GroundTileData));
            };
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                this.tiles_[_local_2].parseFromInput(_arg_1);
                _local_2++;
            };
            this.newObjs_.length = 0;
            _local_3 = CompressedInt.Read(_arg_1);
            _local_2 = _local_3;
            while (_local_2 < this.newObjs_.length)
            {
                FreeList.deleteObject(this.newObjs_[_local_2]);
                _local_2++;
            };
            this.newObjs_.length = Math.min(_local_3, this.newObjs_.length);
            while (this.newObjs_.length < _local_3)
            {
                this.newObjs_.push((FreeList.newObject(ObjectData) as ObjectData));
            };
            _local_2 = 0;
            while (_local_2 < _local_3)
            {
                this.newObjs_[_local_2].parseFromInput(_arg_1);
                _local_2++;
            };
            this.drops_.length = 0;
            var _local_4:int = CompressedInt.Read(_arg_1);
            _local_2 = 0;
            while (_local_2 < _local_4)
            {
                this.drops_.push(CompressedInt.Read(_arg_1));
                _local_2++;
            };
        }

        override public function toString():String
        {
            return (formatToString("UPDATE", "tiles_", "newObjs_", "drops_"));
        }


    }
}//package kabam.rotmg.messaging.impl.incoming

