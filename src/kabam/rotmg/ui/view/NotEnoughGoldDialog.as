// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.ui.view.NotEnoughGoldDialog

package kabam.rotmg.ui.view
{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import io.decagames.rotmg.ui.texture.TextureParser;

    public class NotEnoughGoldDialog extends ModalPopup 
    {

        public static const TITLE:String = "Not Enough Gold";
        public static const NOT_ENOUGH_TEXT:String = "You do not have enough Gold for this item. Would you like to buy Gold?";
        public static const BUTTON_WIDTH:int = 120;
        public static const WIDTH:int = 300;
        public static const HEIGHT:int = 100;
        public static const TRACKING_TAG:String = "/notEnoughGold";

        private var _textText_:TextFieldDisplayConcrete;
        private var _notEnoughText:UILabel;
        private var _cancel:SliceScalingButton;
        private var _buyGold:SliceScalingButton;

        public function NotEnoughGoldDialog()
        {
            super(WIDTH, HEIGHT, TITLE, DefaultLabelFormat.defaultModalTitle);
            this.init();
        }

        public function setTextParams(_arg_1:String, _arg_2:Object):void
        {
            this._textText_.setStringBuilder(new LineBuilder().setParams(_arg_1, _arg_2));
            this._notEnoughText.text = this._textText_.getText();
        }

        private function init():void
        {
            this.createNotEnoughText();
            this.createButtons();
        }

        private function createNotEnoughText():void
        {
            this._notEnoughText = new UILabel();
            this._notEnoughText.width = 280;
            this._notEnoughText.multiline = true;
            this._notEnoughText.wordWrap = true;
            this._notEnoughText.text = NOT_ENOUGH_TEXT;
            DefaultLabelFormat.defaultTextModalText(this._notEnoughText);
            this._notEnoughText.x = ((WIDTH - this._notEnoughText.width) / 2);
            this._notEnoughText.y = 8;
            addChild(this._notEnoughText);
        }

        private function createButtons():void
        {
            this._cancel = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button", 32));
            this._cancel.width = BUTTON_WIDTH;
            this._cancel.setLabel("Cancel", DefaultLabelFormat.defaultButtonLabel);
            this._cancel.x = 20;
            this._cancel.y = ((HEIGHT - this._cancel.height) - 10);
            super.registerButton(this._cancel);
            super.addChild(this._cancel);
            this._buyGold = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button", 32));
            this._buyGold.setLabel("Buy Gold", DefaultLabelFormat.defaultButtonLabel);
            this._buyGold.width = BUTTON_WIDTH;
            this._buyGold.x = ((WIDTH - this._buyGold.width) - 20);
            this._buyGold.y = ((HEIGHT - this._buyGold.height) - 10);
            super.registerButton(this._buyGold);
            super.addChild(this._buyGold);
        }

        public function get cancel():SliceScalingButton
        {
            return (this._cancel);
        }

        public function get buyGold():SliceScalingButton
        {
            return (this._buyGold);
        }


    }
}//package kabam.rotmg.ui.view

