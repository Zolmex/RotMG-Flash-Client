// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.popup.DailyQuestExpiredPopup

package io.decagames.rotmg.dailyQuests.view.popup
{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import io.decagames.rotmg.ui.texture.TextureParser;

    public class DailyQuestExpiredPopup extends ModalPopup 
    {

        private const TITLE:String = "Event Quest Expired";
        private const TEXT:String = "Sorry, this Quest has expired.";
        private const WIDTH:int = 300;
        private const HEIGHT:int = 100;

        private var _okButton:SliceScalingButton;

        public function DailyQuestExpiredPopup()
        {
            super(this.WIDTH, this.HEIGHT, this.TITLE);
            this.init();
        }

        private function init():void
        {
            var _local_1:UILabel;
            _local_1 = new UILabel();
            _local_1.width = 250;
            _local_1.multiline = true;
            _local_1.wordWrap = true;
            _local_1.text = this.TEXT;
            DefaultLabelFormat.defaultSmallPopupTitle(_local_1, TextFormatAlign.CENTER);
            _local_1.x = ((this.WIDTH - _local_1.width) / 2);
            _local_1.y = 10;
            addChild(_local_1);
            this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._okButton.setLabel("OK", DefaultLabelFormat.questButtonCompleteLabel);
            this._okButton.width = 149;
            this._okButton.x = ((this.WIDTH - this._okButton.width) / 2);
            this._okButton.y = (((this.HEIGHT - this._okButton.height) / 2) + 10);
            addChild(this._okButton);
        }

        public function get okButton():SliceScalingButton
        {
            return (this._okButton);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.popup

