// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.supportCampaign.tab.donate.popup.DonateConfirmationPopup

package io.decagames.rotmg.supportCampaign.tab.donate.popup
{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.shop.ShopBuyButton;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import io.decagames.rotmg.ui.texture.TextureParser;

    public class DonateConfirmationPopup extends ModalPopup 
    {

        private var _donateButton:ShopBuyButton;
        private var supportIcon:SliceScalingBitmap;
        private var _gold:int;

        public function DonateConfirmationPopup(_arg_1:int, _arg_2:int)
        {
            var _local_6:SliceScalingBitmap;
            super(240, 130, "Boost");
            this._gold = _arg_1;
            var _local_3:UILabel = new UILabel();
            _local_3.text = "You will receive:";
            DefaultLabelFormat.createLabelFormat(_local_3, 14, 0x999999, TextFormatAlign.CENTER, false);
            _local_3.wordWrap = true;
            _local_3.width = _contentWidth;
            _local_3.y = 5;
            addChild(_local_3);
            this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI", "campaign_Points");
            addChild(this.supportIcon);
            var _local_4:UILabel = new UILabel();
            _local_4.text = _arg_2.toString();
            DefaultLabelFormat.createLabelFormat(_local_4, 22, 15585539, TextFormatAlign.CENTER, true);
            _local_4.x = (((_contentWidth / 2) - (_local_4.width / 2)) - 10);
            _local_4.y = 25;
            addChild(_local_4);
            this.supportIcon.y = (_local_4.y + 3);
            this.supportIcon.x = (_local_4.x + _local_4.width);
            var _local_5:UILabel = new UILabel();
            _local_5.text = "Bonus Points";
            DefaultLabelFormat.createLabelFormat(_local_5, 14, 0x999999, TextFormatAlign.CENTER, false);
            _local_5.wordWrap = true;
            _local_5.width = _contentWidth;
            _local_5.y = 50;
            addChild(_local_5);
            _local_6 = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration", 148);
            addChild(_local_6);
            this._donateButton = new ShopBuyButton(_arg_1);
            this._donateButton.width = (_local_6.width - 45);
            addChild(this._donateButton);
            _local_6.y = (_contentHeight - 50);
            _local_6.x = Math.round(((_contentWidth - _local_6.width) / 2));
            this._donateButton.y = (_local_6.y + 6);
            this._donateButton.x = (_local_6.x + 22);
        }

        public function get donateButton():ShopBuyButton
        {
            return (this._donateButton);
        }

        public function get gold():int
        {
            return (this._gold);
        }


    }
}//package io.decagames.rotmg.supportCampaign.tab.donate.popup

