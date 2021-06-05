// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.tooltip.IconToolTip

package com.company.assembleegameclient.ui.tooltip
{
    import flash.display.Bitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormat;

    public class IconToolTip extends ToolTip 
    {

        private var _title:String;
        private var _toolTipText:String;
        private var _icon:Bitmap;
        private var _titleLabel:UILabel;
        private var _tipLabel:UILabel;

        public function IconToolTip(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Number, _arg_5:uint, _arg_6:Number, _arg_7:Boolean=true, _arg_8:Bitmap=null)
        {
            super(_arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
            this._title = _arg_1;
            this._toolTipText = _arg_2;
            this._icon = _arg_8;
            this.init();
        }

        public function positionIcon(_arg_1:int, _arg_2:int):void
        {
            if (!this._icon)
            {
                return;
            };
            this._icon.x = _arg_1;
            this._icon.y = _arg_2;
            addChild(this._icon);
            draw();
        }

        private function init():void
        {
            this.createTitleLabel();
            this.createTipLabel();
            if (this._icon)
            {
                this.positionIcon((width - (this._icon.width / 2)), (((height / 2) - (this._icon.height / 2)) + 3));
            };
        }

        private function createTitleLabel():void
        {
            this._titleLabel = new UILabel();
            this._titleLabel.text = this._title;
            DefaultLabelFormat.defaultModalTitle(this._titleLabel);
            addChild(this._titleLabel);
        }

        private function createTipLabel():void
        {
            this._tipLabel = new UILabel();
            this._tipLabel.text = this._toolTipText;
            DefaultLabelFormat.defaultTextModalText(this._tipLabel);
            var _local_1:TextFormat = this._tipLabel.getTextFormat();
            _local_1.color = 0xB3B3B3;
            this._tipLabel.setTextFormat(_local_1);
            this._tipLabel.y = (this._titleLabel.y + this._titleLabel.height);
            addChild(this._tipLabel);
            draw();
        }


    }
}//package com.company.assembleegameclient.ui.tooltip

