// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.popups.SeasonalEventErrorPopup

package io.decagames.rotmg.seasonalEvent.popups
{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import flash.text.TextFieldAutoSize;

    public class SeasonalEventErrorPopup extends ModalPopup 
    {

        private const WIDTH:int = 330;
        private const HEIGHT:int = 100;

        private var _okButton:SliceScalingButton;
        private var _errorText:UILabel;
        private var _message:String;

        public function SeasonalEventErrorPopup(_arg_1:String)
        {
            super(this.WIDTH, this.HEIGHT, "Seasonal Event!", DefaultLabelFormat.defaultSmallPopupTitle);
            this._message = _arg_1;
            this.init();
        }

        private function init():void
        {
            this.createLabel();
            this.createButton();
        }

        private function createButton():void
        {
            var _local_1:SliceScalingBitmap;
            _local_1 = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration", 186);
            addChild(_local_1);
            _local_1.x = Math.round(((this.WIDTH - _local_1.width) / 2));
            _local_1.y = ((this._errorText.y + this._errorText.height) + 4);
            this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._okButton.setLabel("OK", DefaultLabelFormat.questButtonCompleteLabel);
            this._okButton.width = 130;
            this._okButton.x = Math.round(((this.WIDTH - 130) / 2));
            this._okButton.y = ((this._errorText.y + this._errorText.height) + 10);
            addChild(this._okButton);
        }

        private function createLabel():void
        {
            this._errorText = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._errorText, 14, 0xFFFFFF, TextFieldAutoSize.CENTER);
            this._errorText.width = this.WIDTH;
            this._errorText.multiline = true;
            this._errorText.wordWrap = true;
            this._errorText.text = this._message;
            this._errorText.y = 10;
            addChild(this._errorText);
        }

        public function get okButton():SliceScalingButton
        {
            return (this._okButton);
        }

        public function get message():String
        {
            return (this._message);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.popups

