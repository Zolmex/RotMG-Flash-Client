﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//kabam.rotmg.game.view.ShopDisplayMediator

package kabam.rotmg.game.view
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.packages.services.PackageModel;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import kabam.rotmg.packages.model.PackageInfo;
    import flash.events.MouseEvent;
    import __AS3__.vec.Vector;
    import com.company.assembleegameclient.parameters.Parameters;

    public class ShopDisplayMediator extends Mediator 
    {

        [Inject]
        public var view:ShopDisplay;
        [Inject]
        public var packageBoxModel:PackageModel;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        private var toolTip:TextToolTip = null;
        private var hoverTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void
        {
            var _local_3:PackageInfo;
            if (((this.view.shopButton) && (this.view.isOnNexus)))
            {
                this.view.shopButton.addEventListener(MouseEvent.CLICK, this.view.onShopClick);
                this.toolTip = new TextToolTip(0x363636, 0x9B9B9B, null, "Click to open!", 95);
                this.hoverTooltipDelegate = new HoverTooltipDelegate();
                this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
                this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
                this.hoverTooltipDelegate.setDisplayObject(this.view.shopButton);
                this.hoverTooltipDelegate.tooltip = this.toolTip;
            };
            var _local_1:Vector.<PackageInfo> = this.packageBoxModel.getTargetingBoxesForGrid().concat(this.packageBoxModel.getBoxesForGrid());
            var _local_2:Date = new Date();
            _local_2.setTime(Parameters.data_["packages_indicator"]);
            for each (_local_3 in _local_1)
            {
                if (((!(_local_3 == null)) && ((!(_local_3.endTime)) || (_local_3.getSecondsToEnd() > 0))))
                {
                    if (((_local_3.isNew()) && ((_local_3.startTime.getTime() > _local_2.getTime()) || (!(Parameters.data_["packages_indicator"])))))
                    {
                        this.view.newIndicator(true);
                    };
                };
            };
        }


    }
}//package kabam.rotmg.game.view

