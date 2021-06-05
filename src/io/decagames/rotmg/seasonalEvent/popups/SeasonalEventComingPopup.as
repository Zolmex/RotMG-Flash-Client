// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.popups.SeasonalEventComingPopup

package io.decagames.rotmg.seasonalEvent.popups
{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import io.decagames.rotmg.utils.date.TimeLeft;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.text.TextFieldAutoSize;

    public class SeasonalEventComingPopup extends ModalPopup 
    {

        private const WIDTH:int = 330;
        private const HEIGHT:int = 100;

        private var _okButton:SliceScalingButton;
        private var _scheduledDate:Date;

        public function SeasonalEventComingPopup(_arg_1:Date)
        {
            var _local_2:SliceScalingBitmap;
            super(this.WIDTH, this.HEIGHT, "Seasonal Event coming!", DefaultLabelFormat.defaultSmallPopupTitle);
            this._scheduledDate = _arg_1;
            _local_2 = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration", 186);
            addChild(_local_2);
            _local_2.y = 40;
            _local_2.x = Math.round(((this.WIDTH - _local_2.width) / 2));
            this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._okButton.setLabel("OK", DefaultLabelFormat.questButtonCompleteLabel);
            this._okButton.width = 130;
            this._okButton.x = Math.round(((this.WIDTH - 130) / 2));
            this._okButton.y = 46;
            addChild(this._okButton);
            var _local_3:String = TimeLeft.getStartTimeString(_arg_1);
            var _local_4:UILabel = new UILabel();
            DefaultLabelFormat.defaultSmallPopupTitle(_local_4);
            _local_4.width = this.WIDTH;
            _local_4.autoSize = TextFieldAutoSize.CENTER;
            _local_4.text = ("Seasonal Event starting in: " + _local_3);
            _local_4.y = 10;
            addChild(_local_4);
        }

        public function get okButton():SliceScalingButton
        {
            return (this._okButton);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.popups

