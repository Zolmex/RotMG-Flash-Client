// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.unity.popup.UnitySignupConfirmation

package io.decagames.rotmg.unity.popup
{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import flash.text.TextFieldAutoSize;

    public class UnitySignupConfirmation extends ModalPopup 
    {

        private const WIDTH:int = 330;
        private const HEIGHT:int = 100;

        private var _okButton:SliceScalingButton;
        private var _infoText:UILabel;
        private var _message:String;

        public function UnitySignupConfirmation(_arg_1:String)
        {
            super(this.WIDTH, this.HEIGHT, UnitySignUpConstants.TITLE, DefaultLabelFormat.defaultSmallPopupTitle);
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
            _local_1.y = ((this._infoText.y + this._infoText.height) + 14);
            this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._okButton.setLabel("OK", DefaultLabelFormat.questButtonCompleteLabel);
            this._okButton.width = 130;
            this._okButton.x = Math.round(((this.WIDTH - 130) / 2));
            this._okButton.y = ((this._infoText.y + this._infoText.height) + 20);
            addChild(this._okButton);
        }

        private function createLabel():void
        {
            this._infoText = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._infoText, 14, 0xFFFFFF, TextFieldAutoSize.CENTER);
            this._infoText.width = this.WIDTH;
            this._infoText.multiline = true;
            this._infoText.wordWrap = true;
            this._infoText.text = this._message;
            this._infoText.y = 10;
            addChild(this._infoText);
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
}//package io.decagames.rotmg.unity.popup

