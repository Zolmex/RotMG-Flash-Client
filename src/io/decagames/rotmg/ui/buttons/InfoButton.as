// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.ui.buttons.InfoButton

package io.decagames.rotmg.ui.buttons
{
    import flash.display.Shape;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.display.Graphics;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;

    public class InfoButton extends BaseButton 
    {

        private var _background:Shape;
        private var _label:UILabel;
        private var _radius:int;

        public function InfoButton(_arg_1:int)
        {
            this._radius = _arg_1;
            this.init();
        }

        private function init():void
        {
            this.createBackground();
            this.createLabel();
            this.buttonMode = true;
        }

        private function createBackground():void
        {
            this._background = new Shape();
            var _local_1:Graphics = this._background.graphics;
            _local_1.beginFill(0xFFFFFF);
            _local_1.drawCircle(0, 0, this._radius);
            addChild(this._background);
        }

        private function createLabel():void
        {
            this._label = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._label, 16, 0xFF, TextFormatAlign.CENTER, true);
            this._label.text = "i";
            this._label.x = ((-(this._radius) / 2) + 1);
            this._label.y = ((-(this._radius) / 2) - 4);
            addChild(this._label);
        }


    }
}//package io.decagames.rotmg.ui.buttons

