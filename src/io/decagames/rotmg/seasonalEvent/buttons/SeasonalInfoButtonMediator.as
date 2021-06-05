// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.buttons.SeasonalInfoButtonMediator

package io.decagames.rotmg.seasonalEvent.buttons
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import flash.events.MouseEvent;
    import io.decagames.rotmg.seasonalEvent.popups.SeasonalEventInfoPopup;

    public class SeasonalInfoButtonMediator extends Mediator 
    {

        [Inject]
        public var view:SeasonalInfoButton;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        private var toolTip:TextToolTip = null;
        private var hoverTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void
        {
            this.view.infoButton.addEventListener(MouseEvent.CLICK, this.onInfoClicked);
            this.toolTip = new TextToolTip(0x363636, 0x9B9B9B, null, "Click to open Seasonal Event Info!", 95);
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
            this.hoverTooltipDelegate.setDisplayObject(this.view.infoButton);
            this.hoverTooltipDelegate.tooltip = this.toolTip;
        }

        override public function destroy():void
        {
            super.destroy();
            this.view.infoButton.removeEventListener(MouseEvent.CLICK, this.onInfoClicked);
            this.hoverTooltipDelegate.removeDisplayObject();
            this.hoverTooltipDelegate = null;
        }

        private function onInfoClicked(_arg_1:MouseEvent):void
        {
            this.showPopupSignal.dispatch(new SeasonalEventInfoPopup(this.seasonalEventModel.rulesAndDescription));
        }


    }
}//package io.decagames.rotmg.seasonalEvent.buttons

