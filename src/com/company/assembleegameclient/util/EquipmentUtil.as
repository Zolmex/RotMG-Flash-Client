// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.util.EquipmentUtil

package com.company.assembleegameclient.util
{
    import flash.display.Bitmap;
    import kabam.rotmg.constants.ItemConstants;
    import flash.display.BitmapData;

    public class EquipmentUtil 
    {

        public static const NUM_SLOTS:uint = 4;


        public static function getEquipmentBackground(_arg_1:int, _arg_2:Number=1):Bitmap
        {
            var _local_3:Bitmap;
            var _local_4:BitmapData = ItemConstants.itemTypeToBaseSprite(_arg_1);
            if (_local_4 != null)
            {
                _local_3 = new Bitmap(_local_4);
                _local_3.scaleX = _arg_2;
                _local_3.scaleY = _arg_2;
            };
            return (_local_3);
        }


    }
}//package com.company.assembleegameclient.util

