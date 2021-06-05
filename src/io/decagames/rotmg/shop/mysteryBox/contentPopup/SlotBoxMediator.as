﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//io.decagames.rotmg.shop.mysteryBox.contentPopup.SlotBoxMediator

package io.decagames.rotmg.shop.mysteryBox.contentPopup
{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.ui.model.HUDModel;
    import kabam.rotmg.core.signals.ShowTooltipSignal;
    import kabam.rotmg.core.signals.HideTooltipsSignal;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.tooltips.HoverTooltipDelegate;
    import kabam.rotmg.text.model.TextKey;

    public class SlotBoxMediator extends Mediator 
    {

        [Inject]
        public var view:SlotBox;
        [Inject]
        public var hud:HUDModel;
        [Inject]
        public var showTooltipSignal:ShowTooltipSignal;
        [Inject]
        public var hideTooltipSignal:HideTooltipsSignal;
        private var toolTip:TextToolTip = null;
        private var hoverTooltipDelegate:HoverTooltipDelegate;


        override public function initialize():void
        {
            if (this.view.slotType == SlotBox.VAULT_SLOT)
            {
                this.toolTip = new TextToolTip(0x363636, 0x9B9B9B, TextKey.VAULT_CHEST, TextKey.VAULT_CHEST_DESCRIPTION, 200);
                this.hoverTooltipDelegate = new HoverTooltipDelegate();
                this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
                this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
                this.hoverTooltipDelegate.setDisplayObject(this.view);
                this.hoverTooltipDelegate.tooltip = this.toolTip;
            }
        }

        override public function destroy():void
        {
        }


    }
}//package io.decagames.rotmg.shop.mysteryBox.contentPopup

