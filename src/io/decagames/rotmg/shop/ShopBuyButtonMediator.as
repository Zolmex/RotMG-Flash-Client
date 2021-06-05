// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.shop.ShopBuyButtonMediator

package io.decagames.rotmg.shop
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import io.decagames.rotmg.supportCampaign.tooltips.PointsTooltip;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import com.company.assembleegameclient.util.Currency;

    public class ShopBuyButtonMediator extends Mediator 
    {

        [Inject]
        public var view:ShopBuyButton;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        [Inject]
        public var model:SupporterCampaignModel;
        private var toolTip:PointsTooltip = null;
        private var hoverTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void
        {
            if (((((((this.model.hasValidData) && (this.view.showCampaignTooltip)) && (this.model.isStarted)) && (!(this.model.isEnded))) && (this.view.currency == Currency.GOLD)) && (!(this.model.shopPurchasePointsRatio == 0))))
            {
                this.toolTip = new PointsTooltip(this.view, 0x363636, 0x9B9B9B, 200);
                this.hoverTooltipDelegate = new HoverTooltipDelegate();
                this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
                this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
                this.hoverTooltipDelegate.setDisplayObject(this.view);
                this.hoverTooltipDelegate.tooltip = this.toolTip;
            }
        }

        override public function destroy():void
        {
            if (this.view.showCampaignTooltip)
            {
                this.hoverTooltipDelegate = null;
                this.toolTip = null;
            }
        }


    }
}//package io.decagames.rotmg.shop

