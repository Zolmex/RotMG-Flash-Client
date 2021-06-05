// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.supportCampaign.tab.donate.DonatePanel

package io.decagames.rotmg.supportCampaign.tab.donate
{
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import flash.display.Bitmap;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import flash.text.TextFieldType;
    import io.decagames.rotmg.utils.colors.GreyScale;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import kabam.rotmg.assets.services.IconFactory;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;

    public class DonatePanel extends Sprite 
    {

        private var _mainContent:Sprite;
        private var _donationContent:Sprite;
        private var _completedContent:Sprite;
        private var _downArrow:SliceScalingButton;
        private var _upArrow:SliceScalingButton;
        private var _donateButton:SliceScalingButton;
        private var _amountTextfield:UILabel;
        private var pointAmountTextfield:UILabel;
        private var completeTextfield:UILabel;
        private var supportIcon:SliceScalingBitmap;
        private var leftPanel:SliceScalingBitmap;
        private var rightPanel:SliceScalingBitmap;
        private var _ratio:int;
        private var _isEnded:Boolean;
        private var _coinBitmap:Bitmap;

        public function DonatePanel(_arg_1:int, _arg_2:Boolean)
        {
            this._ratio = _arg_1;
            this._isEnded = _arg_2;
            this.init();
        }

        private function init():void
        {
            this.createContainers();
            if (!this._isEnded)
            {
                this.createPanels();
                this.createArrows();
                this.createCoinBitmap();
                this.createAmountTextField();
                this.createPointsAmountTextField();
                this.createSupportIcon();
                this.createDonateButton();
                this.updatePoints((SupporterCampaignModel.DEFAULT_DONATE_AMOUNT * this._ratio));
                if (this._ratio == 0)
                {
                    this.disableElements();
                };
            }
            else
            {
                this.createCompleteTextField();
            };
        }

        private function disableElements():void
        {
            this._upArrow.disabled = true;
            this._downArrow.disabled = true;
            this._amountTextfield.text = "0";
            this._amountTextfield.type = TextFieldType.DYNAMIC;
            GreyScale.setGreyScale(this._coinBitmap.bitmapData);
            GreyScale.setGreyScale(this.supportIcon.bitmapData);
            this._donateButton.disabled = true;
        }

        private function createContainers():void
        {
            this._mainContent = new Sprite();
            addChild(this._mainContent);
            this._donationContent = new Sprite();
            this._mainContent.addChild(this._donationContent);
            this._completedContent = new Sprite();
            this._mainContent.addChild(this._completedContent);
        }

        private function createPanels():void
        {
            this.leftPanel = TextureParser.instance.getSliceScalingBitmap("UI", "black_field_background", 130);
            this.leftPanel.height = 30;
            this.leftPanel.y = 6;
            this._donationContent.addChild(this.leftPanel);
            this.rightPanel = TextureParser.instance.getSliceScalingBitmap("UI", "black_field_background", 130);
            this.rightPanel.height = 30;
            this.rightPanel.x = 214;
            this.rightPanel.y = 6;
            this._donationContent.addChild(this.rightPanel);
        }

        private function createArrows():void
        {
            var _local_1:SliceScalingBitmap;
            _local_1 = TextureParser.instance.getSliceScalingBitmap("UI", "spinner_up_arrow");
            this._upArrow = new SliceScalingButton(_local_1.clone());
            this._upArrow.x = (this.leftPanel.width - 40);
            this._upArrow.y = (this.leftPanel.y + 2);
            this._donationContent.addChild(this._upArrow);
            this._downArrow = new SliceScalingButton(_local_1.clone());
            this._downArrow.rotation = 180;
            this._downArrow.x = (this._upArrow.x + this._downArrow.width);
            this._downArrow.y = (this.leftPanel.y + 28);
            this._donationContent.addChild(this._downArrow);
        }

        private function createCoinBitmap():void
        {
            this._coinBitmap = new Bitmap(IconFactory.makeCoin());
            this._coinBitmap.y = (this.leftPanel.y + 6);
            this._coinBitmap.x = (this.leftPanel.width - 64);
            this._donationContent.addChild(this._coinBitmap);
        }

        private function createAmountTextField():void
        {
            this._amountTextfield = new UILabel();
            this._amountTextfield.type = TextFieldType.INPUT;
            this._amountTextfield.restrict = "0-9";
            this._amountTextfield.maxChars = SupporterCampaignModel.DONATE_MAX_INPUT_CHARS;
            this._amountTextfield.selectable = true;
            DefaultLabelFormat.donateAmountLabel(this._amountTextfield);
            this._amountTextfield.wordWrap = true;
            this._amountTextfield.width = 52;
            this._amountTextfield.text = SupporterCampaignModel.DEFAULT_DONATE_AMOUNT.toString();
            this._amountTextfield.x = 10;
            this._amountTextfield.y = (this.leftPanel.y + 6);
            this._donationContent.addChild(this._amountTextfield);
        }

        private function createPointsAmountTextField():void
        {
            this.pointAmountTextfield = new UILabel();
            DefaultLabelFormat.createLabelFormat(this.pointAmountTextfield, 18, 15585539, TextFormatAlign.CENTER, true);
            this.pointAmountTextfield.x = (((this.rightPanel.width / 2) - (this.pointAmountTextfield.width / 2)) + 9);
            this.pointAmountTextfield.y = this._amountTextfield.y;
            this._donationContent.addChild(this.pointAmountTextfield);
        }

        private function createSupportIcon():void
        {
            this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI", "campaign_Points");
            this.supportIcon.x = (this.pointAmountTextfield.x + this.pointAmountTextfield.width);
            this.supportIcon.y = (this.pointAmountTextfield.y + 1);
            this._donationContent.addChild(this.supportIcon);
        }

        private function createDonateButton():void
        {
            var _local_1:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "buy_button_background", 119);
            _local_1.x = 112;
            this._donationContent.addChild(_local_1);
            this._donateButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._donateButton.setLabel("Boost", DefaultLabelFormat.defaultButtonLabel);
            this._donateButton.width = (_local_1.width - 14);
            this._donateButton.x = (_local_1.x + 7);
            this._donateButton.y = (_local_1.y + 4);
            this._donateButton.disabled = this._isEnded;
            this._donationContent.addChild(this._donateButton);
        }

        private function createCompleteTextField():void
        {
            this.completeTextfield = new UILabel();
            DefaultLabelFormat.createLabelFormat(this.completeTextfield, 18, 0xFF00, TextFormatAlign.CENTER, true);
            this._completedContent.addChild(this.completeTextfield);
        }

        public function setCompleteText(_arg_1:String):void
        {
            if (!this.completeTextfield)
            {
                this.createCompleteTextField();
            };
            this._donationContent.visible = false;
            this.completeTextfield.text = _arg_1;
            this.completeTextfield.x = Math.round(((this._mainContent.width - this.completeTextfield.width) / 2));
            this.completeTextfield.y = 8;
            this._completedContent.visible = true;
        }

        public function updateDonateAmount():void
        {
            this.updatePoints((int(this._amountTextfield.text) * this._ratio));
        }

        public function addDonateAmount(_arg_1:int):void
        {
            var _local_2:int = (int(this._amountTextfield.text) + _arg_1);
            if (((_local_2.toString().length > SupporterCampaignModel.DONATE_MAX_INPUT_CHARS) || (_local_2 <= 0)))
            {
                return;
            };
            this._amountTextfield.text = _local_2.toString();
            this.updatePoints((_local_2 * this._ratio));
        }

        private function updatePoints(_arg_1:int):void
        {
            this.pointAmountTextfield.text = _arg_1.toString();
            var _local_2:int = 4;
            var _local_3:int = ((this.pointAmountTextfield.width + this.supportIcon.width) + _local_2);
            this.pointAmountTextfield.x = ((this.rightPanel.x + Math.round(((this.rightPanel.width - this.pointAmountTextfield.width) / 2))) - 8);
            this.supportIcon.x = (this.pointAmountTextfield.x + this.pointAmountTextfield.width);
        }

        public function get downArrow():SliceScalingButton
        {
            return (this._downArrow);
        }

        public function get upArrow():SliceScalingButton
        {
            return (this._upArrow);
        }

        public function get donateButton():SliceScalingButton
        {
            return (this._donateButton);
        }

        public function get gold():int
        {
            return (int(this._amountTextfield.text));
        }

        public function get amountTextfield():UILabel
        {
            return (this._amountTextfield);
        }


    }
}//package io.decagames.rotmg.supportCampaign.tab.donate

