// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.supportCampaign.tooltips.PointsTooltip

package io.decagames.rotmg.supportCampaign.tooltips
{
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import io.decagames.rotmg.ui.labels.UILabel;
    import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
    import io.decagames.rotmg.shop.ShopBuyButton;
    import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
    import flash.text.TextFormatAlign;
    import io.decagames.rotmg.ui.texture.TextureParser;

    public class PointsTooltip extends ToolTip 
    {

        private var pointsInfo:UILabel;
        private var supportIcon:SliceScalingBitmap;
        private var _shopButton:ShopBuyButton;

        public function PointsTooltip(_arg_1:ShopBuyButton, _arg_2:uint, _arg_3:uint, _arg_4:int, _arg_5:Boolean=true)
        {
            super(_arg_2, 1, _arg_3, 1, _arg_5);
            this._shopButton = _arg_1;
            this.pointsInfo = new UILabel();
            DefaultLabelFormat.createLabelFormat(this.pointsInfo, 14, 0xEAEAEA, TextFormatAlign.RIGHT, false);
            addChild(this.pointsInfo);
            this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI", "campaign_Points");
            addChild(this.supportIcon);
        }

        public function updatePoints(_arg_1:int):void
        {
            this.pointsInfo.text = ("You will get " + _arg_1);
            this.supportIcon.y = this.pointsInfo.y;
            this.supportIcon.x = (this.pointsInfo.x + this.pointsInfo.width);
        }

        public function get shopButton():ShopBuyButton
        {
            return (this._shopButton);
        }


    }
}//package io.decagames.rotmg.supportCampaign.tooltips

