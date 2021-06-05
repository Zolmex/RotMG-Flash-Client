﻿// Decompiled by AS3 Sorcerer 6.08
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.ClosedGiftChest

package com.company.assembleegameclient.objects
{
    import kabam.rotmg.game.signals.TextPanelMessageUpdateSignal;
    import kabam.rotmg.core.StaticInjectorContext;
    import com.company.assembleegameclient.ui.tooltip.TextToolTip;
    import kabam.rotmg.text.model.TextKey;
    import com.company.assembleegameclient.ui.tooltip.ToolTip;
    import kabam.rotmg.game.view.TextPanel;
    import com.company.assembleegameclient.game.GameSprite;
    import com.company.assembleegameclient.ui.panels.Panel;

    public class ClosedGiftChest extends GameObject implements IInteractiveObject 
    {

        private var textPanelUpdateSignal:TextPanelMessageUpdateSignal;

        public function ClosedGiftChest(_arg_1:XML)
        {
            super(_arg_1);
            isInteractive_ = true;
            this.textPanelUpdateSignal = StaticInjectorContext.getInjector().getInstance(TextPanelMessageUpdateSignal);
        }

        public function getTooltip():ToolTip
        {
            return (new TextToolTip(0x363636, 0x9B9B9B, TextKey.CLOSEDGIFTCHEST_TITLE, TextKey.TEXTPANEL_GIFTCHESTISEMPTY, 200));
        }

        public function getPanel(_arg_1:GameSprite):Panel
        {
            this.textPanelUpdateSignal.dispatch(TextKey.TEXTPANEL_GIFTCHESTISEMPTY);
            return (new TextPanel(_arg_1));
        }


    }
}//package com.company.assembleegameclient.objects

