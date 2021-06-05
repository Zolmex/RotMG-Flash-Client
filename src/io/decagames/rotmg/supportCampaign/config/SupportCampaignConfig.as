// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.supportCampaign.config.SupportCampaignConfig

package io.decagames.rotmg.supportCampaign.config
{
    import robotlegs.bender.framework.api.IConfig;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import org.swiftsuspenders.Injector;
    import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
    import io.decagames.rotmg.supportCampaign.tasks.GetCampaignStatusTask;
    import io.decagames.rotmg.supportCampaign.signals.UpdateCampaignProgress;
    import io.decagames.rotmg.supportCampaign.signals.TierSelectedSignal;
    import io.decagames.rotmg.supportCampaign.signals.MaxRankReachedSignal;
    import io.decagames.rotmg.supportCampaign.tab.SupporterShopTabView;
    import io.decagames.rotmg.supportCampaign.tab.SupporterShopTabMediator;
    import io.decagames.rotmg.supportCampaign.tab.donate.DonatePanel;
    import io.decagames.rotmg.supportCampaign.tab.donate.DonatePanelMediator;
    import io.decagames.rotmg.supportCampaign.tab.donate.popup.DonateConfirmationPopup;
    import io.decagames.rotmg.supportCampaign.tab.donate.popup.DonateConfirmationPopupMediator;
    import io.decagames.rotmg.supportCampaign.tab.tiers.preview.TiersPreview;
    import io.decagames.rotmg.supportCampaign.tab.tiers.preview.TiersPreviewMediator;
    import io.decagames.rotmg.supportCampaign.tab.tiers.button.TierButton;
    import io.decagames.rotmg.supportCampaign.tab.tiers.button.TierButtonMediator;
    import io.decagames.rotmg.supportCampaign.tooltips.PointsTooltip;
    import io.decagames.rotmg.supportCampaign.tooltips.PointsTooltipMediator;

    public class SupportCampaignConfig implements IConfig 
    {

        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var injector:Injector;


        public function configure():void
        {
            this.injector.map(SupporterCampaignModel).asSingleton();
            this.injector.map(GetCampaignStatusTask);
            this.injector.map(UpdateCampaignProgress).asSingleton();
            this.injector.map(TierSelectedSignal).asSingleton();
            this.injector.map(MaxRankReachedSignal).asSingleton();
            this.mediatorMap.map(SupporterShopTabView).toMediator(SupporterShopTabMediator);
            this.mediatorMap.map(DonatePanel).toMediator(DonatePanelMediator);
            this.mediatorMap.map(DonateConfirmationPopup).toMediator(DonateConfirmationPopupMediator);
            this.mediatorMap.map(TiersPreview).toMediator(TiersPreviewMediator);
            this.mediatorMap.map(TierButton).toMediator(TierButtonMediator);
            this.mediatorMap.map(PointsTooltip).toMediator(PointsTooltipMediator);
        }


    }
}//package io.decagames.rotmg.supportCampaign.config

