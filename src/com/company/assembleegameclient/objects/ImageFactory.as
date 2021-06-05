// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.ImageFactory

package com.company.assembleegameclient.objects
{
    import com.company.util.AssetLibrary;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.util.TextureRedrawer;

    public class ImageFactory 
    {


        public function getImageFromSet(_arg_1:String, _arg_2:int):BitmapData
        {
            return (AssetLibrary.getImageFromSet(_arg_1, _arg_2));
        }

        public function getTexture(_arg_1:int, _arg_2:int):BitmapData
        {
            var _local_4:Number;
            var _local_5:BitmapData;
            var _local_3:BitmapData = ObjectLibrary.getBitmapData(_arg_1);
            if (_local_3)
            {
                _local_4 = ((_arg_2 - TextureRedrawer.minSize) / _local_3.width);
                _local_5 = ObjectLibrary.getRedrawnTextureFromType(_arg_1, 100, true, false, _local_4);
                return (_local_5);
            };
            return (new BitmapDataSpy(_arg_2, _arg_2));
        }


    }
}//package com.company.assembleegameclient.objects

