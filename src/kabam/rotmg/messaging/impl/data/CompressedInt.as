// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.messaging.impl.data.CompressedInt

package kabam.rotmg.messaging.impl.data
{
    import flash.utils.IDataInput;

    public class CompressedInt 
    {


        public static function Read(_arg_1:IDataInput):int
        {
            var _local_2:int;
            var _local_3:int = _arg_1.readUnsignedByte();
            var _local_4:* = (!((_local_3 & 0x40) == 0));
            var _local_5:int = 6;
            _local_2 = (_local_3 & 0x3F);
            while ((_local_3 & 0x80))
            {
                _local_3 = _arg_1.readUnsignedByte();
                _local_2 = (_local_2 | ((_local_3 & 0x7F) << _local_5));
                _local_5 = (_local_5 + 7);
            };
            if (_local_4)
            {
                _local_2 = -(_local_2);
            };
            return (_local_2);
        }


    }
}//package kabam.rotmg.messaging.impl.data

