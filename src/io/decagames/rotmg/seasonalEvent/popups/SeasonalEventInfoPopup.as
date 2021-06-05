// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.popups.SeasonalEventInfoPopup

package io.decagames.rotmg.seasonalEvent.popups
{
    import io.decagames.rotmg.ui.popups.modal.ModalPopup;
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.labels.UILabel;
    import flash.display.Sprite;
    import io.decagames.rotmg.ui.scroll.UIScrollbar;
    import flash.display.Shape;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFieldAutoSize;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.ui.texture.TextureParser;

    public class SeasonalEventInfoPopup extends ModalPopup 
    {

        private const WIDTH:int = 550;
        private const HEIGHT:int = 400;

        private var _okButton:SliceScalingButton;
        private var _infoText:String;
        private var _infoLabel:UILabel;
        private var _scrollContainer:Sprite;
        private var _scroll:UIScrollbar;

        public function SeasonalEventInfoPopup(_arg_1:String)
        {
            super(this.WIDTH, this.HEIGHT, "RIFTS: Rules & Explanations");
            this._infoText = _arg_1;
            this.init();
        }

        override public function get width():Number
        {
            return (this.WIDTH);
        }

        override public function get height():Number
        {
            return (this.HEIGHT + 70);
        }

        private function init():void
        {
            this.createContentInset();
            this.createOkButton();
            this.createScrollContainer();
            this.createInfoLabel();
        }

        private function createScrollContainer():void
        {
            var _local_1:Shape = new Shape();
            _local_1.graphics.beginFill(0xCCFF00, 0.6);
            _local_1.graphics.drawRect(0, 2, this.WIDTH, (this.HEIGHT - 54));
            addChild(_local_1);
            this._scrollContainer = new Sprite();
            this._scrollContainer.mask = _local_1;
            addChild(this._scrollContainer);
            scroll = new UIScrollbar((this.HEIGHT - 54));
            scroll.mouseRollSpeedFactor = 1.5;
            scroll.content = this._scrollContainer;
            scroll.x = 530;
            scroll.y = 2;
            scroll.visible = true;
            addChild(scroll);
        }

        private function createInfoLabel():void
        {
            this._infoLabel = new UILabel();
            DefaultLabelFormat.createLabelFormat(this._infoLabel, 16);
            this._infoLabel.autoSize = TextFieldAutoSize.LEFT;
            this._infoLabel.multiline = true;
            this._infoLabel.wordWrap = true;
            this._infoLabel.width = (this.WIDTH - 34);
            this._infoLabel.htmlText = this._infoText;
            this._infoLabel.x = 10;
            this._infoLabel.y = 8;
            this._scrollContainer.addChild(this._infoLabel);
        }

        private function createOkButton():void
        {
            var _local_1:SliceScalingBitmap;
            _local_1 = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration", 194);
            _local_1.scaleY = 0.8;
            _local_1.y = (this.HEIGHT - 40);
            _local_1.x = Math.round(((this.WIDTH - _local_1.width) / 2));
            addChild(_local_1);
            this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
            this._okButton.setLabel("OK", DefaultLabelFormat.questButtonCompleteLabel);
            this._okButton.width = 149;
            this._okButton.x = Math.round(((this.WIDTH - 149) / 2));
            this._okButton.y = (this.HEIGHT - 38);
            addChild(this._okButton);
        }

        private function createContentInset():void
        {
            var _local_1:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", this.WIDTH);
            _local_1.height = (this.HEIGHT - 50);
            addChild(_local_1);
        }

        public function get okButton():SliceScalingButton
        {
            return (this._okButton);
        }


    }
}//package io.decagames.rotmg.seasonalEvent.popups

