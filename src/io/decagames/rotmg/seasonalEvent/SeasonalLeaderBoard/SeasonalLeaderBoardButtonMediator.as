// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoardButtonMediator

package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
    import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import flash.events.MouseEvent;

    public class SeasonalLeaderBoardButtonMediator extends Mediator 
    {

        [Inject]
        public var view:SeasonalLeaderBoardButton;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        [Inject]
        public var showPopupSignal:ShowPopupSignal;
        [Inject]
        public var seasonalEventModel:SeasonalEventModel;
        private var toolTip:TextToolTip = null;
        private var hoverTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void
        {
            this.view.button.addEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.toolTip = new TextToolTip(0x363636, 0x9B9B9B, null, "Click to open!", 95);
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
            this.hoverTooltipDelegate.setDisplayObject(this.view.button);
            this.hoverTooltipDelegate.tooltip = this.toolTip;
        }

        private function onButtonClick(_arg_1:MouseEvent):void
        {
            if (this.seasonalEventModel.isChallenger)
            {
                this.showPopupSignal.dispatch(new SeasonalLeaderBoard());
            }
            else
            {
                this.showPopupSignal.dispatch(new SeasonalLegacyLeaderBoard());
            };
        }

        override public function destroy():void
        {
            super.destroy();
            this.view.button.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
            this.hoverTooltipDelegate.removeDisplayObject();
            this.hoverTooltipDelegate = null;
        }


    }
}//package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard

