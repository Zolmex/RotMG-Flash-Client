// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.dailyQuests.view.popup.BuyQuestRefreshButton

package io.decagames.rotmg.dailyQuests.view.popup
{
    import io.decagames.rotmg.ui.buttons.SliceScalingButton;
    import io.decagames.rotmg.ui.texture.TextureParser;
    import flash.display.Bitmap;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import kabam.rotmg.assets.services.IconFactory;

    public class BuyQuestRefreshButton extends SliceScalingButton 
    {

        private var _price:int;

        public function BuyQuestRefreshButton(_arg_1:int)
        {
            super(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button", 32));
            this._price = _arg_1;
            this.init();
        }

        private function init():void
        {
            var _local_1:Bitmap;
            this.width = 100;
            this.setLabelMargin(-10, 0);
            this.setLabel(this._price.toString(), DefaultLabelFormat.defaultButtonLabel);
            _local_1 = new Bitmap(IconFactory.makeCoin());
            _local_1.x = (this.width - (2 * _local_1.width));
            _local_1.y = ((this.height - _local_1.height) / 2);
            addChild(_local_1);
        }


    }
}//package io.decagames.rotmg.dailyQuests.view.popup

