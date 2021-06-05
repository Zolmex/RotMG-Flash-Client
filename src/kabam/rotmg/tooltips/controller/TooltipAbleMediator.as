// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.tooltips.controller.TooltipAbleMediator

package kabam.rotmg.tooltips.controller
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.tooltips.TooltipAble;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;

    public class TooltipAbleMediator extends Mediator 
    {

        [Inject]
        public var view:TooltipAble;
        [Inject]
        public var showToolTip:ShowTooltipSignal;
        [Inject]
        public var hideToolTips:HideTooltipsSignal;


        override public function initialize():void
        {
            this.view.setShowToolTipSignal(this.showToolTip);
            this.view.setHideToolTipsSignal(this.hideToolTips);
        }


    }
}//package kabam.rotmg.tooltips.controller

