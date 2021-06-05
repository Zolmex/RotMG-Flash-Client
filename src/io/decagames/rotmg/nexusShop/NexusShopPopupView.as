// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.nexusShop.NexusShopPopupView

package io.decagames.rotmg.nexusShop
{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import com.company.assembleegameclient.objects.SellableObject;
    import org.osflash.signals.Signal;
    import io.decagames.rotmg.ui.labels.UILabel;
    import kabam.rotmg.text.view.TextFieldDisplayConcrete;
    import flash.display.Sprite;
    import io.decagames.rotmg.shop.ShopBuyButton;
    import io.decagames.rotmg.ui.spinner.FixedNumbersSpinner;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.geom.Rectangle;
    import com.company.assembleegameclient.util.FilterUtil;
    import kabam.rotmg.fortune.components.ItemWithTooltip;
    import kabam.rotmg.text.view.stringBuilder.LineBuilder;
    import flash.text.TextFieldAutoSize;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import __AS3__.vec.Vector;
    import flash.events.MouseEvent;
    import __AS3__.vec.*;
    import io.decagames.rotmg.shop.*;

    public class NexusShopPopupView extends ModalPopup 
    {

        public static const TITLE:String = "Purchase";
        public static const WIDTH:int = 300;
        public static const HEIGHT:int = 170;

        private var availableInventoryNumber:int;
        private var owner_:SellableObject;
        public var buyItem:Signal;
        public var buttonWidth:int;
        public var descriptionLabel:UILabel;
        private var nameText_:TextFieldDisplayConcrete;
        public var itemLabel:UILabel;
        private var quantity_:int = 1;
        private var buySectionContainer:Sprite;
        public var buyButton:ShopBuyButton;
        public var spinner:FixedNumbersSpinner;
        private var buyButtonBackground:SliceScalingBitmap;

        public function NexusShopPopupView(_arg_1:Signal, _arg_2:SellableObject, _arg_3:Number, _arg_4:int)
        {
            super(WIDTH, HEIGHT, TITLE, DefaultLabelFormat.defaultSmallPopupTitle, new Rectangle(0, 0, 525, 230), 0);
            this.buyItem = _arg_1;
            this.owner_ = _arg_2;
            this.buttonWidth = _arg_3;
            this.availableInventoryNumber = _arg_4;
            this.descriptionLabel = new UILabel();
            DefaultLabelFormat.infoTooltipText(this.descriptionLabel, 0x999999);
            this.descriptionLabel.text = "Are you sure that you want to buy this item?";
            addChild(this.descriptionLabel);
            this.descriptionLabel.x = ((WIDTH / 2) - (this.descriptionLabel.width / 2));
            this.descriptionLabel.y = 10;
            this.addItemContainer();
            this.addBuyButton();
            this.filters = FilterUtil.getStandardDropShadowFilter();
        }

        private function addItemContainer():void
        {
            var _local_2:ItemWithTooltip;
            if (this.owner_.getSellableType() != -1)
            {
                _local_2 = new ItemWithTooltip(this.owner_.getSellableType(), 80);
            };
            _local_2.x = ((WIDTH / 2) - (_local_2.width / 2));
            _local_2.y = (((HEIGHT / 2) - _local_2.height) + 5);
            addChild(_local_2);
            var _local_1:String = this.owner_.soldObjectName();
            this.nameText_ = new TextFieldDisplayConcrete().setSize(14).setColor(0xFFFFFF);
            this.nameText_.setBold(true);
            this.nameText_.setStringBuilder(new LineBuilder().setParams(_local_1));
            this.nameText_.setAutoSize(TextFieldAutoSize.CENTER);
            addChild(this.nameText_);
            this.nameText_.x = ((WIDTH / 2) - (this.nameText_.width / 2));
            this.nameText_.y = (_local_2.y + 55);
        }

        private function addBuyButton():void
        {
            var _local_2:int;
            this.buySectionContainer = new Sprite();
            this.buySectionContainer.alpha = 1;
            this.buyButton = new ShopBuyButton(this.owner_.price_, this.owner_.currency_);
            this.buyButton.showCampaignTooltip = true;
            this.buyButton.width = 95;
            this.buyButtonBackground = TextureParser.instance.getSliceScalingBitmap("UI", "buy_button_background", (this.buyButton.width + 60));
            var _local_1:Vector.<int> = new Vector.<int>();
            if (this.availableInventoryNumber != 0)
            {
                _local_2 = 1;
                while (_local_2 <= this.availableInventoryNumber)
                {
                    _local_1.push(_local_2);
                    _local_2++;
                };
            }
            else
            {
                _local_1.push(1);
                this.buyButton.disabled = true;
            };
            this.spinner = new FixedNumbersSpinner(TextureParser.instance.getSliceScalingBitmap("UI", "spinner_up_arrow"), 0, _local_1, "x");
            this.buySectionContainer.addChild(this.buyButtonBackground);
            this.buySectionContainer.addChild(this.spinner);
            this.buySectionContainer.addChild(this.buyButton);
            this.buySectionContainer.x = 100;
            this.buySectionContainer.y = (HEIGHT - 45);
            this.buyButton.x = ((this.buyButtonBackground.width - this.buyButton.width) - 6);
            this.buyButton.y = 4;
            this.spinner.y = -2;
            this.spinner.x = 32;
            addChild(this.buySectionContainer);
            this.buySectionContainer.x = Math.round(((WIDTH - this.buySectionContainer.width) / 2));
            this.spinner.upArrow.addEventListener(MouseEvent.CLICK, this.countUp);
            this.spinner.downArrow.addEventListener(MouseEvent.CLICK, this.countDown);
            this.refreshArrowDisable();
        }

        private function refreshArrowDisable():void
        {
            this.spinner.downArrow.alpha = ((this.quantity_ == 1) ? 0.5 : 1);
            if (this.availableInventoryNumber != 0)
            {
                this.spinner.upArrow.alpha = ((this.quantity_ == this.availableInventoryNumber) ? 0.5 : 1);
            }
            else
            {
                this.spinner.upArrow.alpha = 0.5;
            };
        }

        private function countUp(_arg_1:MouseEvent):void
        {
            if (this.quantity_ < this.availableInventoryNumber)
            {
                this.quantity_ = (this.quantity_ + 1);
            };
            this.refreshValues();
        }

        private function countDown(_arg_1:MouseEvent):void
        {
            if (this.quantity_ > 1)
            {
                this.quantity_ = (this.quantity_ - 1);
            };
            this.refreshValues();
        }

        private function refreshValues():void
        {
            this.refreshArrowDisable();
            this.buyButton.price = (this.owner_.price_ * this.quantity_);
        }

        public function get getBuyButton():ShopBuyButton
        {
            return (this.buyButton);
        }

        public function get getBuyItem():Signal
        {
            return (this.buyItem);
        }

        public function get getOwner():SellableObject
        {
            return (this.owner_);
        }

        public function get getQuantity():int
        {
            return (this.quantity_);
        }


    }
}//package io.decagames.rotmg.nexusShop

