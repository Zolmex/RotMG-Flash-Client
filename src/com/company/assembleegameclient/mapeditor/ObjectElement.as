// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.mapeditor.ObjectElement

package com.company.assembleegameclient.mapeditor
{
    import com.company.assembleegameclient.mapeditor.Element;
    import com.company.assembleegameclient.objects.animation.Animations;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.objects.ObjectLibrary;
    import com.company.assembleegameclient.objects.animation.AnimationsData;
    import com.company.assembleegameclient.mapeditor.ObjectTypeToolTip;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import com.company.assembleegameclient.mapeditor.*;

    internal class ObjectElement extends Element 
    {

        public var objXML_:XML;

        public function ObjectElement(_arg_1:XML)
        {
            var _local_3:Animations;
            var _local_5:Bitmap;
            var _local_7:BitmapData;
            super(int(_arg_1.@type));
            this.objXML_ = _arg_1;
            var _local_2:BitmapData = ObjectLibrary.getRedrawnTextureFromType(type_, 100, true, false);
            var _local_4:AnimationsData = ObjectLibrary.typeToAnimationsData_[int(_arg_1.@type)];
            if (_local_4 != null)
            {
                _local_3 = new Animations(_local_4);
                _local_7 = _local_3.getTexture(0.4);
                if (_local_7 != null)
                {
                    _local_2 = _local_7;
                };
            };
            _local_5 = new Bitmap(_local_2);
            var _local_6:Number = ((WIDTH - 4) / Math.max(_local_5.width, _local_5.height));
            _local_5.scaleX = (_local_5.scaleY = _local_6);
            _local_5.x = ((WIDTH / 2) - (_local_5.width / 2));
            _local_5.y = ((HEIGHT / 2) - (_local_5.height / 2));
            addChild(_local_5);
        }

        override protected function getToolTip():ToolTip
        {
            return (new ObjectTypeToolTip(this.objXML_));
        }

        override public function get objectBitmap():BitmapData
        {
            return (ObjectLibrary.getRedrawnTextureFromType(type_, 200, true, false));
        }


    }
}//package com.company.assembleegameclient.mapeditor

