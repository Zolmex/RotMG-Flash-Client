// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.supportCampaign.tooltips.PointsTooltipMediator

package io.decagames.rotmg.supportCampaign.tooltips
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;

    public class PointsTooltipMediator extends Mediator 
    {

        [Inject]
        public var view:PointsTooltip;
        [Inject]
        public var model:SupporterCampaignModel;


        override public function initialize():void
        {
            this.view.updatePoints((this.view.shopButton.price * this.model.shopPurchasePointsRatio));
        }

        override public function destroy():void
        {
        }


    }
}//package io.decagames.rotmg.supportCampaign.tooltips

