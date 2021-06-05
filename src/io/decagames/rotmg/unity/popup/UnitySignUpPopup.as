// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.unity.popup.UnitySignUpPopup

package io.decagames.rotmg.unity.popup
{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFieldType;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.texture.TextureParser;

    public class UnitySignUpPopup extends ModalPopup 
    {

        private const WIDTH:int = 450;
        private const HEIGHT:int = 300;
        private const MARGIN:int = 10;

        private var _submitButton:SliceScalingButton;
        private var _cancelButton:SliceScalingButton;
        private var _buttonContainer:Sprite;
        private var _checkBox:CheckBox;
        private var _infoText:UILabel;
        private var _optionsText:UILabel;
        private var _errorText:UILabel;
        private var _emailInputField:UILabel;
        private var _emailInputFieldLabel:UILabel;

        public function UnitySignUpPopup()
        {
            super(this.WIDTH, this.HEIGHT, UnitySignUpConstants.TITLE, DefaultLabelFormat.defaultMediumPopupTitle);
            this.init();
        }

        private function init():void
        {
            this.createContentInset();
            this.createInfoLabel();
            this.createEmailInputField();
            this.createCheckBox();
            this.createOptionsLabel();
            this.createErrorField();
            this.createButtons();
        }

        private function createOptionsLabel():void
        {
            this._optionsText = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._optionsText, 12, 0xB3B3B3);
            this._optionsText.autoSize = TextFieldAutoSize.LEFT;
            this._optionsText.multiline = true;
            this._optionsText.wordWrap = true;
            this._optionsText.width = (this.WIDTH - (2 * this.MARGIN));
            this._optionsText.text = UnitySignUpConstants.OPTIONS_TEXT;
            this._optionsText.x = (2 * this.MARGIN);
            this._optionsText.y = ((this._checkBox.y + this._checkBox.height) + this.MARGIN);
            addChild(this._optionsText);
        }

        private function createErrorField():void
        {
            this._errorText = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._errorText, 12, 0xFF0000);
            this._errorText.autoSize = TextFieldAutoSize.LEFT;
            this._errorText.multiline = true;
            this._errorText.wordWrap = true;
            this._errorText.width = (this.WIDTH - (2 * this.MARGIN));
            this._errorText.x = (2 * this.MARGIN);
            this._errorText.y = (this.HEIGHT - 70);
            addChild(this._errorText);
        }

        private function createEmailInputField():void
        {
            this._emailInputFieldLabel = new UILabel();
            DefaultLabelFormat.defaultSmallPopupTitle(this._emailInputFieldLabel);
            this._emailInputFieldLabel.text = UnitySignUpConstants.EMAIL_LABEL;
            this._emailInputFieldLabel.x = (2 * this.MARGIN);
            this._emailInputFieldLabel.y = ((this._infoText.y + this._infoText.height) + this.MARGIN);
            addChild(this._emailInputFieldLabel);
            this._emailInputField = new UILabel();
            this._emailInputField.type = TextFieldType.INPUT;
            DefaultLabelFormat.createLabelFormat(this._emailInputField, 14);
            this._emailInputField.autoSize = TextFieldAutoSize.NONE;
            this._emailInputField.border = true;
            this._emailInputField.borderColor = 0xB3B3B3;
            this._emailInputField.background = true;
            this._emailInputField.backgroundColor = 0x333333;
            this._emailInputField.width = (this.WIDTH - (4 * this.MARGIN));
            this._emailInputField.height = 18;
            this._emailInputField.text = UnitySignUpConstants.EMAIL_DEFAULT;
            this._emailInputField.x = (2 * this.MARGIN);
            this._emailInputField.y = (this._emailInputFieldLabel.y + this._emailInputFieldLabel.height);
            addChild(this._emailInputField);
        }

        private function createCheckBox():void
        {
            this._checkBox = new CheckBox(UnitySignUpConstants.CHECK_BOX_LABEL, false, 12, 10);
            this._checkBox.text_.setTextWidth(300);
            this._checkBox.x = (2 * this.MARGIN);
            this._checkBox.y = ((this._emailInputField.y + this._emailInputField.height) + this.MARGIN);
            addChild(this._checkBox);
        }

        private function createInfoLabel():void
        {
            this._infoText = new UILabel();
            DefaultLabelFormat.defaultSmallPopupTitle(this._infoText);
            this._infoText.autoSize = TextFieldAutoSize.LEFT;
            this._infoText.multiline = true;
            this._infoText.wordWrap = true;
            this._infoText.width = (this.WIDTH - (2 * this.MARGIN));
            this._infoText.htmlText = UnitySignUpConstants.TEXT;
            this._infoText.x = this.MARGIN;
            this._infoText.y = this.MARGIN;
            addChild(this._infoText);
        }

        private function createButtons():void
        {
            var _local_1:SliceScalingBitmap;
            this._buttonContainer = new Sprite();
            _local_1 = this.createButtonDecoration();
            _local_1.y = -3;
            this._buttonContainer.addChild(_local_1);
            this._cancelButton = this.createButton();
            this._cancelButton.setLabel("Cancel", DefaultLabelFormat.questButtonCompleteLabel);
            this._cancelButton.width = 130;
            this._cancelButton.x = 19;
            this._buttonContainer.addChild(this._cancelButton);
            var _local_2:SliceScalingBitmap = this.createButtonDecoration();
            _local_2.x = ((_local_1.x + _local_1.width) + this.MARGIN);
            _local_2.y = _local_1.y;
            this._buttonContainer.addChild(_local_2);
            this._submitButton = this.createButton();
            this._submitButton.setLabel("Submit", DefaultLabelFormat.questButtonCompleteLabel);
            this._submitButton.width = 130;
            this._submitButton.x = (_local_2.x + 19);
            this._buttonContainer.addChild(this._submitButton);
            this._buttonContainer.x = ((this.WIDTH - this._buttonContainer.width) / 2);
            this._buttonContainer.y = (this.HEIGHT - 38);
            addChild(this._buttonContainer);
        }

        private function createButtonDecoration():SliceScalingBitmap
        {
            var _local_1:SliceScalingBitmap = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration", 186);
            _local_1.scaleX = 0.9;
            _local_1.scaleY = 0.9;
            return (_local_1);
        }

        private function createButton():SliceScalingButton
        {
            return (new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button")));
        }

        private function createContentInset():void
        {
            var _local_1:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", this.WIDTH);
            _local_1.height = (this.HEIGHT - 50);
            addChild(_local_1);
        }

        public function get submitButton():SliceScalingButton
        {
            return (this._submitButton);
        }

        public function get cancelButton():SliceScalingButton
        {
            return (this._cancelButton);
        }

        public function get checkBox():CheckBox
        {
            return (this._checkBox);
        }

        public function get emailInputField():UILabel
        {
            return (this._emailInputField);
        }

        public function get errorText():UILabel
        {
            return (this._errorText);
        }


    }
}//package io.decagames.rotmg.unity.popup

